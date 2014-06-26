module ApplicationHelper
  def options_for_video_review(selected=nil)
    options_for_select([5,4,3,2,1].map {|num| [pluralize(num, "Star"), num]},selected)
  end
  def display_service_period(datetime)
    "#{datetime.strftime("%d/%m/%Y")} - #{(datetime + 1.months - 1.days).strftime("%d/%m/%Y")}" 
  end
end
