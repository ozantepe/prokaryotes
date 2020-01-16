import QtQuick 2.12
import Felgo 3.0
import "../common" as Common
import "../entities"

Common.LevelBase {
    levelName: "Level3"

    Booster {
        id: boosterCell
    }

    Component.onCompleted: {
        world.gravity.y += 0.30
    }
}
