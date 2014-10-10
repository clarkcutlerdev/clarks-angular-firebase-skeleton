window.myApp.controller 'CcdAuthController', ($scope, myRef) ->
  auth = new FirebaseSimpleLogin myRef, (error, user) ->
    $scope.$apply ->
      $scope.user = user

    $scope.login = -> auth.login('google')
    $scope.logout = auth.logout
