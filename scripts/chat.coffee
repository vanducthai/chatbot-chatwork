module.exports = (robot) ->
  chatBotID = process.env.HUBOT_CHATWORK_BOT_ID
  qaSheetURL = "https://docs.google.com/a/hblab.vn/spreadsheets/d/1xOHYIQMQWIhRK0LBzvONAhXkeIyCZNQ9sfDswTSEUao/edit?usp=drive_web"
  qcCheckListSheetURL = "https://drive.google.com/drive/folders/0By-hGffj5wPaSEZBXzhkV1lRUzA?usp=sharing"
  databaseSheetURL = "https://docs.google.com/spreadsheets/d/15IHjzoeoazJEDN0qVq4phSGib_JTBthNo5L3cxouLn4/edit#gid=788854534"
  noiquySheetURL = "https://docs.google.com/spreadsheets/d/18lPPmJZyrpRb1T5rzLu6CaKb0OgkUuGtYY-Ni8nDdRM/edit#gid=0"
  listUsers = {}
  listUserIDs = []

  d2RoomID = process.env.D2_ROOM
  chatworkToken = process.env.HUBOT_CHATWORK_TOKEN
  # get users from rooms D2
  robot.http("https://api.chatwork.com/v2/rooms/" + d2RoomID + "/members")
    # .header('Content-Type', 'application/json')
    .header('X-ChatWorkToken', chatworkToken)
    .get() (err, res, body) ->
      for item in JSON.parse(body)
        listUsers[item.account_id] = item.name
        listUserIDs.push(item.account_id)

  isChatBot = (res) -> 
    if res.envelope.user.id.toString() is chatBotID
      return true
    return false
  isD2Room = (res)  ->
    envelope = res.envelope
    roomID = envelope.user.room
    return true if roomID is d2RoomID
    return false
  replyUser = (res, txt) -> 
    envelope = res.envelope
    userID = envelope.user.id
    roomID = envelope.user.room
    messageID = res.message.id
    message = "[rp aid=#{userID} to=#{roomID}-#{messageID}] #{envelope.user.name} \n#{txt}"
    res.send message
  
  robot.hear /^kem xôi$/i, (res) ->
    return if isD2Room is false
    return if isChatBot(res)
    userID = res.random listUserIDs
    message = "[To:#{userID}] "
    message += listUsers[userID]
    if userID is chatBotID
      message += " không trả tiền đâu nhé :v"
    else
      message += " trả tiền"
    res.send message
  
  robot.hear /kem xôi/i, (res) ->
    return if isD2Room is false
    return if isChatBot(res)
    kemxois = [
      "Hôm nay ai sẽ là người may mắn được mời mọi người đây (h)",
      "Dù kết quả như thế nào thì cũng Một nụ cười luôn hé nhé. (*)",
      "Quay đều, quay đều, quay đều!\nHôm nay là ngày của bạn! (dance)"
    ]
    if res.match.input.toLowerCase() is "kem xôi"
      return
    res.send res.random kemxois

  robot.hear /nghỉ/i, (res) ->
    return if isD2Room is true
    return if isChatBot(res)
    replyUser res, "Okie đồng chí, nhớ log trên TSM nhé"

  robot.hear /du lịch/i, (res) ->
    return if isD2Room is true
    return if isChatBot(res)
    replyUser res, "Không biết mọi người có háo hức đi xả stress không nhỉ. Cứ chọn địa điểm, việc còn lại để chúng mình lo"

  robot.hear /sếp/i, (res) ->
    return if isD2Room is true
    return if isChatBot(res)
    replyUser res, "Không biết ai nhắc đến Toàn-sama đẹp trai ấy nhỉ"