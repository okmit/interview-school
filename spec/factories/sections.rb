FactoryBot.define do
  factory :section do
    teacher { nil }
    subject { nil }
    classroom { nil }
    start_time { Time.zone.parse("7:30 AM") }
    end_time { Time.zone.parse("8:20 AM") }
    days { [ "Monday" ] }
  end
end
