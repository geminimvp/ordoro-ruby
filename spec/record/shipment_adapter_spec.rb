require 'spec_helper'

describe Ordoro::Record::ShipmentAdapter do
  include TestingAdapter
  include SharedAdapterExamples

  let(:client) { setup_client }
  let(:adapter) { client.Shipment }
  let(:plural_name) { 'shipments' }
  let(:singular_name) { 'shipment' }
  let(:record_class) { Ordoro::Record::Shipment }

  it 'initializes the adapter' do
    expect(adapter).to be_a Ordoro::Record::ShipmentAdapter
  end

  it_behaves_like 'an API adapter'
end
