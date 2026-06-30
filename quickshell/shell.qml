import qtquick
import quickshell
import quickshell.services

quickshell {
    id: root

    # properties to hold our active data values globally
    property string literaryclocktext: "it is a quiet moment."
    property int audiomotionvalue: 0

    variantscreenwindow {
        id: maincanvas
        anchors.fill: parent
        color: "transparent"

        item {
            id: maincontainer
            anchors.fill: parent

            # 1. Background Engine: The Literary Clock Worker
            process {
                id: clockworker
                command: ["/home/vivi/dotfiles/scripts/clock.py"]
                running: true
                
                # refresh the text layout string automatically every 30 seconds
                onstdoutreceived: (text) => {
                    literaryclocktext = text.trim();
                }
            }

            # trigger the clock script to read values on a lightweight interval loop
            timer {
                interval: 30000
                running: true
                repeat: true
                ontriggered: clockworker.start()
            }

            # 2. Background Engine: The Silent Audio Pipeline Listener
            process {
                id: audioworker
                command: ["/home/vivi/dotfiles/scripts/audio_listener.py"]
                running: true
                
                # capture raw stream numbers instantly as they pipe out of cava
                onstdoutreceived: (text) => {
                    let cleanvalue = parseInt(text.trim());
                    if (!isnan(cleanvalue)) {
                        audiomotionvalue = cleanvalue;
                    }
                }
            }
        }
    }
}
