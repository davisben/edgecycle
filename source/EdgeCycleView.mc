using Toybox.WatchUi;
using Toybox.System;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.Graphics;

class EdgeCycleView extends WatchUi.DataField {

	hidden const CENTER = Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER;

    hidden var currentSpeed;
    hidden var elapsedDistance;
    hidden var currentHeartRate;
    hidden var time;

    function initialize() {
        DataField.initialize();
    }

	function compute(info) {
		// Current speed
		var speed = info.currentSpeed ? info.currentSpeed : 0.0;
		if (System.DeviceSettings.paceUnits == System.UNIT_STATUTE) {
			currentSpeed = speed * 2.237;
		} else {
			currentSpeed = speed * 3.6;
		}
		
		// Elapsed distance
		var distance = info.elapsedDistance ? info.elapsedDistance : 0.0;
		if (System.DeviceSettings.distanceUnits == System.UNIT_STATUTE) {
			elapsedDistance = distance / 1609.344;
		} else {
			elapsedDistance = distance / 1000;
		}

		// Current heart rate
        currentHeartRate = info.currentHeartRate ? info.currentHeartRate : 0;
        
        // Current time
        var now = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        var hour = now.hour;
        if (hour > 12) {
        	hour = hour - 12;
        }
        time = Lang.format("$1$:$2$", [hour, now.min]);
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
        dc.setPenWidth(1);
        dc.drawLine(0, rowHeight, width, rowHeight);
        dc.drawLine(width / 2, 0, width / 2, rowHeight);
        dc.drawLine(0, height - rowHeight, width, height - rowHeight);
        dc.drawLine(width / 2, height, width / 2, height - rowHeight);
        
        // Top row
        dc.drawText(width / 4, 10, Graphics.FONT_TINY, "Speed", CENTER);
        dc.drawText(width / 4, 45, Graphics.FONT_NUMBER_HOT, currentSpeed.format("%0.1f"), CENTER);
        dc.drawText(width - (width / 4), 10, Graphics.FONT_TINY, "Distance", CENTER);
        dc.drawText(width - (width / 4), 45, Graphics.FONT_NUMBER_HOT, elapsedDistance.format("%0.1f"), CENTER);
        
        // Bottom row
        dc.drawText(width / 4, height - (rowHeight - 10), Graphics.FONT_TINY, "Heart Rate", CENTER);
        dc.drawText(width / 4, height - (rowHeight - 45), Graphics.FONT_NUMBER_HOT, currentHeartRate, CENTER);
        dc.drawText(width - (width / 4), height - (rowHeight - 10), Graphics.FONT_TINY, "Time", CENTER);
        dc.drawText(width - (width / 4), height - (rowHeight - 40), Graphics.FONT_NUMBER_MEDIUM, time, CENTER);
    }

}
