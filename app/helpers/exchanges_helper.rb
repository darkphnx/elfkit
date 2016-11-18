module ExchangesHelper
  def countdown_timer(deadline)
    content_tag(:span, '', data: { date: deadline.to_s(:iso8601) }, class: 'js-countdown-timer')
  end

  def datepicker_field(objectname, fieldname, selected_time)
    selected_time = selected_time.beginning_of_hour

    content_tag(:div, class: 'js-datepicker', data: { date: selected_time.to_s(:iso8601) }) do
      components = [].tap do |s|
        s << dateselect_field(fieldname, selected_time)
        s << timeselect_field(fieldname, selected_time)
        s << datepicker_hidden_fields(objectname, fieldname, selected_time)
      end

      safe_join(components, " ")
    end
  end

  def dateselect_field(fieldname, _selected_time)
    text_field_tag "#{fieldname}_date", '', placeholder: "Click to select", value: '',
      class: 'u-two-thirds-width js-datepicker--date'
  end

  def timeselect_field(fieldname, selected_time)
    options = (0..23).map { |hour| ["#{hour.to_s.rjust(2, '0')}:00", hour] }
    select_tag "#{fieldname}_time", options_for_select(options, selected_time.hour),
      class: 'u-one-third-width js-datepicker--time'
  end

  def datepicker_hidden_fields(objectname, fieldname, selected_time)
    parts = [:year, :month, :day, :hour, :min].each_with_index.map do |time_part, i|
      hidden_field_tag("#{objectname}[#{fieldname}(#{i}i)]", selected_time.send(time_part),
        class: "js-datepicker--hidden js-datepicker--#{time_part}")
    end

    safe_join(parts, " ")
  end
end
