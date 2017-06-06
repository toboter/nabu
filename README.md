# Nabu

gem 'nabu'
gem 'rails-bootstrap-markdown'

rails nabu:install:migrations

add 'include Nabu' to commentable model
The model needs a 'name' attribute

you will need a current_user object

add a method for 'can_comment?' to your user model

add
'//= require bootstrap-markdown-bundle' to appplication.js
'*= require bootstrap-markdown' to application.scss

add
  concern :commentable do
    resources :comments, only: [:index, :new, :create, :destroy]
  end

  to routes
  and 'concerns: :commentable'
  to each resource where Nabu is included.

use 'commentables_for(obj)' to show comments on the obj show page

use 'obj.root_comments' to show all or count Comments with parent nil