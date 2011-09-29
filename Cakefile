files = ['game', 'element', 'missile', 'small-missile', 'planet', 'planets', 'star', 'stars', 'index']
dir = 'src'

fs = require 'fs'
exec = require('child_process').exec

task 'install', 'compile', (options) ->
  code = ""
  files.forEach((file) ->
    code += "\n\n" + fs.readFileSync "#{__dirname}/#{dir}/#{file}.coffee", "utf8"
  )

  exec "echo '#{code}' | coffee -sc", (err, stdout, stderr) ->
    throw err if err
    console.error stderr if stderr

    fs.writeFileSync "#{__dirname}/lib/space.js", stdout, "utf8"
    process.stdout.write "Brewed to lib/space.js\n"
