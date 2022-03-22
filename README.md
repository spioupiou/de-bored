# :game_die: de.Bored

Have you run out of conversation topics with your friends? Do you need a rapid solution to break the awkward silence that is quietly settling in? 
Do not worry, we got you! Just install de.Bored on your phone and ask your friends to join a game session. And let the fun begin!


![screenshot](https://user-images.githubusercontent.com/68413600/159497483-f18354dc-dc7f-438b-83e3-e0d44fb771f5.png)


App home: https://www.de-bored.fun
   

## Getting Started
### Setup

Install gems
```
bundle install
```
Install JS packages
```
yarn install
```

### ENV Variables
We use [Cloudinary](https://cloudinary.com) to host our cute robot avatars. You will need an API key to see them properly:


Create `.env` file
```
touch .env
```
Inside `.env`, set the below variable: 
```
CLOUDINARY_URL=your_own_cloudinary_url_key
```

### DB Setup
```
rails db:create
rails db:migrate
rails db:seed
```

### Run a server
```
rails s
```

## Built With
- [Rails 6](https://guides.rubyonrails.org/) - Backend / Front-end
- [Heroku](https://heroku.com/) - Deployment
- [PostgreSQL](https://www.postgresql.org/) - Database
- [Bootstrap](https://getbootstrap.com/) — Styling
- [Figma](https://www.figma.com) — Prototyping


## Acknowledgements
A big thank you to all the teachers at Le Wagon for their support and encouragement.

## Team Members
de.Bored was built by four hard-working and dedicated developers. If you enjoyed the game, don’t hesitate to drop us a message!  
- [Hiro](https://www.linkedin.com/in/hiroya-takemura-b98024209/)
- [Carl](https://www.linkedin.com/in/carlnoval/)
- [Shante](https://www.linkedin.com/in/shantejohnson-moore/)
- [Cedrine](https://www.linkedin.com/in/cedrinemonnet/)
