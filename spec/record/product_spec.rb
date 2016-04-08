require 'spec_helper'

describe Ordoro::Record::Product do
  include TestingAdapter
  include VCRHelper
  include SharedRecordExamples

  let(:client) { setup_client }
  let(:plural_name) { 'products' }
  let(:record_class) { Ordoro::Record::Product }
  let(:json) {
    load_vcr_hash('products', 'product').first
  }
  let(:record) {
    record_class.new(json.merge({'client' => client}))
  }
  let(:first_warehouse) { record.warehouses.first }

  before do
    # disable warehouse saving
    allow(record).to receive(:save_warehouses)
  end

  it "initializes an instance of the class" do
    expect(record).to be_a record_class
  end

  it "initializes the warehouse embedded values" do
    expect(first_warehouse.id).to be_a Integer
  end

  it_behaves_like "an API record class"

end
