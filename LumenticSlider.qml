import QtQuick 2.0

Rectangle {
    id: main
    width: 200
    height: 20
    color: "Transparent"
    property real thumbWidth: 20
    property color thumbColor: "#fa8231"
    property color progressColor: "#26de81"
    property color backgroundColor: "#d1d8e0"
    property real finalValue: maxValue*value
    property real maxValue: 10
    property string prefix: "s"
    property real value: positionToValue(circleHandle.x, width)

    property real defaultValue: 0.3
    clip: false
    Component.onCompleted: {
        circleHandle.x = defaultValue*width;
    }

    Rectangle
    {
        clip: false
        width: main.width
        height: 4
        y:main.height/2 - height/2
        radius: height
        color: main.backgroundColor

    }
    Rectangle
    {
        id: progressBar
        width: main.width * main.value
        height: 4
        y:main.height/2 - height/2
        radius: height
        color: main.progressColor

    }
    Rectangle {
        id: circleHandle
        width: main.height
        height: main.height
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
            drag.maximumX: main.width
            drag.maximumY: 0
            drag.minimumX: 0
            drag.minimumY: 0
            onPressed:
            {
                valueText.opacity=1;
                circleHandle.width= main.height + valueText.contentWidth;
            }
            onReleased:
            {

                valueText.opacity=0;
                circleHandle.width= main.height ;
            }
        }
        transform: Translate
        {
            x: -circleHandle.width/2
            y:main.height/2-circleHandle.height/2
        }
    }
    function positionToValue(pos, size)
    {
        return pos/size;
    }

}


