Simpler.application.routes do
  get '/tests', 'tests#index'
  get '/tests/:id', 'tests#show'
  get '/plain', 'tests#plain'

  post '/tests', 'tests#create'
end
