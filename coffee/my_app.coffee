window.myApp = angular.module 'myApp', ['firebase']

window.myApp.value 'myRef', new Firebase('https://myRefSubdomain.firebaseIO.com/')
