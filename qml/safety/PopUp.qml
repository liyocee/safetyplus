import QtQuick 1.1

Item {
    id: container

    property alias text: button.text
    property alias text1: button.text1
    property alias text2: button.text2
    property int posX: 0
    property int posY: 0
    /*property string fontName: "Helvetica"
    property int fontSize: 21
    property color fontColor: "black"*/
    property bool showPopup: false

    signal clicked

    function show() {
        container.showPopup = true;
    }

    anchors.fill: parent
    opacity: container.showPopup == true ? 1 : 0

    Behavior on opacity {
        NumberAnimation {
            duration: 300
            easing.type: Easing.InOutQuad
        }
    }


    Item {
        anchors.fill:  parent
        MouseArea {
            enabled: container.showPopup
            anchors.fill: parent
            onClicked: container.showPopup = false
        }
    }


    Button {
        id: button
        x: parent.posX - width/2
        y: parent.posY - height/2

        /*fontSize: container.fontSize
        fontName: container.fontName
        fontColor: container.fontColor*/


        onClicked: {
            container.showPopup = false
            container.clicked()
        }
    }
}
