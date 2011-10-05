files = ['app', 'game', 'element', 'player', 'spaceship', 'explosion', 'missile', 'small-missile', 'planet', 'planets', 'star', 'stars', 'index']
dir = 'src'

fs = require 'fs'
exec = require('child_process').exec


print = (msg...) ->
  console.log msg...


code = ->
  c = ""
  files.forEach((file) ->
    c += "\n\n" + fs.readFileSync "#{__dirname}/#{dir}/#{file}.coffee", "utf8"
  )

  c

task 'code', 'get the code', (options) ->
  print code()


option '-l', '--line [LINE_NUMBER]', 'set the line number for `cake debug`'

task 'debug', 'pass it a line number and it returns the line', (options) ->
  options.line or= 1
  options.line -= 1
  print code().split("\n")[options.line]


task 'install', 'combines all the files and then compiles them to JavaScript', (options) ->
  exec "echo '#{code()}' | coffee -sc", (err, stdout, stderr) ->
    throw err if err
    console.error stderr if stderr

    fs.writeFileSync "#{__dirname}/lib/space.js", stdout, "utf8"
    process.stdout.write "Brewed to lib/space.js\n"
