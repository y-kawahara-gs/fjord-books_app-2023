# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test '#name_or_email' do
    name_user = users(:name_user)
    no_name_user = users(:no_name_user)

    assert_equal 'Alice', name_user.name_or_email
    assert_equal 'bob@example.com', no_name_user.name_or_email
  end
end
