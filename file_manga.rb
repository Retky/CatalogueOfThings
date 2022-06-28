require 'json'

class FileManga
  def initialize(filename:, object: nil)
    @filename = filename
    @object = object
  end

  def write
    File.open(@filename, 'a') do |f|
      f.write("#{object_to_json}\n")
    end
  end

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

# create back objects:
# restaurants = json_data.map do |hash|
# Restaurant.new(hash[:restaurant], hash[:cost])
# end
