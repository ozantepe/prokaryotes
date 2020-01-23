import QtQuick 2.12
import Felgo 3.0

EntityBase {
    id: enemy2Entity
    entityType: "Enemy"
    width: constants.enemyWidth
    height: constants.enemyHeight

    Image {
        id: enemy2Image
        source: "../../assets/enemy-2.png"
        anchors.fill: parent
    }

    BoxCollider {
        // these are the default physics property values, but they can be changed to match the desired physics behavior
        friction: 0.2
        restitution: 0
        bodyType: Body.Dynamic
        categories: Box.Category2
        collidesWith: Box.Category1
        anchors.fill: parent
        fixture.onBeginContact: {
            enemy2Image.opacity = 0
        }
        fixture.onEndContact: {
            removeEntity()
        }
    }

    Component.onCompleted: {
        x = utils.generateRandomValueBetween(0, parent.width)
        y = 0
    }
}
