Hackathon challenge
App Name: Cornell Hitch

The new way to hitch a ride to nearby cities, by and for Cornell students

Cornell hitch is an app that uses google to authenticate cornell users (through cornell.edu email) and has a posting board for users to post and find rides going to cities. All rides originate in ithaca and the app has a direct messaging system to promote privacy.
  The idea of this app is to have Cornell students post their rides given destination and date, and that allows others to view and message the ride host to form a deal and navigate together. This saves costs for both parties involved. Using Distance Matrix API, the distance was calculated for each ride, and that can be used to calculate costs on front-end for each ride.

Backend requirements:
   Using Flask, I have made a db file with classes User, Ride, and Message in order to form an API that uses many to many relationships to best gather all the data for front-end. Additionally, googlemaps API's are used to calculate distance among the destinations selected and thus giving front end space to handle cost estimates. 
   I have fully deployed the server, but there is one thing to note. Login routes will not work with OAuth because the server does not use a top level domain. However, if testing on a local url, the Oauth works perfectly and uses organization only specifications to only allow cornell students to add to database.
   In order to fix OAuth for the deployment stage, a top level domain would be needed for deployment to host the server there instead, but for the scope of this project I felt that was not necessary. 
   

