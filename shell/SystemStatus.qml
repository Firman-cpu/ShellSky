import QtQuick
import Quickshell.Services.Pipewire
import Quickshell.Services.UPower

Item {
    id: root

    readonly property var battery: UPower.displayDevice
    readonly property var sink: Pipewire.defaultAudioSink
    readonly property int batteryPercent: battery && battery.ready ? Math.round(battery.percentage) : -1
    readonly property bool onBattery: UPower.onBattery
    readonly property bool audioReady: Pipewire.ready && sink !== null
    readonly property bool muted: audioReady && sink.audio ? sink.audio.muted : false
    readonly property int volumePercent: audioReady && sink.audio ? Math.round(sink.audio.volume * 100) : -1

    PwObjectTracker {
        objects: [root.sink]
    }
}