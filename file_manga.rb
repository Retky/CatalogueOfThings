require 'json'

class FileManga
  def initialize(filename:, object:)
    @filename = filename
    @object = object
  end

  def write
    File.open(@filename, 'a') do |f|
      f.write("#{object_to_json}\n")
    end
  end

  private

  def object_to_json
    object_hash = {}

    @object.instance_variables.each do |var|
      s_var = var.to_s.gsub('@', '').to_sym
      object_hash[s_var] = @object.instance_variable_get var
    end
    object_hash.to_json
  end
end

class Person
  def initialize(name:, age:)
    @name = name
    @age = age
  end
end

person = Person.new(name: 'Henry', age: 34)
FileManga.new(filename: 'people.json', object: person).write

#
# person = Person.new(name: 'Henry', age: 33)
#
# instance_vars =  person.instance_variables()
#
# object_hash = {}
#
# written_object = ''
#
# instance_vars.each do |var|
#   #p person.instance_variable_get var
#   s_var = var.to_s.gsub('@', '').to_sym
#   object_hash[s_var] = person.instance_variable_get var
# end
#
# p object_hash.to_json
# p JSON.parse(object_hash.to_json, symbolize_names: true)
#
#
