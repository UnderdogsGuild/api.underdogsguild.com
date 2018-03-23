class Permission < ApplicationRecord
  has_and_belongs_to_many :users
  has_and_belongs_to_many :roles

  validates :name, presence: true, uniqueness: true
  validates :internal_name, presence: true, uniqueness: true,
            format: { with: /\A[a-z_]+\z/, message: 'only allows lowercase letters and underscores'}

  def indirect_users
    User.from("(users INNER JOIN (roles_users INNER JOIN permissions_roles ON roles_users.role_id = permissions_roles.role_id) ON users.id = roles_users.user_id) WHERE permissions_roles.permission_id = #{self.id}")
  end

  def all_users
    User.from("(#{self.users.to_sql} UNION #{self.indirect_users.to_sql}) as users")
  end

  def to_param
    self.internal_name
  end
end
