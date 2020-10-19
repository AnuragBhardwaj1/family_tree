#!/usr/bin/env ruby

require_relative "../lib/family_tree.rb"

puts "fasdf"


 f = FamilyTree.new()

  f.add_person "john shakespeare", "m"
  f.add_person "mary arden", "f"

  f.add_person "joan", "f"
  f.add_person "margaret", "f"
  f.add_person "william", "m"
  f.add_person "anne hathaway", "f"
  f.add_person "gilbert", "m"
  f.add_person "joan2", "f"
  f.add_person "anne", "f"
  f.add_person "richard", "m"
  f.add_person "edmund", "m"

  f.add_person "susana", "f"
  f.add_person "john hall", "m"
  f.add_person "hamnet", "m"
  f.add_person "judith", "f"
  f.add_person "thomas quiney", "m"

  f.add_person "elizabeth", "f"
  f.add_person "shakespeare", "m"
  f.add_person "richard2", "m"
  f.add_person "thomas", "m"
# ----------------------------------

  f.add_relationship "father"
  f.add_relationship "son"
# ----------------------------------

  f.connect "john shakespeare", "joan", "father"
  f.connect "john shakespeare", "margaret", "father"
  f.connect "john shakespeare", "william", "father"
  f.connect "john shakespeare", "gilbert", "father"
  f.connect "john shakespeare", "joan2", "father"
  f.connect "john shakespeare", "anne", "father"
  f.connect "john shakespeare", "richard", "father"
  f.connect "john shakespeare", "edmund", "father"

  f.connect "william", "susana", "father"
  f.connect "william", "hamnet", "father"
  f.connect "william", "judith", "father"
  f.connect "hamnet", "anne hathaway", "son"

  f.connect "john hall", "  elizabeth", "father"

  f.connect "shakespeare", "judith", "son"
  f.connect "richard2", "judith", "son"
  f.connect "thomas", "judith", "son"

  f.connect "gilbert", "mary arden", "son"
  f.connect "thomas quiney", "shakespeare", "father"

  f.immidiate_son_count "william"
  f.all_daughters_count "mary arden"
  f.immidiate_cousin_count "susana"
  f.wives "william"
  f.related "anne hathaway", "thomas quiney"
  f.related "gilbert", "joan"
  p '--------'
