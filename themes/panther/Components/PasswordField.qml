import QtQuick 2.15
import QtQuick.Controls 2.15

TextField {
    id: passwordField

    focus: true
    selectByMouse: true
    placeholderText: "Password"
    placeholderTextColor: config.text_two
    echoMode: TextInput.Password
    passwordCharacter: "*"
    selectionColor: config.neutral_eight
    selectedTextColor: config.text
    renderType: Text.NativeRendering
    font.family: config.Font
    font.pointSize: config.FontSize
    color: config.text
    horizontalAlignment: TextInput.AlignHCenter
    states: [
        State {
            name: "focused"
            when: passwordField.activeFocus

            PropertyChanges {
                target: passFieldBackground
                border.width: 2
                border.color: config.AccentColor
            }

        },
        State {
            name: "hovered"
            when: passwordField.hovered

            PropertyChanges {
                target: passFieldBackground
                border.width: 2
                border.color: config.AccentColor
            }

        }
    ]

    background: Rectangle {
        id: passFieldBackground

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
