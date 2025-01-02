class SectionStudent < ApplicationRecord
  belongs_to :section
  belongs_to :student

  validates :student_id, uniqueness: { scope: :section_id, message: "has already been added to this section" }
end
