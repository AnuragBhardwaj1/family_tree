require_relative './professions/doctor.rb'
require_relative './professions/lawyer.rb'
require_relative './education.rb'

class Member
  attr_accessor :name, :gender, :profession, :education
  attr_reader :student

  def doctor?
    profession.is_a? Professions::Doctor
  end

  def lawyer?
    profession.is_a? Professions::Lawyer
  end

  def student?
    !!education
  end

  def make_doctor
    self.profession = Professions::Doctor.new
  end

  def make_lawyer
    self.profession = Professions::Lawyer.new
  end

  def make_student college_name, year_of_graduation
    self.education = Education.new(college_name, year_of_graduation)
  end

  private
    def initialize name=nil, gender=nil
      self.name = name
      self.gender = gender
    end
end