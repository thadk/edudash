'use strict'

describe 'Controller: DashboardsCtrl', ->

  # load the controller's module
  beforeEach module 'edudashApp'

  DashboardCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    DashboardsCtrl = $controller 'DashboardsCtrl', {
      $scope: scope
    }
