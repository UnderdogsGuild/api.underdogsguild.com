require 'test_helper'

class PermissionTest < ActiveSupport::TestCase

  def setup
    @perm = Permission.new(internal_name: 'herp_derp', name: 'Herp Derp')
    @test_perm = Permission.first
    @direct_user = User.first
    @indirect_user = User.second
    @test_role = Role.first
    @test_perm.users.append(@direct_user)
    @test_perm.roles.append(@test_role)
    @test_role.users.append(@indirect_user)
  end

  test 'valid permission' do
    assert @perm.valid?
  end
  test 'invalid internal name' do
    @perm.internal_name = 'herp derp'
    assert_not @perm.valid?
  end
  test 'direct_users' do
    assert_equal 1, @test_perm.users.length
    assert_equal @direct_user, @test_perm.users.first
  end
  test 'indirect_users' do
    assert_equal 1, @test_perm.indirect_users.length
    assert_equal @indirect_user, @test_perm.indirect_users.first
  end
  test 'all_users' do
    assert_equal 2, @test_perm.all_users.length
    assert_not_equal @test_perm.all_users.first, @test_perm.all_users.second
  end
  test 'all_users with user in both categories' do
    @test_perm.users.append(@indirect_user)
    assert_equal 2, @test_perm.all_users.length
    @test_perm.users.delete(@indirect_user)
  end
end
