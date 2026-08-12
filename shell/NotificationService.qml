pragma Singleton
import Quickshell.Services.Notifications

NotificationServer {
    id: server
    bodySupported: true
    imageSupported: true
    keepOnReload: true
    actionsSupported: true

    onNotification: function(notification) {
        notification.tracked = true
    }
}