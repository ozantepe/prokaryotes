import Felgo 3.0
import QtQuick 2.0
import "scenes"
import "common"

GameWindow {
    id: gameWindow

    PhysicsWorld {
        id: world
        gravity.y: 5.81
    }

    screenWidth: 640
    screenHeight: 960

    property GameScene gameScene
    property bool musicOn: true

    Constants {
        id: constants
    }

    FelgoGameNetwork {
        id: gameNetwork
        gameId: constants.gameId
        secret: constants.gameSecret
        gameNetworkView: gameNetworkView
    }

    BackgroundMusic {
        id: backgroundMusic
        source: "../../assets/backgroundMusic.mp3"
    }

    Component {
        id: sceneCreator

        GameScene {
            onBackButtonPressed: {
                gameWindow.state = "menu"
            }
        }
    }

    MenuScene {
        id: menuScene

        onPlayPressed: {
            var game = sceneCreator.createObject(gameWindow)
            gameScene = game
            gameWindow.state = "game"
        }
        onCreditsPressed: gameWindow.state = "credits"

        onMusicPressed: {
            if (musicOn) {
                backgroundMusic.stop()
                musicOn = false
            } else {
                backgroundMusic.play()
                musicOn = true
            }
        }

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

    CreditsScene {
        id: creditsScene
        onBackButtonPressed: gameWindow.state = "menu"
    }

    state: "menu"
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
