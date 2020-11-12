class Cloth
  attr_accessor :cloth, :type, :max_temp, :min_temp

  def self.from_file(file)
    lines = File.readlines(file, chomp: true)

    temperatures =  lines[2].scan(/\-?\d+/).map(&:to_i)

    new(lines[0], lines[1], temperatures[0], temperatures[1])
  end

  def initialize(cloth, type, min_temp, max_temp)
    @cloth = cloth
    @type = type
    @min_temp = min_temp
    @max_temp = max_temp
  end

  def suitable_for_temperature?(temperature)
    temperature.between?(min_temp, max_temp)
  end

  def to_s
    "#{cloth} (#{type}) #{min_temp}..#{max_temp}"
  end
end
