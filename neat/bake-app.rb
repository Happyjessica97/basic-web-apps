require "sinatra"     # Load the Sinatra web framework

get("/") do
  html = ""

  # Look at the value of background_color in the URL
  # Store that value (somehow)
  # Later, refer to this value instead of using the hard-coded value "red"

  bg_color = "red" # how do we refer to the "background_color" part of the URL?

  # bg_color = get_part_of_url("background_color")

  html.concat("<h1>HELLLLOOO</h1>")
  html.concat("<ul>")
  html.concat("<li><a href='/waffles'>waffles ARE AWESOME </a></li>")
  html.concat("<li><a href='/waffles/chocolate'>show me THE chocolate</a></li>")
  html.concat("<li><a href='/bake?baked_good=cookies&count=2'>bake 10 cookies</a></li>")
  html.concat("<li><a href='/bake?baked_good=coconuts&count=0'>bake 5 coconuts</a></li>")
  html.concat("<li><a href='/bake?baked_good=cupcakes&count=2'>bake 2 cupcakes</a></li>")
  html.concat("</ul>")
  html.concat("<p>There once was a bakery.  </p>")
  html.concat("<style>body{background-color:#{bg_color}</style>")

  body(html)
end

get("/waffles") do
  html = ""

  html.concat("<h1>Waffles are AMAZING.</h1>")

  body(html)
end

get("/waffles/chocolate") do
  html = ""

  html.concat("<h1>Chocolate waffles: more delicious.YAYAYAYAYA</h1>")
  html.concat("<p>Why don't you believe me?</p>")

  body(html)
end

# Visit, e.g., /bake?baked_good=waffles&count=20
get("/bake") do
  count      = Integer(params["count"])
  baked_good = String(params["baked_good"])

  html = "Jessica is going to bake #{count} #{baked_good} so many goods!"

  html.concat("<ul>")
  count.times do |num|
    html.concat("<li>#{baked_good} number #{num}</li>")
  end
  html.concat("</ul>")

  body(html)
end