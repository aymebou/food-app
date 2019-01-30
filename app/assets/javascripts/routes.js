angular.module("foodapp").config(['$stateProvider', '$urlRouterProvider',
  function($stateProvider, $urlRouterProvider) {

    $stateProvider

    //see state configuration in main.js.erb

      .state('home', {
        abstract: false,
        url: "/",
        templateUrl: "home.html",
        controller: 'HomeCtrl',
        controllerAs: 'homeCtrl',
      })
    }
  ])
