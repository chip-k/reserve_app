require 'base64'
require 'json'
require 'net/https'

module Language
  class << self
    def get_data(text)
      # APIのURL作成
      api_url = "https://language.googleapis.com/v1/documents:analyzeEntities?key=#{ENV['GOOGLE_MAP_API_KEY']}"
      # APIリクエスト用のJSONパラメータ
      params = {
        document: {
          type: 'PLAIN_TEXT',
          content: text
        }
      }.to_json
      # Google Cloud Natural Language APIにリクエスト
      uri = URI.parse(api_url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri)
      request['Content-Type'] = 'application/json'
      response = https.request(request, params)
      # APIレスポンス出力
      response_body = JSON.parse(response.body)
      if (error = response_body['error']).present?
        raise error['message']
      else
        entities = response_body['entities']
        entities.uniq! { |entity| entity['name'] } # 重複するエンティティを削除
        entities = remove_numeric_entities(entities) # 数字を含むエンティティを削除
        entities.compact
      end
    end
    
    
    def generate_wiki_link(entity_name)
      base_url = 'https://ja.wikipedia.org/wiki/'
      encoded_name = URI.encode_www_form_component(entity_name)
      "#{base_url}#{encoded_name}"
    end
    
    def remove_numeric_entities(entities)
      entities.reject { |entity| contains_number?(entity['name']) }
    end
    
    def contains_number?(word)
      /\d/.match?(word)
    end
   
  end 
end