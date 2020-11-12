require 'cloth'
require 'cloth_collection'

describe ClothCollection do
  let(:cloth1) { Cloth.new('Джемпер', 'Одежда', 0, 15) }
  let(:cloth2) { Cloth.new('Шлёпанцы', 'Обувь', 20, 40) }
  let(:cloth3) { Cloth.new('Шлёпанцы', 'Обувь', 20, 40) }

  let(:collection) { described_class.new([cloth1, cloth2])}

  describe '.from_dir' do
    let(:collection) { described_class.from_dir("#{__dir__}/fixtures/") }

    it 'reads from dir and initializes new collection' do
      expect(collection).to be_instance_of(described_class)
    end

    it 'reads correctly' do
      expect(collection.clothes).to all be_a Cloth
      expect(collection.clothes.size).to eq 2
      expect(collection.clothes.map(&:to_s)).to match_array(["Джемпер (Одежда) 0..15", "Шлёпанцы (Обувь) 20..40"])
    end
  end

  describe '.new' do
    it 'initialize objects' do
      expect(collection.clothes).to eq ([cloth1, cloth2])
    end
  end

  describe '#for_weather' do
    context 'when clothes for given temperature exist' do
      it 'creates new collection for input temperature' do
        temp = 10
        expect(collection.for_weather(temp)).to be_instance_of(ClothCollection)
        expect(collection.for_weather(temp).clothes).to eq([cloth1])
      end
    end

    context 'when clothes for given temperature do not exist' do
      it 'creates new collection for input temperature' do
        temp = -5
        expect(collection.for_weather(temp)).to be_instance_of(ClothCollection)
        expect(collection.for_weather(temp).clothes).to be_empty
      end
    end
  end

  describe '#for_type' do
    context 'when given type exists' do
      it 'creates new collection for given type' do
        type = 'Одежда'
        expect(collection.for_type(type)).to be_instance_of(ClothCollection)
        expect(collection.for_type(type).clothes).to eq([cloth1])
      end
    end

    context 'when given type does not exist' do
      it 'creates new collection with empty array of clothes' do
        type = 'Роба'
        expect(collection.for_type(type)).to be_instance_of(ClothCollection)
        expect(collection.for_type(type).clothes).to be_empty
      end
    end
  end

  describe '#types' do
    it 'array of uniq cloth types' do
      expect(collection.types).to eq(['Одежда', 'Обувь'])
    end
  end

  describe '#sample' do
    it 'selects random cloth from collection' do
      expect(collection.clothes.sample).to be_instance_of(Cloth)
      expect(collection.clothes.sample).to eq(cloth1).or eq(cloth2).or eq(cloth3)
    end
  end

  describe '#to_s' do
    it 'returns right strings' do
      expect(collection.to_s).to eq("Джемпер (Одежда) 0..15\nШлёпанцы (Обувь) 20..40")
    end
  end
end
