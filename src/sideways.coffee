# Description:
#  Translate engineer to english
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_SIDEWAYS_CHANNEL_BLACKLIST
#
explanations = require './data/explanations.json'
channelBlacklist = (process.env.HUBOT_SIDEWAYS_CHANNEL_BLACKLIST || '').split(",")
jargon = for key of explanations
  "\\b#{key}\\b"
regex = new RegExp jargon.join('|'), 'i'
http = new RegExp "http(s)?://", 'i'
module.exports = (robot) ->
  robot.hear regex, (msg) ->
    bytes = []
    bytes.push(x.charCodeAt(0)) for x in msg.message.text
    match = regex.exec(msg.message.text)
    unless match
      return
    if http.test(msg.message.text)
      return
    if channelBlacklist.indexOf(msg.message.room) < 0
      msg.send "#{match[0]}: #{explanations[match[0].toLowerCase()].join("\n")}"
