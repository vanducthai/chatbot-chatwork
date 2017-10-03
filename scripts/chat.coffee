module.exports = (robot) ->
  chatBotID = process.env.HUBOT_CHATWORK_BOT_ID
  isChatBot = (res) -> 
    if res.envelope.user.id.toString() is chatBotID
      return true
    return false

  replyUser = (res, txt) -> 
    envelope = res.envelope
    userID = envelope.user.id
    roomID = envelope.user.room
    messageID = res.message.id
    message = "[rp aid=#{userID} to=#{roomID}-#{messageID}] #{envelope.user.name} \n#{txt}"
    res.send message

  robot.hear /^kem xôi$/i, (res) ->
    return if isChatBot(res)
    teams = ["Diệu", "Trung", "Tùng", "Duy", "Dũng", "Hoa", "Yến", "Nhàn", "Hưng", "Hợi"]
    res.send (res.random teams) + " trả tiền"
  
  robot.hear /kem xôi/i, (res) ->
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
  
  robot.hear /IQ/i, (res) ->
    return if isChatBot(res)
    replyUser res, "Em ai quy cao lắm đấy!"

  robot.hear /mời chè/i, (res) ->
    return if isChatBot(res)
    replyUser res, "Yeah! Đẹp trai lắm!"

  robot.hear /haylam/i, (res) ->
    return if isChatBot(res)
    replyUser res, "Hay lắm :p"

  robot.hear /cu te/i, (res) ->
    return if isChatBot(res)
    replyUser res, "Ý em là Kuteo à!"
    # res.reply "Ý em là Kuteo à!"
  
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
    return if isChatBot(res)
    tickets = [
      "Anh em update ticket nhanh đi nhé. Bot nhắc nhiều rồi đấy!",
      "Anh Yoshizawa đang kêu đấy. Anh em update task nhé!"
    ]
    res.send res.random tickets

  robot.hear /^test$/i, (res) ->
    return if isChatBot(res)
    replyUser res, "Test nhanh lên em. Khách hàng đang chờ"
  