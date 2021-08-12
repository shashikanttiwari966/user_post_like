module CommentsHelper
	def comment_by user
		user = User.find(user)
		@name = user.user_name
		return @name
	end	
end
