load 'application'

action 'index', -> 
  render 'index'

action 'list', -> 
  send 200, tasks: compound.db.tasks

action 'save', ->

  # get or generate a new id
  id = body.id or Math.ceil(Math.random()*100000000)

  # complete thr CRUD request
  Task.crud id, body, (err=null, task=null) ->
    send 200, {error: err, task: task}

