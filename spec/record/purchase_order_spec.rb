require 'spec_helper'

describe Ordoro::Record::PurchaseOrder do
  include TestingAdapter
  include VCRHelper
  include SharedRecordExamples

  let(:client) { setup_client }
  let(:plural_name) { 'purchase_orders' }
  let(:record_class) { Ordoro::Record::PurchaseOrder }
  let(:json) {
    load_vcr_hash('purchase_orders', 'purchase_order').first
  }
  let(:record) { record_class.new(json.merge('client' => client)) }

  it 'initializes an instance of the class' do
    expect(record).to be_a record_class
  end

  it_behaves_like 'an API record class'
end
