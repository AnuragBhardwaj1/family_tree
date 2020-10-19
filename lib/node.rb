class Node
  attr_accessor :level, :children, :members, :primary, :profession, :student


  def primary
    @primary || members.first
  end
  private
    def initialize
      self.members = []
      self.children = []
    end
end