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
      "\nTing! Ting! Ting!.\nHãy bắt đầu một ngày mới với nụ cười thật tươi nhé. ",
      "\nThay vì lo lắng người khác nói gì về mình, sao bạn không bỏ thời gian cố đạt được điều khiến họ phải khâm phục",
      "\nSửa mình làm cung, uốn ý tưởng làm tên, lấy nghĩa vững làm đích, ngắm cho ngay rồi bắn ra, bắn ra tất phải trúng đích",
      "\nHãy để ý xem bạn đang đi đâu, vì nếu không có ý nghĩa, bạn có thể sẽ chẳng tới được đâu",
      "\nQuyết đoán là một tính cách của những người đàn ông và phụ nữ năng động. Quyết định nào cũng hơn là không có quyết định",
      "\nHãy nắm lấy cơ hội! Tất cả cuộc đời là cơ hội. Người tiến xa nhất thường là người sẵn sàng hành động và chấp nhận thách thức"
      "\nĂn mừng thành công cũng tốt, nhưng quan trọng hơn là phải biết chú ý đến những bài học của sự thất bại."
      "\nThành công là một người thầy tồi tệ. Nó quyến rũ những người thông minh vào ý nghĩ rằng họ sẽ chẳng bao giờ thất bại."
      "\nThành công là một người thầy tồi tệ. Nó quyến rũ những người thông minh vào ý nghĩ rằng họ sẽ chẳng bao giờ thất bại."
      "\nChúng tôi sẽ làm tất cả để thành công. Đơn giản bởi chúng tôi là những người trẻ và chúng tôi không bao giờ biết từ bỏ"
      "\nMọi công việc thành đạt đều nhờ sự kiên trì và lòng say mê"
      "\nThành đạt không phải do sự giúp đỡ của người khác mà chính do lòng tự tin"
      "\nMuốn thành công thì khao khát thành công phải lớn hơn nỗi sợ bị thất bại."
      "\nMức độ thành công được xác định không phải bởi những gì ta đã đạt được, mà bởi những trở ngại ta đã vượt qua."
      "\nBạn càng thành công thì ở gần bạn càng ít người vui vì sự thành công của bạn"
      "\nThành công của chúng ta không phải là những gì mà ta đang sở hữu mà là những gì ta sẽ để lại."
      "\nThành công không phụ thuộc vào kiến thức mà vào cách áp dụng kiến thức"
      "\nKhông phải lúc nào bạn cố gắng cũng thành công nhưng phải luôn cố gắng để không hối tiếc khi thất bại."
      "\nThành công là việc sử dụng tối đa khả năng mà bạn có."
      "\nThành công không bao giờ được đo bằng bao nhiêu tiền bạn có."
      "\nDù người ta có nói với bạn điều gì đi nữa, hãy tin rằng cuộc sống là điều kỳ diệu và đẹp đẽ."
      "\nCon người sinh ra không phải để tan biến đi như một hạt cát vô danh. Họ sinh ra để in dấu lại trên mặt đất, in dấu lại trong trái tim người khác."
      "\nĐời là cuộc đấu tranh liên tục; nó luôn được cải biên với những khó khăn mới. Và chúng ta sẽ chiến thắng nhưng bao giờ cũng phải trải giá."
      "\nHãy hướng về phía mặt trời bạn sẽ không thể nhìn thấy bóng tối. Đó là những gì hoa hướng dương đang làm."
      "\nTrí tuệ của con người trưởng thành trong tĩnh lặng, còn tính cách trưởng thành trong bão táp."
      "\nHãy sống tốt đẹp đi và nhớ rằng, mỗi ngày có một đời sống riêng cho nó thôi "
      "\nBạn có yêu đời không? Vậy đừng phung phí thời gian vì chất liệu của cuộc sống được làm bằng thời gian."
      "\nChúng ta có bốn mươi triệu lý do về sự thất bại nhưng không có một lời bào chữa nào."
      "\nChưa thử sức thì không bao giờ biết hết năng lực của mình. "
      "\nĐừng để đến ngày mai những việc gì anh có thể làm hôm nay. "
      "\nNếu không vấp phải một trở ngại nào nữa, tức là bạn đã đi chệch đường rồi đó."
      "\nHãy học cách sống vượt thành công của người khác. "
      "\nĐiều tôi muốn biết trước tiên không phải là bạn đã thất bại ra sao mà là bạn đã chấp nhận nó như thế nào. "
      "\nThành công chỉ đến khi bạn làm việc tận tâm và luôn nghĩ đến những điều tốt đẹp."
      "\nKhông có nghèo gì bằng không có tài, không có gì hèn bằng không có chí. "
      "\nKẻ nào không muốn cúi xuống lượm một cây kim thì không đáng có một đồng bạc. "
      "\nThành công là một cuộc hành trình chứ không phải là điểm đến."
      "\nNgười bị vấp ngã là người dám liều mình. Qua cách họ đối phó với sai lầm, ta có thể đoán dược cách họ giải quyết khó khăn trong tương lai."
      "\nĐời là cuộc đấu tranh liên tục; nó luôn được cải biên với nhưng khó khăn mới. Và chúng ta sẽ chiến thắng nhưng bao giờ cũng phải trải giá."
    ]
    robot.send envelope, listMornings[Math.floor(Math.random() * listMornings.length)]

  byeAfternoon = () ->
    listAfternoons = [
      "\nCông việc kết thúc rồi!\n Hi vọng mọi người đã có một ngày làm việc hiệu quả. Cố lên! (*)",
      "\nHôm nay bạn thế nào? \nSiêu nhân cân team chứ. Một ngày đến HBLAB là một ngày vui phải không nào. (h)",
      "\nMột ngày tuyệt vời với bạn đúng không nào. \nNhớ log lại những gì ngày hôm nay bạn làm được và Ghi chú thêm những gì ngày mai sẽ làm nhé.",
      "\nThêm một chút bền bỉ, một chút nỗ lực, và điều tưởng chừng như là thất bại vô vọng có thể biến thành thành công rực rỡ",
      "\nCái người đời thường thiếu là ý chí chứ không phải là sức mạnh",
      "\nKhông phải người ta ngừng theo đuổi giấc mơ vì mình già đi, người ta già đi vì ngừng theo đuổi giấc mơ"
      "\nKhông có con đường nào dài quá đối với kẻ bước đi thong thả, không vội vàng. Không có cái lợi nào xa xôi quá đối với những kẻ kiên nhẫn làm việc."
      "\nThành đạt không phải ở người giúp đỡ mà chính do lòng tự tin. "
      "\nHãy làm tròn mỗi công việc của đời mình như thể đó là công việc cuối cùng."
      "\nĐường đi khó không phải vì ngăn sông cách núi . Mà khó vì lòng người ngại núi e sông. "
      "\nMuốn cầu tiến hơn người, ra đời phải biết ngước mặt nhìn lên. Vì nhìn xuống ta thấy hơn người, nhưng nhìn lên ta chỉ là con số không vĩ đại. "
      "\nBiết điều mà ai cũng biết là không biết gì hết. Cái biết chỉ bắt đầu ở chỗ mà mọi người không biết "
      "\nAi than thở không bao giờ có thời gian, người ấy làm được ít việc nhất."
      "\nBiết bao kẻ đọc sách và học hỏi, không phải để tìm ra chân lý mà là để gia tăng những gì mình đã biết. "
      "\nTôi chưa bao giờ gặp một người nào mà tôi không tìm thấy nơi họ một cái gì đáng cho tôi học hỏi."
      "\nChỉ những kẻ nào có nhẫn nại làm được hoàn toàn những việc dễ mới biết nghệ thuật làm được dễ dàng những việc khó."
      "\nCon ong được ca tụng vì nó làm việc không phải cho chính mình nhưng cho tất cả."
      "\nCó 3 thứ ngu dốt: không biết những gì mình cần biết, không rành những gì mình biết và biết những gì mình không cần biết."
      "\nNgười anh hùng vĩ đại nhất là người làm chủ được những ước mơ của mình."
      "\nNếu bạn muốn giầu có thì chẳng những phải học cách làm ra tiền mà còn phải học cách sử dụng đồng tiền."
      "\nLàm việc đừng quá trông đợi vào kết quả, nhưng hãy mong cho mình làm được hết sức mình."
      "\nChiến thắng bản thân là chiến thắng hiển hách nhất."
      "\nKẻ hoang phí sẽ là kẻ ăn mày trong tương lai. Kẻ tham lam là kẻ ăn mày suốt đời."
      "\nĐi vòng mà đến đích còn hơn đi thẳng mà ngã đau. "
      "\nLý tưởng ấp ủ trong tâm trí sẽ tạo nên những hành vi phù hợp với lý tưởng."
      "\nHọc trò xoàng xĩnh là học trò không vượt được thầy."
      "\nHãy tham khảo ý kiến người khác cho kỹ càng trước khi bắt tay vào việc, và khi đã quyết định rồi thì hãy hành động ngay tức khắc. "
      "\nCâu trả lời gọn nhất là hành động. "
      "\nĐường tuy gần không đi không bao giờ đến, việc tuy nhỏ không làm chẳng bao giờ nên."
      "\nBa cái nền tảng của học vấn là: nhận xét nhiều, từng trải nhiều và học tập nhiều. Bí quyết lớn nhất của thành công là thành thật. Không thành thật, không có phương pháp nào đắc dụng với bạn hết. "
      "\nTất cả mọi người đều ao ước có được nhiều hiểu biết, điều kiện đầu tiên là phải biết nhìn đời với cặp mắt của đứa trẻ thơ, cái gì cũng mới lạ và làm cho ta ngạc nhiên cả."
    ]
    robot.send envelope, listAfternoons[Math.floor(Math.random() * listAfternoons.length)]

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

  new cronJob('00 08,11 * * 1-5',(->
    do hiMorning
  ), null, false, tz).start()

  new cronJob('30 14,17 * * 1-5',(->
    do byeAfternoon
  ), null, false, tz).start()

#  new cronJob('30 16 * * 1-5',(->
#    do timeOT
#  ), null, false, tz).start()

  #  new cronJob('20 16 * * 1-5', (->
#    do dailyMtg
#  ), null, false, tz).start()

#  new cronJob('30 45 08 * * 1-5', (->
#    do dailyUpdateTicket
#  ), null, false, tz).start()

  new cronJob('00 14 * * 5', (->
    do playKemxoi
  ), null, false, tz).start()