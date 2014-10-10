myApp.controller('CcdAuthController', function ($scope, myRef) {
  var auth = new FirebaseSimpleLogin(myRef, function(error, user) {
    $scope.$apply(function() {
      $scope.user = user
    })
  });

  $scope.login = function() {
    auth.login('google')
  }
  $scope.logout = auth.logout
});
