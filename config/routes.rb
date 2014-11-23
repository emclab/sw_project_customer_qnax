SwProjectCustomerQnax::Engine.routes.draw do

  resources :project_infos
  resources :user_roles
  resources :role_access_rights
  resources :workflows
  resources :biz_forms
  
  root :to => 'project_infos#index'

end
