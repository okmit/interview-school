module Sections
  class RemoveService
    def initialize(section_id:, student_id:)
      @section = Section.find_by(id: section_id)
      @student = Student.find_by(id: student_id)
    end

    def call
      validate
      return response if errors?

      remove
      response
    end

    private

    attr_reader :section, :student

    def validate
      errors << { message: "Section not found" } unless section
      errors << { message: "Student not found " } unless student

      return if errors?

      unless section.students.exists?(id: student.id)
        errors << { message: "Section for student does not exists" }
      end
    end


    def remove
      return if errors?

      unless section.students.delete(student)
        errors.concat(section.errors.full_messages.map { |msg| { message: msg } })
      end
    end

    def response
      {
        success: !errors?,
        errors: errors
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
