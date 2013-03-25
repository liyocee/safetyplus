// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1
import QtMobility.location 1.2

Page
{
    id:optionsPage

    TitleBar { id: titleBar; appname: "Options"; width: parent.width; height: 40; opacity: 0.8 }

    /*Image {
        id: logo
        source: "splash.png"
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
    }*/
    SelectionListItem
    {
             id: speedLimit
             anchors.top: titleBar.bottom
             anchors.topMargin: 10
             title: "Speed Limit"
             subTitle: selectionDialog1.selectedIndex >= 0
                       ? selectionDialog1.model.get(selectionDialog1.selectedIndex).name
                       : "Please select"

             onClicked: selectionDialog1.open()

             SelectionDialog {
                 id: selectionDialog1
                 titleText: "Select one of the values"
                 selectedIndex: -1
                 model: ListModel {
                     ListElement {
                         name: "50 Km/Hr"
                         //value: 50
                     }
                     ListElement {
                         name: "80 Km/Hr"
                         //value: 80
                     }
                     ListElement {
                         name: "120 Km/Hr"
                         //value: 120
                     }
                 }
             }
         }

    SelectionListItem
    {
             id: blackSpotDistance
             anchors.top: speedLimit.bottom
             anchors.topMargin: speedLimit.anchors.topMargin
             title: "Distance from blackspot"
             subTitle: selectionDialog2.selectedIndex >= 0
                       ? selectionDialog2.model.get(selectionDialog2.selectedIndex).name
                       : "Please select"

             onClicked: {selectionDialog2.open();
                 console.log(speed)
                 console.log(distance) }

             SelectionDialog {
                 id: selectionDialog2
                 titleText: "Select one of the values"
                 selectedIndex: -1
                 model: ListModel {
                     ListElement {
                         name: "1 KM"
                         //value: 1
                     }
                     ListElement {
                         name: "2 KM"
                         //value: 2
                     }
                     ListElement {
                         name: "3 KM"
                         //value: 3
                     }
                 }
             }
         }

    tools:ToolBarLayout
    {
        ToolButton
        {
            flat: true
            text: "Save"
            onClicked:  {
                var speed = selectionDialog1.selectedIndex >= 0 ? selectionDialog1.model.get(selectionDialog1.selectedIndex).name
                        : "None"
                var distance = selectionDialog2.selectedIndex >= 0 ? selectionDialog2.model.get(selectionDialog1.selectedIndex).name
                        : "None"
                safety.savePreferences(speed,distance);
                //console.log(speed)
                //console.log(distance)
                window.pageStack.pop()
            }
        }
        ToolButton
        {
            flat: true
            text: "Cancel"
            onClicked: window.pageStack.pop()
        }
    }

}
