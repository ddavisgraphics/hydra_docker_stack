# Image Viewer Class 
class ImageviewersController < ApplicationController
  ## gets image and shows image
  def index
    holt = Holt.where(identifier: params[:id]).first
    @image = params[:type].to_s.downcase == 'thumbnail' ? holt.thumbnail_file.content : holt.image_file.content
    render "index.jpg.erb", layout: false
  end
end