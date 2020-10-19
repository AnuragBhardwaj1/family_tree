module Actions
  class AddFather
    def execute root, father_node, child_node
      # check if relation is already executed
      child_node.primary = child_node.members.first
      father_node.children << child_node
      adjust_gender father_node
      # merge_father_and_mother(root, child_node, father_node)
    end

    def adjust_gender father_node
      return if father_node.members.empty?
      member1 = father_node.members[0]
      member2 = father_node.members[1]
      return if father_node.members.all? { |member| member.gender }
      if member1 && member1.gender
        member2.gender = Constants::FEMALE if member1.gender == Constants::MALE
        member2.gender = Constants::MALE if member1.gender == Constants::FEMALE
      elsif member2 && member2.gender
        member1.gender = Constants::FEMALE if member2.gender == Constants::MALE
        member1.gender = Constants::MALE if member2.gender == Constants::FEMALE
      end
    end

    def merge_father_and_mother root, father_node, child_node
      parents = find_parents root, child_node
      merge_nodes parents if parents.length > 1
    end

    def find_parents root, child_node
      queue = [root]
      parents = []
      until queue.empty?
        current_node = queue.shift
        parents << current_node if current_node.children.include?(child_node)
        queue.push(*current_node.children) if !current_node.children.empty?
      end
    end

    def merge_nodes nodes
      node1, node2 = *nodes
      node.children  = (node1.children | node2.children)
      node1.members = (node1.members | node2.members)
      # reassign_node2_from_children
    end

  end
end