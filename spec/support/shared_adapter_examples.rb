# Shared tests for Gecko::Record Adapters
# requires definition of several variables
# - adapter
# - plural_name
# - record_class

require 'json'
module SharedAdapterExamples
  RSpec.shared_examples "an API adapter" do

    describe "#where" do
      let(:collection) { adapter.where(limit: 1) }

      it "returns a collection of records" do
        VCR.use_cassette(plural_name) do
          expect(collection).to be_a Array
          expect(collection.size).to eq 1
          expect(collection[0]).to be_an_instance_of(record_class)
        end
      end
    end

    describe "#count" do
      it "returns a count of records" do
        VCR.use_cassette(plural_name + '_count') do
          expect(adapter.count).to be > 1
        end
      end
    end

    describe "#size" do
      it "returns a count of records" do
        VCR.use_cassette(plural_name + '_count') do
          trash = adapter.count
          expect(adapter.size).to be >= 1
        end

      end
    end

    describe "#fetch" do
      let(:dummy_id) { 12345 }
      let(:dummy_response) {
        {
          headers: { "Content-Type" => "application/json" },
          body: JSON.dump({id: dummy_id})
        }
      }
      let(:record_path_regex) {
        /#{adapter.get_request_path(dummy_id)}/
      }

      after(:each) do
        WebMock.reset!
      end

      it "fetches the record by ID" do
        request_stub = WebMock.stub_request(:get, record_path_regex)
                         .to_return(dummy_response)

        record = adapter.fetch(dummy_id)
        expect(record.id).to eq(dummy_id)
        expect(request_stub).to have_been_requested
      end

      context "when record is not found" do
        let(:not_found_response) {
          {
            status: 404,
            headers: { "Content-Type" => "application/json" },
            body: JSON.dump({
              error_message: "Product does not exist",
              param: nil
            })
          }
        }

        it "raises a RecordNotFound exception" do
          request_stub = WebMock.stub_request(:get, record_path_regex)
                         .to_return(not_found_response)
          expect { adapter.fetch(dummy_id) }.to raise_error(Ordoro::Record::RecordNotFound)
        end
      end
    end

    describe "#find" do
      context "when no ID is provided" do
        it "raises a RecordNotFound exception" do
          expect { adapter.find(nil) }.to raise_error(Ordoro::Record::RecordNotFound)
        end
      end
    end

    describe "#build" do
      subject { record }
      let(:record) { adapter.build }
      it { should_not be_persisted }
      it { should be_a record_class }

      context "when attributes are provided" do
        let(:random_attribute) {
          record_class.attribute_set.find { |att| att.type == Axiom::Types::String }.name
        }

        let(:dummy_value) { "Max Power" }
        let(:record) { adapter.build(record_attrs) }
        let(:record_attrs) {
          {
            random_attribute => dummy_value
          }
        }
        it "builds the record with the provided attributes" do
          expect(subject.attributes[random_attribute]).to eq dummy_value
        end
      end
    end

    describe "#save" do
      let(:new_record_id) { 123 }
      let(:record) { adapter.build }
      let(:path_regex) {
        /#{singular_name}\//
      }
      let(:create_response) {
        {
          headers: { "Content-Type" => "application/json" },
          body: JSON.dump({id: new_record_id})
        }
      }

      before do
        WebMock.stub_request(:post, path_regex)
          .to_return(create_response)
      end

      it "adds an ID to the record" do
        adapter.save(record)
        expect(record.id).to eq new_record_id
      end

      context "when record is invalid" do
        let(:create_response) {
          {
            status: 422,
            headers: { "Content-Type" => "application/json" },
            body: JSON.dump(
              {"errors" => { name: ["can not be what you chose"]}}
            )
          }
        }

        it "does not add an id to the record" do
          adapter.save(record)
          expect(record.id).to be_nil
        end

        it "marks the record as invalid" do
          adapter.save(record)
          expect(record).to_not be_valid
        end
      end

      context "when record already exists" do
        let(:record) {
          record_class.new('client' => client, 'id_token' => new_record_id)
        }
        let(:record_id) { record.id}

        let(:path_regex) {
          /#{adapter.update_request_path(record)}/
        }
        let(:update_response) {
          {
            headers: { "Content-Type" => "application/json" },
            body: JSON.dump({id: new_record_id})
          }
        }

        before do
          WebMock.stub_request(:put, path_regex)
            .to_return(update_response)
        end

        it "marks the record as valid" do
          adapter.save(record)
          expect(record).to be_valid
        end

      end

    end

  end
end
