require 'rails_helper'

RSpec.describe Account, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  before do
    sleep(0.05) # MySQL client is not connected対策
  end

  it 'is Valid' do
    account = FactoryBot.create(:account)
    expect(account).to be_valid
  end

  context 'メールアドレス' do
    context 'Valid' do
      [
        'me@akki.jp',
        'me+test-1@akki.jp',
        'me+test-2@akki.jp.aaa',
        'me+test-2@aaa.akki.jp',
      ].each do |email|
        it "「#{email}」is Valid" do
          account = FactoryBot.build(:account, email: email)
          expect(account).to be_valid
        end
      end
    end

    context 'Invalid' do
      [
        'aaaa',
        'aaa@',
        '    '
      ].each do |email|
        it "「#{email}」is Invalid" do
          account = FactoryBot.build(:account, email: email)
          expect(account).to be_invalid
        end
      end
    end
  end


  context 'パスワード' do
    context '文字数' do
      context 'Valid' do
        [
          "pW0d#{'a' * 4}",
          "pW0d#{'a' * (32 - 4)}",
        ].each do |password|
          it "「#{password}」is Valid" do
            account = FactoryBot.build(:account, password: password, password_confirmation: password)
            expect(account).to be_valid
          end
        end
      end

      context 'Invalid' do
        [
          "pW0d#{'a' * 3}",
          "pW0d#{'a' * (32 - 3)}",
        ].each do |password|
          it "「#{password}」is Invalid" do
            account = FactoryBot.build(:account, password: password, password_confirmation: password)
            expect(account).to be_invalid
          end
        end
      end
    end

    context '大文字小文字数字が必要' do
      context 'Valid' do
        [
          'pW0dpW0d',
          'Aa1aA1aA',
          '!a1!a1!a1',
        ].each do |password|
          it "「#{password}」is Valid" do
            account = FactoryBot.build(:account, password: password, password_confirmation: password)
            expect(account).to be_valid
          end
        end
      end

      context 'Invalid' do
        [
          '0' * 8,  
          'a' * 8,
          'A' * 8,
          '!' * 8,
        ].each do |password|
          it "「#{password}」is Invalid" do
            account = FactoryBot.build(:account, password: password, password_confirmation: password)
            expect(account).to be_invalid
          end
        end
      end
    end

    context '脆弱なパスワードを弾く' do

      context 'Invalid' do
        [
          'qwertyuiop',
          'password',
          'zag12wsx',
          '12345678',
          'homelesspa',
          'password1',
        ].each do |password|
          it "「#{password}」is Invalid" do
            account = FactoryBot.build(:account, password: password, password_confirmation: password)
            expect(account).to be_invalid
          end
        end
      end

    end

    context '確認用パスワード必要' do
      [
        'password',
      ].each do |password|
        it "「#{password}」is Valid" do
          account = FactoryBot.build(:account, password: password, password_confirmation: password)
          expect(account).to be_valid
        end
      end

      [
        'password',
      ].each do |password|
        it "「#{password}」is Invalid" do
          account = FactoryBot.build(:account, password: password, password_confirmation: password)
          expect(account).to be_invalid
        end
      end
    end
  end

end
