module ApplicationHelper
   include Blacklight::BlacklightHelperBehavior

  def application_name
    "Rush Dew Holt | WVU Libraries"
  end

  def render_page_description 
    "The Rush Dew Holt Political Cartoons digital collection makes publically available the hundreds of political cartoons about the legislator from newspapers across America."
  end

  def render_key_words 
    "Rush Dew Holt, Rush Holt, Holt, Political Cartoons, Special Collections"
  end 
end
