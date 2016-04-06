require 'spec_helper'

describe Ordoro::Record::ProductAdapter do
  include TestingAdapter
  include SharedAdapterExamples

  let(:client) { setup_client }
  let(:adapter) { client.Product }
  let(:plural_name) { 'products' }
  let(:singular_name) { 'product' }
  let(:record_class) { Ordoro::Record::Product }

  it "initializes the adapter" do
    expect(adapter).to be_a Ordoro::Record::ProductAdapter
  end

  it_behaves_like "an API adapter"

end
