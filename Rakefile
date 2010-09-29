task :default => :link

desc "Symlinks the dotfiles to #{ENV['HOME']}"
task :link do
  Dir["#{pwd}/*"].each do |p| 
    link = File.expand_path "~/.#{File.basename(p)}"
    run %Q{ln -s "#{p}" "#{link}"} unless File.exists?(link)
  end
end

desc "Removes all symlinks to dotfiles from #{ENV['HOME']}"
task :unlink do
  Dir["#{pwd}/*"].each do |p|
    link = File.expand_path "~/.#{File.basename(p)}"
    run %Q{rm "#{link}"}
  end
end

def pwd
  File.expand_path(File.dirname(__FILE__))
end
 
def run(cmd)
  puts cmd
  system cmd
end
