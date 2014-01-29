module ApplicationHelper

	def companies_names
		Company.select(:name).join(', ')
	end
end
