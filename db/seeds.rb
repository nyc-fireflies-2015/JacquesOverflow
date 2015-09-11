user = User.create(username: 'ddog', email: 'ddogrusoy@gmail.com', password: 'password')

user2 = User.create(username: 'Jacques', email: 'jacques@gmail.com', password: 'password')

questions = [['what is activerecord ?', "someone explain it to me please!!!"], ['how does this git thingie work?', 'I accidently lost all my work, teammates are pissed!!?']]

answers = ["it's for databases and shit", "Go read the documentation noob"]

comments = ['very insigntful answer', 'extremely helpful, thanks']

questions.each do |q|
  User.first.questions.create(title: q[0], content: q[1])
end

vote = User.second.votes.create(value: 1,  voteable_id: Question.first.id)

answers.each do |a|
  Question.first.answers.create(content: a, responder_id: User.second.id)
end

comments.each do |c|
  Question.first.answers.first.comments.create(content: c, commentator: User.second)
end



