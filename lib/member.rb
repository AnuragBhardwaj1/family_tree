require_relative './constants.rb'
class Member
  attr_accessor :name, :gender, :profession, :student

  def doctor?
    profession == Constants::DOCTOR
  end

  def doctor?
    profession == Constants::LAWYER
  end

  def student?
    !!student
  end

  def make_doctor
    self.profession = Constants::DOCTOR
  end

  def make_lawyer
    self.profession = Constants::LAWYER
  end

  def make_student
    self.student = true
  end

  private
    def initialize name=nil, gender=nil
      self.name = name
      self.gender = gender
      self.student = false
    end
end