require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(username: 'faore', email: "faore@admt.im", password: 'pony')

  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'username should not be blank' do
    @user.username = ''
    assert_not @user.valid?
    @user.username = '          '
    assert_not @user.valid?
    @user.username = 'faore'
  end

  test 'username and email should be unique' do
    @user.save

    dupe = @user.dup
    assert_not dupe.valid?

    # Duplicate Email
    dupe.username = 'not_faore'
    assert_not dupe.valid?

    # Duplicate Username
    dupe.username = 'faore'
    dupe.email = 'different@email.com'
    assert_not dupe.valid?

    # No duplicates
    dupe.username = 'foo'
    assert dupe.valid?
  end

  test 'email should be in email format' do
    @user.email = 'doom'
    assert_not @user.valid?
    @user.email = 'doom@gloom'
    assert_not @user.valid?
    @user.email = 'do@@d.com'
    assert_not @user.valid?
  end
end
