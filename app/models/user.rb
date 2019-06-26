class User < ActiveRecord::Base
    has_secure_password

    validates_presence_of :name, :email, :password, :password_digest
end