FactoryBot.define do
  
  factory :task do
    name { "task" }
  end

  factory :taskA, class: Task do
    name { "task-A" }
  end

  factory :taskB, class: Task do
    name { "task-B" }
  end

  factory :taskC, class: Task do
    name { "task-C" }
  end

end
