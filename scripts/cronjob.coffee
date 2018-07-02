# Description:
#   Notification of the study meeting.

cronJob = require('cron').CronJob
module.exports = (robot) ->
  tz = 'Asia/Saigon'
  toAll = "[toall] "
  rooms = process.env.HUBOT_CHATWORK_ROOMS.split ","
  envelope = room: rooms[0]
  d3RoomID = room: process.env.D3_ROOM
  #Reminder: Daily meeting
  dailyMtg = () ->
    robot.send envelope, toAll + "Daily Meeting!\n Mọi người đứng dậy đi nào!"
  
  weeklyMtg = () ->
    robot.send d3RoomID, toAll + "\nWeekly Meeting!\n Mọi người ra phòng DREAM ROOM để họp nhé!"

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