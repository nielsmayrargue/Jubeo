require 'oembed'

class PagesController < ApplicationController

skip_before_filter :authenticate_user!, :only => [:home]

def home
	redirect_to tracks_url if user_signed_in?
end

def dashboard
end

end
