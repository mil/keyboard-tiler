#!/usr/bin/ruby
#Used to generate a xchainkeys config file (~/.config/xchainkeys/xchainkeys.conf)
#Will use the chain of W-x to enter grid-wm
#This assumes that you have grid-wm as an alias or in your PATH
#Use this script like: ruby generate-xchainkeys.rb > ~/.config/xchainkeys/xchainkeys.conf

$gridKeys = [
	[ '1', '2', '3', '4', '5', '6', '7', '8', '9', '0' ],
	[ 'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p' ],
	[ 'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';' ],
	[ 'z', 'x', 'c', 'v', 'b', 'n', 'm', ',', '.', '/' ]
]

puts "feedback on"
puts "timeout 0"
puts "delay 0"

def crawl(s)
	$gridKeys.each_with_index do |row, column|
		row.each_with_index do |cell, count|
			if (cell != s) then
				replacements = {
					';' => "semicolon",
					',' => "comma",
					'.' => "period",
					'/' => "slash"
				}

				s1 = replacements[s] || s
				cell1 = replacements[cell] || cell

				puts "W-x #{s1} #{cell1} :exec grid-wm #{s}#{cell}"
			end
		end
	end
end

#Generate all permutations (2 key presses)
$gridKeys.each_with_index do |row, column|
	row.each_with_index do |cell, count|
			crawl(cell)
	end
end
