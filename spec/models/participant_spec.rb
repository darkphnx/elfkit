require 'rails_helper'
require 'models/shared_examples_for_permalinks'

RSpec.describe Participant, type: :model do
  describe "validations" do
    it_should_behave_like "it has a permalink"
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email_address) }
  end
end
