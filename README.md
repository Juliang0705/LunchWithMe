# LunchWithMe

## Description

Have you ever eaten lunch by yourself because of no friends? Meet other loners like you! LunchWithMe is the new Tinder for lunch except that you can't "Netflix and Chill" in public. 

## User Stories

The following are our core user stories:

- [X] User can post status to public
- [X] Status post has detail view
- [X] Geofencing
- [X] User can choose to remain anonymous
- [X] User can sign up to create a new account using Parse authentication
- [X] User can log in and log out of his or her account
- [X] The current signed in user is persisted across app restarts
- [ ] User have profile setting page
- [X] User can view other loners on a map near him
- [X] User can view other loners on a table view
- [ ] User can communicate with other loners in app
- [ ] User can friend loners
- [ ] Restaurant recommandation from Yelp API

## Schema

* Map
  * Geofencing
  * Map pins denoting loners
  * List of statues( i.e. "On the way to Mcdonald's, anybody wanna tag along? )
* Loners
  * Location
  * Status (i.e. Going to lunch in 15)
  * First Name
  * Profile Image (if non-anonymous)
  * Favorite food categories as tags (i.e. Chicken finger, Italian, melts, beer)
