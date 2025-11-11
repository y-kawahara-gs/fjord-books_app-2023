# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test '#greet' do
    user = users(:alice)
    assert_equal 'Hi! I`m Alice.', user.greet
  end
end
