class Section < ApplicationRecord
  belongs_to :teacher
  belongs_to :subject
  belongs_to :classroom

  validates :start_time, :end_time, :days, presence: true
end
