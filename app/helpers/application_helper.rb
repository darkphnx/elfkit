module ApplicationHelper
  def title(set = nil)
    @title = set if set

    "".tap do |s|
      s << @title << ' - ' if @title
      s << 'Elfkit'
    end
  end

  def display_flash
    flashes = flash.map do |type, message|
      content_tag(:div, message, class: "flash flash--#{type}")
    end

    safe_join(flashes, "\n")
  end

  def errors_for(object)
    return unless object.errors.any?

    content_tag(:div, class: 'form-errors') do
      safe_join([error_title(object), error_list(object)], "\n")
    end
  end

  def error_title(object)
    content_tag(:h4, "#{pluralize(object.errors.count, "error")} prevented this #{object.model_name.human} " \
      "from being saved:")
  end

  def error_list(object)
    content_tag(:ul) do
      errors = object.errors.full_messages.map do |message|
        content_tag(:li, message)
      end

      safe_join(errors)
    end
  end
end
