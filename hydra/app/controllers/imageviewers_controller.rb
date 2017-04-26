# Image Viewer Class 
class ImageviewersController < ApplicationController
  ## gets image and shows image
  def index
    @image = Holt.find(params[:id]).getImage(params[:type])
    render "index.jpg.erb", layout: false
  end
end