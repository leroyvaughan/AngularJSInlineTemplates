// Define a new module.
angular.module("myApp.service", []).
    factory('DataSource', ['$http', function($http){
        return {
            get: function(file, callback, transform){
                    $http.get(
                        file,
                        {transformResponse:transform}
                    ).
                    success(function(data, status) {
                        //console.log("Request succeeded");
                        callback(data);
                    }).
                    error(function(data, status) {
                        console.log("Request failed " + status);
                    });

            }
        }
}]);


angular.module('switchableGrid', ['myApp.service']);


// The controller. 
function SwitchableGridController($scope, DataSource){

    // Default layout of the app. Clicking the buttons in the toolbar
    // changes this value.
    $scope.layout = 'webstuff';
    $scope.html = [];
    $scope.designstuff = [];
    $scope.flash = [];

    //using the original xml from the Flash portfolio...with some minor modifications
    var SOURCE_FILE = "/portfolio/xml/portfolio_new.xml";

    //$scope.IMAGE_LOCATION = "";

    xmlTransform = function (data) {
        //console.log("transform data");
        var x2js = new X2JS();
        var json = x2js.xml_str2json(data);
        return json.categories;
    };


    // get data
    setData = (function (data) {
        // Assigning the pics array will cause the view
        // to be automatically redrawn by Angular.
        $scope.html = data.html.img;
        $scope.designstuff = data.designstuff.img;
        $scope.flash = data.flash.img;

        $scope.list = "list view";
        $scope.grid = "grid view";
    });

    DataSource.get(SOURCE_FILE, setData, xmlTransform);

}
