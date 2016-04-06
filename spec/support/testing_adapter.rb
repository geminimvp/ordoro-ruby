module TestingAdapter

  require 'dotenv'

  def setup_client
    Dotenv.load
    @client = Ordoro::Client.new(ENV['ORDORO_USERNAME'],
                                 ENV['ORDORO_PASSWORD'])
  end

end
