import QtQuick 1.1
import com.nokia.symbian 1.1

Page {
    id: splashScreen
     Rectangle{
         anchors.fill : parent
         Image{
             source: "splash.svg"
             anchors.verticalCenter: parent.verticalCenter
             anchors.horizontalCenter: parent.horizontalCenter
         }
     }

    Component.onCompleted: {
        splashTimer.start()
    }

    tools: null

    Timer {
        id: splashTimer
        interval: 5000
        running: false
        onTriggered: {
            window.pageStack.pop()
            window.pageStack.push(Qt.resolvedUrl("MainPage.qml"))
        }

    }
}
