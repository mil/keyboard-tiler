#!/usr/bin/ruby
# A CLI to positions windows on the grid of your screen using xdotool

#Prefs
$useScreen = "LVDS1" #Should come from xrandr
$grid = { :height =>  4, :width  => 10 } #Corresponds to keboard ha

#Based on the 
def repositionWindow(squareA, squareB, screen, grid) 
	#Calculate Height and width factor based on passed screen and grid
	heightFactor = screen[:height] / grid[:height]
	widthFactor  = screen[:width]  / grid[:width]

	#Calculate Start X and Y
	startX = squareA[:x] * widthFactor
	startY = squareA[:y] * heightFactor

	#Figure out how big to resize to
	newWidth = (squareB[:x] - squareA[:x]) * widthFactor
	newHeight = (squareB[:y] - squareA[:y]) * heightFactor 

	#Fire to xdotool move and resize commands
	%x[xdotool getactivewindow windowmove #{startX} #{startY}]
	%x[xdotool getactivewindow windowsize #{newWidth} #{newHeight}]
end

def main

	#Get the Screens Dimensions
	screens = {}
	%x[xrandr --current].scan(/(.+) connected (\d+)x(\d+)+/).map do |screen|
		screens[screen[0]] = {
			:width  =>  screen[1].to_i,
			:height =>  screen[2].to_i,
		}
	end

	#2 Prompts getting the ordered pairs
	pairs = {}
	[[:start, "Start"], [:end, "End"]].each do |l|
		print "#{l[1]} Ordered Pair x,y :: "
		gets.chomp!.scan(/(\d+),(\d+)/).each do |d|
			pairs[l[0]] = { 
				:x => d[0].to_i, 
				:y => d[1].to_i
			}
		end
	end

	puts "Calculating xdotool from #{pairs[:start]} to #{pairs[:end]}"
	repositionWindow(pairs[:start], pairs[:end], screens[$useScreen], $grid)
end

main
