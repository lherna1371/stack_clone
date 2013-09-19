module CommentsHelper

	def type_to_s(object)
		object.class.to_s.downcase
	end

end