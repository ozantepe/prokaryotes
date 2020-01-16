import QtQuick 2.12
import Felgo 3.0

EnemyBase {
    id: thirdEnemy
    entityType: "Enemy"

    Image {
        id: enemyImage
        source: "../../assets/enemy-3.png"
        anchors.fill: parent
    }
}
