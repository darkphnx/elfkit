module ApplicationHelper
  def title(set = nil)
    @title = set if set

    "".tap do |s|
      s << @title << ' - ' if @title
      s << 'Elfkit'
    end
  end
end
