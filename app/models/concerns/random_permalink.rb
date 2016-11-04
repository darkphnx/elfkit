module RandomPermalink
  extend ActiveSupport::Concern

  included do
    before_validation :assign_random_permalink
  end

  def to_param
    permalink
  end

  private

  def assign_random_permalink
    self.permalink ||= generate_unique_permalink
  end

  def generate_unique_permalink
    loop do
      permalink_candidate = SecureRandom.hex(3)
      return permalink_candidate unless self.class.where(:permalink => permalink_candidate).first
    end
  end
end