# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test '#name_or_email' do
    test_user = users(:test_user1)
    test_user.name = 'Alice'
    test_user.email = 'alice@test.com'

    assert_equal 'Alice', test_user.name_or_email

    test_user.name = ''
    assert_equal 'alice@test.com', test_user.name_or_email
  end
end
