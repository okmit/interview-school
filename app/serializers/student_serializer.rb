class StudentSerializer
  include JSONAPI::Serializer

  attributes :id, :name
end
