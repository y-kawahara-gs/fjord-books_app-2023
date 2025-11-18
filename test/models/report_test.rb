# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  def setup
    @test_user = users(:model_test_user)
    @test_user_failing = users(:system_test_user)
    @test_report = reports(:test_report)
  end

  test '#editable?' do
    test_report = @test_report

    assert test_report.editable?(@test_user)
    assert_not test_report.editable?(@test_user_failing)
  end

  test '#created_on' do
    test_report = @test_report
    test_report.created_at = "Thu, 18 Nov 2025 11:12:04.733175000 JST +09:00"
    assert_equal "2025-11-18", "#{test_report.created_on}"
  end
end
