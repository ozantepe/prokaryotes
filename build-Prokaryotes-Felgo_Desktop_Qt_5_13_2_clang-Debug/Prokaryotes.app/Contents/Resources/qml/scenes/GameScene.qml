import Felgo 3.0
import QtQuick 2.12
import QtSensors 5.5
import "../common"

SceneBase {
    id: gameScene

    // actual scene size
    width: 320
    height: 480

    PhysicsWorld {
        id: world
        gravity.y: 0.81
    }

    // the filename of the current level gets stored here, it is used for loading the
    property string activeLevelFileName
    // the currently loaded level gets stored here
    property variant activeLevel
    // score
    property int score: 0

    signal levelCompleted

    // set the name of the current level, this will cause the Loader to load the corresponding level
    function setLevel(fileName) {
        activeLevelFileName = fileName
    }

    // background
    Image {
        anchors.fill: parent.gameWindowAnchorItem
        source: {
            if (activeLevelFileName == "Level1.qml") {
                "../../assets/background1.png"
            }
            else if (activeLevelFileName == "Level2.qml") {
                "../../assets/background2.png"
            }
            else if (activeLevelFileName == "Level3.qml") {
                "../../assets/background3.png"
            }
        }
    }

    // back button to leave scene
    MenuButton {
        text: "Back to menu"
        // anchor the button to the gameWindowAnchorItem to be on the edge of the screen on any device
        anchors.right: gameScene.gameWindowAnchorItem.right
        anchors.rightMargin: 10
        anchors.top: gameScene.gameWindowAnchorItem.top
        anchors.topMargin: 10
        onClicked: {
            backButtonPressed()
            activeLevel = undefined
            activeLevelFileName = ""
            gameNetwork.reportScore(score) // report the current score to the gameNetwork
        }
    }

    // name of the current level
    Text {
        anchors.left: gameScene.gameWindowAnchorItem.left
        anchors.leftMargin: 10
        anchors.top: gameScene.gameWindowAnchorItem.top
        anchors.topMargin: 10
        color: "white"
        font.pixelSize: 20
        text: (activeLevel !== undefined)
              && (activeLevel !== null) ? activeLevel.levelName : ""
    }

    // load levels at runtime
    Loader {
        id: loader
        source: activeLevelFileName !== "" ? "../levels/" + activeLevelFileName : ""
        onLoaded: {
            // reset the score
            score = 0
            // since we did not define a width and height in the level item itself, we are doing it here
            item.width = gameScene.width
            item.height = gameScene.height
            // store the loaded level as activeLevel for easier access
            activeLevel = item
        }
    }

    // we connect the gameScene to the loaded level
    Connections {
        // only connect if a level is loaded, to prevent errors
        target: activeLevel !== undefined ? activeLevel : null
        // increase the score when the rectangle is clicked
        onIncreaseScore: {
            score++
            if (score >= 100) {
                winSound.play()
                backButtonPressed()
                activeLevel = undefined
                activeLevelFileName = ""
                gameNetwork.reportScore(score) // report the current score to the gameNetwork
                levelCompleted()
            }
        }

        onGameOver: {
            gameOverSound.play()
            backButtonPressed()
            activeLevel = undefined
            activeLevelFileName = ""
            gameNetwork.reportScore(score) // report the current score to the gameNetwork
        }
    }

    // display the current score
    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: gameScene.gameWindowAnchorItem.top
        anchors.topMargin: 30
        color: "white"
        font.pixelSize: 40
        text: score
    }

    EntityManager {
        id: entityManager
        entityContainer: gameScene
    }

    // Enemy spawner
    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            entityManager.createEntityFromUrl(Qt.resolvedUrl(
                                                  "../entities/Enemy.qml"))
        }
    }

    // Enemy2 spawner
    Timer {
        interval: 3000
        running: true
        repeat: true
        onTriggered: {
            if (activeLevelFileName != "Level1.qml") {
                entityManager.createEntityFromUrl(Qt.resolvedUrl(
                                                  "../entities/Enemy2.qml"))
            }
        }
    }

    // Enemy3 spawner
    Timer {
        interval: 4000
        running: true
        repeat: true
        onTriggered: {
            if (activeLevelFileName == "Level3.qml") {
                entityManager.createEntityFromUrl(Qt.resolvedUrl(
                                                  "../entities/Enemy3.qml"))
            }
        }
    }

    // Booster spawner
    Timer {
        interval: 8000
        running: true
        repeat: true
        onTriggered: {
            if (activeLevelFileName !== "Level1.qml") {
                entityManager.createEntityFromUrl(
                            Qt.resolvedUrl("../entities/Booster.qml"))
            }
        }
    }

    SoundEffect {
      id: gameOverSound
      source: "../../assets/game_over.wav"
    }

    SoundEffect {
      id: winSound
      source: "../../assets/win.wav"
    }
}
