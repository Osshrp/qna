require 'rails_helper'

describe '.execute' do

  let(:query) { '111' }

  %w{questions answers comments users}.each do |region|
    it "should send search message to class" do
      expect(capitalize_first(region).singularize.constantize).to receive(:search).with(query)
      Search.execute(query, region)
    end
  end

  it 'should send search message to ThinkingSphinx' do
    expect(ThinkingSphinx).to receive(:search).with(query)
    Search.execute(query, 'all')
  end

  def capitalize_first(string)
    string.sub(/\S/, &:upcase)
  end
end
