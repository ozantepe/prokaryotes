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
      gameId: 802 // put your gameId here
      secret: "sccr345smth534random23144ff42" // put your game secret here
      gameNetworkView: gameNetworkView
    }

    // menu scene
    MenuScene {
        id: menuScene

        // listen to the button signals of the scene and change the state according to it
        onSelectLevelPressed: gameWindow.state = "selectLevel"
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

    // scene for selecting levels
    SelectLevelScene {
        id: selectLevelScene
        onLevelPressed: {
            // selectedLevel is the parameter of the levelPressed signal
            gameScene.setLevel(selectedLevel)
            gameWindow.state = "game"
        }
        onBackButtonPressed: gameWindow.state = "menu"
    }

    // credits scene
    CreditsScene {
        id: creditsScene
        onBackButtonPressed: gameWindow.state = "menu"
    }

    // game scene to play a level
    GameScene {
        id: gameScene
        onBackButtonPressed: gameWindow.state = "selectLevel"
    }

    // default state is menu -> default scene is menuScene
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
            name: "selectLevel"
            PropertyChanges {
                target: selectLevelScene
                opacity: 1
            }
            PropertyChanges {
                target: gameWindow
                activeScene: selectLevelScene
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
        }
    ]
}
