require 'rails_helper'

RSpec.describe User, type: :model do

  describe "正常確認" do

    context "問題なく保存できることを確認" do
      it "クライアントユーザー(admin、position指定なし)" do
        user = FactoryBot.build(:user)
        expect(user.valid?).to be true
        user.save
        check_user = User.find(user.id)
        expect(check_user.name).to eq "test"
      end
      
      it "adminユーザー(adminはtrue、positionは2)" do
        user = FactoryBot.build(:admin)
        expect(user.valid?).to be true
        user.save
        check_user = User.find(user.id)
        expect(check_user.admin).to be true
      end
      
      it "workerユーザー(admin指定なし、positionは2)" do
        user = FactoryBot.build(:worker)
        expect(user.valid?).to be true
        user.save
        check_user = User.find(user.id)
        expect(check_user.position).to be 2
      end
    end
  end
  

  describe "バリデーション確認" do

    context "name" do
      it "空の場合、(名前)、(入力必須です)が表示される" do
        user = FactoryBot.build(:user, name: "")
        expect(user.valid?).to be false
        expect(user.errors.full_messages.join).to include("名前")
        expect(user.errors.full_messages.join).to include("入力必須です")
      end
    end


    context "email" do
      it "空の場合、(メールアドレス)、(入力必須です)が表示される" do
        user = FactoryBot.build(:user, email: "")
        expect(user.valid?).to be false
        expect(user.errors.full_messages.join).to include("メールアドレス")
        expect(user.errors.full_messages.join).to include("入力必須です")
      end

      it "重複している場合、(メールアドレス)、(重複しています)が表示される" do
        FactoryBot.create(:user)
        user = FactoryBot.build(:user)
        expect(user.valid?).to be false
        expect(user.errors.full_messages.join).to include("メールアドレス")
        expect(user.errors.full_messages.join).to include("重複しています")
      end
    end


    context "password、password_confirmation" do
      it "空の場合、(パスワード)、(入力必須です)が表示される" do
        user = FactoryBot.build(:user, password: "")
        expect(user.valid?).to be false
        expect(user.errors.full_messages.join).to include("パスワード")
        expect(user.errors.full_messages.join).to include("入力必須です")
      end

      it "一致しない場合、(パスワード(確認用))、(入力が一致していません)が表示される" do
        user = FactoryBot.build(:user, password_confirmation: "password1")
        expect(user.valid?).to be false
        expect(user.errors.full_messages.join).to include("パスワード(確認用)")
        expect(user.errors.full_messages.join).to include("入力が一致していません")
      end
      
      it "短い場合、(パスワード)、(入力が短すぎます)が表示される" do
        user = FactoryBot.build(:user, password: "pass", password_confirmation: "pass")
        expect(user.valid?).to be false
        expect(user.errors.full_messages.join).to include("パスワード")
        expect(user.errors.full_messages.join).to include("入力が短すぎます")
      end
    end


    context "position" do
      it "0の場合、(ポジション)、(1か2でないといけません)が表示される" do
        user = FactoryBot.build(:user, position: 0)
        expect(user.valid?).to be false
        expect(user.errors.full_messages.join).to include("ポジション")
        expect(user.errors.full_messages.join).to include("1か2でないといけません")
      end

      it "3の場合、(ポジション)、(1か2でないといけません)が表示される" do
        user = FactoryBot.build(:user, position: 3)
        expect(user.valid?).to be false
        expect(user.errors.full_messages.join).to include("ポジション")
        expect(user.errors.full_messages.join).to include("1か2でないといけません")
      end
    end
  end
end
