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

    // score
    property int score: 0

    signal levelCompleted

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
            backButtonPressed()
            gameScene.destroy()
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
        interval: 2500
        running: true
        repeat: true
        onTriggered: {
            if (score < 5) {
                entityManager.createEntityFromUrl(Qt.resolvedUrl(
                                                      "../entities/Enemy.qml"))
            } else if (score < 15) {
                entityManager.createEntityFromUrl(Qt.resolvedUrl(
                                                      "../entities/Enemy.qml"))
                entityManager.createEntityFromUrl(Qt.resolvedUrl(
                                                      "../entities/Enemy2.qml"))
            } else if (score < 35) {
                entityManager.createEntityFromUrl(Qt.resolvedUrl(
                                                      "../entities/Enemy.qml"))
                entityManager.createEntityFromUrl(Qt.resolvedUrl(
                                                      "../entities/Enemy2.qml"))
                entityManager.createEntityFromUrl(Qt.resolvedUrl(
                                                      "../entities/Enemy3.qml"))
            } else if (score < 50) {
                entityManager.createEntityFromUrl(Qt.resolvedUrl(
                                                      "../entities/Enemy.qml"))
                entityManager.createEntityFromUrl(Qt.resolvedUrl(
                                                      "../entities/Enemy2.qml"))
                entityManager.createEntityFromUrl(Qt.resolvedUrl(
                                                      "../entities/Enemy3.qml"))
                entityManager.createEntityFromUrl(Qt.resolvedUrl(
                                                      "../entities/Enemy4.qml"))
            } else if (score < 75) {
                entityManager.createEntityFromUrl(Qt.resolvedUrl(
                                                      "../entities/Enemy.qml"))
                entityManager.createEntityFromUrl(Qt.resolvedUrl(
                                                      "../entities/Enemy2.qml"))
                entityManager.createEntityFromUrl(Qt.resolvedUrl(
                                                      "../entities/Enemy3.qml"))
                entityManager.createEntityFromUrl(Qt.resolvedUrl(
                                                      "../entities/Enemy4.qml"))
                entityManager.createEntityFromUrl(Qt.resolvedUrl(
                                                      "../entities/Enemy5.qml"))
            } else if (score < 100) {
                entityManager.createEntityFromUrl(Qt.resolvedUrl(
                                                      "../entities/Enemy.qml"))
                entityManager.createEntityFromUrl(Qt.resolvedUrl(
                                                      "../entities/Enemy2.qml"))
                entityManager.createEntityFromUrl(Qt.resolvedUrl(
                                                      "../entities/Enemy3.qml"))
                entityManager.createEntityFromUrl(Qt.resolvedUrl(
                                                      "../entities/Enemy4.qml"))
                entityManager.createEntityFromUrl(Qt.resolvedUrl(
                                                      "../entities/Enemy5.qml"))
                entityManager.createEntityFromUrl(Qt.resolvedUrl(
                                                      "../entities/Enemy6.qml"))
            } else {
                entityManager.createEntityFromUrl(Qt.resolvedUrl(
                                                      "../entities/Enemy.qml"))
                entityManager.createEntityFromUrl(Qt.resolvedUrl(
                                                      "../entities/Enemy2.qml"))
                entityManager.createEntityFromUrl(Qt.resolvedUrl(
                                                      "../entities/Enemy3.qml"))
                entityManager.createEntityFromUrl(Qt.resolvedUrl(
                                                      "../entities/Enemy4.qml"))
                entityManager.createEntityFromUrl(Qt.resolvedUrl(
                                                      "../entities/Enemy5.qml"))
                entityManager.createEntityFromUrl(Qt.resolvedUrl(
                                                      "../entities/Enemy6.qml"))
                entityManager.createEntityFromUrl(Qt.resolvedUrl(
                                                      "../entities/Enemy7.qml"))
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
        if (score == 55) {
            winSound.play()
            backgroundImage.source = "../../assets/background4.png"
            world.gravity.y = 25.20
            gameNetwork.reportScore(score)
            gameNetwork.unlockAchievement("thirdLevelCompleted")
        } else if (score == 25) {
            winSound.play()
            backgroundImage.source = "../../assets/background3.png"
            world.gravity.y = 20.20
            gameNetwork.reportScore(score)
            gameNetwork.unlockAchievement("secondLevelCompleted")
        } else if (score == 10) {
            winSound.play()
            backgroundImage.source = "../../assets/background2.png"
            world.gravity.y = 10.80
            gameNetwork.reportScore(score)
            gameNetwork.unlockAchievement("firstLevelCompleted")
        }
        gameNetwork.incrementAchievement("score20")
        gameNetwork.incrementAchievement("score50")
    }

    function gameOver() {
        gameOverSound.play()
        gameNetwork.reportScore(score)
        backButtonPressed()
    }
}
