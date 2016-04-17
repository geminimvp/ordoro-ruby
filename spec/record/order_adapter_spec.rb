require 'spec_helper'

describe Ordoro::Record::OrderAdapter do
  include TestingAdapter
  include SharedAdapterExamples

  let(:client) { setup_client }
  let(:adapter) { client.Order }
  let(:plural_name) { 'orders' }
  let(:singular_name) { 'order' }
  let(:record_class) { Ordoro::Record::Order }

  it "initializes the adapter" do
    expect(adapter).to be_a Ordoro::Record::OrderAdapter
  end

  it_behaves_like "an API adapter"

end
