import QtQuick 2.12
import "../entities"

Item {
    width: parent.width
    height: parent.height

    property string levelName
    signal increaseScore

    Character {
        id: characterCell

        DragHandler {
            id: dragHandler
        }

        onMonsterHit: increaseScore()
    }
}
