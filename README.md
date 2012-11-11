ruby-sdk
============

Ticket on Rails Api Ruby Client


## Authentication

Every call must have a parameter called "token" defined as:

md5(project_domain + md5(api_token))

Where 'md5' represents an MD5 hashing operation, and '+' represents a string concatenation. 
The project domain should be lower-cased before hashing.

## Tickets

### New ticket
This method creates a new ticket.

url: http://api.ticketonrails.com/v1/tickets

method: POST

Parameters:

* token: see authentication
* ticket: json string defined ad follow
	
	{
		email: 'from@example.com',
		from_name: 'John Doe',
		subject: 'lorem ipsum...',
		body: 'lorem ipsum...',
		html: false,
		date: 123456790,
		labels: ['label 1', 'label 2', ...],
		attachment: 'filename.file'
		fields: [
					{
						code: 12345
						value: 'value'
					}, ...
				]
	}

email, subject and body are required. if date is not speficied the current EPOCH time will be used.
html indicates if the message body is plain text or HTML.

* attachment: 1 file can be specified in the request. Your POST  request's Content-Type 
should be set to multipart/form-data with the attachments parameter.

Response: json response with the associated ticket id.

	{
		id: 12345
		ticket: '#1'
	}

### Tickets list
Returns the complete list of tickets

url: http://api.ticketonrails.com/v1/tickets

method: GET

Parameters:

* page: page number
* limit: number of tickets per page

Response: json response with the tickets list.

	{
		"tickets":[
			...,
			{
				"date_last_post": 1351381907,
				"date_update": 1352623898,
				"generated_id": "#6",
				"id": "6",
				"labels":[],
				"project_id": 1,
				"status": 2,
				"subject": "Setup complete!"
			},
			...
		],
		"page": "1",
		"limit": "100",
		"total": 23
	}

Note that all the dates are in EPOCH format; "status" value is enumerated in the following way

* Open: 0
* In Progress: 1
* Closed: 2

### Ticket details
This allows to retrieve all the ticket details

url: http://api.ticketonrails.com/v1/tickets/[ticket id]

method: GET

Parameters: None. The ticket id is specifies in the url.

Response: json response with the seleccted ticket details.

	{
		"ticket":
			{
				"id": "6",
				"generated_id": "#6",
				"project_id": "1",
				"subject": "Setup complete!",
				"labels":[],,
				"status": 2,
				"date_create": "1351381907",
				"date_update": "1352623898",
				"date_last_post":"1351381907"
			},
		"posts": [
			{
				"id":"18",
				"message_id": "<508c7393b7b275.64700838@ticketonrails.com>",
				"in_reply_to": null,
				"from_email": "welcome@ticketonrails.com",
				"from_name": "Ticket on Rails",
				"to_email": null,
				"cc_email": null,
				"reply_to": "welcome@ticketonrails.com",
				"date_email": "1351381907",
				"body_text": "Congratulations...",
				"body_html": "...",
				"body_md": "...",
				"date_create": "1351381907",
				"attachments":[]
			}
		]
	}

Note that all the dates are in EPOCH format; "status" value is enumerated in the following way

* Open: 0
* In Progress: 1
* Closed: 2

## LICENSE

This SDK is released under the [MIT license](https://github.com/ticketonrails/ruby-sdk/blob/master/LICENSE)