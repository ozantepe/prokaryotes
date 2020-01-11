import QtQuick 2.12
import Felgo 3.0

EntityBase {

    id: firstLevel

    entityType: "FirstLevel"

    Image {
        anchors.fill: parent.gameWindowAnchorItem
        source: "../../assets/background.png"
    }

    PhysicsWorld {
        gravity.y: 0.81
    }

    Enemy {
        id: enemyCell
        x: parent.width / 2
        width: dp(100)
        height: dp(100)
    }

    Character {
        id: cell
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        width: dp(100)
        height: dp(100)

        DragHandler { id: dragHandler }
    }
}
