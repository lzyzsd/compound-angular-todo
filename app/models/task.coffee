module.exports = (compound, Task) ->
  # define Task here

  Task.crud = (body, callback) ->

    # get or generate a new id
    id = body.id or Math.ceil(Math.random()*100000000)

    # protect sticky notes
    if compound.db.tasks[id] and compound.db.tasks[id].sticky
      return callback()

    # handle delete
    if body.remove
      if compound.db.tasks[id] and not compound.db.tasks[id].sticky
        delete compound.db.tasks[id]
        return callback()

    # dont allow a big db in our example
    if Object.keys(compound.db.tasks).length >= 25 and not compound.db.tasks[id]
      return callback "No new tasks please"

    # create or updated an existing task
    compound.db.tasks[id] = {
      description: body.description.slice 0, 50
      id: id
      completed: !!body.completed
      updated_at: new Date
    }
    return callback null, compound.db.tasks[id]
