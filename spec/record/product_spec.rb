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
  let(:record) { record_class.new(client, json) }

  it "initializes an instance of the class" do
    expect(record).to be_a record_class
  end

  it_behaves_like "an API record class"

end
