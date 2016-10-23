class BlogsController < ApplicationController

	skip_before_filter :authenticate_user!

	def index
	end

	def show
		render "#{params[:title]}"
	end
	
end
