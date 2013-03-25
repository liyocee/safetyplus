// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1
import QtMobility.location 1.2

Page
{
    id:aboutPage
    Image {
        id: logo
        source: "splash.png"
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Text {
        id: aboutTheApp
        anchors.top: logo.bottom
        anchors.topMargin: 10
        font.pixelSize: 24
        wrapMode: Text.Wrap
        width: parent.width
        color: "white"
        text: "Version 1.0<br/>Copyright&#169; Safety+ Inc.<br/>2012 All rights reserved.<br/>For more infromation visit http://safety.campomoja.com/"
    }
    tools:ToolBarLayout
    {
        ToolButton
        {
            flat: true
            //text: "Back"
            iconSource: "toolbar-previous"
            onClicked: window.pageStack.pop()
        }
    }
}
