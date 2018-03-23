require 'uri'

class ApplicationController < ActionController::API
  def list_action(uri)
    File.basename(URI.parse(uri).path)
  end
end
