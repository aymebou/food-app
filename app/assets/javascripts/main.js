angular.module("foodapp", ['ngAnimate', 'ngResource', 'templates', 'ui.router' ])

  .run([ '$window', '$rootScope', '$location', '$http', '$state', function( $window, $rootScope, $location, $http, $state) {
    $state.go("home");
  }])
