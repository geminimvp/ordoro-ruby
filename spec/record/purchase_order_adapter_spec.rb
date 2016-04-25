require 'spec_helper'

describe Ordoro::Record::PurchaseOrderAdapter do
  include TestingAdapter
  include SharedAdapterExamples

  let(:client) { setup_client }
  let(:adapter) { client.PurchaseOrder }
  let(:plural_name) { 'purchase_orders' }
  let(:singular_name) { 'purchase_order' }
  let(:record_class) { Ordoro::Record::PurchaseOrder }

  it 'initializes the adapter' do
    expect(adapter).to be_a Ordoro::Record::PurchaseOrderAdapter
  end

  it_behaves_like 'an API adapter'
end
