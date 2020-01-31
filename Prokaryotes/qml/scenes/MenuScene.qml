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
        source: "../../assets/logo.png"
        scale: 0.5
        anchors.horizontalCenter: parent.horizontalCenter
    }

    // menu
    Column {
        anchors.centerIn: parent
        MenuButton {
            text: "Play"
            onClicked: playPressed()
            anchors.horizontalCenter: parent.horizontalCenter
        }
        MenuButton {
            text: "Credits"
            onClicked: creditsPressed()
            anchors.horizontalCenter: parent.horizontalCenter
        }
        MenuButton {
            text: "Leaderboard"
            onClicked: gameNetwork.showLeaderboard()
            anchors.horizontalCenter: parent.horizontalCenter
        }
        MenuButton {
            text: "Music On/Off"
            onClicked: musicPressed()
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
