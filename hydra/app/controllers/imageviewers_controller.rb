# Image Viewer Class 
class ImageviewersController < ApplicationController
  ## gets image and shows image
  def index
    record_id = CGI::unescape(params[:id])
    holt = Holt.find(record_id)
    @image = params[:type].to_s.downcase == 'thumbnail' ? holt.thumbnail_file.content : holt.image_file.content
    render "index.jpg.erb", layout: false
  end
end