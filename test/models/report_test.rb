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
    test_report.created_at = "Thu, 18 Nov 2025 11:12:04.733175000 JST +09:00"
    assert_equal "2025-11-18", "#{test_report.created_on}"
  end

  test '#save_mentions' do
    test_report1 = @test_report
    test_report2 = reports(:test_report2)
    test_report3 = reports(:test_report3)
    test_report1.content = "http://localhost:3000/reports/#{test_report2.id}"
    test_report1.save
    test_report1.reload
    test_report2.reload
    assert_equal test_report1, test_report2.mentioned_reports[0]

    test_report1.content = "http://localhost:3000/reports/#{test_report3.id}"
    test_report1.save
    test_report1.reload
    test_report2.reload

    refute test_report2.mentioned_reports[0]
    assert_equal test_report1, test_report3.mentioned_reports[0]

    test_report1.content = "ないよう１"
    test_report1.save
    test_report1.reload
    test_report3.reload
    refute test_report1.mentioning_reports[0]

  end
end
