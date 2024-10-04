require 'rails_helper'

RSpec.describe ProjectMissionTask, type: :model do

  let(:user) { FactoryBot.create(:user) }
  let!(:user2) { FactoryBot.create(:user, name: "test2", email: "test2@test.com") }

  let(:project) { user.projects.create(name: "project") }

  let(:missionA) { FactoryBot.create(:missionA) }
  let(:missionB) { FactoryBot.create(:missionB) }
  let(:missionC) { FactoryBot.create(:missionC) }

  let(:taskA) { FactoryBot.create(:taskA) }
  let(:taskB) { FactoryBot.create(:taskB) }
  let(:taskC) { FactoryBot.create(:taskC) } 


  describe "正常確認" do

    before do
      project.missions << missionA
      project.missions << missionB
      project.missions << missionC
    end

    context "問題なく保存できることを確認" do
      it "大タスクに小タスクを紐づける" do
        mission1 = ProjectMission.where(project_id: project.id , mission_id: missionA.id).first
        mission1_taskA = mission1.project_mission_tasks.build(task_id: taskA.id , role: 1)
        mission1_taskA.save
        mission1_taskB = mission1.project_mission_tasks.build(task_id: taskB.id , role: 2)
        mission1_taskB.save
        mission1_taskC = mission1.project_mission_tasks.build(task_id: taskC.id , role: 3)
        mission1_taskC.save
        expect(mission1.tasks.count).to be 3
        expect(mission1.tasks[0].name).to eq "task-A"
      end

      it "missionGetTask関数によって、大タスクに小タスクを紐づける" do
        mission1 = ProjectMission.where(project_id: project.id , mission_id: missionA.id).first
        mission2 = ProjectMission.where(project_id: project.id , mission_id: missionB.id).first
        mission3 = ProjectMission.where(project_id: project.id , mission_id: missionC.id).first
        mission1.missionGetTask(taskA.id , 1)
        mission1.missionGetTask(taskC.id , 2)
        mission1.missionGetTask(taskA.id , 1)
        mission2.missionGetTask(taskA.id , 1)
        mission2.missionGetTask(taskB.id , 3)
        mission3.missionGetTask(taskC.id , 1)

        expect(mission1.tasks.count).to be 3
        expect(mission2.tasks.count).to be 2
        expect(mission3.tasks.count).to be 1
      end

      it "大タスクの一つ目の小タスクを削除する" do
        mission1 = ProjectMission.where(project_id: project.id , mission_id: missionA.id).first
        mission1.missionGetTask(taskA.id , 1)
        mission1.missionGetTask(taskB.id , 1)
        mission1.missionGetTask(taskC.id , 2)

        mission1_task_destroy = mission1.project_mission_tasks.where(task_id: taskA.id).first
        mission1_task_destroy.destroy
        expect(mission1.tasks.count).to be 2
      end

      it "大タスクの小タスクを全て削除する" do
        mission1 = ProjectMission.where(project_id: project.id , mission_id: missionA.id).first
        mission1.missionGetTask(taskA.id , 1)
        mission1.missionGetTask(taskB.id , 1)
        mission1.missionGetTask(taskC.id , 2)

        mission1_task_all_destroy = mission1.project_mission_tasks
        mission1_task_all_destroy.destroy_all
        expect(mission1.tasks.count).to be 0
      end
    end
  end


  describe "バリデーション確認" do

    before do
      project.missions << missionA
      project.missions << missionB
      project.missions << missionC
    end

    let(:mission1) { ProjectMission.where(project_id: project.id , mission_id: missionA.id).first }

    context "project_mission_id" do
      it "空の場合、(プロジェクト-大タスクID)、(入力必須です)が表示される" do
        project_mission_task = ProjectMissionTask.new(project_mission_id: nil , task_id: taskA.id , role: 1)
        expect(project_mission_task.valid?).to be false
        expect(project_mission_task.errors.full_messages.join).to include("プロジェクト-大タスクID")
        expect(project_mission_task.errors.full_messages.join).to include("入力必須です")
      end
    end

    context "task_id" do
      it "空の場合、(小タスクID)、(入力必須です)が表示される" do
        project_mission_task = ProjectMissionTask.new(project_mission_id: mission1.id , task_id: nil , role: 1)
        expect(project_mission_task.valid?).to be false
        expect(project_mission_task.errors.full_messages.join).to include("小タスクID")
        expect(project_mission_task.errors.full_messages.join).to include("入力必須です")
      end
    end

    context "status" do
      it "0の場合、(ステータス)、(1か2でないといけません)が表示される" do
        project_mission_task = ProjectMissionTask.new(project_mission_id: mission1.id , task_id: taskA.id , role: 1 , status: 0)
        expect(project_mission_task.valid?).to be false
        expect(project_mission_task.errors.full_messages.join).to include("ステータス")
        expect(project_mission_task.errors.full_messages.join).to include("1か2でないといけません")
      end

      it "3の場合、(ステータス)、(1か2でないといけません)が表示される" do
        project_mission_task = ProjectMissionTask.new(project_mission_id: mission1.id , task_id: taskA.id , role: 1 , status: 3)
        expect(project_mission_task.valid?).to be false
        expect(project_mission_task.errors.full_messages.join).to include("ステータス")
        expect(project_mission_task.errors.full_messages.join).to include("1か2でないといけません")
      end
    end

    context "role" do
      it "0の場合、(役割)、(1か2でないといけません)が表示される" do
        project_mission_task = ProjectMissionTask.new(project_mission_id: mission1.id , task_id: taskA.id , role: 0)
        expect(project_mission_task.valid?).to be false
        expect(project_mission_task.errors.full_messages.join).to include("役割")
        expect(project_mission_task.errors.full_messages.join).to include("1か2でないといけません")
      end

      it "3の場合、(役割)、(1か2でないといけません)が表示される" do
        project_mission_task = ProjectMissionTask.new(project_mission_id: mission1.id , task_id: taskA.id , role: 3)
        expect(project_mission_task.valid?).to be false
        expect(project_mission_task.errors.full_messages.join).to include("役割")
        expect(project_mission_task.errors.full_messages.join).to include("1か2でないといけません")
      end

      it "空の場合、(役割)、(入力必須です)が表示される" do
        project_mission_task = ProjectMissionTask.new(project_mission_id: mission1.id , task_id: taskA.id , role: nil)
        expect(project_mission_task.valid?).to be false
        expect(project_mission_task.errors.full_messages.join).to include("役割")
        expect(project_mission_task.errors.full_messages.join).to include("入力必須です")
      end
    end

    context "missionGetTask関数で保存に失敗した場合" do
      it "task_idが空の場合、(小タスクID)、(入力必須です)が表示される" do
        expect(mission1.missionGetTask( nil , 1).join).to include("小タスクID")
        expect(mission1.missionGetTask( nil , 1).join).to include("入力必須です")
      end
    end
  end
end
