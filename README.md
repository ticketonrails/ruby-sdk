ruby-sdk
============

Ticket on Rails Api Ruby Client


## Authentication

Every call must have a parameter called "token" defined as:

md5(project_domain + md5(api_token))

Where 'md5' represents an MD5 hashing operation, and '+' represents a string concatenation. 
The project domain should be lower-cased before hashing.

## tickets

### new ticket
This method creates a new ticket.

url: http://api.ticketonrails.com/v1/tickets

method: POST

Parameters:

* token: see authentication
* ticket: json string defined ad follow

```
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
```

email, subject and body are required. if date is not specified the current EPOCH time will be used.
html indicates if the message body is plain text or HTML.

* attachment: 1 file can be specified in the request. Your POST request Content-Type 
should be set to multipart/form-data with the attachments parameter.

Response: json response with the associated ticket id.

	{
		id: 12345
		ticket: '#1'
	}

## LICENSE

This SDK is released under the [MIT license](https://github.com/ticketonrails/ruby-sdk/blob/master/LICENSE)