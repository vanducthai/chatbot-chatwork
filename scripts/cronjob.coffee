# Description:
#   Notification of the study meeting.

cronJob = require('cron').CronJob
module.exports = (robot) ->
  tz = 'Asia/Hanoi'
  #Reminder: Daily meeting
  dailyMtg = () ->
    envelope = room: process.env.HUBOT_CHATWORK_ROOMS
    robot.send envelope, "Daily Meeting!\n Mọi người đứng dậy đi nào!"
  
  #for golang
  dailyUpdateTicket = () ->
    envelope = room: process.env.HUBOT_CHATWORK_ROOMS
    robot.send envelope, "Mọi người update ticket trước 9h sáng nhé!"

  playKemxoi = () ->
    envelope = room: process.env.HUBOT_CHATWORK_ROOMS
    robot.send envelope, "Ai kem xôi không!"

  new cronJob('30 14 08 * * 1-5', (->
    do dailyMtg
  ), null, false, tz).start()

  new cronJob('30 45 08 * * 1-5', (->
    do dailyUpdateTicket
  ), null, false, tz).start()

  new cronJob('30 55 2 * * 1-5', (->
    do playKemxoi
  ), null, false, tz).start()