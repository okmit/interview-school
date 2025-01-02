class SectionSerializer
  include JSONAPI::Serializer

  attributes :id, :days

  attribute :teacher_name do |section|
    section.teacher.name
  end

  attribute :subject_name do |section|
    section.subject.name
  end

  attribute :start_time do |section|
    section.start_time.strftime("%H:%M %p")
  end

  attribute :end_time do |section|
    section.end_time.strftime("%H:%M %p")
  end
end
