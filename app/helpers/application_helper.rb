module ApplicationHelper
  def full_title(page_title = ' ')
    base_title = 'Eureka Caffe'
    if page_title.empty?
      base_title
    else
      page_title + ' - ' + base_title
    end
  end

  def active_class(path)
    current_page?(path) ? 'current-page' : ''
  end

  def active_dashboard(path)
    current_page?(path) ? 'current-dashboard route' : 'route'
  end

  def current_request?(*requests)
    requests.each do |request|
      if request[:controller] == controller.controller_name
        return true if request[:action].is_a?(Array) && request[:action].include?(controller.action_name)
        return true if request[:action] == controller.action_name
      end
    end
    false
  end
end
