# Description:
#   Notification of the study meeting.

cronJob = require('cron').CronJob
module.exports = (robot) ->
  tz = 'Asia/Saigon'
  toAll = "[toall] "
  rooms = process.env.HUBOT_CHATWORK_ROOMS.split ","
  envelope = room: rooms[0]
  d2RoomID = room: process.env.D2_ROOM
  #Reminder: Daily meeting
#  dailyMtg = () ->
#    robot.send envelope, toAll + " \nDaily Meeting!\n Mọi người đứng dậy đi nào!"
  hiMorning = () ->
    listMornings = [
      "\nChào ngày mới mọi người! \nChúc mọi người có một ngày làm việc thật hiệu quả và vui vẻ nhé! ",
      "\nおはようございます。Ngày mới bắt đầu rồi mọi người ơi! \nĂn sáng đầy đủ. Năng lượng dồi dào. Và cùng mình Chiến nào!!!",
      "\nTing! Ting! Ting!.\nHãy bắt đầu một ngày mới với nụ cười thật tươi nhé. "
    ]
    robot.send envelope, toAll + listMornings[Math.floor(Math.random() * listMornings.length)]

  byeAfternoon = () ->
    listAfternoons = [
      "\nCông việc kết thúc rồi!\n Hi vọng mọi người đã có một ngày làm việc hiệu quả. Cố lên! (*)",
      "\nHôm nay bạn thế nào? \nSiêu nhân cân team chứ. Một ngày đến HBLAB là một ngày vui phải không nào. (h)",
      "\nMột ngày tuyệt vời với bạn đúng không nào. \nNhớ log lại những gì ngày hôm nay bạn làm được và Ghi chú thêm những gì ngày mai sẽ làm nhé."
    ]
    robot.send envelope, toAll + listAfternoons[Math.floor(Math.random() * listAfternoons.length)]

  weeklyMtg = () ->
    robot.send d2RoomID, toAll + "\nWeekly Meeting!\n Mọi người ơi! Đã đến giờ họp team đầu tuần. Mọi người ra phòng BIG ROOM để họp nhé!"

  timeOT = () ->
    robot.send d2RoomID, toAll + "\nHôm nay có team nào OT không nhỉ? Nếu OT thì hãy đăng ký ở TMS nhé.\nhttps://tms.insight.hblab.vn/"
  #for golang
#  dailyUpdateTicket = () ->
#    robot.send envelope, toAll + "Mọi người update ticket trước 9h sáng nhé!"

  playKemxoi = () ->
    robot.send d2RoomID, toAll + "Ai kem xôi không!"

  new cronJob('30 08 * * 1', (->
    do weeklyMtg
  ), null, false, tz).start()

  new cronJob('00 08 * * 1-5',(->
    do hiMorning
  ), null, false, tz).start()

  new cronJob('45 17 * * 1-5',(->
    do byeAfternoon
  ), null, false, tz).start()

  new cronJob('30 16 * * 1-5',(->
    do timeOT
  ), null, false, tz).start()

  #  new cronJob('20 16 * * 1-5', (->
#    do dailyMtg
#  ), null, false, tz).start()

#  new cronJob('30 45 08 * * 1-5', (->
#    do dailyUpdateTicket
#  ), null, false, tz).start()

  new cronJob('00 14 * * 5', (->
    do playKemxoi
  ), null, false, tz).start()