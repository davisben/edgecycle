using Toybox.Application;

class EdgeCycleApp extends Application.AppBase {

    function getInitialView() {
        return [ new EdgeCycleView() ];
    }

}