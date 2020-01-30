import Felgo 3.0
import QtQuick 2.0
import "scenes"
import "common"

GameWindow {
    id: gameWindow

    // window size
    screenWidth: 640
    screenHeight: 960

    Constants {
        id: constants
    }

    FelgoGameNetwork {
      id: gameNetwork
      gameId: 807 // put your gameId here
      secret: "sccr345smth534random23144ff42" // put your game secret here
      gameNetworkView: gameNetworkView
    }

    // menu scene
    MenuScene {
        id: menuScene

        onPlayPressed: {
            gameWindow.state = "game"
        }
        onCreditsPressed: gameWindow.state = "credits"

        GameNetworkView {
            id: gameNetworkView
            visible: false
            anchors.fill: parent.gameWindowAnchorItem

            onShowCalled: {
                gameNetworkView.visible = true
            }

            onBackClicked: {
                gameNetworkView.visible = false
            }
        }
    }

    GameScene {
        id: gameScene
        onBackButtonPressed: gameWindow.state = "menu"
    }

    CreditsScene {
        id: creditsScene
        onBackButtonPressed: gameWindow.state = "menu"
    }

    state: "menu"

    // state machine, takes care reversing the PropertyChanges when changing the state like changing the opacity back to 0
    states: [
        State {
            name: "menu"
            PropertyChanges {
                target: menuScene
                opacity: 1
            }
            PropertyChanges {
                target: gameWindow
                activeScene: menuScene
            }
        },
        State {
            name: "game"
            PropertyChanges {
                target: gameScene
                opacity: 1
            }
            PropertyChanges {
                target: gameWindow
                activeScene: gameScene
            }
        },
        State {
            name: "credits"
            PropertyChanges {
                target: creditsScene
                opacity: 1
            }
            PropertyChanges {
                target: gameWindow
                activeScene: creditsScene
            }
        }
    ]
}
