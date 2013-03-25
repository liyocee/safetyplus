

import QtQuick 1.1
import QtMobility.location 1.2



    Item {
        id: container

         anchors.fill: parent
         focus : true
         property bool xmlReady: false

         property int counter: 0

         property  double myLatitude:0.0
         property  double myLongitude:0.0

                onXmlReadyChanged: {
                    console.log("******", feedModelMap.count);
                    var locationCount = feedModelMap.count;

                    for(var i=0; i<locationCount; i++ )
                    {
                        var name = feedModelMap.get(i).desc;
                        var  latitude =feedModelMap.get(i).lat;
                        var  longitude =feedModelMap.get(i).lng;
                        console.log("::::",name, latitude, longitude);
                        map.addPushPin(latitude , longitude,  name);
                    }

                }



                function deleteAllPushPin(){
                         var count = map.markers.length
                         for (var i = 0; i<count; i++){
                             map.removeMapObject(map.markers[i])
                             map.markers[i].destroy()
                         }
                         map.markers = []
                         counter = 0
                     }





        PositionSource {
            id: positionSource
            updateInterval: 1000
            active: true



        }
        property alias mapType: map.mapType
        Map {
            id: map
            z : 1
            plugin : Plugin {
                name : "nokia"
            }
            mapType: Map.StreetMap
            size.width: parent.width
            size.height: parent.height
            zoomLevel: 15


            property list<Item> markers

            property Item currentMarker





            function pushPinClicked(aLat , aLng,aName)
            {

                myLatitude =  positionSource.position.coordinate.latitude;
                myLongitude = positionSource.position.coordinate.longitude;

                 var dist= distance(myLatitude,myLongitude,aLat,aLng);


                popup.text = aName + "\n";
                popup.text2 ="You are around "+dist+" away";
                popup.posX = 250;
                popup.posY = 350;
                popup.show();
                console.log("You have clicked me")

            }
            // popup
            PopUp {
                    id: popup

                }

     function distance(lat1,lon1,lat2,lon2) {
                var R = 6371; // km
                var dLat = (lat2-lat1) * Math.PI / 180;
                var dLon = (lon2-lon1) * Math.PI / 180;
                var a = Math.sin(dLat/2) * Math.sin(dLat/2) +
                Math.cos(lat1 * Math.PI / 180 ) * Math.cos(lat2 * Math.PI / 180 ) *
                Math.sin(dLon/2) * Math.sin(dLon/2);
                var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
                var d = R * c;
                if (d>1) return Math.round(d)+"km";
                else if (d<=1) return Math.round(d*1000)+"m";
                return d;
                }



            function addPushPin( latitude, longitude,name ) {
                        var  myArray
                         var count = map.markers.length
                         counter++


                var component = Qt.createComponent("PushPin.qml");
                console.log(component.status + " " + Component.Null);
                var object = component.createObject(container,
                                                    { "latid": latitude,  "longit": longitude,"name":name}
                                                    );

                if (object.status == Component.Ready) {
                    console.log("Component ready");
                    map.addMapObject(object);
                    object.clicked.connect(pushPinClicked);


                      myArray = new Array()
                             for (var i = 0; i<count; i++){
                                 myArray.push(markers[i])
                             }
                             myArray.push(object)
                             markers = myArray
                }
                if (object.status == Component.Error) {
                    console.log("Error: " + component.errorString());
                }


            }






            Coordinate
            {
                id: defaultMapCenter
                latitude: -1.269608
                longitude:36.793368
            }

            Coordinate
            {
                id: mapMarkerCordinate
                latitude: positionSource.position.coordinate.latitude;
                longitude: positionSource.position.coordinate.longitude


                /*
                latitude: -1.269608
                longitude:36.793368
                */
            }



            center: Coordinate {

                latitude: positionSource.position.coordinate.latitude
                longitude: positionSource.position.coordinate.longitude
              /*  latitude: -1.269608
                longitude:36.793368*/
            }





            //user location
           MapImage {
                id:userMarker
                source:  "user.png"
                coordinate: defaultMapCenter

            }



   }
        PinchArea {
            id: pincharea

            property double __oldZoom

            anchors.fill: parent

            function calcZoomDelta(zoom, percent) {
                return zoom + Math.log(percent)/Math.log(2)
            }

            onPinchStarted: {
                __oldZoom = map.zoomLevel
            }

            onPinchUpdated: {
                map.zoomLevel = calcZoomDelta(__oldZoom, pinch.scale)
            }

            onPinchFinished: {
                map.zoomLevel = calcZoomDelta(__oldZoom, pinch.scale)
            }
        }

        MouseArea {
            id: mousearea

            property bool __isPanning: false
            property int __lastX: -1
            property int __lastY: -1

            anchors.fill : parent

            onPressed: {
                __isPanning = true
                __lastX = mouse.x
                __lastY = mouse.y
            }

            onReleased: {
                __isPanning = false
            }

            onPositionChanged: {
                if (__isPanning) {
                    var dx = mouse.x - __lastX
                    var dy = mouse.y - __lastY
                    map.pan(-dx, -dy)
                    __lastX = mouse.x
                    __lastY = mouse.y
                }
            }

            onCanceled: {
                __isPanning = false;
            }
        }


 }



