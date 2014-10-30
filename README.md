#MetaMeetup
ruby "2.1.2"
--------
MetaMeetup is a location-based communication service for attendees of Meetup events. Once a user arrives at a Meetup event, they can use MetaMeetup to connect with  people sharing the same interests. It's designed for mobile Chrome and not well tested or intended for use on desktop computers. The goal of MetaMeetup is to use it to find the right people, meet them in person, then put the phone and app away til next time.


#Markups
--------
The following markups are supported.  The dependencies listed are required to run correctly.

* gem 'devise' - Devise is an authentication solution for Rails
* gem 'thin' - A Ruby server that uses Mongrel parser/Event Machine/Rack
* gem 'omniauth' - Library that standardizes multi-provider authentication
* gem 'omniauth-meetup', '~> 0.0.2 - Authentication for meetup
* gem 'private_pub' - facilitates use of websockets for chat
* gem 'meetup_client' - To connect with Meetup's API


#Installation
-------------
Include all gems in your Gemfile.


#Version 
--------
MetaMeet version 1.0

# Work In Progress