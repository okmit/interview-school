module Sections
  class AddService
    def initialize(section_id:, student_id:)
      @section = Section.find_by(id: section_id)
      @student = Student.find_by(id: student_id)
    end

    def call
      validate
      return response if errors?

      save
      response
    end

    private

    attr_reader :section, :student

    def validate
      errors << { message: "Section not found" } unless section
      errors << { message: "Student not found " } unless student

      return if errors?

      if section.section_students.exists?(student: student)
        errors << { message: "Section for student exist" }
      end

      return if errors?

      if overlap?
        errors << { message: "Section overlaps with another section" }
      end
    end

    def overlap?
      student.sections.where(
        "days && ARRAY[?]::varchar[] AND start_time < ? AND end_time > ?",
        section.days, section.end_time, section.start_time
      ).exists?
    end

    def save
      return if errors?

      section_student = section.section_students.build(student: student)

      unless section_student.save
        errors.concat(section_student.errors.full_messages.map { |msg| { message: msg } })
      end
    end

    def response
      {
        success: !errors?,
        data: response_data,
        errors: errors
      }
    end

    def response_data
      return if errors?
      {
        student: {},
        section: {}
      }
    end

    def errors
      @errors ||= []
    end

    def errors?
      errors.any?
    end
  end
end
