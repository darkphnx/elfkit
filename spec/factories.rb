FactoryGirl.define do
  factory :exchange do
    title "Bob's Secret Santa"
    match_at { 1.week.from_now }
    exchange_at { 2.weeks.from_now }
  end

  factory :participant do
    name "Bob"
    sequence :email_address do |n|
      "#{name}#{n}@example.com"
    end
    exchange
  end
end
