module CustomHelpers

  def status_bullet bol
    status = bol ? "active" : "inactive"
    icon = bol ? "circle" : "circle-o"
    klass = "tip "
    klass += bol ? "bullet-active" : "bullet-inactive"    
    message = data.messages[status]
    icon(icon, "", class: klass, title: message)
  end

  def icon(icon, text="", html_options={})
    content_class = "fa fa-#{icon}"
    content_class << " #{html_options[:class]}" if html_options.key?(:class)
    html_options[:class] = content_class

    html = content_tag(:i, nil, html_options)
    html << " #{text}" unless text.blank?
    html
  end

end
