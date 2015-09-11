user = User.create(username: 'ddog', email: 'ddogrusoy@gmail.com', password: 'password')

questions = [['what is activerecord ?', "someone explain it to me please!!!"], ['how does this git thingie work?', 'I accidently lost all my work, teammates are pissed!!?']]

answers = ["it's for databases and shit", "Go read the documentation noob"]

comments = ['very insigntful answer', 'extremely helpful, thanks']

questions.each do |q|
  user.questions.create(title: q[0], content: q[1])
end

answers.each do |a|
  Question.first.comment.create(content: a)
end
