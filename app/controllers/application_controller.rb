class ApplicationController < ActionController::Base
  
  before_action :basic
  
  private
  def basic
    name = 'aaa'
    passwd = 'bbb'
    # name  = ENV['NAME']
    # passwd = ENV['PASSWD']
    authenticate_or_request_with_http_basic('BA') do |n, p|
      n == name && p == passwd
    end
  end
end
