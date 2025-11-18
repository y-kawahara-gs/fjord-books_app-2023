# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test '#name_or_email' do
    test_user = users(:model_test_user)
    test_user.name = 'Alice'
    test_user.email = 'alice@example.com'

    assert_equal 'Alice', test_user.name_or_email

    test_user.name = ''
    assert_equal 'alice@example.com', test_user.name_or_email
  end
end
