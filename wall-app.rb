require "sinatra"     # Load the Sinatra web framework
require "data_mapper" # Load the DataMapper database library

require "./setup"
require "./models"

get("/") do
  records = Story.all(order: :created_at.desc)
  erb(:index, locals: { messages: records })
end

#add another post 
#get the message id which one
#update the message likes by 1 
#reload the page 
#https://gist.github.com/jfarmer/8e0aa88091ba7fcc0712
#  post is actually posting data while "get" is actually getting something 
#  from the server 
#there's also "put" and "delete"
post("/messages") do
  message_title = params["title"]
  message_body = params["body"]
  message_time = DateTime.now
  
  message = Story.create(
    title: message_title,
    body: message_body, 
    created_at: message_time)
  
  if message.saved?
    redirect("/")
  else
    erb(:error)
  end
end

get("/signup") do 
  user = User.new
  erb(:new_userform, locals: {:user => user})
end 

post("/messages/:id") do
  message_id = params["id"]
  message = Story.get(message_id.to_i)
  message.likes += 1

  if message.save()
    redirect("/")
  else 
    erb(:error)
  end
end

