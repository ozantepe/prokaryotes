import Felgo 3.0
import QtQuick 2.0
import "scenes"

GameWindow {
    id: gameWindow

    // window size
    screenWidth: 640
    screenHeight: 960

    activeScene: gameScene

    EntityManager {
        id: entityManager
        entityContainer: gameScene
    }

    GameScene {
        id: gameScene
    }
}
