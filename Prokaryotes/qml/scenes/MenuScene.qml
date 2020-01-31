import Felgo 3.0
import QtQuick 2.0
import "../common"

SceneBase {
    id: menuScene

    signal playPressed
    signal creditsPressed
    signal musicPressed

    Image {
        anchors.fill: parent.gameWindowAnchorItem
        source: "../../assets/menu.png"
    }

    Image {
//        anchors.fill: parent.gameWindowAnchorItem
        source: "../../assets/logo.png"
        scale: 0.5
        anchors.horizontalCenter: parent.horizontalCenter
    }

    // the "logo"
//    Text {
//        anchors.horizontalCenter: parent.horizontalCenter
//        y: 30
//        font.pixelSize: 30
//        color: "#e9e9e9"
//        text: "Prokaryotes"
//    }

    // menu
    Column {
        anchors.centerIn: parent
        MenuButton {
            text: "Play"
            onClicked: playPressed()
        }
        MenuButton {
            text: "Credits"
            onClicked: creditsPressed()
        }
        MenuButton {
            text: "Leaderboard"
            onClicked: gameNetwork.showLeaderboard()
        }
        MenuButton {
            text: "Music On/Off"
            onClicked: musicPressed()
        }
    }
}
