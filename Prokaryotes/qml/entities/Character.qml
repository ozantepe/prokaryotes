import QtQuick 2.12
import Felgo 3.0

EntityBase {
    id: characterEntity
    entityType: "Character"
    x: parent.width / 2
    y: parent.height / 2
    width: constants.characterWidth
    height: constants.characterHeight

    property bool boosted: false

    property bool died: false

    signal characterDied

    signal monsterHit

    Image {
        id: characterImage
        source: {
            if (gameScene.score < 10 ) {
                "../../assets/character.png"
            } else {
                "../../assets/characterNormal.png"
            }
        }
        anchors.fill: parent
    }

    BoxCollider {
        // the BoxCollider will not be affected by gravity or other applied physics forces
        collisionTestingOnlyMode: true
        categories: Box.Category1
        collidesWith: Box.Category2 | Box.Category3
        anchors.fill: parent
        fixture.onBeginContact: {
            if (gameScene.score < 10 ) {
                characterImage.source = "../../assets/character1Eating.png"
            } else {
                characterImage.source = "../../assets/characterEating.png"
            }

            if (other.categories === Box.Category2) {
                monsterHit()
                enemyHitSound.play()
                if (characterImage.scale < 1) {
                    died = true
                    characterDied()
                }
            } else {
                boosted = true
                characterImage.scale += 0.5
                boosterHitSound.play()
            }
        }
        fixture.onEndContact: {
            if (gameScene.score < 10 ) {
                characterImage.source = "../../assets/character.png"
            } else {
                characterImage.source = "../../assets/characterNormal.png"
            }
        }
    }

    Timer {
        interval: 5000
        running: boosted
        repeat: true
        onTriggered: {
            characterImage.scale -= 0.25
            if (characterImage.scale < 1) {
                characterImage.source = "../../assets/characterLosing.png"
            }
            if (!died) {
                boosterEndSound.play()
            }
        }
    }

    SoundEffect {
      id: enemyHitSound
      source: "../../assets/enemy_hit.wav"
    }

    SoundEffect {
      id: boosterHitSound
      source: "../../assets/booster_hit.wav"
    }

    SoundEffect {
      id: boosterEndSound
      source: "../../assets/booster_end.wav"
    }
}
