import QtQuick 2.12
import "../entities"

Item {
    width: parent.width
    height: parent.height

    property string levelName
    signal increaseScore

    Enemy {
        id: enemyCell
    }

    Character {
        id: characterCell

        DragHandler {
            id: dragHandler
        }

        onMonsterHit: increaseScore()
    }
}
