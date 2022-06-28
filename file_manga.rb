require 'json'

# to write to a file
#  FileManga.new(file_name: 'file_name.json', object<any>).write => writes to file
#  FileManga.new(file_name: 'file_name.json').read(construct:ClassName) => returns array of instances 

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

  def read(construct:)
    instances = []
    File.open(@filename, 'r') do |f|
      f.each do |line|
        attributes = JSON.parse(line, symbolize_names: true)
        instance = construct.new(attributes)
        instances << instance
      end
    end
    instances
  rescue StandardError
    nil
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
  attr_accessor :name, :age

  def initialize(params = {})
    @name = params[:name]
    @age = params[:age]
  end
end
