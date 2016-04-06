module VCRHelper
  def load_vcr_hash(fixture, key)
    yaml_path = VCR.configuration.cassette_library_dir +
                "/#{fixture}.yml"
    yaml = YAML.load_file(yaml_path)
    first_record_hash = yaml["http_interactions"][0]
    response = VCR::HTTPInteraction.from_hash(first_record_hash).
               response.decompress.body
    JSON.parse(response)[key]
  end
end
