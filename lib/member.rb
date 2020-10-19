class Member
  attr_accessor :name, :gender

  private
    def initialize name=nil, gender=nil
      self.name = name
      self.gender = gender
    end
end