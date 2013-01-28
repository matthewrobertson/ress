require_relative '../../lib/ress'

describe Ress::CategoryCollection do


  describe '#add_alternate' do

    let(:collection) { Ress::CategoryCollection.new }

    it 'adds an item to the alternate_versions' do
      expect {
        collection.add_alternate({:name => 'stuff', :media_query => 'foo'})
      }.to change { collection.alternate_versions.size }.by(1)
    end

    it 'sets the name and media_query of the alternate_version' do
      collection.add_alternate({:name => 'stuff', :media_query => 'foo'})
      collection.alternate_versions.last.name.should == 'stuff'
    end

    it 'passes options to the alternate_version' do
      collection.add_alternate({:name => 'stuff', :media_query => 'foo', :subdomain => 'm'})
      collection.alternate_versions.last.subdomain.should == 'm'
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


end