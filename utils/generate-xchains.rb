#!/usr/bin/ruby
#Used to generate a xchainkeys config file (~/.config/xchainkeys/xchainkeys.conf)
#This assumes that you have grid-wm as an alias or in your PATH (executable)
#Use this script like: ruby generate-xchainkeys.rb > ~/.config/xchainkeys/xchainkeys.config

#Should correspond to the Grid Your using in grid-wm
$tiles = [
	[ '1', '2', '3', '4', '5', '6', '7', '8', '9', '0' ],
	[ 'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p' ],
	[ 'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';' ],
	[ 'z', 'x', 'c', 'v', 'b', 'n', 'm', ',', '.', '/' ]
]

#Default Chain is Windows Keys (w) and x, Change this if wanted
$chain = "W-x"

#This assumes you copied grid-wm to a folder called bin in home directory
$keyboardTilerLocation = "~/bin/keyboard-tiler.rb" 

puts [
	"feedback on",
	"timeout 0",
	"delay 0",
	"foreground white",
	"background black"
]

def crawl(s)
	$tiles.each_with_index do |row, column|
		row.each_with_index do |cell, count|
			replacements = {
				';' => "semicolon",
				',' => "comma",
				'.' => "period",
				'/' => "slash"
			}

			s1 = replacements[s] || s
			cell1 = replacements[cell] || cell

			puts "#{$chain} #{s1} #{cell1} :exec #{$keyboardTilerLocation} '#{s}#{cell}'"
		end
	end
end

#Generate all permutations (2 key presses)
$tiles.each_with_index do |row, column|
	row.each_with_index do |cell, count|
			crawl(cell)
	end
end
