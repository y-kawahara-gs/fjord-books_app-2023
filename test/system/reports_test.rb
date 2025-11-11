# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    visit root_url
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'Password!'
    click_button 'ログイン'
    assert_text 'ログインしました'
  end

  test 'create report' do
    visit reports_url
    click_on '日報の新規作成'

    fill_in 'タイトル', with: '今日の日報'
    fill_in '内容', with: '色んなことをした'
    click_on '登録する'

    assert_text '日報が作成されました。'
    assert_text '今日の日報'
    assert_text '色んなことをした'
    click_on '日報の一覧に戻る'
  end

  test 'update report' do
    report = reports(:alice_report)
    visit report_url(report)
    assert_text 'About muscle'
    assert_text 'memo'
    click_on 'この日報を編集'
    fill_in 'タイトル', with: '筋肉について'
    fill_in '内容', with: 'メモ'
    click_on '更新する'

    assert_text '日報が更新されました。'
    visit report_url(report)
    assert_text  '筋肉について'
    assert_text  'メモ'
  end

  test 'destroy report' do
    report = reports(:alice_report)
    visit report_url(report)
    assert_text 'About muscle'
    assert_text 'memo'
    click_on 'この日報を削除'
    assert_selector 'h1', text: '日報の一覧'
    refute_text 'About muscle'
  end
end
