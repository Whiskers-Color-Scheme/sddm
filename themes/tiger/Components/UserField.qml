import QtQuick 2.15
import QtQuick.Controls 2.15

TextField {
    id: userField

    height: inputHeight
    width: inputWidth
    selectByMouse: true
    echoMode: TextInput.Normal
    selectionColor: config.neutral_eight
    selectedTextColor: config.text
    renderType: Text.NativeRendering
    color: config.text
    horizontalAlignment: Text.AlignHCenter
    placeholderText: "Username"
    placeholderTextColor: config.text_two
    text: userModel.lastUser
    states: [
        State {
            name: "focused"
            when: userField.activeFocus

            PropertyChanges {
                target: userFieldBackground
                border.width: 2
                border.color: config.AccentColor
            }

        },
        State {
            name: "hovered"
            when: userField.hovered

            PropertyChanges {
                target: userFieldBackground
                border.width: 2
                border.color: config.AccentColor
            }

        }
    ]

    font {
        family: config.Font
        pointSize: config.FontSize
    }

    background: Rectangle {
        id: userFieldBackground

        radius: 99
        color: config.neutral_two
        border.width: 2
        border.color: config.neutral_six
    }

    transitions: Transition {
        PropertyAnimation {
            properties: "color"
            duration: 200
        }

    }

}
