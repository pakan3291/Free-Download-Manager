import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

Rectangle {
    id: root

    color: "#1C1C1C"

    // Responsive scaling helpers with safe fallbacks
    readonly property real effectiveWidth: root.width > 0 ? root.width : (parent ? parent.width : 576)
    readonly property real effectiveHeight: root.height > 0 ? root.height : (parent ? parent.height : 500)

    // Responsive scaling properties for addLinkButton tied to titleText scaling
    readonly property real responsiveRatio: Math.min(Math.max((titleText.font.pixelSize - 24) / 12, 0.0), 1.0)
    readonly property int btnHeight: Math.round(36 + responsiveRatio * 14)
    readonly property int btnTextPixelSize: Math.round(13 + responsiveRatio * 4)
    readonly property int btnIconPixelSize: Math.round(15 + responsiveRatio * 5)
    readonly property int btnPaddingHorizontal: Math.round(16 + responsiveRatio * 8)
    readonly property int btnRadius: Math.round(8 + responsiveRatio * 4)
    readonly property int btnSpacing: Math.round(6 + responsiveRatio * 3)

    Row {
        id: headerRow

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: Math.round(Math.min(Math.max(root.effectiveHeight * 0.05, 25), 40))
        anchors.leftMargin: Math.round(Math.min(Math.max(root.effectiveWidth * 0.04, 30), 50))
        anchors.rightMargin: Math.round(Math.min(Math.max(root.effectiveWidth * 0.04, 30), 50))
        height: Math.max(titleText.implicitHeight, addLinkButton.implicitHeight)

        Text {
            id: titleText
            text: "Downloads"

            anchors.verticalCenter: parent.verticalCenter

            color: "#FFFFFF"
            font.family: "Segoe UI"
            font.weight: Font.Medium
            font.pixelSize: Math.round(Math.min(
                Math.max(root.effectiveWidth * 0.012 + 17, 24),
                root.effectiveHeight > 0 ? Math.max(root.effectiveHeight * 0.06, 22) : 36,
                36
            ))

            renderType: Text.QtRendering
            elide: Text.ElideRight
        }

        Item {
            id: spacer
            width: Math.max(0, headerRow.width - titleText.width - addLinkButton.width)
            height: 1
        }

        Button {
            id: addLinkButton

            anchors.verticalCenter: parent.verticalCenter

            text: "Add Link"

            implicitHeight: root.btnHeight
            implicitWidth: contentRow.implicitWidth + (root.btnPaddingHorizontal * 2)

            // Pointer cursor
            HoverHandler {
                cursorShape: Qt.PointingHandCursor
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                acceptedButtons: Qt.NoButton
            }

            background: Rectangle {
                id: buttonBg
                radius: root.btnRadius

                // Modern light blue color scheme
                color: {
                    if (addLinkButton.down) return "#0284C7"
                    if (addLinkButton.hovered) return "#7DD3FC"
                    return "#38BDF8"
                }

                border.color: addLinkButton.hovered ? "#BAE6FD" : "transparent"
                border.width: 1

                Behavior on color {
                    ColorAnimation { duration: 150 }
                }

                scale: addLinkButton.down ? 0.97 : (addLinkButton.hovered ? 1.02 : 1.0)
                Behavior on scale {
                    NumberAnimation { duration: 100 }
                }
            }

            contentItem: Item {
                implicitWidth: contentRow.implicitWidth
                implicitHeight: contentRow.implicitHeight

                Row {
                    id: contentRow
                    anchors.centerIn: parent
                    spacing: root.btnSpacing

                    Item {
                        id: iconContainer
                        width: root.btnIconPixelSize
                        height: root.btnIconPixelSize
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: Math.round(1 + root.responsiveRatio * 0.5)

                        Image {
                            id: addIcon
                            source: "icons/add.svg"
                            anchors.fill: parent
                            sourceSize: Qt.size(root.btnIconPixelSize * 2, root.btnIconPixelSize * 2)
                            fillMode: Image.PreserveAspectFit
                            smooth: true
                            mipmap: true
                            visible: false
                        }

                        ColorOverlay {
                            anchors.fill: addIcon
                            source: addIcon
                            color: "#0F172A"
                        }
                    }

                    Text {
                        id: btnText
                        text: addLinkButton.text
                        font.family: "Segoe UI"
                        font.pixelSize: root.btnTextPixelSize
                        font.weight: Font.DemiBold
                        color: "#0F172A"
                        verticalAlignment: Text.AlignVCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
        }
    }
}