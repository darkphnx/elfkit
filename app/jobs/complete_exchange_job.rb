class CompleteExchangeJob < ApplicationJob
  def perform
    Exchange.require_completing.each(&:complete!)
  end
end
