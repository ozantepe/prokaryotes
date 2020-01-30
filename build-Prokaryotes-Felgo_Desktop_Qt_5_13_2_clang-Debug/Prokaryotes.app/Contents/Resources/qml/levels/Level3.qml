import QtQuick 2.12
import Felgo 3.0
import "../common" as Common
import "../entities"

Common.LevelBase {
    levelName: "Level3"

    Booster {
        id: boosterCell
    }

    Enemy2 {
        id: enemy2
    }

    Enemy3 {
        id: enemy3
    }

    Component.onCompleted: {
        world.gravity.y += 3.30
    }
}
