RSpec.shared_examples "it has a permalink" do
  it { is_expected.to validate_uniqueness_of(:permalink) }
end
