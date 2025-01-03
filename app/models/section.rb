class Section < ApplicationRecord
  VALID_DAYS = %w[Monday Tuesday Wednesday Thursday Friday Saturday Sunday].freeze
  EARLIEST_START_TIME_MINUTES = 7 * 60 + 30 # 7:30 AM
  LATEST_END_TIME_IN_MINUTES = 22 *  60 # 10:00 PM
  VALID_DURATION_IN_MINUTES = [ 50, 80 ]

  belongs_to :teacher
  belongs_to :subject
  belongs_to :classroom
  has_and_belongs_to_many :students

  validates :start_time, :end_time, :days, presence: true

  validate :validate_time_range
  validate :validate_duration
  validate :validate_days

  private

  def validate_time_range
    return if start_time.blank? || end_time.blank? || !start_time.is_a?(Time) || !end_time.is_a?(Time)

    start_time_in_minutes = start_time.hour * 60 + start_time.min
    end_time_in_minutes = end_time.hour * 60 + end_time.min

    if start_time_in_minutes < EARLIEST_START_TIME_MINUTES || start_time_in_minutes > LATEST_END_TIME_IN_MINUTES
      errors.add(:start_time, "must be between 7:30 AM and 10:00 PM")
    end

    if end_time_in_minutes < EARLIEST_START_TIME_MINUTES || end_time_in_minutes > LATEST_END_TIME_IN_MINUTES
      errors.add(:end_time, "must be between 7:30 AM and 10:00 PM")
    end

    if start_time >= end_time
      errors.add(:end_time, "must be after start time")
    end
  end

  def validate_duration
    return if start_time.blank? || end_time.blank? || !start_time.is_a?(Time) || !end_time.is_a?(Time)

    duration_in_minutes = ((end_time - start_time) / 60).to_i # time in mins = sec / 60 sec per min

    unless VALID_DURATION_IN_MINUTES.include?(duration_in_minutes)
      errors.add(:duration, "Section duration must be either 50 or 80 minutes")
    end
  end

  def validate_days
    return if days.blank? || !days.is_a?(Array)

    invalid_days = days - VALID_DAYS

    if invalid_days.any?
      errors.add(:days, "contains invalid days: #{invalid_days.join(', ')}")
    end
  end
end
