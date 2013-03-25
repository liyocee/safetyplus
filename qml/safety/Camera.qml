// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1
import QtMultimediaKit 1.1

Page
{
    id:cameraPage
    anchors.fill: parent
    Camera {
        focus : visible // to receive focus and capture key events when visible

        flashMode: Camera.FlashRedEyeReduction
        whiteBalanceMode: Camera.WhiteBalanceFlash
        exposureCompensation: -1.0

        onImageCaptured : {
            photoPreview.source = preview  // Show the preview in an Image element
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
