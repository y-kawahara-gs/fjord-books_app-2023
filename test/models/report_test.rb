# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test '#recommend' do
    report = reports(:alice_report)
    assert_equal 'I recommend About muscle.', report.recommend
  end
end
