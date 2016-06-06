class User < ApplicationRecord
	include Filterable
	scope :email, -> (email) { where("email like ?", "#{email}%")}
	scope :starts_with, -> (name) { where("name like ?", "#{name}%")}
	#Assign an API key on create
	before_create do |user|
		user.api_key = user.generate_api_key		
	end

	#Generate a unique API key
	def generate_api_key
		loop do
			token = SecureRandom.base64.tr('+/=', 'Qrt')
			break token unless User.exists?(api_key: token)
		end
	end
end
