class ExportsController < ApplicationController

	skip_before_action :authenticate_user!, only: %i[homepage]

	def exports
	end

end
