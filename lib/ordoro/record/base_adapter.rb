module Ordoro
  module Record
    class BaseAdapter
      attr_reader :client, :last_response

      DEFAULT_LIMIT = 10.freeze

      def initialize(client, model_name)
        @client       = client
        @model_name   = model_name
        @identity_map = {}
      end

      def find(id)
        if has_record_for_id?(id)
          record_for_id(id)
        else
          fetch(id)
        end
      end

      def record_for_id(id)
        verify_id_presence!(id)
        @identity_map.fetch(id) { record_not_in_identity_map!(id) }
      end

      def has_record_for_id?(id)
        @identity_map.key?(id)
      end

      def find_many(ids)
        existing, required = ids.partition { |id| has_record_for_id?(id) }
        if required.any?
          where(id: ids) + existing.map { |id| record_for_id(id) }
        else
          existing.map { |id| record_for_id(id) }
        end
      end

      def where(params={})
        full_path = record_path
        response = request(:get, full_path, query: params)
        parsed_response = JSON.parse(response.body)
        set_pagination(parsed_response)
        parsed_records = parse_records(parsed_response)
        # has_more_records = (parsed_records.count < @pagination[:total_records])
        if params[:limit].nil?
          offset = 0
          while parsed_records.count < @pagination[:total_records] do
            offset = offset + DEFAULT_LIMIT
            page_query_params = params.merge(offset: offset)
            next_response = request(:get, full_path, query: page_query_params)
            parsed_records += parse_records(next_response)
          end
        end
        parsed_records
      end

      def first(params={})
        where(params.merge(limit: 1)).first
      end

      def count(params={})
        where(params.merge(limit: 1))
        @pagination[:total_records]
      end

      def size
        (@pagination && @pagination[:total_records]) || count
      end

      def fetch(id)
        verify_id_presence!(id)
        full_path = get_request_path(id)
        response = @last_response = request(:get, full_path)
        if response.code == 404
          record_not_found!(id)
          raise RecordNotFound
        end
        parsed_body = JSON.parse(response.body)
        record_json = parsed_body
        instantiate_and_register_record(record_json)
      end

      def get_request_path(id)
        "#{record_path}#{id.to_s}/"
      end

      def parse_records(json)
        extract_collection(json).map do |record_json|
          instantiate_and_register_record(record_json)
        end
      end

      def extract_collection(json)
        json[json_root] || []
      end

      # For a single record, the JSON response is not namespaced
      def extract_record(json)
        json
      end

      def build(attributes={})
        model_class.new(attributes.merge({'client' => @client}))
      end

      def save(record)
        if record.persisted?
          update_record(record)
        else
          create_record(record)
        end
      end

      def instantiate_and_register_record(record_json)
        record = build(record_json)
        register_record(record)
        record
      end

      def update_request_path(record)
        "#{record_path}#{record.id.to_s}/"
      end

      private

      def json_root
        @model_name.to_s.underscore
      end

      def record_path
        '/' + json_root + '/'
      end

      def plural_path
        json_root + 's'
      end

      def model_class
        Ordoro::Record.const_get(@model_name)
      end

      def register_record(record)
        @identity_map[record.id] = record
      end

      def create_record(record)
        request_path = create_request_path(record)
        request_params = {
          body: record.as_json,
          raise_errors: false
        }
        response = request(:post, request_path, request_params)
        handle_response(record, response)
      end

      def create_request_path(record)
        record_path
      end

      def update_record(record)
        request_path = update_request_path(record)
        request_params = {
          body: record.as_json,
          raise_errors: false
        }
        response = request(:put, request_path, request_params)
        handle_response(record, response)
      end

      def handle_response(record, response)
        parsed_body = JSON.parse(response.body)
        case response.code
        when 200..299
          response_json = extract_record(parsed_body)
          if response_json
            record.attributes = response_json
            register_record(record)
          end
          true
        when 422
          record.errors.from_response(parsed_body['errors'])
          false
        else
          fail HTTParty::ResponseError.new(response)
        end
      end

      def set_pagination(json_response)
        @pagination = {
          total_records: json_response['count'].to_i
        }
      end

      def request(verb, path, options={})
        ActiveSupport::Notifications.instrument('request.ordoro') do |payload|
          payload[:verb]         = verb
          payload[:params]       = options[:params]
          payload[:body]         = options[:body]
          payload[:model_class]  = model_class
          payload[:request_path] = path
          options[:headers]      = options.fetch(:headers, {}).tap {|headers| headers['Content-Type'] = 'application/json'  }
          options[:body]         = options[:body].to_json if options[:body]
          payload[:response]     = @client.request(verb, path, options)
        end
      end

      def record_not_found!(id)
        fail RecordNotFound, "Couldn't find #{model_class.name} with id=#{id}"
      end

      def verify_id_presence!(id)
        if id.respond_to?(:empty?) ? id.empty? : !id
          fail RecordNotFound, "Couldn't find #{model_class.name} without an ID"
        end
      end

    end
  end
end
