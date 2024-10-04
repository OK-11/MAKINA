FactoryBot.define do
  factory :mission do
    name { "mission" }
  end

  factory :missionA, class: Mission do
    name { "mission-A" }
  end

  factory :missionB, class: Mission do
    name { "mission-B" }
  end

  factory :missionC, class: Mission do
    name { "mission-C" }
  end
end
