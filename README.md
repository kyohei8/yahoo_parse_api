# Yahoo Parse Api Client

This is Yahoo Parse Api Client for ruby.

## API documentation

[日本語形態素解析API](http://developer.yahoo.co.jp/webapi/jlp/ma/v1/parse.html)
(yahoo developers network)

## Installation

Add this line to your application's Gemfile:

    gem 'yahoo_parse_api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yahoo_parse_api

## Configuration

```ruby
require 'yahoo_parse_api'

# and setup
YahooParseApi::Config.app_id = [your applicationID]
```

## Usage

```ruby
yp = YahooParseApi::Parse.new
# GET Request
result = yp.parse('庭には二羽ニワトリがいる。', {
            results: 'ma,uniq',
            uniq_filter: '9|10'
         })
# => {"ResultSet"=>{
#        "ma_result"=>{
#          "total_count"=>"8",
#          "filtered_count"=>"8",
#          "word_list"=>{"word"=>[{"surface"=>"庭", "reading"=>"にわ", "pos"=>"名詞"},
#                                 {"surface"=>"に", "reading"=>"に", "pos"=>"助詞"},
#                                 {"surface"=>"は", "reading"=>"は", "pos"=>"助詞"},
#                                 {"surface"=>"二羽", "reading"=>"にわ", "pos"=>"名詞"},
#                                 {"surface"=>"ニワトリ", "reading"=>"にわとり", "pos"=>"名詞"},
#                                 {"surface"=>"が", "reading"=>"が", "pos"=>"助詞"},
#                                 {"surface"=>"いる", "reading"=>"いる", "pos"=>"動詞"},
#                                 {"surface"=>"。", "reading"=>"。", "pos"=>"特殊"}]}},
#        "uniq_result"=>{
#           "total_count"=>"8",
#           "filtered_count"=>"4",
#           "word_list"=>{"word"=>[{"count"=>"1", "surface"=>"いる", "reading"=>nil, "pos"=>"動詞"},
#                                  {"count"=>"1", "surface"=>"ニワトリ", "reading"=>nil, "pos"=>"名詞"},
#                                  {"count"=>"1", "surface"=>"二羽", "reading"=>nil, "pos"=>"名詞"},
#                                  {"count"=>"1", "surface"=>"庭", "reading"=>nil, "pos"=>"名詞"}]}},
#     "schemaLocation"=>"urn:yahoo:jp:jlp http://jlp.yahooapis.jp/MAService/V1/parseResponse.xsd"}}


# POST Request
result = yp.parse('庭には二羽ニワトリがいる。', { results: 'ma,uniq', uniq_filter: '9|10' }, :POST)
# => {"ResultSet"=>...


# Example of parameter
result = yp.parse('庭には二羽ニワトリがいる。', {
                      results: 'ma',
                      ma_response: 'surface',
                      ma_response: '2|5'
                  })

```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
