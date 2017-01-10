# a1c2f6b445549125eee22f80e9c8476d6e5303fb
require 'pry'
require 'watson-api-client'
service = WatsonAPIClient::AlchemyLanguage.new(:apikey=>"a1c2f6b445549125eee22f80e9c8476d6e5303fb",
                                               :verify_ssl=>OpenSSL::SSL::VERIFY_NONE)
result = service.URLGetRankedConcepts('url'        => 'https://techmeme.com/',  # url:        'www.cnn.com',
                                    'outputMode' => 'json')         # outputMode: 'json')

a =  JSON.parse(result.body)
binding.pry


# # curl -X POST \
# -d "outputMode=json" \
# -d "url=http://www.twitter.com/ibmwatson" \
# "https://gateway-a.watsonplatform.net/calls/url/URLGetRankedKeywords?apikey=$API_KEY"
