using Toybox.Application;

class EdgeCycleApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    function getInitialView() {
        return [ new EdgeCycleView() ];
    }

}
