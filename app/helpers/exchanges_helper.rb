module ExchangesHelper
  def countdown_timer(deadline)
    return "Any minute now" if deadline.past?
    distance_of_time_in_words(Time.now.utc, deadline, true)
  end
end
