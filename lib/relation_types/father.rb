require_relative '../actions/add_father.rb'
require_relative '../relation_type.rb'

module RelationTypes
  class Father < RelationType

    def eligible?
      
    end

    def actions
      [Actions::AddFather.new]
    end
  end
end