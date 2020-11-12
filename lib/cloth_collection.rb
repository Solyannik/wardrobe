require_relative 'cloth'

class ClothCollection
  attr_reader :clothes

  def self.from_dir(dir_path)
    files = Dir[File.join(dir_path, '*.txt')]

    clothes = files.map { |file| Cloth.from_file(file) }

    new(clothes)
  end

  def initialize(clothes)
    @clothes = clothes
  end

  def for_weather(temperature)
    suitable_for_temp =
      @clothes.select { |cloth| cloth.suitable_for_temperature?(temperature) }
      self.class.new(suitable_for_temp)
  end

  def for_type(type)
    suitable_for_type =
      @clothes.select { |item| item.type == type }

    self.class.new(suitable_for_type)
  end

  def types
    @clothes.map(&:type).uniq
  end

  def sample
    @clothes.sample
  end

  def to_s
    @clothes.join("\n")
  end
end
