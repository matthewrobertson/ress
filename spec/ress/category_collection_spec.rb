require_relative '../../lib/ress'

describe Ress::CategoryCollection do


  describe '.register_category' do

    let(:collection) { Ress::CategoryCollection.new }

    it 'adds a category to list' do
      expect {
        collection.register_category({:name => 'stuff', :media_query => 'foo'})
      }.to change { collection.size }.by(1)
    end

    it 'sets the name and media_query of the category' do
      collection.register_category({:name => 'stuff', :media_query => 'foo'})
      collection.last.name.should == 'stuff'
    end

    it 'passes options tot he category' do
      collection.register_category({:name => 'stuff', :media_query => 'foo', :subdomain => 'm'})
      collection.last.subdomain.should == 'm'
    end

  end

  describe '#each' do

    it 'delegates the @categories' do
      collection = Ress::CategoryCollection.new
      collection.respond_to?(:each).should be_true
    end

  end

end