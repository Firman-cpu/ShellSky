import QtQuick
import Quickshell

QtObject {
    property string kernel: ""
    property string uptime: ""

    function refresh() {
        Quickshell.execDetached(["bash", "-lc", "printf '%s|%s' \"$(uname -r)\" \"$(uptime -p 2>/dev/null || true)\""])
    }
}