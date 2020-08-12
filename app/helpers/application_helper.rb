module ApplicationHelper

  def full_title(page_title = ' ')
    base_title = "Eureka Caffe"
    if page_title.empty?
      base_title
    else
      page_title + " - " + base_title
    end
  end

  def active_class(path)
    current_page?(path) ? 'current-page' : ''
  end
end
