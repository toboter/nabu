# Nabu

## Installation
```ruby
gem 'nabu', git: 'https://github.com/toboter/nabu.git'
gem 'rails-bootstrap-markdown'
```

rails nabu_engine:install:migrations

add 'include Nabu' to the model you like comments on.
(The model needs a 'name' attribute)

you will need a current_user object

add a helper method for 'can_comment?' 

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