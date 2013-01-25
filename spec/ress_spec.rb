require_relative '../lib/ress'

describe Ress do

  describe '.configure' do

    it 'yields the default category collection' do
      Ress.configure { |r| r.should be_a(Ress::CategoryCollection) }
    end

  end

end