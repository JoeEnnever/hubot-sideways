# Description:
#  Makes it rain!
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_SLACK_WEBHOOK_URL
#
explanations = require './data/explanations.json'
jargon = for key of explanations
  "\\b#{key}\\b"
regex = new RegExp jargon.join('|'), 'i'
http = new RegExp "http(s)?://", 'i'
module.exports = (robot) ->
  robot.hear regex, (msg) ->
    bytes = []
    bytes.push(x.charCodeAt(0)) for x in msg.message.text
    match = regex.exec(msg.message.text)
    if match
      unless http.test(msg.message.text)
        msg.send "#{match[0]}: #{explanations[match[0].toLowerCase()].join("\n")}"
