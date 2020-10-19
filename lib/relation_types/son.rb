require_relative '../actions/add_son.rb'
require_relative '../relation_type.rb'

module RelationTypes
  class Son < RelationType
    def actions
      [Actions::AddSon.new]
    end
  end
end