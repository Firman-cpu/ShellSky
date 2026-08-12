import QtQuick
import Quickshell
import Quickshell.Services.UPower

QtObject {
    id: root

    readonly property var battery: UPower.displayDevice
    readonly property bool hasBattery: battery && battery.isPresent
    readonly property real batteryPercent: hasBattery ? battery.percentage : -1
    readonly property bool charging: hasBattery ? battery.state === UPowerDeviceState.Charging : false
}
