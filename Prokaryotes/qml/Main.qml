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

        Component.onCompleted: {
            gameNetwork.incrementAchievement("5opens")
        }

        achievements: [
            Achievement {
                key: "5opens"
                name: "Game Opener"
                iconSource: "../assets/tick.png"
                target: 5
                points: 10
                description: "Open this game 5 times"
            },
            Achievement {
                key: "score20"
                name: "Bacteria"
                iconSource: "../assets/enemy-5.png"
                target: 20
                points: 5
                description: "Score 20 points"
            },
            Achievement {
                key: "score50"
                name: "Virus"
                iconSource: "../assets/enemy-3.png"
                target: 50
                points: 15
                description: "Score 50 points"
            },
            Achievement {
                key: "firstLevelCompleted"
                name: "Starting from the bottom"
                iconSource: "../assets/background1.png"
                points: 5
                description: "Complete first level"
            },
            Achievement {
                key: "secondLevelCompleted"
                name: "Going up!"
                iconSource: "../assets/background2.png"
                points: 15
                description: "Complete second level"
            },
            Achievement {
                key: "thirdLevelCompleted"
                name: "The Predator!"
                iconSource: "../assets/background3.png"
                points: 30
                description: "Complete third level"
            }
        ]
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
        }
    ]
}
