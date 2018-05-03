# Description:
#   Notification of the study meeting.

cronJob = require('cron').CronJob
module.exports = (robot) ->
  tz = 'Asia/Saigon'
  listUsers = {
    "2271814": "Hoa",
    "2916062": "A Toàn",
    "2283905": "Tùng",
    "2284642": "Duy",
    "2006399": "Ngọc",
    "2406328": "Nhàn",
    "2452050": "Dũng",
    "2502915": "Yến",
    "704223": "A Thắng",
    "862029": "Diệu",
    "2833545": "Mạnh",
    "2726824": "A Hào"
  }
  toAll = ""
  for id, name of listUsers
    toAll += "[To:#{id}] #{name}\n"
  rooms = process.env.HUBOT_CHATWORK_ROOMS.split ","
  envelope = room: rooms[0]
  d3RoomID = process.env.D3_ROOM
  #Reminder: Daily meeting
  dailyMtg = () ->
    robot.send envelope, toAll + "Daily Meeting!\n Mọi người đứng dậy đi nào!"
  
  weeklyMtg = () ->
    robot.send d3RoomID, toAll + "TO ALL >>> \nWeekly Meeting!\n Mọi người ra phòng DREAM ROOM để họp nhé!"

  #for golang
  dailyUpdateTicket = () ->
    robot.send envelope, toAll + "Mọi người update ticket trước 9h sáng nhé!"

  playKemxoi = () ->
    robot.send d3RoomID, toAll + "Ai kem xôi không!"

  new cronJob('30 55 16 * * 4', (->
    do weeklyMtg
  ), null, false, tz).start()

  new cronJob('30 14 08 * * 1-5', (->
    do dailyMtg
  ), null, false, tz).start()

  new cronJob('30 45 08 * * 1-5', (->
    do dailyUpdateTicket
  ), null, false, tz).start()

  new cronJob('30 30 14 * * 1-5', (->
    do playKemxoi
  ), null, false, tz).start()