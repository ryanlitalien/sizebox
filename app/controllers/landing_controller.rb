require 'dropbox-api'

class LandingController < ApplicationController

  def index
    if Rails.env.development?
      Dropbox::API::Config.app_key    = AppConstants.dropbox_app_key
      Dropbox::API::Config.app_secret = AppConstants.dropbox_app_secret
      Dropbox::API::Config.mode       = AppConstants.dropbox_mode
      @client = Dropbox::API::Client.new(:token => AppConstants.dropbox_access_token, :secret => AppConstants.dropbox_access_secret)
    else
      consumer = Dropbox::API::OAuth.consumer(:authorize)
      request_token = consumer.get_request_token
      request_token.authorize_url(:oauth_callback => 'http://localhost/callback')
      # Here the user goes to Dropbox, authorizes the app and is redirected
      # The oauth_token will be available in the params
      token = request_token.get_access_token(:oauth_verifier => params[:oauth_token])
      @client = Dropbox::API::Client.new :token => token, :secret => secret
    end

    @client.ls.each do |db|
      puts db
      if db.kind_of? Dropbox::API::Dir
        puts "DIR: #{db.path}"
      elsif db.kind_of? Dropbox::API::File
        puts "FILE: #{db.path}"
      end
    end

    #json = User.all( :include => :contacts).to_json( :include => :contacts )
  end
end
