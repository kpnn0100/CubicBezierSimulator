import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Shapes 1.15
Window {
    width: 1000
    height: 300
    visible: true
    title: qsTr("Hello World")
    color: "#f8f8f8"
    property color grayBackGround: "#f3f3f3"
    property color grayDirection: "#a3a3a3"
    property color grayShow: "#333333"
    property color mainColor1: "#2bcbba"
    property color mainColor2: "#fed330"
    property real strokeWidth:1
    property int gridCount:5
    property bool gridEnable: gridChecked.checked
    property bool startOfAnimation: true
    property int animationDuration: durationSlider.finalValue*2500

    Row{

        spacing:20
        x:50
        y:parent.height/2 - bezierRegion.height/2
        Rectangle
        {

            id: bezierRegion
            width:200
            height:200
            color:grayBackGround



            clip: false
            //duration slider


            //start end circle
            Rectangle
            {
                height:20
                width:height
                color: grayDirection
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                radius:height/2
                anchors.margins: -width/2
                z:2
            }
            Rectangle
            {
                height:20
                width:height
                color: grayDirection
                anchors.top: parent.top
                anchors.right: parent.right
                radius:height/2
                anchors.margins: -width/2
                z:2
            }
            //Vertical Property
            Rectangle
            {
                height: parent.height
                width: 2
                color: grayDirection
                anchors.left: parent.left
                anchors.leftMargin: -width/2
            }
            Text {

                text: qsTr("Value")
                y: -contentHeight
                x:-5
                color: grayShow

            }
            //Horizontal Property
            Rectangle
            {
                height: 2
                width: parent.width
                color: grayDirection
                anchors.bottom: parent.bottom
                anchors.bottomMargin: -height/2
            }
            Text {

                text: qsTr("Time: " +  (animationDuration/2500).toFixed(2))
                x:parent.width-contentWidth
                y:parent.height-contentHeight
                color: grayShow

            }
            //VectorOfStart

            XYSlider
            {
                id: startVector
                z:2
                color:mainColor1
                yPadding: 1000
                anchors.fill:parent
                defaultValueX: 0.8
                defaultValueY: 1
            }
            //VectorOfEnd
            XYSlider
            {
                id: endVector
                z:2
                color:mainColor2
                yPadding:1000
                anchors.fill: parent
                defaultValueX: 0.2
                defaultValueY: 0
            }
            Rectangle
            {
                anchors.fill: parent
                anchors.margins: -200
                layer.enabled: true
                layer.samples: 4
                antialiasing: true
                color:"Transparent"
                z:0
                Shape {
                    x: -parent.anchors.leftMargin
                    y:-parent.anchors.topMargin
                    z:1
                    //LineToStartVector
                    ShapePath {
                        strokeColor: grayDirection;
                        strokeWidth: 1.5

                        fillColor: "Transparent"
                        startX: bezierRegion.width; startY: 0

                        PathLine {
                            x: startVector.valueX*bezierRegion.width; y: (1-startVector.valueY)*bezierRegion.height

                        }
                    }
                    //LineToEndVector
                    ShapePath {
                        strokeColor: grayDirection;
                        strokeWidth: 1.5

                        fillColor: "Transparent"
                        startX:0 ; startY: bezierRegion.height

                        PathLine {
                            x: endVector.valueX*bezierRegion.width; y: (1-endVector.valueY)*bezierRegion.height

                        }
                    }
                    //BezierCurve
                    ShapePath {
                        strokeColor: grayShow;
                        strokeWidth: 4

                        fillColor: "Transparent"
                        startX: 0; startY: bezierRegion.height

                        PathCubic {
                            x: bezierRegion.width; y: 0
                            control2X: startVector.valueX*bezierRegion.width; control2Y: (1-startVector.valueY)*bezierRegion.height
                            control1X: endVector.valueX*bezierRegion.width; control1Y: (1-endVector.valueY)*bezierRegion.height
                        }
                    }


                }
                Rectangle
                {
                    anchors.fill: parent
                    anchors.margins: -200
                    layer.enabled: true
                    layer.samples: 4
                    antialiasing: true
                    color:"Transparent"
                    z:0
                    opacity:0.5
                    Shape {
                        x: -parent.anchors.leftMargin
                        y:-parent.anchors.topMargin
                        z:1

                        //BezierCurve
                        ShapePath {
                            strokeColor: grayShow;
                            strokeWidth: 20

                            fillColor: "Transparent"
                            startX: 0; startY: bezierRegion.height

                            PathCubic {
                                x: bezierRegion.width; y: 0
                                control2X: startVector.valueX*bezierRegion.width; control2Y: (1-startVector.valueY)*bezierRegion.height
                                control1X: endVector.valueX*bezierRegion.width; control1Y: (1-endVector.valueY)*bezierRegion.height
                            }
                        }


                    }
                }
            }
        }
        Rectangle
        {
            width:40
            height:200
            color: "Transparent"
            LumenticVerticalSlider
            {
                defaultValue: 0.9
                id: durationSlider
                anchors.centerIn: parent
            }
        }
        Rectangle
        {
            id: showRegion
            width:200
            height:200
            color:grayBackGround
            Rectangle
            {
                id:showButton
                anchors.fill:parent
                color: "Transparent"
                LumenticLongButton
                {
                    anchors.bottom: parent.bottom
                    anchors.margins: -40
                    anchors.horizontalCenter: parent.horizontalCenter
                    text:"Show"
                    onClicked:
                    {
                        startOfAnimation= !startOfAnimation;
                    }
                }
            }
            Rectangle
            {
                id: gridShow
                opacity:gridEnable ? 1 : 0
                Behavior on opacity
                {
                    SmoothedAnimation{velocity: 1}
                }

                Row
                {
                    Repeater
                    {
                        model: gridCount
                        Rectangle {
                            width: showRegion.width/gridCount; height: showRegion.height
                            color:"Transparent"
                            Rectangle {
                                anchors.right: parent.right
                                color: grayDirection
                                height: parent.height
                                width: strokeWidth
                            }
                        }
                    }
                }
                Column
                {
                    Repeater
                    {
                        model: gridCount
                        Rectangle {
                            height: showRegion.height/gridCount; width: showRegion.width
                            color:"Transparent"
                            Rectangle {
                                anchors.top: parent.top
                                color: grayDirection
                                width: parent.width
                                height: strokeWidth
                            }
                        }
                    }
                }
            }
            Rectangle
            {
                height: parent.height
                width: 2
                color: grayDirection
                anchors.left: parent.left
                anchors.leftMargin: -width/2
                radius:height/2
            }
            Rectangle
            {
                height: 2
                width: parent.width
                color: grayDirection
                anchors.bottom: parent.bottom
                anchors.bottomMargin: -height/2
                radius:height/2
            }
            Rectangle
            {
                id: handle
                property real standardHeight: 20
                property real finalHeight: 100
                property real standardWidth: 20
                property real finalWidth: 100
                property real standardX: 40
                property real finalX: 140
                property real standardRadius: 0
                property real finalRadius: (finalWidth>finalHeight)? finalWidth/2:finalHeight/2
                property real widthTemp: widthAnimationChecked.checked? ( startOfAnimation? standardWidth : finalWidth) : standardWidth
                width:widthAnimationChecked.checked? ( startOfAnimation? standardWidth : finalWidth) : standardWidth
                height: heightAnimationChecked.checked ? (startOfAnimation? standardHeight : finalHeight) : standardHeight
                x: moveAnimationChecked.checked ? (startOfAnimation? -(widthTemp)/2+standardX : -widthTemp/2+finalX): showRegion.width/2-widthTemp/2
                radius:radiusAnimationChecked.checked ? (startOfAnimation? standardRadius : finalRadius) : finalRadius
                y:showRegion.height/2 - height/2
                property var bez: [endVector.valueX,endVector.valueY,startVector.valueX,startVector.valueY,1,1]
                color: "Black"
                Behavior on x
                {
                    PropertyAnimation{

                        duration: animationDuration
                        easing.type: Easing.Bezier
                        easing.bezierCurve: handle.bez
                    }
                }
                Behavior on width
                {
                    PropertyAnimation{
                        onStarted: console.log(console.time())
                        onFinished: console.log(console.time())
                        duration: animationDuration
                        easing.type: Easing.Bezier
                        easing.bezierCurve: handle.bez
                    }
                }
                Behavior on height
                {
                    PropertyAnimation{
                        duration: animationDuration
                        easing.type: Easing.Bezier
                        easing.bezierCurve: handle.bez
                    }
                }
                Behavior on radius
                {
                    PropertyAnimation{
                        duration: animationDuration
                        easing.type: Easing.Bezier
                        easing.bezierCurve: handle.bez
                    }
                }



            }
        }


        Rectangle
        {
            id: optionRegion
            width:200
            height:200
            color:"Transparent"


            Column
            {
                spacing:10
                LumenticCheckBox
                {
                    id: moveAnimationChecked
                    text: "Position"
                }
                LumenticCheckBox
                {
                    id: heightAnimationChecked
                    text: "Height"
                    checked: true
                }
                LumenticCheckBox
                {
                    id: widthAnimationChecked
                    text: "Width"
                    checked: true
                }
                LumenticCheckBox
                {
                    id: radiusAnimationChecked
                    text: "Radius"
                }
                LumenticCheckBox
                {
                    id: gridChecked
                    text: "Grid"
                    checked: true
                }
            }
        }


    }


}
