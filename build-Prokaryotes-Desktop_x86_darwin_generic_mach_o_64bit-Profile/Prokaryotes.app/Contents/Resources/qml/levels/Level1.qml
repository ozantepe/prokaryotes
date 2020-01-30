import QtQuick 2.12
import Felgo 3.0
import "../common" as Common
import "../entities"

Common.LevelBase {
    levelName: "Level1"

    Component.onCompleted: {
        world.gravity.y += 1.10
    }
}
