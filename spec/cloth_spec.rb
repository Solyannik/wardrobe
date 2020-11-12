require 'cloth'

describe Cloth do
  let(:line) { Cloth.from_file("#{__dir__}/fixtures/clothes_01.txt") }
  let(:item) { Cloth.new('Джемпер', 'Одежда', 0, 15) }

  describe '.from_file' do
    it 'sets variables from file lines' do
      expect(line.cloth).to eq 'Джемпер'
      expect(line.type).to eq 'Одежда'
      expect(line.min_temp).to eq 0
      expect(line.max_temp).to eq 15
    end
  end

  describe '.new' do
    it 'initializes variables' do
      expect(item.cloth).to eq 'Джемпер'
      expect(item.type).to eq 'Одежда'
      expect(item.min_temp).to eq 0
      expect(item.max_temp).to eq 15
    end
  end

  describe '#suitable_for_temperature?' do
    it 'when garment is suitable for given temperature' do
      expect(item.suitable_for_temperature?(10)).to be true
    end

    it 'when garment is not suitable for given temperature'  do
      expect(item.suitable_for_temperature?(30)).to be false
    end
  end

  describe '#to_s' do
    it 'returns right string' do
      expect(item.to_s).to eq 'Джемпер (Одежда) 0..15'
    end
  end
end
