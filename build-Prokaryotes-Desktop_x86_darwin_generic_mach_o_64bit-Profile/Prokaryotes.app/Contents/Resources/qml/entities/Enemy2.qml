import QtQuick 2.12
import Felgo 3.0

EnemyBase {
    id: secondEnemy
    entityType: "Enemy"

    Image {
        id: enemyImage
        source: "../../assets/enemy-2.png"
        anchors.fill: parent
    }
}
