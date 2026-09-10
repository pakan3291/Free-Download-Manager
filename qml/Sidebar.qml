import QtQuick

Rectangle {
    id: root
    width: Math.min(Math.max(parent ? parent.width * 0.28 : 240, 220), 280)
    height: parent ? parent.height : 500

    color: "#0F0F12"

    property string activeItem: "downloads"

    Rectangle {
        id: rightBorder
        width: 1
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        color: "#1E1E24"
    }

    Item {
        id: logoSection
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 72

        Image {
            id: logo
            source: "assets/SwiftDL.svg"
            width: Math.min(parent.width - 40, 160)
            height: width * (428 / 1895)

            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 18

            fillMode: Image.PreserveAspectFit
            mipmap: true
            smooth: true
        }
    }

    component SidebarItem: Item {
        id: itemRoot
        width: parent.width
        height: 42

        property string itemId: ""
        property string text: ""
        property string iconSource: ""
        property string badgeText: ""
        readonly property bool isActive: root.activeItem === itemId

        signal clicked()

        MouseArea {
            id: itemMouseArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                root.activeItem = itemRoot.itemId
                itemRoot.clicked()
            }
        }

        Rectangle {
            id: itemPill
            anchors.fill: parent
            anchors.leftMargin: 12
            anchors.rightMargin: 12
            radius: 8

            color: itemRoot.isActive ? Qt.rgba(1, 1, 1, 0.10) : (itemMouseArea.containsMouse ? Qt.rgba(1, 1, 1, 0.06) : "transparent")

            Behavior on color {
                ColorAnimation { duration: 150 }
            }

            // Left active accent indicator bar
            Rectangle {
                id: activeIndicator
                width: 3
                height: 16
                radius: 1.5
                color: "#3B82F6"
                anchors.left: parent.left
                anchors.leftMargin: 4
                anchors.verticalCenter: parent.verticalCenter
                opacity: itemRoot.isActive ? 1.0 : 0.0

                Behavior on opacity {
                    NumberAnimation { duration: 150 }
                }
            }

            // Item Icon
            Image {
                id: itemIcon
                source: itemRoot.iconSource
                width: 20
                height: 20
                sourceSize: Qt.size(20, 20)
                fillMode: Image.PreserveAspectFit
                mipmap: true
                smooth: true

                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 14

                opacity: itemRoot.isActive ? 1.0 : (itemMouseArea.containsMouse ? 0.95 : 0.65)

                Behavior on opacity {
                    NumberAnimation { duration: 150 }
                }
            }

            // Item Label
            Text {
                id: itemLabel
                text: itemRoot.text
                color: itemRoot.isActive ? "#FFFFFF" : (itemMouseArea.containsMouse ? "#F3F4F6" : "#9CA3AF")
                font.pixelSize: 14
                font.weight: itemRoot.isActive ? Font.DemiBold : Font.Medium
                font.family: "Segoe UI"

                anchors.verticalCenter: parent.verticalCenter
                anchors.left: itemIcon.right
                anchors.leftMargin: 12
                anchors.right: badgeContainer.visible ? badgeContainer.left : parent.right
                anchors.rightMargin: 8
                elide: Text.ElideRight

                Behavior on color {
                    ColorAnimation { duration: 150 }
                }
            }

            // Optional Count Badge
            Rectangle {
                id: badgeContainer
                visible: itemRoot.badgeText !== ""
                width: Math.max(badgeContent.implicitWidth + 14, 22)
                height: 20
                radius: 10
                color: itemRoot.isActive ? Qt.rgba(0.23, 0.51, 0.96, 0.25) : Qt.rgba(1, 1, 1, 0.08)
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.verticalCenter: parent.verticalCenter

                Text {
                    id: badgeContent
                    anchors.centerIn: parent
                    text: itemRoot.badgeText
                    color: itemRoot.isActive ? "#60A5FA" : "#9CA3AF"
                    font.pixelSize: 11
                    font.weight: Font.DemiBold
                    font.family: "Segoe UI"
                }
            }
        }
    }

    // Main Navigation Section
    Item {
        id: menuSection
        anchors.top: logoSection.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: bottomSection.top
        anchors.topMargin: 8

        Column {
            id: navColumn
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            spacing: 4

            SidebarItem {
                id: downloadItem
                itemId: "downloads"
                text: "Downloads"
                iconSource: "icons/download.svg"
            }

            SidebarItem {
                id: downloadingItem
                itemId: "downloading"
                text: "Downloading"
                iconSource: "icons/downloading.svg"
            }

            SidebarItem {
                id: completedItem
                itemId: "completed"
                text: "Completed"
                iconSource: "icons/completed.svg"
            }

            SidebarItem {
                id: pausedItem
                itemId: "paused"
                text: "Paused"
                iconSource: "icons/paused.svg"
            }

            SidebarItem {
                id: failedItem
                itemId: "failed"
                text: "Failed"
                iconSource: "icons/failed.svg"
            }
        }
    }

    // Bottom Section with divider & Settings
    Item {
        id: bottomSection
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottomMargin: 12
        height: 54

        Rectangle {
            id: bottomDivider
            width: parent.width - 24
            height: 1
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#1E1E24"
        }

        SidebarItem {
            id: settingsItem
            itemId: "settings"
            anchors.bottom: parent.bottom
            text: "Settings"
            iconSource: "icons/settings.svg"
        }
    }
}