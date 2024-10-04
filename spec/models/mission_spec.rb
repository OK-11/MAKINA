require 'rails_helper'

RSpec.describe Mission, type: :model do
  
  describe "正常確認" do

    it "問題なく保存できることを確認" do
      mission = FactoryBot.build(:mission)
      expect(mission.valid?).to be true
      mission.save
      check_mission = Mission.find(mission.id)
      expect(check_mission.name).to eq "mission"
    end
  end


  describe "バリデーション確認" do

    context "name" do
      it "空の場合、(大タスク名)、(入力必須です)が表示される" do
        mission = FactoryBot.build(:mission, name: "")
        expect(mission.valid?).to be false
        expect(mission.errors.full_messages.join).to include("大タスク名")
        expect(mission.errors.full_messages.join).to include("入力必須です")
      end
    end
  end
  
end
