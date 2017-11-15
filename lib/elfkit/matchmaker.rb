module Elfkit
  # Takes a set of participants and randomly pairs them up.
  class Matchmaker
    attr_accessor :participants

    # @param [Array<Participant>] The participants to be matched
    def initialize(participants)
      @participants = participants
    end

    # Pair up our participants. Each participant will be included as a gifter and a giftee.
    #
    # @return [Hash<Participant, Participant>] Matched participants, key is gifter, value is giftee
    def pair
      giftees = participants.shuffle

      participants.each_with_object({}) do |gifter, matches|
        giftee = giftees.find { |potential| gifter.acceptable_giftee?(potential) }
        giftees.delete(giftee)

        matches[gifter] = giftee
      end
    end
  end
end
