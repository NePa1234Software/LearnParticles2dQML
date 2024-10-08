import QtQuick
import QtQuick.Shapes
import QtQuick.Particles

Shape {
    id: control
    objectName: "EditableShapeSpot_" + control.shapeIndex

    property color borderColor: "blue"
    property color editBorderColor: "red"
    property bool editing: true
    property bool hidden: false
    property int shapeIndex: -1

    signal requestShapeMove(positionNew : point)
    signal requestShapeDelete()
    signal requestShapeSelect()

    function pointAtPercent(t: real) : point {
        return Qt.point(x,y);
    }

    function load() {
        settingsId.load()
    }
    function save() {
        settingsId.save()
    }

    SettingHelper {
        id: settingsId
        saveProperties: []
    }

    QtObject {
        id: priv
        property int dotWidth: 2
    }

    Rectangle {
        visible: control.editing
        border.color: "orange"
        border.width: 1
        color: "transparent"
        anchors.fill: parent
    }

    DragPoint {
        id: movePoint
        visible: control.editing && !control.hidden
        toolTipText: qsTr("CTRL-Right click to delete.\n" +
                          "Drag the shape to desired position.")
        x: control.x
        y: control.y
        color: control.editBorderColor
        border.color: control.editBorderColor
        border.width: priv.dotWidth
        cursorShape: Qt.DragMoveCursor
        onRequestPointMove: (pointNew) => {
            control.requestShapeMove(pointNew)
        }
        onRequestPointDelete: {
            control.requestShapeDelete()
        }
        onRequestPointSelect: {
            control.requestShapeSelect()
        }
    }
}
