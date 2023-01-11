import QtQuick 2.0

Rectangle {
    id: main
    width: 20
    height: 200
    color: "Transparent"
    property real thumbWidth: 20
    property color thumbColor: "#fa8231"
    property color progressColor: "#26de81"
    property color backgroundColor: "#d1d8e0"
    property real finalValue: maxValue*value
    property real maxValue: 10
    property string prefix: "s"
    property real value: 1-positionToValue(circleHandle.y, height)

    property real defaultValue: 0.3
    clip: false
    Component.onCompleted: {
        circleHandle.y = defaultValue*height;
    }

    Rectangle
    {
        clip: false
        height: main.height
        width: 4
        x:main.width/2 - width/2
        radius: width
        color: main.backgroundColor

    }
    Rectangle
    {
        id: progressBar
        height: main.height * main.value
        width: 4
        x:main.width/2 - width/2
        anchors.bottom: parent.bottom
        radius: width
        color: main.progressColor

    }
    Rectangle {
        id: circleHandle
        width: thumbWidth
        height: thumbWidth
        radius: width/2
        color: main.thumbColor
        Text {
            id: valueText
            text: qsTr((main.value*main.maxValue).toFixed(2)+main.prefix)
            anchors.centerIn: parent
            color: "White"
            opacity: 0
            font.bold: true
            Behavior on opacity
            {
                SmoothedAnimation{velocity:2}
            }

        }
        Behavior on width
        {
            PropertyAnimation
            {
                easing.type: Easing.InOutCubic
                duration: 600
            }
        }
        MouseArea
        {
            anchors.fill: parent
            drag.target: parent
            drag.maximumX: 0
            drag.maximumY: main.height
            drag.minimumX: 0
            drag.minimumY: 0
            onPressed:
            {
                valueText.opacity=1;
                circleHandle.width= thumbWidth + valueText.contentWidth;
            }
            onReleased:
            {

                valueText.opacity=0;
                circleHandle.width= thumbWidth ;
            }
        }
        transform: Translate
        {
            x: main.width/2-circleHandle.width/2
            y:-circleHandle.height/2
        }
    }
    function positionToValue(pos, size)
    {
        return pos/size;
    }

}


