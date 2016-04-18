require 'spec_helper'

describe Ordoro::Record::OrderTagAdapter do
  include TestingAdapter
  include SharedAdapterExamples

  let(:client) { setup_client }
  let(:adapter) { client.OrderTag }
  let(:plural_name) { 'order_tags' }
  let(:singular_name) { 'tag' }
  let(:record_class) { Ordoro::Record::OrderTag }

  it 'initializes the adapter' do
    expect(adapter).to be_a Ordoro::Record::OrderTagAdapter
  end

  it_behaves_like 'an API adapter'
end
