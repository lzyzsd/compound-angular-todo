tasksApp = window.tasksApp = angular.module 'tasksApp', []

tasksApp.controller 'main', ['$scope', '$http', ($scope, $http) ->

  $scope.tasks = []

  list = ->
    $http.get('/tasks/list').success (data, response) ->
      $scope.tasks.push task for k, task of data.tasks

  post = (data, callback) -> 
    $http.post('tasks/save', data).success(callback)

  save = (i, callback) ->
    task = $scope.tasks[i]
    post task, callback or (data, response) ->
      if data.error
        $scope.cancel(i)
        return alert data.error
      task.id = data.task.id
      task.originalContent = task.description
      task.edit = false

  $scope.new = ->
    if $scope.tasks[$scope.tasks.length-1].id
      $scope.tasks.push {edit: true, completed: false, description: "", id: null}

  $scope.edit = (i) ->
    $scope.tasks[i].originalContent = $scope.tasks[i].description
    $scope.tasks[i].edit = true

  $scope.cancel = (i) ->
    if $scope.tasks[i].id
      $scope.tasks[i].description = $scope.tasks[i].originalContent
      $scope.tasks[i].edit = false
    else
      $scope.remove i, true

  $scope.remove = (i, force=false) ->
    if force or confirm "Remove this task?" 
      $scope.tasks[i].remove = true
      save i, -> $scope.tasks.splice i, 1

  $scope.keyup = (i, e) ->
    save(i) if e.which == 13

  $scope.save = (i) ->
    task = $scope.tasks[i]

    if task.description == ""
      return $scope.cancel i if task.id
      return $scope.remove i, true 

    save(i)

  # init
  list()

]