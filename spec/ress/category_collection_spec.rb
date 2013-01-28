require_relative '../../lib/ress'

describe Ress::CategoryCollection do


  describe '#add_alternate' do

    let(:collection) { Ress::CategoryCollection.new }

    it 'adds a category to list' do
      expect {
        collection.add_alternate({:name => 'stuff', :media_query => 'foo'})
      }.to change { collection.size }.by(1)
    end

    it 'sets the name and media_query of the category' do
      collection.add_alternate({:name => 'stuff', :media_query => 'foo'})
      collection.last.name.should == 'stuff'
    end

    it 'passes options to the category' do
      collection.add_alternate({:name => 'stuff', :media_query => 'foo', :subdomain => 'm'})
      collection.last.subdomain.should == 'm'
    end

  end

  describe '#base_host_name' do

    let(:collection) { Ress::CategoryCollection.new }

    it 'returns the paramter if there are no matching categories' do
      collection.base_host_name('foo.stuff').should == 'foo.stuff'
    end

    it 'drops the first subdomain if there is a matching category' do
      collection.add_alternate(:name => 'foo', :media_query => 'foo')
      collection.base_host_name('foo.stuff.baz').should == 'stuff.baz'
    end

  end

  describe '#each' do

    it 'delegates the @categories' do
      collection = Ress::CategoryCollection.new
      collection.respond_to?(:each).should be_true
    end

  end

end