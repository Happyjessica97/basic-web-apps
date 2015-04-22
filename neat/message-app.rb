require "sinatra"     # Load the Sinatra web framework

get("/") do
  html = ""

  html.concat("<h1>Message of The May</h1>")
  html.concat("<a href='/message'>There's a girl named May and she likes to say the message of the day. </a>")

  body(html)
end

get("/message") do
  file_contents = File.read("message-of-the-day.txt")

  html = ""
  html.concat("<h1>Message of the Day</h1>")
  html.concat("<p>Today's message is: #{file_contents}")

  body(html)
end
