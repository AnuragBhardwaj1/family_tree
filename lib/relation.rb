class Relation
  attr_accessor :source, :destination, :relation_type

  private
    def initialize  source, destination, relation_type
      self.source = source
      self.destination = destination
      self.relation_type = relation_type
    end
end