load 'application'

action 'index', -> 
  render 'index'

action 'list', -> 
  send 200, tasks: compound.db.tasks

action 'save', ->
  # complete thr CRUD request
  Task.crud body, (err=null, task=null) -> 
    send 200, {error: err, task: task}
    

