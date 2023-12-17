Rails.application.routes.draw do
  get 'page/:slug',
      to: 'pages#show',
      slug: /[-a-z0-9+]*/,
      as: :page

  get 'search/:year/:month', to: 'search#index', year: /\d{4}/, month: /\d{2}/
  get 'search', to: 'search#index'

  root 'home#index'
end