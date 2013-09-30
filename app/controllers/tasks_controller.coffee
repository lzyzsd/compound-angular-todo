load 'application'

action 'index', -> 
  render 'index'

action 'list', -> 
  send 200, tasks: compound.db.tasks

action 'save', ->

  # get or generate a new id
  id = body.id or Math.ceil(Math.random()*100000000)

  # protect sticky notes
  if compound.db.tasks[id] and compound.db.tasks[id].sticky
    return send 200

  # handle delete
  if body.remove
    task = compound.db.tasks[id]
    if task and not task.sticky
      delete compound.db.tasks[id]
      return send 200

  # dont allow a big db in our example
  if Object.keys(compound.db.tasks).length >= 25 and not compound.db.tasks[id]
    return send 200, error: "No new tasks please"

  # create or updated an existing task
  compound.db.tasks[id] = {
    description: body.description.slice 0, 50
    id: id
    completed: !!body.completed
    updated_at: new Date
  }
  send 200, task: compound.db.tasks[id]