Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  get 'question' => "question#index"
  get 'question/new' => "question#new"
  get 'question/edit/:id' => 'question#edit'
  delete 'question/destroy/:id' => 'question#destroy'
end


