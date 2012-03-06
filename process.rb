require 'csv'
require 'awesome_print'

a = CSV.read(ARGV[0], col_sep: "\t")
a.reject!{|e| e.first.nil? or e.first.strip.empty?}

out = []
a.each do |fields|

  notes_regexp = /(CAN|MEX|US)/
  name  = fields[1].strip.gsub(notes_regexp,'').strip
  notes = fields[1].strip.match(notes_regexp) ? fields[1].strip.match(notes_regexp)[0] : ""
  
  out << {
    level: fields[0].strip.size,
    code:  fields[0].strip.to_i,
    name:  name,
    notes: notes,
  }
end

CSV.open(ARGV[1], "wb") do |csv|
  csv << %w[level code name notes]
  out.each do |line|
    csv << [line[:level],line[:code],line[:name],line[:notes]]
  end
end