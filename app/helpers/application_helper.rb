module ApplicationHelper

  def show_title(spec_title)
    spec_title.starts_with?('blank') ? '' : spec_title
  end
end
