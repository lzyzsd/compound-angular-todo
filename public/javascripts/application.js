(function() {
  var tasksApp;

  tasksApp = window.tasksApp = angular.module('tasksApp', []);

  tasksApp.controller('main', [
    '$scope', '$http', function($scope, $http) {
      var list, post, save;
      $scope.tasks = [];
      list = function() {
        return $http.get('/tasks/list').success(function(data, response) {
          var k, task, _ref, _results;
          _ref = data.tasks;
          _results = [];
          for (k in _ref) {
            task = _ref[k];
            _results.push($scope.tasks.push(task));
          }
          return _results;
        });
      };
      post = function(data, callback) {
        return $http.post('tasks/save', data).success(callback);
      };
      save = function(i, callback) {
        var task;
        task = $scope.tasks[i];
        return post(task, callback || function(data, response) {
          if (data.error) {
            $scope.cancel(i);
            return alert(data.error);
          }
          task.id = data.task.id;
          task.originalContent = task.description;
          return task.edit = false;
        });
      };
      $scope["new"] = function() {
        if ($scope.tasks[$scope.tasks.length - 1].id) {
          return $scope.tasks.push({
            edit: true,
            completed: false,
            description: "",
            id: null
          });
        }
      };
      $scope.edit = function(i) {
        $scope.tasks[i].originalContent = $scope.tasks[i].description;
        return $scope.tasks[i].edit = true;
      };
      $scope.cancel = function(i) {
        if ($scope.tasks[i].id) {
          $scope.tasks[i].description = $scope.tasks[i].originalContent;
          return $scope.tasks[i].edit = false;
        } else {
          return $scope.remove(i, true);
        }
      };
      $scope.remove = function(i, force) {
        if (force == null) {
          force = false;
        }
        if (force || confirm("Remove this task?")) {
          $scope.tasks[i].remove = true;
          return save(i, function() {
            return $scope.tasks.splice(i, 1);
          });
        }
      };
      $scope.keyup = function(i, e) {
        if (e.which === 13) {
          return save(i);
        }
      };
      $scope.save = function(i) {
        var task;
        task = $scope.tasks[i];
        if (task.description === "") {
          if (task.id) {
            return $scope.cancel(i);
          }
          return $scope.remove(i, true);
        }
        return save(i);
      };
      return list();
    }
  ]);

}).call(this);
