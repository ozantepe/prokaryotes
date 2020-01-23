import Felgo 3.0
import QtQuick 2.0

Scene {
    id: sceneBase
    opacity: 0
    // we set the visible property to false if opacity is 0 because the renderer skips invisible items.
    // this is an performance improvement
    visible: opacity > 0
    enabled: visible


    Behavior on opacity {
        NumberAnimation {
            property: "opacity"
            easing.type: Easing.InOutQuad
        }
    }
}
