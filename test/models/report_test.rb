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

  test '#mention' do
    test_report = @test_report
    test_report.content = ''
  end
end
