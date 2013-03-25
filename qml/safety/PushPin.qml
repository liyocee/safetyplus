
import QtQuick 1.1


import QtMobility.location 1.2



MapImage {
    id:mapMarker
    width: 35
    signal clicked(double lat, double lon,string name, string address)

    source:  "pushpin.png"
    property alias latid: mapMarkerCordinate.latitude
    property alias longit: mapMarkerCordinate.longitude
    property string name:""
    property string address:""
    coordinate: Coordinate
    {
        id: mapMarkerCordinate;
    }

    MapMouseArea {
        onClicked:  mapMarker.clicked(coordinate.latitude, coordinate.longitude,name,address)
    }

}
