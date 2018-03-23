class User < ApplicationRecord
  has_and_belongs_to_many :roles
  has_and_belongs_to_many :permissions

  has_secure_password

  validates :username, presence: true, length: { maximum: 50 }, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true

  def indirect_permissions
    Permission.from("permissions INNER JOIN (roles_users INNER JOIN permissions_roles ON roles_users.role_id = permissions_roles.role_id) ON permissions.id = permissions_roles.permission_id WHERE roles_users.user_id = #{self.id}")
  end

  def all_permissions
    Permission.from("(#{self.permissions.to_sql} UNION #{self.indirect_permissions.to_sql}) as permissions")
  end

  def can(permission)
    permission = Permission.find_by(internal_name: permission) unless permission.is_a? Permission
    all_permissions.where(id: permission.id).length == 1
  end
end
