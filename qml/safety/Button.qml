import QtQuick 1.1

Item {
    id: container

    property string buttonName: ""
    property string text: ""
    property string text1: ""
    property string text2: ""

    property string fontName: "Helvetica"
    property int fontSize: 21
    property color fontColor: "green"

    property bool active: false



    signal clicked(string button)

    width: 350
    height: 200


    BorderImage {
        id: background
        opacity: enabled ? 0.9 : 0.4


        Rectangle{
            id:popUpRect
            color: "black"
            anchors.fill: parent
            radius:5
        }

        width: parent.width
        height: parent.height
    }


    Column {
            x:3 ; width: 350; y: 2;
    Text {
        width: 345
        id: buttonLabel
        text: container.text
        clip: true
         wrapMode: Text.WrapAtWordBoundaryOrAnywhere
         font.bold: true;
        font.pixelSize: 30
        anchors.left: parent.left

        font {
            family: container.fontName

        }

        color:"white"

    }
    Text {
        width: 345

        id: buttonLabel1
        text: container.text1
        clip: true
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        font.pixelSize: 20
        anchors.left: parent.left


        font {
            family: container.fontName

        }
      color:"white"

    }
    Text {
        width: 345

        id: buttonLabel2
        text: container.text2

         clip: true
         wrapMode: Text.WrapAtWordBoundaryOrAnywhere

        font.pixelSize: 20

        anchors.left: parent.left


        font {
            family: container.fontName

        }

        color:"white"

    }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: container.clicked(buttonName);
    }

    states: [
        State {
            name: 'pressed'; when: mouseArea.pressed
            PropertyChanges { target: background  }
        },
        State {
            name: 'active'; when: container.active
            PropertyChanges { target: background}
        }
    ]
}
