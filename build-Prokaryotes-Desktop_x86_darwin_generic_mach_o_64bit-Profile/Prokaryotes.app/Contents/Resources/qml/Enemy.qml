import QtQuick 2.12
import Felgo 3.0

EntityBase {
    id: enemyEntity

    entityType: "Enemy"

    Image {
        id: enemyImage
        source: "../assets/monster.png"
        width: dp(100)
        height: dp(100)
    }

    BoxCollider {
        // these are the default physics property values, but they can be changed to match the desired physics behavior
        friction: 0.2
        restitution: 0

        bodyType: Body.Dynamic

        // make the same size as the Image
        anchors.fill: enemyImage

        fixture.onBeginContact: {
            // handle the collision and make the image semi-transparent
            console.info("ahhhh")
            enemyImage.opacity = 0
        }

        fixture.onEndContact: {
            // remove itself
            enemyImage.opacity = 0
        }
    }
}
