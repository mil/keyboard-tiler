#!/usr/bin/ruby
# A CLI to positions windows on the grid of your screen using xdotool

#Prefs
$useScreen = "LVDS" #Should come from xrandr
$grid = { :height =>  4, :width  => 10 } #Corresponds to keboard ha

$gridKeys = [
	[ '1', '2', '3', '4', '5', '6', '7', '8', '9', '0' ],
	[ 'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p' ],
	[ 'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';' ],
	[ 'z', 'x', 'c', 'v', 'b', 'n', 'm', ',', '.', '/' ]
]


#Based on the 
def repositionWindow(squareA, squareB, screen, grid) 
	#Calculate Height and width factor based on passed screen and grid
	heightFactor = screen[:height] / grid[:height]
	widthFactor  = screen[:width]  / grid[:width]

	#Calculate Start X and Y
	startX = squareA[:x] * widthFactor
	startY = squareA[:y] * heightFactor

	#Figure out how big to resize to
	newWidth = (squareB[:x] - squareA[:x] + 1) * widthFactor
	newHeight = (squareB[:y] - squareA[:y] + 1) * heightFactor 

	#Fire to xdotool move and resize commands
	%x[xdotool getactivewindow windowmove --sync #{startX} #{20 + startY}]
	%x[xdotool getactivewindow windowsize --sync #{newWidth} #{newHeight - 40 }]
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


	#Find cords to draw within grid
	pairs = {}
	if (!ARGV) then
		#2 Prompts getting the ordered pairs
		[[:start, "Start"], [:end, "End"]].each do |l|
			print "#{l[1]} Ordered Pair x,y :: "
			gets.chomp!.scan(/(\d+),(\d+)/).each do |d|
				pairs[l[0]] = { 
					:x => d[0].to_i, 
					:y => d[1].to_i
				}
			end
		end
	elsif (ARGV.length == 2)
		#Passed in keys
		ARGV.each_with_index do |arg, index|
			puts arg.to_s[1]
			$gridKeys.each_with_index do |row, column|
				row.each_with_index do |cell, count|
					if (cell == arg) then
						puts "#{index} cell is at #{count} #{column}"

						label = (index == 0) ? :start : :end
						pairs[label] =  { :x => count, :y => column }
					end
				end
			end
		end	
	else 
		pairs = {
			:start => { :x => ARGV[0].to_i, :y => ARGV[1].to_i },
			:end   => { :x => ARGV[2].to_i, :y => ARGV[3].to_i }
		}
	end


	#Fire to xdotool
	puts "Calculating xdotool from #{pairs[:start]} to #{pairs[:end]}"
	repositionWindow(pairs[:start], pairs[:end], screens[$useScreen], $grid)
end

main
