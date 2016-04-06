require 'ordoro'
require 'rspec'
require 'vcr'
require 'support/testing_adapter'
require 'support/shared_adapter_examples'
require 'support/shared_record_examples'
require 'support/vcr_helper'
require 'webmock/rspec'

include Ordoro

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.filter_sensitive_data('<USERNAME>') {
    CGI.escape ENV['ORDORO_USERNAME']
  }
  config.filter_sensitive_data('<PASSWORD>') {
    CGI.escape ENV['ORDORO_PASSWORD']
  }
end
