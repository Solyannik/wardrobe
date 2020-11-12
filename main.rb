require_relative 'lib/cloth_collection'

collection = ClothCollection.from_dir(File.join(__dir__, 'data'))

puts 'Сколько градусов за окном? (можно с минусом)'
temperature_now = STDIN.gets.to_i

suitable_collection = collection.for_weather(temperature_now)

puts suitable_collection

collection_today =
  ClothCollection.new(suitable_collection.types.map { |type| suitable_collection.for_type(type).sample }
  )

puts 'Предлагаем сегодня надеть:'
puts collection_today
