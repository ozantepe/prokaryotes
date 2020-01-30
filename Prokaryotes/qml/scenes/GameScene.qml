import Felgo 3.0
import QtQuick 2.12
import QtSensors 5.5
import QtQuick.Controls 2.4
import QtMultimedia 5.0
import "../common"
import "../entities"

SceneBase {
    id: gameScene

    // actual scene size
    width: 320
    height: 480

    PhysicsWorld {
        id: world
        gravity.y: 5.81
    }

    // score
    property int score: 0

    signal levelCompleted

    BackgroundMusic {
      id: backgroundMusic
      source: "../assets/backgroundMusic.mp3"
      autoPlay: true
      autoLoad: true
      autoPauseInBackground: true
      muted: false
    }

    // background
    Image {
        id: backgroundImage
        anchors.fill: parent.gameWindowAnchorItem
        source: "../../assets/background1.png"
    }

    // back button to go menu scene
    MenuButton {
        text: "Back to menu"
        anchors.right: gameScene.gameWindowAnchorItem.right
        anchors.rightMargin: 10
        anchors.top: gameScene.gameWindowAnchorItem.top
        anchors.topMargin: 10
        onClicked: {
            gameNetwork.reportScore(score)
            score = 0
            backButtonPressed()
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

    Popup {
        id: winPopup
        x: 100
        y: 100
        width: 200
        height: 300
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
    }

    Popup {
        id: gameOverPopup
        x: 100
        y: 100
        width: 200
        height: 300
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
    }

    EntityManager {
        id: entityManager
        entityContainer: gameScene
    }

    // Enemy spawner
    Timer {
        interval: 3000
        running: true
        repeat: true
        onTriggered: {
            if (score < 5) {
                entityManager.createEntityFromUrl(Qt.resolvedUrl(
                                                      "../entities/Enemy.qml"))
            } else if (score < 20) {
                entityManager.createEntityFromUrl(Qt.resolvedUrl(
                                                      "../entities/Enemy.qml"))
                entityManager.createEntityFromUrl(Qt.resolvedUrl(
                                                      "../entities/Enemy2.qml"))
            } else {
                entityManager.createEntityFromUrl(Qt.resolvedUrl(
                                                      "../entities/Enemy.qml"))
                entityManager.createEntityFromUrl(Qt.resolvedUrl(
                                                      "../entities/Enemy2.qml"))
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
            if (score >= 5) {
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

    Character {
        id: characterCell

        DragHandler {
            id: dragHandler
        }

        onMonsterHit: increaseScore()

        onCharacterDied: gameOver()
    }

    function increaseScore() {
        score++
        if (score > 20) {
            winSound.play()
            backgroundImage.source = "../../assets/background3.png"
            world.gravity.y = 20.20
            gameNetwork.reportScore(score)
        } else if (score > 5) {
            winSound.play()
            backgroundImage.source = "../../assets/background2.png"
            world.gravity.y = 10.80
            gameNetwork.reportScore(score)
        }
    }

    function gameOver() {
        gameOverSound.play()
        gameNetwork.reportScore(score)
        backButtonPressed()
    }
}
