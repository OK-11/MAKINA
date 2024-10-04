FactoryBot.define do
  factory :project do
    name { "project" }
  end

  factory :project2, class: Project  do
    name { "project2" }
  end
end
