config = require '../config'

request = require 'superagent'


module.exports = (channel) ->
    # Returns a handler that will post gollum events (as issued by github) to `channel`
    (req, res) ->
        createdCount = updatedCount = 0
        created = updated = null

        for page in req.body.pages
            if page.action is 'created'
                created = page
                createdCount += 1
            else
                updated = page
                updatedCount += 1

        message = 'I '
        if createdCount
            if createdCount > 1
                message += "just created #{createdCount} new pages "
            else
                message += "created a page called <#{created.html_url}|#{created.page_name}> "

        if createdCount and updatedCount
            message += 'and '
        if updatedCount
            if updatedCount > 1
                message += "just updated #{updatedCount} pages "
            else
                message += "updated the <#{updated.html_url}|#{updated.page_name}> page "
        message += "on the <#{req.body.repository.html_url}|#{req.body.repository.full_name}>
                    <#{req.body.repository.html_url}/wiki|Wiki> "


        res.status(202).send(
            'code': 'OK'
            'message': "Accepted"
        )

        request
        .get(req.body.sender.url)
        .set("Accept", "application/vnd.github.v3+json")
        .end (err, response) ->
            name = req.body.sender.login
            if not err and response.body and response.body.name
                name = response.body.name

            request
                .post(config.slack.webhook)
                .send(
                    'username': name
                    'icon_url': req.body.sender.avatar_url
                    'channel': channel
                    'text': message
                )
                .end()
