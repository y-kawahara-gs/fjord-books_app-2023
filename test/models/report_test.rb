# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  def setup
    @test_user1 = users(:test_user1)
    @test_user2 = users(:test_user2)
    @test_report = reports(:test_report1)
  end

  test '#editable?' do
    test_report = @test_report
    test_report.user = @test_user1

    assert test_report.editable?(@test_user1)
    assert_not test_report.editable?(@test_user2)
  end

  test '#created_on' do
    test_report = @test_report
    test_report.created_at = 'Thu, 18 Nov 2025 11:12:04.733175000 JST +09:00'
    assert_equal '2025-11-18', test_report.created_on.to_s
  end

  test '#save_mentions' do
    test_report1 = @test_report
    test_report2 = reports(:test_report2)
    test_report3 = reports(:test_report3)

    test_report1.content = "http://localhost:3000/reports/#{test_report2.id}と\nhttp://localhost:3000/reports/#{test_report3.id}はとても参考になりました。"
    test_report1.save
    assert_includes test_report2.mentioned_reports, test_report1
    assert_includes test_report1.mentioning_reports, test_report2
    assert_includes test_report3.mentioned_reports, test_report1
    assert_includes test_report1.mentioning_reports, test_report3

    test_report4 = reports(:test_report4)
    test_report4.active_mentions.create(mentioned: test_report2)
    test_report4.content = "http://localhost:3000/reports/#{test_report3.id}はとても参考になりました。"
    test_report4.save
    assert_not_includes test_report2.mentioned_reports, test_report4
    assert_not_includes test_report4.mentioning_reports, test_report2
    assert_includes test_report3.mentioned_reports, test_report4
    assert_includes test_report4.mentioning_reports, test_report3

    test_report2.active_mentions.create(mentioned: test_report3)
    test_report2.content = '今日は頑張りました。'
    test_report2.save
    assert_not_includes test_report3.mentioned_reports, test_report2
    assert_not_includes test_report2.mentioning_reports, test_report3
  end
end
