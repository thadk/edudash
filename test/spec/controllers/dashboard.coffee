'use strict'

describe 'Controller: DashboardCtrl', ->

  beforeEach module 'leafletMap'
  beforeEach module 'edudashAppSrv'
  beforeEach module 'edudashAppCtrl'

  # so many mocks :(
  beforeEach module 'edudashApp', ($provide, $translateProvider) ->
    $translateProvider.translations 'en', {}
    $provide.factory 'OpenDataApi', ($q) ->
      getYearAggregates: -> $q.when {}
    $provide.factory 'staticApi', ($q) ->
      getRegions: -> $q.when objects: tz_Regions: []
      getDistricts: -> $q.when objects: tz_districts: []
    $provide.factory 'topojson', ->
      feature: -> features: []
    $provide.factory 'loadingSrv', ->
      containerLoad: ->
    null  # explicitly return nothing because angular is awful

  # inject the controller and get its scope
  $scope = null
  beforeEach inject ($rootScope, $controller) ->
    $scope = $rootScope.$new()
    $controller 'DashboardCtrl', $scope: $scope

  describe 'polyToggle', ->
    it 'should switch from schools to regions', ->
      $scope.setViewMode 'schools'
      $scope.$apply()
      expect($scope.viewMode).toEqual 'schools'
      $scope.togglePolygons 'regions'
      $scope.$apply()
      expect($scope.viewMode).toEqual 'polygons'
      expect($scope.polyType).toEqual 'regions'

    it 'should switch from schools to districts', ->
      $scope.setViewMode 'schools'
      $scope.$apply()
      expect($scope.viewMode).toEqual 'schools'
      $scope.togglePolygons 'districts'
      $scope.$apply()
      expect($scope.viewMode).toEqual 'polygons'
      expect($scope.polyType).toEqual 'districts'

    it 'should switch regions/districts', ->
      $scope.setViewMode 'schools'
      $scope.$apply()
      expect($scope.viewMode).toEqual 'schools'
      $scope.togglePolygons 'regions'
      $scope.$apply()
      expect($scope.viewMode).toEqual 'polygons'
      expect($scope.polyType).toEqual 'regions'
      $scope.togglePolygons 'districts'
      $scope.$apply()
      expect($scope.viewMode).toEqual 'polygons'
      expect($scope.polyType).toEqual 'districts'
      $scope.togglePolygons 'regions'
      $scope.$apply()
      expect($scope.viewMode).toEqual 'polygons'
      expect($scope.polyType).toEqual 'regions'

    it 'should toggle off regions to schools', ->
      $scope.setViewMode 'schools'
      $scope.$apply()
      expect($scope.viewMode).toEqual 'schools'
      $scope.togglePolygons 'regions'
      $scope.$apply()
      expect($scope.viewMode).toEqual 'polygons'
      expect($scope.polyType).toEqual 'regions'
      $scope.togglePolygons 'regions'
      $scope.$apply()
      expect($scope.viewMode).toEqual 'schools'

    it 'should toggle off districts to schools', ->
      $scope.setViewMode 'schools'
      $scope.$apply()
      expect($scope.viewMode).toEqual 'schools'
      $scope.togglePolygons 'districts'
      $scope.$apply()
      expect($scope.viewMode).toEqual 'polygons'
      expect($scope.polyType).toEqual 'districts'
      $scope.togglePolygons 'districts'
      $scope.$apply()
      expect($scope.viewMode).toEqual 'schools'

    it 'should deselect a selected school when switching to a polygon view', ->
      $scope.selectedSchoolCode = 'z'
      $scope.togglePolygons 'regions'
      $scope.$apply()
      expect($scope.selectedSchoolCode).toBe null

      $scope.selectedSchoolCode = 'z'
      $scope.togglePolygons 'districts'
      $scope.$apply()
      expect($scope.selectedSchoolCode).toBe null
