module Elfkit
  # Takes a set of participants and randomly pairs them up.
  class Matchmaker
    attr_accessor :giftees
    attr_reader :participants

    # @param [Array<Participant>] The participants to be matched
    def initialize(participants)
      @participants = participants
    end

    # Pair up our participants. Each participant will be included as a gifter and a giftee.
    #
    # Implementation is as follows:
    #
    # Randomise the order of the participants of using Array#shuffle. Step through the shuffled array for our gifter
    # and add a randomised offset to it's index to get the giftee, the index + offset are run through a mod to allow
    # the results to wrap around to the beginning of the when the end is reached.
    #
    # @yieldparam gifter [Participant] The gifting participant for this match
    # @yieldparam giftee [Participant] The receiving participant for this match
    def pair
      # Randomise the order of the participants because getting them in the order they signed up would be lame
      shuffled_participants = participants.shuffle

      # Ensure offset will not make an element select itself (max = highest index - 1) + 1 to ensure it isn't 0
      #
      # Does shift need to be randomised? Not really, 1 would probably do in all circumstances
      giftee_shift = Kernel.rand(participants.length - 1) + 1

      shuffled_participants.each_with_index.map do |gifter, i|
        giftee_index = (i + giftee_shift) % participants.length
        giftee = shuffled_participants[giftee_index]

        [gifter, giftee]
      end
    end
  end
end
