jacques = User.create(
	username: 'Jacques', 
	email: 'jacques@gmail.com', 
	password: 'password',
	bio: "je suis Jacques",
	avatar_url: Faker::Avatar.image)

25.times { User.create(
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

content = ["Je ne comprends pas!!!! Expert en utilisabilité des sites web et des logiciels, du faux-texte dans.",
	"I don't understand.  la conception de sites web est que ce texte n'étant jamais lu. ",
	"Please help! il ne permet pas de.",
	"expliquez-moi ce qui se passe!  vérifier sa lisibilité effective. La lecture à l'écran étant plus difficile, cet aspect est pourtant essentiel. Nielsen préconise donc l'utilisation de textes.",
	"je veux apprendre à coder.  représentatifs plutôt que du lorem ipsum. On peut aussi faire remarquer que les formules conçues avec du faux-texte ont tendance à sous-estimer l'espace.",
	"i aime ruby mais je ne comprends pas. nécessaire à une titraille immédiatement intelligible, ce qui oblige les rédactions à formuler ensuite des titres simplificateurs, voire inexacts, pour ne pas dépasser l'espace imparti."]

answers = ["It's for databases and shit", 
	"Go read the documentation noob", 
	"le mettre en latin est que l'opérateur sait au premier coup d'oeil que la page contenant ces lignes n'est pas valide, et surtout l'attention du client n'est pas dérangée par le contenu, il demeure concentré seulement sur l'aspect graphique",
	"Il est pour les bases de données",
	"allez lire la documentation noob"
	]

comments = ['very insigntful answer', 
	'extremely helpful, thanks',
	"réponse très perspicace",
	"extrêmement serviable, merci",
	"vous êtes totalement faux",
	"ce que l'on vous parle même pas"]

3.times.with_index do |i| 
	Question.create(
		title: titles[i],
		content: content.sample,
		submitter: jacques
	)
end

titles.each do |title| 
	Question.create(
	title: title,
	content: content.sample,
	submitter: User.all.sample)
end	

Question.all.each do |question|
	(3..5).to_a.sample.times {
		question.comments.create(content: comments.sample, commentator: User.all.sample)
		question.answers.create(content: answers.sample, responder: User.all.sample)
	}
end	

Answer.all.each do |answer|
	(2..5).to_a.sample.times {
		answer.comments.create(content: comments.sample, commentator: User.all.sample)
	}
end	

5.times {
	Question.all.sample.answers.create(content: answers.sample, responder: jacques)
	Question.all.sample.comments.create(content: comments.sample, commentator: jacques)
	Answer.all.sample.comments.create(content: comments.sample, commentator: jacques)
}	

Question.all.each do |question|
	(5..50).to_a.sample.times {
		question.votes.create(value: 1, voter: User.all.sample)
	}
	(1..10).to_a.sample.times {
		question.votes.create(value: -1, voter: User.all.sample)
	}
end

Answer.all.each do |answer|
	(5..10).to_a.sample.times {
		answer.votes.create(value: 1, voter: User.all.sample)
	}
	(1..5).to_a.sample.times {
		answer.votes.create(value: -1, voter: User.all.sample)
	}
end	



