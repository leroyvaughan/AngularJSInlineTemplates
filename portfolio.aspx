<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="portfolio.aspx.cs" Inherits="Portfolio_portfolio" Title="GLV Consulting: Portfolio" %>

<%@ Register Src="../navMenu.ascx" TagName="navMenu" TagPrefix="uc" %>

<asp:Content ID="headContent" ContentPlaceHolderID="headContent" Runat="Server">
    <meta charset="utf-8" />

    <script src="../javascript/jquery-latest.js" type="text/javascript"></script>
    <link href="/css/portfolio.css" rel="Stylesheet" />

    <!--[if lte IE 9]>
        <script type="text/javascript">
            document.location.href("portfolio_ie.aspx");
        </script>
    <![endif]-->

    <!--[if lt IE 9]>
            <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
            <script src="/javascript/effects.core.js" type="text/javascript"></script>
            <script src="/javascript/jquery.dropshadow.js" type="text/javascript"></script>
            <script>
                    setTimeout(
                        function(){
                            var objArr = new Array("ul.list li", "#navMenu");
                            var curObjStr;
                            for(xx=0; xx<objArr.length; xx++){
                                curObjStr = objArr[xx];
                                $(curObjStr).dropShadow({left: 4, top: 4, blur: 2, opacity: 0.4});
                            }
                        }, 1000);
            </script>
    <![endif]-->
</asp:Content>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <uc:navMenu ID="navMenuControl" runat="server" />

    <script type="text/javascript">

        $(document).ready(function()
        {
            _$('hdrGrafik').style.display = 'none';
            $("#hdrGrafik").show("slow");
            setTimeout( function(){ _$("hdrGrafik").style.display = 'none'; $("#hdrGrafik").fadeIn(1000); }, 920 );
        });
    </script>

    <!-- THIS IS THE RELEVANT STUFF FOR ANGULAR.JS -->
    <div ng-app="switchableGrid" id="ng-app" ng-controller="SwitchableGridController">

        <div class="bar">
            <!-- These two buttons switch the layout varaible,
                 which causes the correct UL to be shown. -->
            <div class="cat">
                <div class="catHdr">WEB</div>
                <a href="#" ng-class="{active: layout == 'list'}" ng-click="layout = 'webstuff'"><img src="images/list.png" alt="{{list}}" /></a>
                <a href="#" ng-class="{active: layout == 'grid'}" ng-click="layout = 'webstuff_grid'"><img src="images/grid.png" alt="{{grid}}" /></a>
            </div>

            <div class="cat">
                <div class="catHdr">FLASH</div>
                <a href="#" ng-class="{active: layout == 'list'}" ng-click="layout = 'flashstuff'"><img src="images/list.png" alt="{{list}}" /></a>
                <a href="#" ng-class="{active: layout == 'grid'}" ng-click="layout = 'flashstuff_grid'">
                    <img src="images/grid.png" alt="{{grid}}" />
                </a>
            </div>

            <div class="cat">
                <div class="catHdr">DESIGN</div>
                <a href="#" ng-class="{active: layout == 'list'}" ng-click="layout = 'designstuff'"><img src="images/list.png" alt="{{list}}" /></a>
                <a href="#" ng-class="{active: layout == 'grid'}" ng-click="layout = 'designstuff_grid'"><img src="images/grid.png" alt="{{grid}}" /></a>
            </div>
            <div class="clear"></div>
        </div>

        <div class="images">
            <!-- We have three layouts. We choose which one to show depending on the "layout" binding -->
            <ul class="list webstuff" ng-show="layout == 'webstuff'">
                <li ng-repeat="p in html" id="{{p.source}}">
                    <p class="title">{{p.titlework}}</p>
                    <p class="desc">{{p.desc}}</p>
                    <div ng-switch on="isBlank(p.link)">
                        <div ng-switch-when="blank">
                            <img ng-src="/portfolio/images/webstuff/{{p.source}}" />
                        </div>
                        <div ng-switch-default>
                            <a href="{{p.link}}" target="_blank"><img ng-src="/portfolio/images/webstuff/{{p.source}}" /></a>
                        </div>
                    </div>
                    <div class="topLink"><a href="#ng-app">back to top</a></div>
                </li>
            </ul>
            
            <ul class="grid webstuff" ng-show="layout == 'webstuff_grid'">
                <!-- A smaller compact view without text -->
                <li ng-repeat="p in html">
                    <a href="#" ng-click="getWebDesc(p)"><img ng-src="/portfolio/images/webstuff/{{p.source}}" /></a>
                </li>
            </ul>

            <ul class="list flashstuff" ng-show="layout == 'flashstuff'">
                <li ng-repeat="p in flash" id="{{p.source}}">
                    <p class="title">{{p.titlework}}</p>
                    <p class="desc">{{p.desc}}</p>
                    <a href="{{p.link}}" target="_blank"><img ng-src="/portfolio/images/webstuff/{{p.source}}" /></a>
                    <div class="topLink"><a href="#ng-app">back to top</a></div>
                </li>
            </ul>
            <ul class="grid flashstuff" ng-show="layout == 'flashstuff_grid'">
                <!-- A smaller compact view without text -->
                <li ng-repeat="p in flash"><a href="{{p.link}}" target="_blank">
                    <a href="#" ng-click="getFlashDesc(p)"><img ng-src="/portfolio/images/webstuff/{{p.source}}" /></a>
                </li>
            </ul>

        
            <ul class="list designstuff" ng-show="layout == 'designstuff'">
                <li ng-repeat="p in designstuff" id="{{p.source}}">
                    <p class="title">{{p.titlework}}</p>
                    <p class="desc">{{p.desc}}</p>
                    <img ng-src="/portfolio/images/designstuff/{{p.source}}" />
                    <div class="topLink"><a href="#ng-app">back to top</a></div>
                </li>
            </ul>
            <ul class="grid designstuff" ng-show="layout == 'designstuff_grid'">
                <!-- A smaller compact view without text-->
                <li ng-repeat="p in designstuff">
                    <a href="#" ng-click="getDesignDesc(p)"><img ng-src="/portfolio/images/designstuff/{{p.source}}" /></a>
                </li>
            </ul>
        </div>
    </div>

    <script src="/Scripts/angular_v1.0.7.min.js"></script>
    <script src="/Scripts/xml2json.js"></script>
    <script src="/Scripts/switchablegrid.js"></script>
</asp:Content>