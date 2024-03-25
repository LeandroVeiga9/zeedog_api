class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  def generate_jwt
    JWT.encode({id: id, exp: 3.days.from_now.to_i}, ENV['SECRET_KEY_BASE'])
  end
end
