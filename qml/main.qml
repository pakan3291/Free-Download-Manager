import QtQuick
import QtQuick.Controls

ApplicationWindow {
    visible: true
    
    minimumWidth: 800
    minimumHeight: 500

    color: "#1C1C1C"

    Sidebar {
        id: sidebar
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
    }

    Downloads {
        visible: sidebar.activeItem === "downloads"

        anchors.left: sidebar.right
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
    }
}
