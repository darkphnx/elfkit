module ExchangesHelper
  def countdown_timer(deadline)
    distance_of_time_in_words(Time.now.utc, deadline, true)
  end
end
