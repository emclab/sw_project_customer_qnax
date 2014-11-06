SwProjectCustomerQnax::Engine.routes.draw do
  get "role_access_rights/index"

  get "role_access_rights/new"

  get "role_access_rights/create"

  get "role_access_rights/edit"

  get "role_access_rights/update"

  get "role_access_rights/show"

  get "role_access_rights/destroy"

  get "user_roles/index"

  get "user_roles/new"

  get "user_roles/create"

  get "user_roles/edit"

  get "user_roles/update"

  get "user_roles/show"

  get "user_roles/destroy"

  resources :project_infos
  
  root :to => 'project_infos#index'

end
