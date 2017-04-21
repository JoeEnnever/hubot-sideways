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
jargon = explanations.map((o) -> "\\b#{o.term}\\b")
regex = new RegExp jargon.join('|'), 'gi'

module.exports = (robot) ->
  robot.hear regex, (msg) ->
    match = regex.exec(msg.message.text)
    if match:
      msg.send "#{match[0]}: #{explanations[match[0]].join("\n")}"
