require 'rails_helper'

RSpec.describe CategoryWebSiteInfo, type: :model do
  before do
    @category_web_site_info = FactoryBot.build(:category_web_site_info)
  end

  describe 'カテゴリとサイト情報、サブカテゴリの保存' do
    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@category_web_site_info).to be_valid
        sleep 0.5 # DBの処理に時間がかかるため、時間を置きます。
      end
    end

    context '内容に問題がある場合' do
      it 'URLがリンク切れの場合、保存できないこと' do
        @category_web_site_info.site_URL = "http://abcdefg"
        @category_web_site_info.valid?
        expect(@category_web_site_info.errors.full_messages).to include("提供されたURLは無効またはリンクが切れています。")
        sleep 0.5
      end
      it 'URLが登録済みの場合、保存できないこと' do
        another_category_web_site_info = FactoryBot.build(:category_web_site_info)
        another_category_web_site_info.save
        @category_web_site_info.valid?
        expect(@category_web_site_info.errors.full_messages).to include('すでに登録されています。')
        sleep 0.5
      end
      it 'カテゴリ名がない場合、保存できないこと' do
        @category_web_site_info.category_name = ''
        @category_web_site_info.valid?
        expect(@category_web_site_info.errors.full_messages).to include("Category name can't be blank")
        sleep 0.5
      end
      it 'サイトのタイトルがない場合、保存できないこと' do
        @category_web_site_info.site_title = ''
        @category_web_site_info.valid?
        expect(@category_web_site_info.errors.full_messages).to include("Site title can't be blank")
        sleep 0.5
      end
      it 'サイトのタイトルが文字数オーバーの場合、保存できないこと' do
        @category_web_site_info.site_title = 'a'*201
        @category_web_site_info.valid?
        expect(@category_web_site_info.errors.full_messages).to include("Site title is invalid. 100 characters max.")
        sleep 0.5
      end
      it '要約文がない場合、保存できないこと' do
        @category_web_site_info.summary_text = ''
        @category_web_site_info.valid?
        expect(@category_web_site_info.errors.full_messages).to include("Summary text can't be blank")
        sleep 0.5
      end
      it '要約文の文字数がオーバーしている場合、保存できないこと' do
        @category_web_site_info.summary_text = 'b'*281
        @category_web_site_info.valid?
        expect(@category_web_site_info.errors.full_messages).to include('Summary text is invalid. 140 characters max.')
        sleep 0.5
      end
      it 'URLがない場合、保存できないこと' do
        @category_web_site_info.site_URL = ''
        @category_web_site_info.valid?
        expect(@category_web_site_info.errors.full_messages).to include("Site url can't be blank")
        sleep 0.5
      end
      it 'URLが[http, https]でない場合、保存できないこと' do
        @category_web_site_info.site_URL = 'abcdefghij'
        @category_web_site_info.valid?
        expect(@category_web_site_info.errors.full_messages).to include('Site url is invalid.')
        sleep 0.5
      end
      it 'サブカテゴリ名がない場合、保存できないこと' do
        @category_web_site_info.scategory_names = ''
        @category_web_site_info.valid?
        expect(@category_web_site_info.errors.full_messages).to include("Scategory names can't be blank")
        sleep 0.5
      end
    end
  end
end
