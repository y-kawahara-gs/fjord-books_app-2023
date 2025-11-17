# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  def setup
    @edit_user = users(:editable_user)
    @not_edit_user = users(:not_editable_user)
    @report = reports(:editable_report)
  end

  test '#editable?' do
    assert @report.editable?(@edit_user)
    assert_not @report.editable?(@not_edit_user)
  end

  test '#created_on' do
    assert_equal @report.created_at.to_date, @report.created_on
  end
end
