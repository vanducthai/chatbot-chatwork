module.exports = (robot) ->
  robot.hear /^random$/i, (res) ->
    teams = ["Diệu", "Trung", "Tùng", "Duy", "Dũng", "Hoa", "Yến", "Nhàn"]
    rand = Math.floor(Math.random() * teams.length)
    res.send teams[rand] + " trả tiền"

  robot.hear /bugfix/i, (res) ->
    // room = res.envelope.user.name
    res.reply room,"I'm afraid I can't let you do that."

###
  robot.hear /random/i, (res) ->
    res.emote process.env.HUBOT_CHATWORK_TOKEN
###