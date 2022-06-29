require './label'
require './item'

describe Label do
  before(:each) do
    @label = Label.new(title: 'Test Label', color: 'Blue')
    params = { publish_date: Date.new(2000, 1, 1), author: 'John Doe' }
    @item = Item.new(params)
  end

  it 'should have a title' do
    expect(@label.title).to eq('Test Label')
  end

  it 'should have a color' do
    expect(@label.color).to eq('Blue')
  end

  it 'should have an id' do
    expect(@label.id).to be_a(Integer)
  end

  it 'should have an items array' do
    expect(@label.items).to be_a(Array)
  end

  it ':add_item should add an item to the items array' do
    @label.add_item(@item)
    expect(@label.items).to include(@item)
  end

  it ':add_item should set the label of the item' do
    @label.add_item(@item)
    expect(@item.label).to eq(@label)
  end
end
