import QtQuick 1.1
import QtMobility.location 1.2
import com.nokia.symbian 1.1

Item {
    id: titleBar
    property string appname

    Item {
        id: container
        width: parent.width ; height: parent.height

        Text {
            id: categoryText
            anchors {
                left: parent.left
                bottomMargin: 20
            }
            elide: Text.ElideLeft
            text: titleBar.appname
            font.bold: true; color: "White"; style: Text.Raised; styleColor: "Black"
        }
    }
    transitions: Transition {
        NumberAnimation { properties: "x"; easing.type: Easing.InOutQuad }
    }
}
