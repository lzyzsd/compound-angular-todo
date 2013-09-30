exports.routes = (map)->

  map.root 'tasks#index'

  # map.resources 'tasks'
  map.get  'tasks/list', 'tasks#list', collection: true
  map.post 'tasks/save', 'tasks#save', collection: true
