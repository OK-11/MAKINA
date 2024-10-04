require 'rails_helper'

RSpec.describe Task, type: :model do

  describe "正常確認" do

    it "問題なく保存できることを確認" do
      task = FactoryBot.build(:task)
      expect(task.valid?).to be true
      task.save
      check_task = Task.find(task.id)
      expect(check_task.name).to eq "task"
    end
  end


  describe "バリデーション確認" do

    context "name" do
      it "空の場合、(小タスク名)、(入力必須です)が表示される" do
        task = FactoryBot.build(:task, name: "")
        expect(task.valid?).to be false
        expect(task.errors.full_messages.join).to include("小タスク名")
        expect(task.errors.full_messages.join).to include("入力必須です")
      end
    end
  end

end
