import QtQuick 1.1
import com.nokia.symbian 1.1
import QtMobility.location 1.2


Page {
    id: mainPage
    onVisibleChanged: {
        loadLandMark();
        console.log("LoadLandMark Called");
    }
    Rectangle {
        id: mapRect
         anchors.fill: parent
         signal xmlMapReady
         onXmlMapReady: {

             container.xmlReady = !container.xmlReady;
            // loadLandMark();
             console.log("Xml Map Ready");
         }
         RssModelMap {id: feedModelMap}
         MapDelegate {id: container }


    }

    function loadLandMark()
    {
        myLatitude =  positionSource.position.coordinate.latitude;
        myLongitude = positionSource.position.coordinate.longitude;
        /* myLatitude=-1.269608;
        myLongitude=36.793368;
        */


       console.log("fxn1 >latitude:" +myLatitude + "longitude:" +myLongitude );
       var url =
           "http://safety.campomoja.com/viewblackspots.php?latitude="+myLatitude+"&longitude="+ myLongitude+"&distance=10000000";
        var doc = new XMLHttpRequest();
        console.log(url);

        doc.onreadystatechange = function() {
        if (doc.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
          }
        else if (doc.readyState ===XMLHttpRequest.DONE) {
             console.log("HttpRequest DONE");
             var status = doc.status;
             if(status!=200) {
                return;
            }
            var data = doc.responseText;
            //console.log("Google Data:\n"+data);

        feedModelMap.xmlData = data;

         }
        }
        doc.open("GET", url);
        doc.send();


    }


    tools:ToolBarLayout {
        id: toolBarLayout
        ToolButton {
            flat: true
            iconSource: "toolbar-back"
            onClicked: Qt.quit()
        }

        ToolButton {
            flat: true
            iconSource: "toolbar-menu"
            onClicked: menu.open()
        }
    }

    Menu{
        id: menu
        content: MenuLayout{
            MenuItem{
                text: "Report Incident"
                onClicked: window.pageStack.push(Qt.resolvedUrl("ReportIncident.qml"))
            }
            MenuItem{
                text: "Options"
                onClicked: window.pageStack.push(optionsPage)
            }
            MenuItem
            {
                text: "User Guide"
                onClicked: window.pageStack.push(userGuidePage)
            }
            MenuItem
            {
                text: "About"
                onClicked: window.pageStack.push(aboutPage)
            }
        }
    }

}
