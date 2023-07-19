require_relative '../modules/label'
require_relative '../modules/item'

describe Label do
  let(:label) { Label.new('Sci-Fi', 'blue') }
  let(:item) { Item.new('2022-01-01') }

  it 'should initialize with title and color' do
    expect(label.title).to eq('Sci-Fi')
    expect(label.color).to eq('blue')
    expect(label.items).to eq([])
  end

  it 'should add an item to the label' do
    label.add_item(item)
    expect(label.items).to contain_exactly(item)
    expect(item.label).to eq(label)
  end
end
