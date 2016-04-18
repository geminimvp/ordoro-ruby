require 'spec_helper'

describe Ordoro::Record::SupplierAdapter do
  include TestingAdapter
  include SharedAdapterExamples

  let(:client) { setup_client }
  let(:adapter) { client.Supplier }
  let(:plural_name) { 'suppliers' }
  let(:singular_name) { 'supplier' }
  let(:record_class) { Ordoro::Record::Supplier }

  it 'initializes the adapter' do
    expect(adapter).to be_a Ordoro::Record::SupplierAdapter
  end

  it_behaves_like 'an API adapter'
end
