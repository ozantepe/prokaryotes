import QtQuick 2.12
import Felgo 3.0
import "../common" as Common
import "../entities"

Common.LevelBase {
    levelName: "Level1"

    Enemy {
        id: enemyCell

        Image {
            id: enemyImage
            source: "../../assets/enemy-1.png"
            anchors.fill: parent
        }
    }

    Component.onCompleted: {
        world.gravity.y += 0.10
    }
}
