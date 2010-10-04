#!/usr/bin/ruby
require 'rubygems'
require 'yaml'
require 'irb/completion'
require 'irb/ext/save-history'

IRB.conf[:AUTO_INDENT] = true
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
IRB.conf[:PROMPT_MODE] = :SIMPLE

def ls
  %x{ls}.split("\n")
end

def cd(dir)
  Dir.chdir(dir.to_s)
  Dir.pwd
end

def pwd
  Dir.pwd
end

def copy(str)
  IO.popen('pbcopy', 'w') { |f| f << str.to_s }
end

def copy_history
  history = Readline::HISTORY.entries
  index = history.rindex("exit") || -1
  content = history[(index+1)..-2].join("\n")
  puts content
  copy content
end

def paste
  `pbpaste`
end

class Object
  def local_methods(obj = self)
    (obj.methods - obj.class.superclass.instance_methods).sort
  end
end
