class User < ActiveRecord::Base
	has_many :comments
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
     :omniauthable, :omniauth_providers => [:facebook]
  # USED FOR PROFILE PICTURE: LIBRARY
  include Gravtastic
	gravtastic :size => 50,
						 :default => 'mm'


  def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uuid = auth.uuid
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
      end
  end
end
