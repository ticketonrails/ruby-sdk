require 'rubygems'
require 'digest/md5'
require 'json'

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

    def request(url, method = 'GET', params = nil)
      return "hi"
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
          params["attachment"] = values["attachment"]
        end
      end
      params["ticket"] = ticket.to_json
      return request("/tickets", "POST", params)
    end

  end

  class TorApiException < RuntimeError
  end

end
