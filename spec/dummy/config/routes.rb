Rails.application.routes.draw do

  mount SwProjectCustomerQnax::Engine => "/sw_project_customer_qnax"
  mount Commonx::Engine => "/commonx"
  mount Authentify::Engine => '/authentify'
  mount Searchx::Engine => '/searchx'
  mount Kustomerx::Engine => '/customer'
  mount InfoServiceProjectx::Engine => '/project'
  #mount StateMachineLogx::Engine => '/sm_log'
  #mount BizWorkflowx::Engine => '/biz_wf'
  
  resource :session
  
  root :to => "authentify::sessions#new"
  match '/signin',  :to => 'authentify::sessions#new'
  match '/signout', :to => 'authentify::sessions#destroy'
  match '/user_menus', :to => 'user_menus#index'
  match '/view_handler', :to => 'authentify::application#view_handler'
end
