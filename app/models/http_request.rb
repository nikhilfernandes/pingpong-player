require "net/http"
require "uri"

class HttpRequest

  def self.post(host, port, path, params, auth_token)
    headers = { 'Content-Type' => 'application/json', 'accept' => 'application/json', "X_AUTHENTICATION_TOKEN"=> auth_token }
    http = Net::HTTP.new(host, port)
    payload = JSON.generate params
    request = Net::HTTP::Post.new(path, headers)    
    res = http.request(request, payload)
  end

  def self.get(host, port, path)
    headers = { 'Content-Type' => 'application/json', 'accept' => 'application/json'}
    http = Net::HTTP.new(host, port)    
    res = http.get(path)
  end

end