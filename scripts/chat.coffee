module.exports = (robot) ->
  chatBotID = process.env.HUBOT_CHATWORK_BOT_ID
  qaSheetURL = "https://docs.google.com/a/hblab.vn/spreadsheets/d/1xOHYIQMQWIhRK0LBzvONAhXkeIyCZNQ9sfDswTSEUao/edit?usp=drive_web"
  qcCheckListSheetURL = "https://drive.google.com/drive/folders/0By-hGffj5wPaSEZBXzhkV1lRUzA?usp=sharing"
  databaseSheetURL = "https://docs.google.com/spreadsheets/d/15IHjzoeoazJEDN0qVq4phSGib_JTBthNo5L3cxouLn4/edit#gid=788854534"
  noiquySheetURL = "https://docs.google.com/spreadsheets/d/18lPPmJZyrpRb1T5rzLu6CaKb0OgkUuGtYY-Ni8nDdRM/edit#gid=0"
  listUsers = {}
  listUserIDs = []

  d3RoomID = process.env.D3_ROOM
  # get users from rooms D3
  robot.http("https://api.chatwork.com/v2/rooms/" + d3RoomID + "/members")
    # .header('Content-Type', 'application/json')
    .header('X-ChatWorkToken', '3a9a18884f494c810e4ccb124846f8b2')
    .get() (err, res, body) ->
      for item in JSON.parse(body)
        listUsers[item.account_id] = item.name
        listUserIDs.push(item.account_id)

  isChatBot = (res) -> 
    if res.envelope.user.id.toString() is chatBotID
      return true
    return false
  isD3Room = (res)  ->
    envelope = res.envelope
    roomID = envelope.user.room
    return true if roomID is d3RoomID
    return false
  replyUser = (res, txt) -> 
    envelope = res.envelope
    userID = envelope.user.id
    roomID = envelope.user.room
    messageID = res.message.id
    message = "[rp aid=#{userID} to=#{roomID}-#{messageID}] #{envelope.user.name} \n#{txt}"
    res.send message
  
  robot.hear /^kem xôi$/i, (res) ->
    return if isD3Room is false
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
    return if isD3Room is false
    return if isChatBot(res)
    if res.match.input is "kem xôi"
      return
    res.send "Tìm người trả tiền chè nào! :D"

  robot.hear /^hello/i, (res) ->
    return if isChatBot(res)
    welcomes = [
      "Hello em ku te o!",
      "Anh đẹp giai! Mời chè team đi",
      "Ku te",
      "Hi em!"
    ]
    replyUser res, res.random welcomes
  
  robot.hear /IQ /i, (res) ->
    return if isChatBot(res)
    replyUser res, "Em ai quy cao lắm đấy!"

  robot.hear /mời chè/i, (res) ->
    return if isChatBot(res)
    replyUser res, "Yeah! Đẹp trai lắm!"

  robot.hear /cảm ơn/i, (res) ->
    return if isChatBot(res)
    replyUser res, "(h)(h)(h)"

  robot.hear /xin phép/i, (res) ->
    return if isChatBot(res)
    replyUser res, "Ok baby."

  robot.hear /haylam/i, (res) ->
    return if isChatBot(res)
    replyUser res, "Hay lắm :p"

  robot.hear /cu te/i, (res) ->
    return if isChatBot(res)
    replyUser res, "Ý em là Kuteo à!"
  
  robot.hear /bug/i, (res) ->
    return if isChatBot(res)
    bugs = [
      "Bug gì đấy em?",
      "A A A A! Bug kinh hồn!",
      "Bắt con Phích nhanh 8-)",
      "Bug to thế :(",
      "Bug thế này release sao được ;("
    ]
    replyUser res, res.random bugs
  
  robot.hear /update ticket/i, (res) ->
    return if isD3Room is true
    return if isChatBot(res)
    tickets = [
      "Anh em update ticket nhanh đi nhé. Bot nhắc nhiều rồi đấy!",
      "Anh Yoshizawa đang kêu đấy. Anh em update task nhé!"
    ]
    res.send res.random tickets

  robot.hear /^test$/i, (res) ->
    return if isD3Room is true
    return if isChatBot(res)
    replyUser res, "Test nhanh lên em. Khách hàng đang chờ"
  
  # robot.hear /a thắng/i, (res) -> 
  #   return if isChatBot(res)
  #   res.send "anh Thắng xấu trai nhất công ty (devil) (devil) (devil)"

  # robot.hear /anh thắng/i, (res) -> 
  #   return if isChatBot(res)
  #   res.send "anh Thắng xấu trai nhất công ty (devil) (devil) (devil)"
  
  robot.hear /#database/i, (res) -> 
    return if isD3Room is true
    replyUser res, databaseSheetURL

  robot.hear /#noiquy/i, (res) -> 
    return if isD3Room is true
    replyUser res, noiquySheetURL

  robot.hear /tùng/i, (res) -> 
    return if isChatBot(res)
    res.send "Hello, Tùng điệu đà :D"

  robot.hear /Hào/i, (res) -> 
    return if isChatBot(res)
    res.send "A Hào mời chè à :D"

  # robot.hear /(y)/i, (res) -> 
  #   return if isChatBot(res)
  #   res.send "(y)"
  
  robot.hear /#qa/i, (res) -> 
    return if isD3Room is true
    return if isChatBot(res)
    replyUser res, "Q&A Sheet đây:\n" + qaSheetURL
  
  robot.hear /#Q&A/i, (res) ->
    return if isD3Room is true 
    return if isChatBot(res)
    replyUser res, "Q&A Sheet đây:\n" + qaSheetURL
  
  robot.hear /#qcchecklist/i, (res) ->
    return if isD3Room is true 
    return if isChatBot(res)
    replyUser res, "QC Checklist Sheet đây:\n" + qcCheckListSheetURL
  
  robot.hear /hihi/i, (res) -> 
    return if isChatBot(res)
    replyUser res, "A hihi! Đồ ngốc!"
  
  robot.hear /lìu lìu/i, (res) -> 
    return if isChatBot(res)
    replyUser res, "Quá lìu tìu!!!"