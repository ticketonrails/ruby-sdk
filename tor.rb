require 'rubygems'
require 'digest/md5'
require 'json'
require 'rest_client'

module ToR

  class TorApi
    attr_accessor :api_key, :project_domain, :server_url, :api_token, :api_version

    def initialize(api_key, project_domain)
      @api_key = api_key
      @project_domain = project_domain
      @server_url = "http://api.ticketonrails.com"
      @api_version = "1"
      md5_key = Digest::MD5.hexdigest(api_key)
      @api_token = Digest::MD5.hexdigest(project_domain + md5_key)
    end

    def request(url, method = 'GET', parameters = nil)
      request_url = @server_url + "/v" + @api_version + url
      parameters["token"] = @api_token
      http_response = nil

      case method
        when "GET"
          http_response = RestClient.get request_url, parameters
        when "POST"
          http_response = RestClient.post request_url, parameters
        else
          # TODO: implement other methods
      end

      begin
        response = JSON.parse(http_response)
        if http_response.code >= 400
          raise TorApiException(response["error"])
        end
      rescue
        raise TorApiException($!.message)
      end

      return response
    end

    def new_ticket(values = nil)
      params = {}
      ticket = {}
      unless values.nil?
        ticket_params = ["email", "from_name", "subject", "body", "html", "date", "labels"]        
        ticket_params.each do |param|
          if 
            ticket[param] = values[param]
          end
        end
        if values.has_key?("attachment")
          # rest-client gems auto-detects a File value and sends it as multipart
          params["attachment"] = File.new(values["attachment"], 'rb')
        end
      end
      params["ticket"] = ticket.to_json
      return request("/tickets", "POST", params)
    end

  end

  class TorApiException < RuntimeError
  end

end
