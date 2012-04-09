#!/usr/bin/ruby
# A CLI to positions windows on the grid of your screen using xdotool

#Prefs
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
	startX = screen[:offsetX] + (squareA[:x] * widthFactor)
	startY = squareA[:y] * heightFactor

	#Figure out how big to resize to
	newWidth = (squareB[:x] - squareA[:x] + 1) * widthFactor
	newHeight = (squareB[:y] - squareA[:y] + 1) * heightFactor 

	#Fire to xdotool move and resize commands
	%x[xdotool getactivewindow windowmove --sync #{startX} #{20 + startY}]
	%x[xdotool getactivewindow windowsize --sync #{newWidth} #{newHeight - 40 }]
end

def main

	#Determine Current Window Values from xwin
	xwin = %x[xwininfo -id $(xdotool getactivewindow)]
	window = {}
	{
		:x => /Absolute upper-left X:\s+(\d+)/,
		:y => /Absolute upper-left Y:\s+(\d+)/,
		:width => /Width:\s+(\d+)/,
		:height => /Height:\s+(\d+)/
	}.each do |key, regex|
		window[key] = xwin.scan(regex).join.to_i
	end


	#Get the Screens Dimensions from xrandr
	screens = {}
	%x[xrandr --current].scan(/(.+) connected (\d+)x(\d+)+/).each_with_index.map do |screen, screenNumber|
		screens[screenNumber]= {
			:name   =>  screen[0],
			:width  =>  screen[1].to_i,
			:height =>  screen[2].to_i,
			:offsetX => 0
		}
	end

	#Add offset if the window's x more than the first screen's width
	if (window[:x] > screens[0][:width]) then
		screenNumber = 1
		screens[1][:offsetX] = screens[0][:width]
	else
		screenNumber = 0
	end
	

	#Process ARGS to get pairs on the grid
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


	puts "Calculating xdotool from #{pairs[:start]} to #{pairs[:end]}"
	repositionWindow(pairs[:start], pairs[:end], screens[screenNumber], $grid)
end

main
