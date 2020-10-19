class Education
  attr_accessor :college_name, :year_of_graduation

  private
    def initialize college_name, year_of_graduation
      self.college_name = college_name
      self.year_of_graduation = year_of_graduation
    end
end