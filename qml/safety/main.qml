import QtQuick 1.1
import com.nokia.symbian 1.1
import QtMobility.location 1.2

PageStackWindow {
    id: window
    Component.onCompleted: pageStack.push(Qt.resolvedUrl("SplashScreen.qml"))
    property string myLatitude:""
    property string myLongitude :""


    PositionSource {
           id: positionSource
           active: true
       }

    ToolBarLayout{
        visible: false
    }
    Options
    {
        id:optionsPage
    }
    About
    {
        id:aboutPage
    }
    UserGuide
    {
        id:userGuidePage
    }




}
