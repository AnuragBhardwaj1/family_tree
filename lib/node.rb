class Node
  attr_accessor :children, :members, :primary


  def primary
    @primary || members.first
  end

  def spouse
    (members - [primary]).first
  end

  private
    def initialize
      self.members = []
      self.children = []
    end
end