jacques = User.create(
	username: 'Jacques', 
	email: 'jacques@gmail.com', 
	password: 'password',
	bio: "je suis Jacques",
	avatar_url: Faker::Avatar.image)

100.times { User.create(
	username: Faker::Internet.user_name,
	email: Faker::Internet.email,
	bio: "Cet utilisateur aime à être mystérieux",
	password: "supersecure",
	avatar_url: Faker::Avatar.image
	)
}



titles = ['Quel est activerecord? Je ne comprends pas!', 
	"Comment cela fonctionne-chose git??", 
	"Comment faire --no-ri --no-rdoc défaut pour gem install?",
	"Une explication concise de néant v. nil v. empty dans Ruby on Rails",
	"Quel est attr_accessor en Ruby?",
	"Comment puis-je retirer RVM (Ruby Version Manager) de mon système?",
	"Pourquoi les gens utilisent Heroku lorsque AWS est présent? Qu'est-ce à propos de la distinction Heroku",
	"Purger ou recréer une base de données Ruby on Rails",
	"Ruby: qu'est-ce que w% (array) signifie?",
	"Pas de matches de route \"/users/sign_out\" concevoir des rails 3"
	]


"someone explain it to me please!!!"], ['how does this git thingie work?', 'I accidently lost all my work, teammates are pissed!!?']]

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



