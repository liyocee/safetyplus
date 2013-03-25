import QtQuick 1.1
import com.nokia.symbian 1.1

Page {
    id: reportIncident

    property string latitude;
    property string longitude;

    TitleBar { id: titleBar; appname: "Report Incident"; z: 5; width: parent.width; height: 40; opacity: 0.8 }

    Flickable{
        //anchors.fill : parent
        anchors.top: titleBar.bottom
        anchors.bottom: parent.bottom
        flickableDirection: Flickable.VerticalFlick
        contentHeight: 800
        contentWidth: parent.width
        width: parent.width
        height: parent.height
        clip: true


            Item {
                width: parent.width
                height: parent.height

                Button {
                    id: locationButton
                    anchors.top: parent.top
                    anchors.left: parent.left
                    platformInverted: window.platformInverted
                    width: parent.width
                    text: "Select Location on a Map"
                    //font.pixelSize: 30
                    height: 60
                    onClicked: {
                        window.pageStack.push(Qt.resolvedUrl("Location.qml"))
                    }
                }

                Button {
                    id: imageButton
                    anchors.top: locationButton.bottom
                    anchors.topMargin: 10
                    anchors.left: parent.left
                    platformInverted: window.platformInverted
                    width: parent.width
                    text: "Take an image of incident"
                    //font.pixelSize: 30
                    height: 60
                    onClicked: {
                        window.pageStack.push(Qt.resolvedUrl("Camera.qml"))
                    }
                }


                Label {
                    id: description
                    anchors.top: imageButton.bottom
                    anchors.topMargin: 10
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    platformInverted: window.platformInverted
                    text: "Description"
                }

                TextArea {
                    id: descriptionTextRec
                    anchors.top: description.bottom
                    anchors.topMargin: 10
                    anchors.left: parent.left
                    platformInverted: window.platformInverted
                    width: parent.width
                    horizontalAlignment: Text.AlignLeft
                    height: 200
                }


            SelectionListItem {
                id: visibilitySelect
                //anchors.left: visibility.right
                anchors.top: descriptionTextRec.bottom
                anchors.topMargin: 10
                title: "Visibility"
                subTitle: visibilitySelectDialog.selectedIndex >= 0
                          ? visibilitySelectDialog.model.get(visibilitySelectDialog.selectedIndex).name
                          : "Please select"
                onClicked: visibilitySelectDialog.open()
                SelectionDialog {
                    id: visibilitySelectDialog
                    titleText: "Select one of the values"
                    selectedIndex: -1
                    model: ListModel {
                        ListElement { name: "Clear" }
                        ListElement { name: "Poor" }
                    }
                }
            }

            SelectionListItem {
                id: weather
                anchors.top: visibilitySelect.bottom
                anchors.topMargin: 10
                title: "State of Weather"
                subTitle: weatherDialog.selectedIndex >= 0
                          ? weatherDialog.model.get(weatherDialog.selectedIndex).name
                          : "Please select"
                onClicked: weatherDialog.open()
                SelectionDialog {
                    id: weatherDialog
                    titleText: "Select one of the values"
                    selectedIndex: -1
                    model: ListModel {
                        ListElement { name: "Dry" }
                        ListElement { name: "Wet" }
                    }
                }
            }


            SelectionListItem {
                id: level
                //anchors.left: visibility.right
                anchors.top: weather.bottom
                anchors.topMargin: 10
                title: "Level"
                subTitle: levelDialog.selectedIndex >= 0
                          ? levelDialog.model.get(levelDialog.selectedIndex).name
                          : "Please select"
                onClicked: levelDialog.open()
                SelectionDialog {
                    id: levelDialog
                    titleText: "Select one of the values"
                    selectedIndex: -1
                    model: ListModel {
                        ListElement { name: "Minor" }
                        ListElement { name: "Serious with no fatalities" }
                        ListElement { name: "Fatalities" }
                    }
                }
            }
         }
    }
    QueryDialog {
            id: queryDialog

            titleText: "Information"
            platformInverted: window.platformInverted
            content:Label{
                text: "Data sent successfully"

            }

            acceptButtonText: "Okay"
            onAccepted:
            {
                queryDialog.close()
                window.pageStack.pop()
            }

        }

    tools:ToolBarLayout {
        ToolButton {
            flat: true
            text: "Send"
            //iconSource: "toolbar-back"
            onClicked: {
                /*console.log(longitude)
                console.log(latitude)
                console.log(descriptionTextRec.text)
                console.log(visibilitySelectDialog.selectedIndex >= 0
                            ? visibilitySelectDialog.model.get(visibilitySelectDialog.selectedIndex).name
                            : "None")
                console.log(weatherDialog.selectedIndex >= 0
                            ? weatherDialog.model.get(weatherDialog.selectedIndex).name
                            : "None")
                console.log(levelDialog.selectedIndex >= 0
                            ? levelDialog.model.get(levelDialog.selectedIndex).name
                            : "None")
                window.pageStack.pop()*/

                var url="http://safety.campomoja.com//highlights.php"
                var req=new XMLHttpRequest
                req.open("POST",url,true)
                req.setRequestHeader("Content-type","application/x-www-form-urlencoded")
                var weatherVar=weatherDialog.selectedIndex >= 0? weatherDialog.model.get(weatherDialog.selectedIndex).name: "None"
                var levelVar=levelDialog.selectedIndex >= 0? levelDialog.model.get(levelDialog.selectedIndex).name: "None"
                var visibilityVar=visibilitySelectDialog.selectedIndex >= 0? visibilitySelectDialog.model.get(visibilitySelectDialog.selectedIndex).name: "None"
                req.send("longitude="+longitude+"&latitude="+latitude+"&description="+descriptionTextRec.text+"&level="+levelVar+"&weather="+weatherVar+"&visibility="+visibilityVar)
                req.onreadystatechange=function()
                        {
                            if(req.readyState===XMLHttpRequest.DONE)
                            {
                                console.log("Done")
                                console.log(req.responseText)
                                queryDialog.open()

                            }
                        }
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

