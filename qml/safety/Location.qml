import QtQuick 1.1
import QtMobility.location 1.2
import com.nokia.symbian 1.1

Page {
    id: locationPage
    property double lat
    property double lng
    anchors.fill: parent
    focus: true

    TitleBar { id: titleBar; appname: "Choose Location"; z: 5; width: parent.width; height: 40; opacity: 0.8 }

    Rectangle {
        id: locLatitude
        anchors.top: titleBar.bottom
        anchors.left: parent.left
        anchors.topMargin: 4;
        anchors.leftMargin: 4;
        height: locLatitudeText.height;
        width: locLatitudeText.width;
        border.color : "#555555"
        border.width : 2
        color: "#40000000"
        Text { id: locLatitudeText; text: "N/A"; font.pointSize: 8; color: "white"}
    }

    Rectangle {
        id: locLongitude
        anchors.top: locLatitude.bottom
        anchors.left: parent.left
        anchors.topMargin: 4;
        anchors.leftMargin: 4;
        height: locLongitudeText.height;
        width: locLongitudeText.width;
        border.color : "#555555"
        border.width : 2
        color: "#40000000"
        Text { id: locLongitudeText; text: "N/A"; font.pointSize: 8; color: "white"}
    }


    Rectangle {
        id: dataArea
        anchors.top: titleBar.bottom
        anchors.bottom: parent.bottom
        width: parent.width
        color: "#343434"

        Map {
            id: map
            plugin : Plugin {
                name : "nokia"
            }


            PositionSource {
                id: positionSource
                updateInterval: 1000
                active: true
                onPositionChanged: {
                    if(positionSource.position.latitudeValid && positionSource.position.longitudeValid){
                        map.center = positionSource.position.coordinate;
                    }
               }
            }

            MapCircle {
                id: position
                color: "yellow"
                radius: 1000
                opacity: 0.1
                center: positionSource.position.coordinate
            }


           NumberAnimation { loops: Animation.Infinite; target:position; properties: "radius"; from: 200; to: 500; duration: 1000}



            anchors.fill: parent
            size.width: parent.width
            size.height: parent.height
            zoomLevel: 10
            center: Coordinate {latitude: positionSource.position.coordinate.latitude; longitude: positionSource.position.coordinate.latitude}

            MapGroup {
                id: icons
                MapImage {
                    id: positionImage
                    source: "images/marker.png"
                    Coordinate {latitude: positionSource.position.coordinate.latitude; longitude: positionSource.position.coordinate.latitude}
                }
            }

            MapMouseArea {
                id: mouseArea
                property bool __isPanning: false

                anchors.fill : parent

                //! Last pressed X and Y position
                property int __lastX: -1
                property int __lastY: -1

                //! When pressed, indicate that panning has been started and update saved X and Y values
                onPressed: {
                    __isPanning = true
                    __lastX = mouse.x
                    __lastY = mouse.y
                }

                //! When released, indicate that panning has finished
                onReleased: {
                    __isPanning = false
                }

                //! Move the map when panning
                onPositionChanged: {
                    if (__isPanning) {
                        var dx = mouse.x - __lastX
                        var dy = mouse.y - __lastY
                        map.pan(-dx, -dy)
                        __lastX = mouse.x
                        __lastY = mouse.y
                    }
                }
                //! Zoom one level when double clicked
                onDoubleClicked: {
                    //map.center = map.toCoordinate(Qt.point(__lastX,__lastY))
                    positionImage.coordinate = (map.toCoordinate(Qt.point(__lastX,__lastY)))
                    lat = map.toCoordinate(Qt.point(__lastX,__lastY)).latitude
                    lng = map.toCoordinate(Qt.point(__lastX,__lastY)).longitude
                    console.log(map.toCoordinate(Qt.point(__lastX,__lastY)).latitude.toString() + " " +
                                map.toCoordinate(Qt.point(__lastX,__lastY)).longitude.toString())
                    map.zoomLevel += 1
                }
                onClicked: {
                    //map.center = map.toCoordinate(Qt.point(__lastX,__lastY))
                    positionImage.coordinate = (map.toCoordinate(Qt.point(__lastX,__lastY)))
                    lat = map.toCoordinate(Qt.point(__lastX,__lastY)).latitude
                    lng = map.toCoordinate(Qt.point(__lastX,__lastY)).longitude
                }
            }
        } // map

    }

    tools:ToolBarLayout {
        ToolButton {
            flat: true
            text: "Select"
            //iconSource: "toolbar-back"
            onClicked: {
                window.pageStack.pop()
                window.pageStack.replace(Qt.resolvedUrl("ReportIncident.qml"), {latitude:lat.toString(), longitude:lng.toString()});
            }

        }
        ToolButton {
            flat: true
            text: "Cancel"
            //iconSource: "toolbar-back"
            onClicked: window.pageStack.pop()
        }
    }
}

