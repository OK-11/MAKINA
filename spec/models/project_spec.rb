require 'rails_helper'

RSpec.describe Project, type: :model do

  let(:user) { FactoryBot.create(:user) }
  let!(:user2) { FactoryBot.create(:user, name: "test2", email: "test2@test.com") }
  
  describe "正常確認" do

    context "問題なく保存できることを確認" do
      it "ユーザがプロジェクトを持つ" do
        project = user.projects.build(name: "project")
        expect(project.valid?).to be true
        project.save
        check_project = Project.find(project.id)
        expect(check_project.name).to eq "project"
      end

      it "ユーザがプロジェクトを２つ持つ" do
        project = user.projects.build(name: "project")
        project.save
        project2 = user.projects.build(name: "project2")
        project2.save
        expect(user.projects.count).to be 2
      end

      it "ユーザのプロジェクト名の変更" do
        project = user.projects.build(name: "project")
        project.save
        change_name = user.projects.find(project.id)
        change_name.update(name: "project2")
        check_project = user.projects.find(project.id)
        expect(check_project.name).to eq "project2"
      end

      it "ユーザのプロジェクトを削除" do
        project = user.projects.build(name: "project")
        project.save
        destroy_project = user.projects.find(project.id)
        destroy_project.destroy
        expect(user.projects.count).to be 0
      end
    end
  end


  describe "バリデーション確認" do

    context "name" do
      it "空の場合、(プロジェクト名)、(入力必須です)が表示される" do
        project = user.projects.build(name: "")
        expect(project.valid?).to be false
        expect(project.errors.full_messages.join).to include("プロジェクト名")
        expect(project.errors.full_messages.join).to include("入力必須です")
      end
    end

    context "user_id" do
      it "空の場合、(ユーザーID)、(入力必須です)が表示される" do
        project = Project.new(name: "project" , user_id: nil)
        expect(project.valid?).to be false
        expect(project.errors.full_messages.join).to include("ユーザーID")
        expect(project.errors.full_messages.join).to include("入力必須です")
      end
    end
  end
end
