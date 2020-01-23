import QtQuick 2.0

Rectangle {
    id: button
    width: buttonText.width + paddingHorizontal * 2
    height: buttonText.height + paddingVertical * 2
    color: "#e9e9e9"
    radius: 10

    property int paddingHorizontal: 10
    property int paddingVertical: 5
    property alias text: buttonText.text
    property bool completed: false

    signal clicked

    Text {
        id: buttonText
        anchors.centerIn: parent
        font.pixelSize: 18
        color: "black"
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: button.clicked()
        onPressed: button.opacity = 0.5
        onReleased: button.opacity = 1
    }

    Image {
        id: tickImage
        source: "../../assets/tick.png"
        opacity: completed ? 1 : 0
        scale: 0.35
        anchors.centerIn: parent
    }
}
