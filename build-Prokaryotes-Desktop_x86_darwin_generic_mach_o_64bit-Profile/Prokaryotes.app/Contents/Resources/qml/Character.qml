import QtQuick 2.12
import Felgo 3.0

EntityBase {
    id: characterEntity

    entityType: "Character"

    Image {
        id: characterImage
        source: "../assets/monster.png"
        width: dp(100)
        height: dp(100)
    }

    BoxCollider {
        // the BoxCollider will not be affected by gravity or other applied physics forces
        collisionTestingOnlyMode: true

        // make the same size as the Image
        anchors.fill: characterImage

        fixture.onBeginContact: {
            console.info("collision in character")
        }
    }
}
