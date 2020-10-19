require_relative './node.rb'
require_relative 'constants.rb'
require_relative "./relation_types/father.rb"
require_relative "./relation_types/son.rb"

class Tree
  attr_accessor :root, :relations

  def apply_relation relation
    source_node  = find_or_initialize_node(relation.source)
    destination_node = find_or_initialize_node(relation.destination)

    relation.relation_type.actions.each { |action| action.execute(root, source_node, destination_node) }
    assign_gender(relation)
    assign_root(relation, source_node, destination_node) unless root
  end

  def find_node member
    queue = [root]
    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.members.include?(member)
      queue.push(*current_node.children) if !current_node.children.empty?
    end
  end

  def get_parent node
    queue = [root]
    until queue.empty?
      current_node = queue.shift
      if current_node.children.include?(node)
        return current_node
      end
      queue.push(*current_node.children) if !current_node.children.empty?
    end
  end

  private
    def initialize
      self.relations = [RelationTypes::Father.new, RelationTypes::Son.new]
    end

    def assign_gender relation
      relation.source.gender = Constants::MALE if relation.relation_type.class == RelationTypes::Son
      relation.source.gender = Constants::MALE if relation.relation_type.class == RelationTypes::Father
    end

    def assign_root relation, source_node, destination_node
      root = destination_node if relation.relation_type.class == RelationTypes::Son
      root = source_node if relation.relation_type.class == RelationTypes::Father
      self.root = root
    end

    def find_or_initialize_node member
      return new_node(member) unless root
      node = find_node(member)
      return node if node
      return new_node(member)
    end

    def new_node member
      new_node = Node.new
      new_node.members.push(member)
      new_node
    end
end