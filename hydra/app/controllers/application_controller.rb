# Adds a few additional behaviors into the application controller
class ApplicationController < ActionController::Base
  include Blacklight::Controller
  include Hydra::Controller::ControllerBehavior
  layout 'blacklight'
  protect_from_forgery with: :exception
end
