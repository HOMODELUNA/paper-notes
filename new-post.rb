require "optparse"
require "date"
categories = []
open_file_at_exit = nil
OptionParser.new do |opt|
  opt.on("-c CATA","--category CATA","添加标签") {|cat| categories << cat}
  opt.on("-q [CMD]","在结束时使用 CMD 打开文件") {|cmd| open_file_at_exit = cmd || "code"}
end.parse!



title = if ARGV[0]
  ARGV[0]
else
  print "请输入文件名: "
  readline.chomp!
end



time = Time.new

PostHeader = <<-EOF
# #{title}


EOF
file_in_src = "#{Date.today}-#{title}.md"
filename = "src/"+file_in_src
File.open(filename,"w+") do |f|
  f << PostHeader
end

File.open("src/SUMMARY.md","a+") do |f|
  f.puts "- [#{title}](#{file_in_src})"
end
if open_file_at_exit
  at_exit do
    exec(open_file_at_exit,filename )
  end
else
  puts <<-EOF
成功创建文档 #{filename}, 接下来

code #{filename}
EOF
end


