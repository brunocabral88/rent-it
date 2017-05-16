# Project Description
Rent-it is a tool rental website (similar to Airbnb for tools and equipments).
John has many tools at his home and is running out of space and also he is looking for a way to make money from his tools collection. Jan rarely uses tools and don't like spending 500$ to buy a tool.

with Rent-it, John can rent his tools and not only have more space at home, but also make money. Also Jan can rent a tool instead of buying it and save money.

# Functional Specifications:
* Users can put their tools for rent
* Users can rent others' rental tools
* Payments process is handled by Stripe API
* At booking time, user is charged for a deposit money and after the rental period (after returning the tool to the owner), renter will get a refund with the amount of deposit-rental fee
* Users can search for a tool and filter tools based on their category and the distance between theri location and the tool owner location.
* The location of the tool search result is shown on a map (using Google Maps API)
* Application is mobile responsive (Using Bootstrap)
* When the user wants to add a new tool, they just upload a picture and application suggests them a few options for the tool's name (using Clarifai image recognition API + cross refrencing the API result with a database of tool names, the database is created by scraping the home improvement websites)
* Each user has a dashboard containing their history of using Rent-it and a graph which shows them how much they spend on renting from Rent-it and how much they made from renting their tools through Rent-it (using MorrisJS)
* there is a live chat between customers and customer service of Rent-it which is integrated with Slack (customers chat on websit and Customer Service answer them through their Slack)
* Users can login via their username/password of Rent-it website or using their Facebook login (using oauth)
* Tool owner gets an email after their tool was booked
* Renter gets email after they paid the deposit to know how much they were charged for deposit and the amount that they should pay at the end
* Renter gets an email after returning and understand how much refund they get
# Technical Specifications:
## Tech-Stack:
* Ruby
* Rails
* Oauth
* PostgreSQL
* JavaScript
* AJAX
* JQuery
* MorrisJS
* HTML & SASS
* Bootstrap
* Amazon S3 (storeing images)
* Heroku
* Google Maps API
* Clarifai API (image recognition)
* Stripe Payments API
* MailGun API (for sending email)
## Project Screenshots:
![picture alt](https://raw.github.com/brunocabral88/rent-it/master/screenshot/register.png "register")
![picture alt](https://github.com/brunocabral88/rent-it/blob/master/screenshot/login.png "login")
![picture alt](https://raw.github.com/brunocabral88/rent-it/master/screenshot/main-page.png "main_page")
![picture alt](https://raw.github.com/brunocabral88/rent-it/master/screenshot/search-result.png "search-result")
![picture alt](https://raw.github.com/brunocabral88/rent-it/master/screenshot/payment.png "payment")
![picture alt](https://raw.github.com/brunocabral88/rent-it/master/screenshot/graph.png "graph")
![picture alt](https://raw.github.com/brunocabral88/rent-it/master/screenshot/create-new-tool.png "create-new-tool")
![picture alt](https://raw.github.com/brunocabral88/rent-it/master/screenshot/my-tool.png "my-tool")
![picture alt](https://raw.github.com/brunocabral88/rent-it/master/screenshot/history.png "history")
