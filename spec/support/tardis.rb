# Time And Relative Dimensions In Space
#
# Allow us to travel through time in our tests

RSpec.configure do |config|
  config.include ActiveSupport::Testing::TimeHelpers
end
