import QtQml.Models 2.15
import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    property var session: sessionList.currentIndex

    implicitHeight: sessionButton.height
    implicitWidth: sessionButton.width

    DelegateModel {
        id: sessionWrapper

        model: sessionModel

        delegate: ItemDelegate {
            id: sessionEntry

            height: 40
            width: parent.width
            highlighted: sessionList.currentIndex == index
            states: [
                State {
                    name: "hovered"
                    when: sessionEntry.hovered

                    PropertyChanges {
                        target: sessionEntryBackground
                        color: config.neutral_two
                    }

                }
            ]

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    sessionList.currentIndex = index;
                    sessionPopup.close();
                }
            }

            contentItem: Text {
                renderType: Text.NativeRendering
                font.family: config.Font
                font.pointSize: config.FontSize
                font.bold: true
                horizontalAlignment: Text.AlignHStart
                verticalAlignment: Text.AlignVCenter
                color: config.text
                text: name
            }

            background: Rectangle {
                id: sessionEntryBackground

                color: config.neutral_four
                radius: 4
            }

        }

    }

    Button {
        id: sessionButton

        height: 40
        width: 40
        hoverEnabled: true
        onClicked: {
            sessionPopup.visible ? sessionPopup.close() : sessionPopup.open();
            sessionButton.state = "pressed";
        }
        states: [
            State {
                name: "pressed"
                when: sessionButton.down

                PropertyChanges {
                    target: sessionButtonBackground
                    color: config.neutral_six
                }

            },
            State {
                name: "hovered"
                when: sessionButton.hovered

                PropertyChanges {
                    target: sessionButtonBackground
                    color: config.neutral_six
                }

            },
            State {
                name: "selection"
                when: sessionPopup.visible

                PropertyChanges {
                    target: sessionButtonBackground
                    color: config.neutral_six
                }

            }
        ]

        icon {
            source: Qt.resolvedUrl("../icons/settings.svg")
            height: 24
            width: 24
            color: config.AccentColor
        }

        background: Rectangle {
            id: sessionButtonBackground

            color: config.neutral_four
            radius: 99
        }

        transitions: Transition {
            PropertyAnimation {
                properties: "color"
                duration: 150
            }

        }

    }

    Popup {
        id: sessionPopup

        width: 400
        x: 48
        y: -sessionPopup.height

        background: Rectangle {
            radius: 5.4
            color: config.neutral_four
            border.width: 1
            border.color: config.neutral_six
        }

        contentItem: ListView {
            id: sessionList

            implicitHeight: contentHeight
            model: sessionWrapper
            currentIndex: sessionModel.lastIndex
            clip: true
        }

        enter: Transition {
            ParallelAnimation {
                NumberAnimation {
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: 400
                    easing.type: Easing.OutExpo
                }

                NumberAnimation {
                    property: "x"
                    from: 0
                    to: sessionPopup.x
                    duration: 500
                    easing.type: Easing.OutExpo
                }

            }

        }

        exit: Transition {
            NumberAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: 200
                easing.type: Easing.OutExpo
            }

        }

    }

}
