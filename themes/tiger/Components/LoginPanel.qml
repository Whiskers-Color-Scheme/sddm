import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Item {
  property var user: userField.text
  property var password: passwordField.text
  property var session: sessionPanel.session
  Rectangle {
    id: loginBackground
    anchors {
      verticalCenter: parent.verticalCenter
      horizontalCenter: parent.horizontalCenter
    }
    height: 40 + 8 + 40 + 8 + 40 + 8 + 64
    width: 440
    radius: 14
    color: config.neutral_four
    border.width: 1
    border.color: config.neutral_six
  }
  Column {
    spacing: 16
    anchors {
      bottom: parent.bottom
      left: parent.left
    }
    PowerButton {
      id: powerButton
    }
    RebootButton {
      id: rebootButton
    }
    SessionPanel {
      id: sessionPanel
    }
    z: 5
  }
  Column {
    spacing: 8
    z: 5
    width: 400
    anchors {
      verticalCenter: parent.verticalCenter
      horizontalCenter: parent.horizontalCenter
    }
    UserField {
      id: userField
      height: 40
      width: parent.width
    }
    PasswordField {
      id: passwordField
      height: 40
      width: parent.width
      onAccepted: loginButton.clicked()
    }
    Button {
      id: loginButton
      height: 40
      width: parent.width
      enabled: user != "" && password != "" ? true : false
      hoverEnabled: true
      contentItem: Text {
        id: buttonText
        renderType: Text.NativeRendering
        font {
          family: config.Font
          pointSize: config.FontSize
          bold: true
        }
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: config.neutral
        text: "Login"
      }
      background: Rectangle {
        id: buttonBackground
        color: config.AccentColor
        radius: 99
      }
      states: [
        State {
          name: "pressed"
          when: loginButton.down
          PropertyChanges {
            target: buttonBackground
            color: config.AccentColorHover
          }
        },
        State {
          name: "hovered"
          when: loginButton.hovered
          PropertyChanges {
            target: buttonBackground
            color: config.AccentColorHover
          }
        },
        State {
          name: "enabled"
          when: loginButton.enabled
          PropertyChanges {
            target: buttonBackground
          }
        }
      ]
      transitions: Transition {
        PropertyAnimation {
          properties: "color"
          duration: 200
        }
      }
      onClicked: {
        sddm.login(user, password, session)
      }
    }
  }
  Connections {
    target: sddm

    function onLoginFailed() {
      passwordField.text = ""
      passwordField.focus = true
    }
  }
}
