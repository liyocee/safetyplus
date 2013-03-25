// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1
import QtMobility.location 1.2

Page
{
    id:aboutPage

    TitleBar { id: titleBar; appname: "User Guide"; width: parent.width; height: 40; opacity: 0.8 }

    /*Image {
        id: logo
        source: "splash.png"
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
    }*/

    Flickable
    {
        id: flickArea
        width: parent.width
        height: parent.height-titleBar.height-titleBar.anchors.topMargin-anchors.topMargin
        contentWidth: aboutTheApp.width
        contentHeight: aboutTheApp.height
        flickableDirection: Flickable.VerticalFlick
        clip: true
        anchors.top: titleBar.bottom
        anchors.topMargin: 10
        Text {
            id: aboutTheApp
            width: aboutPage.width
            font.pixelSize: 24
            wrapMode: Text.Wrap
            color: "white"
            text: "<strong>Reporting an Incident</strong><br/>To report an incident click on the <img src=\"toolbar-menu.png\"/> icon and select the \"Report incident option\". On the add incident page, select the point in the map on which the accident has occured. You can optionally add a description of the accident, select the visibility of the road, the weather conditions and the level of damage in the accident.<br/><br/><strong>Setting Your Speed Limit</strong><br/>In the options page you can set the speed at which the phone will alert you that you are over speeding.<br/><br/><strong>Setting Your Distance from a Blackspot</strong><br/>You can set the distance from a blackspot in which you want to be alerted about the blackspot."
        }
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
