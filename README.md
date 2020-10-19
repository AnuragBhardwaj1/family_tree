# Summary
There are fair assumptions made to solve this problem as the scope is large. Solution has been made with a given example at hand(Shakespeare family tree).


## Main Entities
* Member - member is a person, which hold data about `name`,  `gender`,  `education`, `profession`, etc.
* Relationship - relationship has `source`,  `destination`, and `relationType`. For simplicity two `RelationType` has been assumed: `father` and `son`. This interfere with mapping of `elizabeth` as she is neither a son and father does not exist in tree(which need `spouse` relation to map).
* Node - node hold partner together and map to common things namely children.

## Setup

Example tree has been setup in ./bin/family_tree.rb.
Flow goes like:
```
FamilyTree -> Tree -> Nodes
```

* FamilyTree: is a kind of handler which exposes basic set of methods to manipulate tree.
* Tree: hold nodes and have methods to query the tree like bfs and etc.
* Node: Node hold members. One node can hold, at max, two members. Primary and Spouse. Primary is needed to identify topdown relation mapping right when there are two members in a node. The other left is spouse.
* RelationTypes: Each RelationType(for eg son), holds actions associated with it. For every relation manipulation it checks `eligible?` and execute corrosponding `Actions`.
* Actions: Actions are taken when a node is manipulated. These triggers will execute actions and eligiblilty of actions can be deduced with `eligible?` method, which is currently redundant. Actions for add son take care things like of merging parents if one already exist and other scenerios.
* Profession and Education is add on for part II queries.

## Improvements:
* Lot of scope has been limited. For ex providing gender simplifies and doesn't need method to evaluate spouse/partner's gender for `RelationType::Father`.
* Relations and members array could have been removed and all queries directed to tree instead.
* Loops has been used multiple time, like `(select{x}).map{y}...` for readablity.
* Console setup and tests.
