Rails.application.routes.draw do
  get 'page/:slug',
      to: 'pages#show',
      slug: /[-a-z0-9+]*/,
      as: :page

  root 'home#index'
end