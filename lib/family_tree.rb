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
    self.members.push(member)
  end

  def add_relationship relation_type
    return unless SUPPORTED_RELATION_TYPES.keys.include?(relation_type.to_sym)
    self.relation_types.push(relation_type)
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

  def apply_relation relation
    tree.apply_relation relation
  end

  # ----------------

  def immidiate_son_count member_name
    immidiate_children(member_name, Constants::MALE).count
  end

  def all_daughters_count member_name
    all(member_name, Constants::FEMALE).count
  end

  def immidiate_cousin_count member_name
    immidiate_cousin(member_name).count
  end

  def wives member_name
    member = member(member_name)
    node = tree.find_node(member)
    node.spouse
  end

  def related member_name1, member_name2
    member1 = member(member_name1)
    member2 = member(member_name2)
    first_member, node = tree.find_first(member1, member2)
    second_member = first_member == member1 ? member2 : member1
    immidiate_cousin(member1.name).include?(second_member) || all(member1.name).include?(second_member) || node.members.include?(second_member)
  end

  def sons_doctor member_name
    sons = all(member_name, Constants::MALE)
    sons.select { |son| son.doctor? }
  end

  def student? member_name
    member = member(member_name)
    member.student?
  end

  def students_are_lawyers
    members.select { |member| member.student? && member.lawyer?}
  end

  

  def immidiate_children member_name, gender=nil
    member = member(member_name)
    children_nodes = tree.immidiate_children(member)
    children_members = primaries(children_nodes)
    filter_with_gender(children_members, gender)
  end

  def all member_name, gender=nil
    member = member(member_name)
    nodes = bfs(member)
    nodes.unshift
    members = primaries(nodes)
    members = filter_with_gender(members, gender)
  end

  def immidiate_cousin member_name
    member = member(member_name)
    node = tree.find_node(member)
    parent_node = get_parent(node)
    cousin_nodes = parent_node.children.select { |child| child if child != node }
    primaries(cousin_nodes)
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
      tree.bfs(member)
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
    end

    def primaries nodes
      nodes.map { |node| node.primary }.compact
    end

    def filter_with_gender members, gender=nil
      gender = get_gender(gender)
      return members unless  gender
      members.select { |member| member.gender == gender }.compact
    end
end