require "chunky_png"
require "sinatra"

MAP_SIZE = 320
WHITE    = ChunkyPNG::Color::WHITE
BLACK    = ChunkyPNG::Color::BLACK
canvas = ChunkyPNG::Canvas.new(MAP_SIZE, MAP_SIZE, WHITE)
canvas.border!(3)

get "/" do
  keys = params.keys
  if keys.length == 1
    string = keys.first[0,7]
    x, y = string.split(",").map(&:to_i)
    color = canvas.get_pixel(x,y) == WHITE ? BLACK : WHITE
    canvas.set_pixel_if_within_bounds(x, y, color)
  end

  @image = canvas.to_data_url
  erb :index
end
