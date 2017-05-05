# Adds a few additional behaviors into the application controller
class ApplicationController < ActionController::Base
  include Blacklight::Controller
  include Hydra::Controller::ControllerBehavior

  layout 'blacklight'
  
  protect_from_forgery with: :exception

  def show_only_holt_records (solr_parameters, _user_parameters)
    # add a new solr facet query ('fq') parameter that limits results to those with a 'public_b' field of 1 
    solr_parameters[:fq] ||= []
    solr_parameters[:fq] << 'project_tesim:holt'
  end
end
