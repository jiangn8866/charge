class User < ApplicationRecord

  attr_accessor :login

  # rails g devise user
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # BUG --- 加s
  has_many :accounts


  ADMIN_ID = 559

  def admin?
    return self.id == ADMIN_ID
  end


  protected

  def self.find_for_database_authentication warden_conditions
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    logger.debug(login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", {value: login.strip.downcase}]).first
  end


end
