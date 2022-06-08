class User < ApplicationRecord
	# Returns the hash digest of the given string.
	attr_accessor :remember_token
	def User.digest string
		cost = if ActiveModel::SecurePassword.min_cost
				BCrypt::Engine::MIN_COST
			else
				BCrypt::Engine.cost
			end
		BCrypt::Password.create string, cost: cost
	end

	class << self
		def new_token
			SecureRandom.urlsafe_base64
		end
	end

	def remember
		self.remember_token = User.new_token
		update_attribute :remember_digest, User.digest(remember_token)
	end

	def authenticated? remember_token
		BCrypt::Password.new(remember_digest).is_password? remember_token
	end

	# Forgets a user.
	def forget
		update_attribute :remember_digest, nil
	end

	validates :password, presence: true, length: {minimum: 6}, allow_nil: true
end