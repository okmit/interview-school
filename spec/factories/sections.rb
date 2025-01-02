FactoryBot.define do
  factory :section do
    teacher { nil }
    subject { nil }
    classroom { nil }
    start_time { "2025-01-02 14:35:02" }
    end_time { "2025-01-02 14:35:02" }
    days { "MyString" }
  end
end
