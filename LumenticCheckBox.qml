import QtQuick 2.0

Item {
    id:main
    height:20
    width:checkRectangle.width+5+nameOfCheckBox.contentWidth

    property string text: "My CheckBox"
    property bool checked: false
    property color color: "Black"
    Rectangle
    {
        id: checkRectangle
        height: parent.height
        width:parent.height
        border.width: 2
        border.color: main.color
        color: "Transparent"
        clip: true
        Rectangle
        {
            height:checked ? parent.height*1.31415 : 0
            width: height
            anchors.centerIn: parent
            color: main.color
            radius: height/2
            antialiasing: true
            Behavior on height {
                PropertyAnimation{
                     duration:1000
                 easing.type: Easing.InOutCubic
                 }
            }
        }
        MouseArea
        {
            anchors.fill: parent
            onClicked:
            {
                main.checked = !main.checked;

            }
        }
    }
    Text {
        id: nameOfCheckBox
        text: main.text
        x:checkRectangle.width+5
anchors.verticalCenter: parent.verticalCenter
    }
}
