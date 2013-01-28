require_relative '../../lib/ress'

describe Ress::CategoryCollection do

  let(:collection) { Ress::CategoryCollection.new }

  describe '#add_alternate' do

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

  describe 'canonical_version' do

    it 'defaults to a canonical_version with no subdomain' do
      collection.canonical_version.subdomain.should be_false
    end

    it 'can be altered through set_canonical' do
      collection.set_canonical :subdomain => 'foo'
      collection.canonical_version.subdomain.should == 'foo'
    end

  end

end