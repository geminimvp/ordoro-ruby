require 'active_support/inflector'
module SharedRecordExamples

  RSpec.shared_examples "an API record class" do

    it "sets up an ID" do
      expect(record.id).to be_a Fixnum
      expect(record.id).to eq(json['id'])
    end

    describe "#persisted?" do
      subject { new_record.persisted? }
      context "when record has an ID" do
        let(:new_record) {
          record_class.new('client' => client, 'id' => 123)
        }
        it { should be true }
      end

      context "when record has no params" do
        let(:new_record) { record_class.new({'client' => client}) }
        it { should be false }
      end
    end

    describe "#save" do
      it "calls the adapter save method" do
        record_name = record_class.demodulized_name
        expect(client.adapter_for(record_name)).to receive(:save).with(record)
        record.save
      end
    end

  end
end
