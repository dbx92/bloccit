class User < ApplicationRecord

has_many :posts, dependent: :destroy
  before_save { self.email = email.downcase if email.present? }
  before_save { self.name = name.split(' ').map {|x| x.capitalize}.join(' ') if name.present?}

validates :name, length: { minimum: 1, maximum: 100 }, presence: true, uniqueness: { case_sensitive:true }

validates :password, presence: true, length: { minimum: 6 }, if: "password_digest.nil?"
validates :password, length: { minimum: 6 }, allow_blank: true

validates :email,
          presence: true,
          uniqueness: { case_sensitive: true },
          length: { minimum: 3, maximum: 254 }


has_secure_password

end
