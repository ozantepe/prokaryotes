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

    signal monsterHit

    Image {
        id: characterImage
        source: "../../assets/character.png"
        anchors.fill: parent
    }

    BoxCollider {
        // the BoxCollider will not be affected by gravity or other applied physics forces
        collisionTestingOnlyMode: true
        categories: Box.Category1
        collidesWith: Box.Category2 | Box.Category3
        anchors.fill: parent
        fixture.onBeginContact: {
            if (other.categories === Box.Category2) {
                monsterHit()
            } else {
                boosted = true
                characterImage.scale += 0.50
            }
        }
    }

    Timer {
        interval: 5000
        running: boosted
        repeat: true
        onTriggered: {
            characterImage.scale -= 0.05
        }
    }
}
