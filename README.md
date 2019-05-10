# Music App
Ruby (2.5.1) Rails (5.2.3) project using Postgres database. Demo at https://murmuring-castle-75704.herokuapp.com/

## Description
A web app for cataloguing bands, their albums and tracks, and associated data. Allows for user commenting. Users can search all models at once using the provided search on any page.

## App Permissions
All active users may edit/delete/add bands, albums, and tracks regardless of ownership. A user's comments can only be deleted by that user.

## Account Signup
Users must register and click on a link in an activation email before accessing the app. Email is simulated in the dev environment using the letter_opener gem.

## Possible Extension of the App
- Add admin accounts and limit user permissions for creating/editing/destroying data.
- Incorporate YouTube API for displaying related music
- Allow multi-session sign in
- Add tagging and index it for search