'use strict';

glob = require('glob')
fileUtil = fetchReadmeList: (cb) ->
  glob 'node_modules/**/README.md', (err, matches) ->
    if err
      cb err, null
      return
    cb null, matches
    return
  return

fileUtil.fetchReadmeList (err, matches) ->
  if(!err)
    greetings = document.getElementById 'title'
    greetings.innerHTML = matches.join()
