var myApp = angular.module('myApp', ['firebase']);

myApp.value('myRef', new Firebase('https://<myRef>.firebaseIO.com/'));
