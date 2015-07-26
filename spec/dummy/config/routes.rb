Rails.application.routes.draw do

  mount SwProjectCustomerQnax::Engine => "/sw_project_customer_qnax"
  mount Commonx::Engine => "/commonx"
  mount Authentify::Engine => '/authentify'
  mount Searchx::Engine => '/searchx'
  mount Kustomerx::Engine => '/customer'
  mount InfoServiceProjectx::Engine => '/project'
  #mount StateMachineLogx::Engine => '/sm_log'
  #mount BizWorkflowx::Engine => '/biz_wf'
  
  root :to => "authentify/sessions#new"
  get '/signin',  :to => 'authentify/sessions#new'
  get '/signout', :to => 'authentify/sessions#destroy'
  get '/user_menus', :to => 'user_menus#index'
  get '/view_handler', :to => 'authentify/application#view_handler'
end
