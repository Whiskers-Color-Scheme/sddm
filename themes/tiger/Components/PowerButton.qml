import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    implicitHeight: powerButton.height
    implicitWidth: powerButton.width

    Button {
        id: powerButton

        height: 40
        width: 40
        hoverEnabled: true
        onClicked: sddm.powerOff()
        states: [
            State {
                name: "hovered"
                when: powerButton.hovered

                PropertyChanges {
                    target: powerButtonBackground
                    color: config.neutral_six
                }

            }
        ]

        icon {
            source: Qt.resolvedUrl("../icons/power.svg")
            height: 24
            width: 24
            color: config.AccentColor
        }

        background: Rectangle {
            id: powerButtonBackground

            radius: 99
            color: config.neutral_four
        }

        transitions: Transition {
            PropertyAnimation {
                properties: "color"
                duration: 200
            }

        }

    }

}
