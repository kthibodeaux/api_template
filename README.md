# API Template

This template repo is a starting point for a Ruby on Rails API with a Vue.js frontend.

## What's Included

### Development

* docker-compose configuration

### Backend

* Ruby on Rails
* Authentication (authentication-zero)
  * Email verification
  * Password reset
  * Session management
* Authorization (pundit)
  * Field level authorization with Blueprinter (if this is not desired, delete `api/config/initializers/blueprinter.rb`, the `ApplicationPolicy.blueprint_authorize` method, and the call to `blueprint_authorize` in `Admin::LinkPolicy`)
* Background job processing (good_job)

### Frontend

* CSS Framework (bulma)
* Icons (iconoir)
* Vue.js
* Pinia
* Custom validation framework
* Layouts
* `runQuery` and `runMutation`

## Getting Production Ready

* Setup mail (smtp or gem)


## Screenshots

![Sign In](readme-images/sign-in.png)

![Active Sessions](readme-images/active-sessions.png)
