FactoryBot.define do
  factory :notice do
    comment { nil }
    user { nil }
    status { 1 }
  end
end
