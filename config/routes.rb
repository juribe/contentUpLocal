Rails.application.routes.draw do
  resources :publishers do 
    resources :publisher_contents do
      member do
        get 'preview'
      end
    end
  end
  resources :contents
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  #constraints subdomain: /.*/ do
  #  get ':seo', to: 'publisher_contents#content'
  #end
 
  constraints(DomainConstraint.new) do
      get ':seo', to: 'publisher_contents#content'
  end
  

  #constraints subdomain: DomainConstraint.new do
  #  get ':seo', to: 'publisher_contents#content'
  #end
  
  # Defines the root path route ("/")
  root "contents#index"
end
