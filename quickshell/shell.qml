import qtquick
import quickshell
import quickshell.services

quickshell {
    id: root

    # properties to hold our active dynamic data streams
    property string literaryclocktext: "it is a quiet moment."
    property int audiomotionvalue: 0

    variantscreenwindow {
        id: maincanvas
        anchors.fill: parent
        
        # lock the layer transparently beneath your windows as a desktop backdrop
        color: "transparent"
        windowwflags: qt.windowtransparentforinput | qt.windowdoesnotacceptfocus

        item {
            id: maincontainer
            anchors.fill: parent

            # 1. Background Engine: The Literary Clock Worker
            process {
                id: clockworker
                command: ["/home/vivi/dotfiles/scripts/clock.py"]
                running: true
                
                onstdoutreceived: (text) => {
                    literaryclocktext = text.trim().tolowercase();
                }
            }

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
                
                onstdoutreceived: (text) => {
                    let cleanvalue = parseint(text.trim());
                    if (!isnan(cleanvalue)) {
                        audiomotionvalue = cleanvalue;
                    }
                }
            }

            # 3. Visual UI Layer: The Poetic Text Element
            text {
                id: literaryclockdisplay
                text: root.literaryclocktext
                
                # aesthetic styling rules
                font.pointsize: 32
                font.family: "jetbrains mono"  # falls back to system mono if missing
                color: "#ffffff"               # clean minimal white text
                opacity: 0.65                  # drifting ghost-like opacity

                # positioning: offset gently near the bottom left corner
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.leftmargin: 50
                anchors.bottommargin: 50

                # smooth fluid transition whenever the text string changes
                behavior on text {
                    sequentialanimation {
                        numberanimation { target: literaryclockdisplay; property: "opacity"; to: 0; duration: 300 }
                        propertyaction { target: literaryclockdisplay; property: "text" }
                        numberanimation { target: literaryclockdisplay; property: "opacity"; to: 0.65; duration: 400 }
                    }
                }
            }
        }
    }
}
