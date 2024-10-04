require 'rails_helper'

RSpec.describe ProjectMission, type: :model do

  let(:user) { FactoryBot.create(:user) }
  let!(:user2) { FactoryBot.create(:user, name: "test2", email: "test2@test.com") }

  let(:project) { user.projects.create(name: "project") }

  let(:missionA) { FactoryBot.create(:missionA) }
  let(:missionB) { FactoryBot.create(:missionB) }
  let(:missionC) { FactoryBot.create(:missionC) }
  

  describe "正常確認" do

    before do
      project.missions << missionA
      project.missions << missionB
      project.missions << missionC
    end

    context "問題なく保存できることを確認" do
      it "プロジェクトに大タスクを複数紐づける" do
        expect(project.missions.count).to be 3
        expect(project.missions[0].name).to eq "mission-A"
        expect(project.missions[1].name).to eq "mission-B"
        expect(project.missions[2].name).to eq "mission-C"
      end

      it "プロジェクトの一つ目の大タスクをcloseさせる" do
        change_status = project.project_missions.where(project_id: project.id , mission_id: missionA.id)
        change_status[0].update(status: 2)
        check_status = project.project_missions.where(project_id: project.id , mission_id: missionA.id)
        expect(check_status[0].status).to be 2
      end

      it "プロジェクトの一つ目の大タスクを削除する" do
        destroy_project_mission = project.project_missions.where(project_id: project.id , mission_id: missionA.id)
        destroy_project_mission[0].destroy
        expect(project.missions.count).to be 2
        expect(project.missions[0].name).to eq "mission-B"
        expect(project.missions[1].name).to eq "mission-C"
      end

      it "プロジェクトの大タスクを全て削除する" do
        destroy_all_project_missions = project.project_missions.where(project_id: project.id)
        destroy_all_project_missions.destroy_all
        expect(project.missions.count).to be 0
      end
    end
  end  


  describe "バリデーション確認" do

    context "project_id" do
      it "空の場合、(プロジェクトID)、(入力必須です)が表示される" do
        project_mission = ProjectMission.new(project_id: nil , mission_id: missionA.id)
        expect(project_mission.valid?).to be false
        expect(project_mission.errors.full_messages.join).to include("プロジェクトID")
        expect(project_mission.errors.full_messages.join).to include("入力必須です")
      end
    end

    context "mission_id" do
      it "空の場合、(大タスクID)、(入力必須です)が表示される" do
        project_mission = project.project_missions.build(mission_id: nil)
        expect(project_mission.valid?).to be false
        expect(project_mission.errors.full_messages.join).to include("大タスクID")
        expect(project_mission.errors.full_messages.join).to include("入力必須です")
      end
    end

    context "project_idとmission_id" do
      it "重複している場合、(重複しています)が表示される" do
        project.missions << missionA
        project_mission = project.project_missions.build(mission_id: missionA.id)
        expect(project_mission.valid?).to be false
        expect(project_mission.errors[:project_id].join).to include("重複しています")
      end
    end

    context "status" do
      it "0の場合、(ステータス)、(1か2でないといけません)が表示される" do
        project_mission = project.project_missions.build(mission_id: missionA.id , status: 0)
        expect(project_mission.valid?).to be false
        expect(project_mission.errors.full_messages.join).to include("ステータス")
        expect(project_mission.errors.full_messages.join).to include("1か2でないといけません")
      end

      it "3の場合、(ステータス)、(1か2でないといけません)が表示される" do
        project_mission = project.project_missions.build(mission_id: missionA.id , status: 3)
        expect(project_mission.valid?).to be false
        expect(project_mission.errors.full_messages.join).to include("ステータス")
        expect(project_mission.errors.full_messages.join).to include("1か2でないといけません")
      end
    end
  end
end
