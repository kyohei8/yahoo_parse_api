require 'yahoo_parse_api/version'
require 'httparty'

module YahooParseApi
  SITE_URL = 'http://jlp.yahooapis.jp/MAService/V1/parse'

  class YahooParseApiError < StandardError
  end

  module Config

    def self.app_id
      @@app_id
    end

    def self.app_id=(val)
      @@app_id = val
    end
  end

  # parse
  # ex. YahooParseApi::Parse.extract
  class Parse
    # initializer if creating a new Yahoo parse API client
    # @param appid Yahoo APP id
    def initialize(appid = YahooParseApi::Config.app_id)
      @app_key = appid
      raise YahooParseApiError.new('please set app key before use') unless @app_key
    end

    # execute parse
    #
    # @param [String] sentence
    # @param [Hash] option yahoo parse api option see: http://developer.yahoo.co.jp/webapi/jlp/ma/v1/parse.html
    # @param [Symbol] method :GET or :POST
    # @return
    def parse(sentence='', option={results: :ma}, method=:GET)
      params = {
          appid: @app_key,
          sentence: sentence
      }.merge! option

      if method == :GET
        url = "#{SITE_URL}?"
        url << parameterize(params)
        HTTParty.get(url).parsed_response
      elsif method == :POST
        HTTParty.post("#{SITE_URL}", {body: params}).parsed_response
      else
        # invalid arguments
        raise YahooKeyPhraseApiError.new('invalid request method')
      end
    end

    private
    def parameterize(params)
      URI.escape(params.collect { |k, v| "#{k}=#{v}" }.join('&'))
    end

  end
end
