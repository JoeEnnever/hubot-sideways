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
  key
regex = new RegExp jargon.join('|'), 'gi'

module.exports = (robot) ->
  robot.hear regex, (msg) ->
    console.log(msg.message.text)
    match = regex.exec(msg.message.text)
    console.log(match)
    if match
      msg.send "#{match[0]}: #{explanations[match[0].toLowerCase()].join("\n")}"
