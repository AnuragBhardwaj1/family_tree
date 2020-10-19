require 'byebug'
require_relative "./member.rb"
require_relative "./constants.rb"
require_relative "./relation.rb"
require_relative "./tree.rb"
require_relative "./relation_types/father.rb"
require_relative "./relation_types/son.rb"

SUPPORTED_RELATION_TYPES = { father: RelationTypes::Father.new , son: RelationTypes::Son.new }

class FamilyTree
  attr_accessor :members, :relations, :tree, :relation_types

  def add_person member_name, gender=nil
    member = Member.new(member_name)
    member.gender = get_gender(gender) if gender
    self.members << member
  end

  def add_relationship relation_type
    return unless SUPPORTED_RELATION_TYPES.keys.include?(relation_type.to_sym)
    self.relation_types << relation_type
  end

  def connect source_name, destination_name, relation_type_name
    source = members.find { |member| member.name == source_name }
    destination = members.find { |member| member.name == destination_name }
    relation_type = SUPPORTED_RELATION_TYPES[relation_type_name.to_sym]
    return unless source && destination && relation_type

    relation = Relation.new(source, destination, relation_type)
    self.relations.push relation
    apply_relation(relation)
  end

  def immidiate_children member_name, gender=Constants::MALE
    member = member(member_name)
    node = tree.find_node(member)
    node.children.map { |child_node| child_node if child_node.primary && child_node.primary.gender == gender }
  end

  def all member_name, gender=Constants::FEMALE
    member = member(member_name)
    members = bfs(member)
    members.select { |mem| mem.gender == gender }
  end

  def immidiate_cousin member_name
    member = member(member_name)
    node = tree.find_node(member)
    parent_node = get_parent(node)
    parent_node.children.select { |child| child if child != node }
  end

  def apply_relation relation
    tree.apply_relation relation
  end

  private
    def initialize
      self.members = []
      self.relations = []
      self.relation_types = []
      self.tree = Tree.new
    end

    def member member_name
      members.find { |member| member.name == member_name }
    end

    def bfs member
      return [] unless member
      queue, output = [],[]
      queue.push(tree.find_node(member))

      while(queue.size != 0)
        node = queue.shift
        output << node.primary
        node.children.each do |child_node|
          queue.push(child_node)
        end
      end
      output
    end

    def get_gender gender
      if gender == "m" || gender == "male"
        Constants::MALE
      elsif gender == "f" || gender == "female"
        Constants::FEMALE
      end
    end

    def get_parent node
      tree.get_parent node
    #   queue = [self.tree.root]
    #   until queue.empty?
    #     current_node = queue.shift
    #     if current_node.children.include?(node)
    #       debugger
    #       return current_node
    #     end
    #     queue.push(*current_node.children) if !current_node.children.empty?
    #   end
    end
end