import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
  implicitHeight: rebootButton.height
  implicitWidth: rebootButton.width
  Button {
    id: rebootButton
    height: 40
    width: 40
    hoverEnabled: true
    icon {
      source: Qt.resolvedUrl("../icons/reboot.svg")
      height: 24
      width: 24
      color: config.AccentColor
    }
    background: Rectangle {
      id: rebootButtonBackground
      radius: 99
      color: config.neutral_four
    }
    states: [
      State {
        name: "hovered"
        when: rebootButton.hovered
        PropertyChanges {
          target: rebootButtonBackground
          color: config.neutral_six
        }
      }
    ]
    transitions: Transition {
      PropertyAnimation {
        properties: "color"
        duration: 200
      }
    }
    onClicked: sddm.reboot()
  }
}
