require_relative '../lib/ress'

describe Ress do

  describe '.configure' do

    it 'yeilds Ress'

  end

  describe '.register_category' do

    it 'adds a category to list' do
      expect {
        Ress.register_category({:name => 'stuff', :media_query => 'foo'})
      }.to change { Ress.categories.count }.by(1)
    end

    it 'sets the name and media_query of the category' do
      Ress.register_category({:name => 'stuff', :media_query => 'foo'})
      Ress.categories.last.name.should == 'stuff'
    end

    it 'passes options tot he category' do
      Ress.register_category({:name => 'stuff', :media_query => 'foo', :subdomain => 'm'})
      Ress.categories.last.subdomain.should == 'm'
    end

  end

  describe '.configure' do

    it 'yields itself' do
      Ress.configure { |r| r.should == Ress }
    end

  end

end