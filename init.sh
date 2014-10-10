#!/usr/bin/env ruby
# Thanks to https://github.com/carbonfive/raygun/blob/master/lib/raygun/raygun.rb for inspiration
require 'fileutils'

puts "Enter some basic info to get started..."
print "Your app/module name (myApp): "
myApp = gets.chomp!
print "Your firebase url subdomain: "
myRefSubdomain = gets.chomp!
print "Your firebase reference (myRef): "
myRef = gets.chomp!
print "Your main controller name (MyMainController) "
MyMainController = gets.chomp!
print "Your app title: "
myTitle = gets.chomp!

# Run a shell command and raise an exception if it fails.
def shell(command)
  %x{#{command}}
  raise "#{command} failed with status #{$?.exitstatus}." unless $?.success?
end

# Distinguish BSD vs GNU sed with the --version flag (only present in GNU sed).
def sed_i
  @sed_format ||= begin
    %x{sed --version &> /dev/null}
    $?.success? ? "sed -i" : "sed -i ''"
  end
end

def underscore(camel_cased_word)
  word = camel_cased_word.to_s.gsub('::', '/')
  word.gsub!(/([A-Z\d]+)([A-Z][a-z])/,'\1_\2')
  word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
  word.tr!("-", "_")
  word.downcase!
  word
end

{
  'myApp' => myApp,
  'my_app' => underscore(myApp),
  'myRefSubdomain' => myRefSubdomain,
  'myRef' => myRef,
  'MyMainController' => MyMainController,
  'my_main_controller' => underscore(MyMainController),
  'myTitle' => myTitle,
}.each do |proto_name, new_name|
  shell "#{sed_i} 's/#{proto_name}/#{new_name}/g' index.html coffee/*.coffee coffee/**/*.coffee scripts/*.js scripts/**/*.js"
end

FileUtils.mv 'coffee/my_app.coffee', "coffee/#{underscore(myApp)}.coffee"
FileUtils.mv 'coffee/controllers/my_main_controller.coffee', "coffee/controllers/#{underscore(MyMainController)}.coffee"
FileUtils.mv 'scripts/my_app.js', "scripts/#{underscore(myApp)}.js"
FileUtils.mv 'scripts/controllers/my_main_controller.js', "scripts/controllers/#{underscore(MyMainController)}.js"

puts 'Done!'
