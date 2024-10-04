FactoryBot.define do
  factory :project_mission_task do
    project_mission { nil }
    task { nil }
    status { 1 }
    role { 1 }
  end
end
