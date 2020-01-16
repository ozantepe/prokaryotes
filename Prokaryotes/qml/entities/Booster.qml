import QtQuick 2.12
import Felgo 3.0

EntityBase {
    id: boosterEntity
    entityType: "Booster"
    width: constants.boosterWidth
    height: constants.boosterHeight

    Image {
        id: boosterImage
        source: "../../assets/booster.png"
        anchors.fill: parent
    }

    BoxCollider {
        // these are the default physics property values, but they can be changed to match the desired physics behavior
        friction: 0.2
        restitution: 0
        bodyType: Body.Dynamic
        categories: Box.Category3
        collidesWith: Box.Category1
        anchors.fill: parent
        fixture.onBeginContact: {
            boosterImage.opacity = 0
        }
        fixture.onEndContact: {
            removeEntity()
        }
    }

    Component.onCompleted: {
        x = utils.generateRandomValueBetween(0, gameScene.width)
        y = 0
    }
}
