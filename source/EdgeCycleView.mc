using Toybox.WatchUi;
using Toybox.Graphics;

class EdgeCycleView extends WatchUi.DataField {

	hidden const CENTER = Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER;

    function compute(info) {
        currentPower = info.currentPower ? info.currentPower : 0;
        maxPower = info.maxPower ? info.maxPower : 400;
    }

    function onUpdate(dc) {
    	// Colors
    	var backgroundColor = getBackgroundColor();
    	var color = backgroundColor == Graphics.COLOR_WHITE ? Graphics.COLOR_BLACK : Graphics.COLOR_WHITE;
    	
    	// Positioning
        var width = dc.getWidth();
        var height = dc.getHeight();
        var rowHeight = height / 4;
        
        // Draw grid lines
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawLine(0, rowHeight, width, rowHeight);
        dc.drawLine(width / 2, 0, width / 2, rowHeight);
        dc.drawLine(0, height - rowHeight, width, height - rowHeight);
        dc.drawLine(width / 2, height, width / 2, height - rowHeight);
    }

}
