//create app namespace + module
var myApp = angular.module('switchableGrid', []);


// Define app module.
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

//now add the factory dependency
angular.module('switchableGrid', ['myApp.service']);



// The controller.
function SwitchableGridController($scope, DataSource, $location, $anchorScroll){

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


    /*
        These functions are for when user clicks on GridView item.
        - they will be switched back to list view with details for that clicked item
    */

        //Web Stuff
    $scope.getWebDesc = function (item) {
        $scope.jumpTo("webstuff", item);
    }

    //Flash Stuff
    $scope.getFlashDesc = function (item) {
        $scope.jumpTo("flashstuff", item);
    }
    
    //Design Stuff
    $scope.getDesignDesc = function (item) {
        $scope.jumpTo("designstuff", item);
    }


    $scope.jumpTo = function(_view, _loc){
        $scope.layout = _view;

        //need to allow delay for rendering of content
        setTimeout(function(){
            $location.hash(_loc.source);
            $anchorScroll();
        }, 400);
    }

    $scope.isBlank = function(link){
        console.log(link);
        if(typeof(link) == 'undefined'){
            return "blank";
        }
        return link;
    }



    //now get data and render UI
    DataSource.get(SOURCE_FILE, setData, xmlTransform);
}


/* for future use!! */
//    http://www.bennadel.com/blog/2441-Nested-Views-Routing-And-Deep-Linking-With-AngularJS.htm












