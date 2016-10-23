#seeding videos URL

videos = ["https://www.youtube.com/watch?v=CIn0TQsCxRo",
"https://www.youtube.com/watch?v=CrU9CM5n3ys",
"https://www.youtube.com/watch?v=5PnNt8tsytE",
"https://www.youtube.com/watch?v=09rHHvq75-U",
"https://www.youtube.com/watch?v=cjD5R3wXAtQ",
"https://www.youtube.com/watch?v=Bq19BAYfuvo",
"https://www.youtube.com/watch?v=rsjXNrDy0j4",
"https://www.youtube.com/watch?v=vpPtVoaBA08",
"https://www.youtube.com/watch?v=loF15AJ3pts&feature=c4-overview-vl&list=PLCA3DFDAA847412CB"
]

titles = ["10 jours pour apprendre à méditer",
	"15 jours pour comprendre la méditation indienne",
	"8 jours pour s'ouvrir à la méditation chinoise",
	"7 jours pour travailler sa confiance à l'orale",
	"14 jours pour se fixer de nouveaux objectifs",
	"13 jours pour comprendre la récupération émotionnelle",
	"9 jours pour mieux gérer son stresse",
	"17 jours pour se mettre au yoga",
	"10 jours pour trouver un nouveau projet",
	"5 jours pour apprendre à s'organiser"
]

#seeding tags

@tags = ["Eveil & Méditation", "Gestion du stress", "Productivité",
 "PNL & Cybernétique"]

#seeding fake users with 1 track with 5 steps

title_number = 0

10.times do |x|

	user = User.new
	user.email = Faker::Internet.email
	user.password = 'motdepasse'
	user.password_confirmation = 'motdepasse'
	user.full_name = Faker::Name.name
	user.save!
	title_number += 1

	track = user.tracks.build({
		title: titles[title_number],
		description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce nisi sem, malesuada quis placerat vitae, tristique at diam. Praesent vitae quam malesuada, imperdiet odio sed, blandit eros. Nullam eget libero ut turpis elementum malesuada porttitor eget nisl. Fusce euismod rutrum neque at blandit. Maecenas libero tortor, cursus et sem vel, imperdiet feugiat felis. Proin vulputate, magna a feugiat suscipit, diam augue aliquet quam, vel fermentum est est in metus. Aliquam vel lorem hendrerit, elementum libero sit amet, cursus ipsum. Proin velit augue, dapibus a ligula non, fringilla elementum lorem. Pellentesque faucibus fermentum velit sed dapibus. Nullam a mattis turpis, vel pellentesque turpis.",
		price: [0,5,10].sample,
		intro_video: videos[rand(0..videos.count-1)]
		})
	track.theme_list.add(@tags[rand(0..3)])
	track.save

	order = 0

	5.times do |step|
		order += 1
		step = track.steps.build({
			order: order,
			title: "day #{order}",
			description: "Aliquam erat volutpat. Pellentesque lectus nunc, volutpat et eleifend id, aliquet quis felis. Donec sit amet elementum nibh, in congue nisi. Ut luctus eros sollicitudin cursus condimentum. Nam ut sagittis enim. Donec sit amet dui at enim imperdiet euismod. Curabitur mattis varius ligula sed iaculis. Etiam at urna a nibh viverra bibendum ut ac urna. Etiam non venenatis erat, id ornare quam.",
			video: videos[rand(0..videos.count-1)]
			})
		step.save
	end

end

#seeding user Niels Mayrargue

user = User.new
user.email = 'niels.mayrargue@gmail.com'
user.password = 'motdepasse'
user.password_confirmation = 'motdepasse'
user.full_name = "Niels Mayrargue"
user.save!

5.times do |x|

	track = user.tracks.build({
			title: "Super Track de #{user.full_name}",
			description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce nisi sem, malesuada quis placerat vitae, tristique at diam. Praesent vitae quam malesuada, imperdiet odio sed, blandit eros. Nullam eget libero ut turpis elementum malesuada porttitor eget nisl. Fusce euismod rutrum neque at blandit. Maecenas libero tortor, cursus et sem vel, imperdiet feugiat felis. Proin vulputate, magna a feugiat suscipit, diam augue aliquet quam, vel fermentum est est in metus. Aliquam vel lorem hendrerit, elementum libero sit amet, cursus ipsum. Proin velit augue, dapibus a ligula non, fringilla elementum lorem. Pellentesque faucibus fermentum velit sed dapibus. Nullam a mattis turpis, vel pellentesque turpis.",
			price: [0,5,10].sample,
			intro_video: videos[rand(0..videos.count-1)]
			})
		track.theme_list.add(@tags[rand(0..3)])
		track.save

		order = 0

		5.times do |step|
		order += 1
		step = track.steps.build({
			order: order,
			title: "day #{order}",
			description: "Aliquam erat volutpat. Pellentesque lectus nunc, volutpat et eleifend id, aliquet quis felis. Donec sit amet elementum nibh, in congue nisi. Ut luctus eros sollicitudin cursus condimentum. Nam ut sagittis enim. Donec sit amet dui at enim imperdiet euismod. Curabitur mattis varius ligula sed iaculis. Etiam at urna a nibh viverra bibendum ut ac urna. Etiam non venenatis erat, id ornare quam.",
			video: videos[rand(0..videos.count-1)]
			})
		step.save
		end
	end