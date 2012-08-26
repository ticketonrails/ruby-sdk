$: << File.join(File.dirname(__FILE__), ".")
require 'tor'

API_KEY = "YOUR API KEY"
PROJECT_DOMAIN = "YOUR PROJECT DOMAIN"

api = ToR::TorApi.new(API_KEY, PROJECT_DOMAIN)

ticket = {}
ticket["email"] = "your@email.address"
ticket["from_name"] = 'John Doe'
ticket["subject"] = 'lorem ipsum...'
ticket["body"] = 'lorem ipsum...'
ticket["html"] = false
ticket["date"] = Time.now.nsec
ticket["labels"] = ['label 1', 'label 2']
ticket["attachment"] = "./attachment.txt"

ticket_result = api.new_ticket(ticket)
puts ticket_result
