# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


n = User.make_user("Niranjan")
r = User.make_user("Ryan")
p1 = User.make_user("Tony the Tank")
p2 = User.make_user("Cocky Charlie")
p3 = User.make_user("Big Bob")
p4 = User.make_user("Fat Freddy")
p5 = User.make_user("Tiny Tina")
p6 = User.make_user("Classy Clerise")
p7 = User.make_user("Lisa Legs")

color = Poll.make_poll("Favorite color", %w(red green blue), n)
animal = Poll.make_poll("Favorite animal", %w(pig cow dog), n)

color_op_1 = color.options.where(body: 'red').first
color_op_2 = color.options.where(body: 'green').first
color_op_3 = color.options.where(body: 'blue').first
animal_op_1 = animal.options.where(body: 'pig').first
animal_op_2 = animal.options.where(body: 'cow').first
animal_op_3 = animal.options.where(body: 'dog').first

r.answer_poll(color_op_1)
p1.answer_poll(color_op_1)
p2.answer_poll(color_op_1)
p3.answer_poll(color_op_2)
p4.answer_poll(color_op_2)
p5.answer_poll(color_op_2)
p6.answer_poll(color_op_3)
p7.answer_poll(color_op_3)

r.answer_poll(animal_op_1)
p1.answer_poll(animal_op_1)
p2.answer_poll(animal_op_1)
p3.answer_poll(animal_op_2)
p4.answer_poll(animal_op_2)
p5.answer_poll(animal_op_2)
p6.answer_poll(animal_op_3)
p7.answer_poll(animal_op_3)