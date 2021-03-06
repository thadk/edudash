'use strict'

###*
 # @ngdoc function
 # @name edudashApp.controller:SchoollistmodalCtrl
 # @description
 # # SchoollistmodalCtrl
 # Controller of the edudashApp
###
angular.module 'edudashAppCtrl'
  .controller 'SchoollistmodalCtrl', ($scope, $modalInstance, items, $q) ->
    $scope.items = $q (resolve, reject) ->
      if items?
        $scope.limit = items.total
        $scope.type = items.type
        $scope.school = items.school
        resolve items.schoolList
      else
        reject "There are no school"

    $scope.cancel = () ->
      $modalInstance.dismiss('cancel');

    $scope.selectSchool = (code) ->
      $modalInstance.close(code);


