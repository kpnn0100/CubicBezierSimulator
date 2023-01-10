import QtQuick 2.4
import QtGraphicalEffects 1.12
Item {
    id: global
    height: 30
    width:mainRegion.width
    property color color: "#05082f"
    property color pressColor: "#ffffff"
    property int normalWidth: 100
    property int focusWidth: 200
    property string text: "My Button"
    property color textColor: "#ffffff"
    signal clicked
    Rectangle{
        color: parent.color
        id: mainRegion


        width: normalWidth
        height: parent.height
        radius: 0
        anchors.centerIn: parent
        z:1
        Behavior on width {
            SmoothedAnimation{velocity:200}
        }
        Behavior on height {
            SmoothedAnimation{velocity:200}
        }
        Behavior on radius {
            SmoothedAnimation{velocity:15}
        }
        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: Item {
                width: mainRegion.width
                height: mainRegion.height
                Rectangle {
                    anchors.centerIn: mainRegion
                    width: mainRegion.width
                    height: mainRegion.height
                    radius: mainRegion.radius
                }
            }
        }

        Rectangle{
            id: animatedCircle
            width:0
            height: width
            color: global.pressColor
            radius:height/2
            opacity: 0.3
            z: 4
            layer.enabled: true
            layer.effect: OpacityMask {
                maskSource: mainRegion
            }

            property double relativeX: 0
            property double relativeY: 0
            property double widthVelocity: 1000
                        property double opacityVelocity: 0.3
            x: relativeX-width/2
            y: relativeY-width/2

            Behavior on width {
                SmoothedAnimation{velocity:animatedCircle.widthVelocity}
            }

            Behavior on opacity {
                SmoothedAnimation{velocity:animatedCircle.opacityVelocity}
            }
        }

        Text {
            id: mainText
            text: qsTr(global.text)
            anchors.centerIn: parent
            color: global.textColor
            font.bold: true
        }
        MouseArea{
            anchors.fill:parent
            hoverEnabled: true
            onClicked: {
                global.clicked();
            }

            onEntered:{ parent.width=global.focusWidth
                parent.radius=parent.height/2
            }
            onExited:
            {parent.width=global.normalWidth
                parent.radius=0
            }
            onPressed:
            {
                animatedCircle.relativeX = mouseX
                animatedCircle.relativeY = mouseY
                animatedCircle.width = global.focusWidth*2
                animatedCircle.opacity=0.3
                animatedCircle.widthVelocity=400
                animatedCircle.opacityVelocity=2
            }
            onReleased:
            {
                animatedCircle.width=0
                animatedCircle.opacity=0
                animatedCircle.widthVelocity=100
                animatedCircle.opacityVelocity=0.3
            }
        }
    }
}
