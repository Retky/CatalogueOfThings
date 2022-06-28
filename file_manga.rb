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

  # restaurants = json_data.map do |hash|
  # Restaurant.new(hash[:restaurant], hash[:cost])
  # end

  def read
    objects = []
    File.open(@filename, 'r') do |f|
      f.each do |line|
        objects << JSON.parse(line, symbolize_names: true)
      end
    end
    objects
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
# manga = FileManga.new(filename: 'people.json', object: person).write

persons = FileManga.new(filename: 'people.json', object: person).read

p persons

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
