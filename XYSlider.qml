import QtQuick 2.0
import QtQuick.Controls 2.0
Item {
    id: main
    width: 200
    height: 200
    property real yPadding:100
    property real thumbWidth: 20
    property color color: "White"
    property real valueX: positionToValue(circleHandle.x, width)
    property real valueY: 1-positionToValue(circleHandle.y, height)
    property real defaultValueX: 0.3
    property real defaultValueY: 0.3
    clip: false
    Component.onCompleted: {
        circleHandle.x = defaultValueX*width;
        circleHandle.y = (1-defaultValueY)*height;
    }

    Rectangle
    {
        clip: false

        Rectangle {
            id: circleHandle
            implicitWidth: thumbWidth
            implicitHeight: thumbWidth
            radius: thumbWidth
            color: main.color

            MouseArea
            {
                anchors.fill: parent
                drag.target: parent
                drag.maximumX: main.width
                drag.maximumY: main.height + yPadding
                drag.minimumX: 0
                drag.minimumY: -yPadding

            }
            transform: Translate
            {
                x: -thumbWidth/2
                y:-thumbWidth/2
            }
        }
    }
    function positionToValue(pos, size)
    {
        return pos/size;
    }

}
