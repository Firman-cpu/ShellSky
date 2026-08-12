import QtQuick
import Quickshell

QtObject {
    readonly property var applications: DesktopEntries.applications

    function launch(entry) {
        if (entry)
            entry.execute()
    }

    function filtered(query) {
        const needle = String(query || "").trim().toLowerCase()
        if (!needle)
            return applications.values

        return applications.values.filter(function(entry) {
            return entry.name.toLowerCase().indexOf(needle) !== -1
                || String(entry.genericName || "").toLowerCase().indexOf(needle) !== -1
                || String(entry.comment || "").toLowerCase().indexOf(needle) !== -1
        })
    }
}