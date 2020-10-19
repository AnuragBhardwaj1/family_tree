module Actions
  class AddSon
    def execute root, son_node, parent_node
      # check if relation is already executed
      son_node.primary = son_node.members.first
      merge_parent_if_exists root, parent_node, son_node
    end

    def merge_parent_if_exists root, parent_node, son_node
      existing_parent = find_parent root, son_node
      if existing_parent
        existing_parent.members.push parent_node.members.first
      else
        parent_node.children.push son_node
      end
    end

    def find_parent root, son_node
      queue = [root]
      until queue.empty?
        current_node = queue.shift
        return current_node if current_node.children.include?(son_node)
        queue.push(*current_node.children) if !current_node.children.empty?
      end
    end
  end
end