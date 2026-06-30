import qtquick
import quickshell
import quickshell.services

quickshell {
    id: root

    // properties to hold our active dynamic data streams
    property string literaryclocktext: "it is a quiet moment."
    property int audiomotionvalue: 0

    variantscreenwindow {
        id: maincanvas
        anchors.fill: parent
        
        // lock the layer transparently beneath your windows as a desktop backdrop
        color: "transparent"
        windowflags: qt.windowtransparentforinput | qt.windowdoesnotacceptfocus

        item {
            id: maincontainer
            anchors.fill: parent

            // 1. Background Engine: The Literary Clock Worker
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

            // 2. Background Engine: The Silent Audio Pipeline Listener
            process {
                id: audioworker
                command: ["/home/vivi/dotfiles/scripts/audio_listener.py"]
                running: true
                
                onstdoutreceived: (text) => {
                    let cleanvalue = parseint(text.trim());
                    if (!isnan(cleanvalue)) {
                        // clamp values to keep scaling within clean aesthetic bounds
                        audiomotionvalue = math.max(0, math.min(cleanvalue, 100));
                    }
                }
            }

            // 3. Visual UI Layer: The Poetic Text Element
            text {
                id: literaryclockdisplay
                text: root.literaryclocktext
                
                font.pointsize: 32
                font.family: "jetbrains mono"
                color: "#ffffff"
                opacity: 0.65

                // position: bottom left corner
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.leftmargin: 50
                anchors.bottommargin: 50

                behavior on text {
                    sequentialanimation {
                        numberanimation { target: literaryclockdisplay; property: "opacity"; to: 0; duration: 300 }
                        propertyaction { target: literaryclockdisplay; property: "text" }
                        numberanimation { target: literaryclockdisplay; property: "opacity"; to: 0.65; duration: 400 }
                    }
                }
            }

            // 4. Visual UI Layer: The Audio-Reactive Vector Mascot
            rectangle {
                id: mascotshape
                
                // base resting dimensions + physics injection from audio stream
                width: 80 + (root.audiomotionvalue * 1.5)
                height: 80 - (root.audiomotionvalue * 0.5)
                radius: width / 2
                
                // aesthetic colors: a muted, clean pastel accent
                color: "#a6e3a1" 
                opacity: 0.80

                // position: anchored gently right above the literary clock
                anchors.left: parent.left
                anchors.bottom: literaryclockdisplay.top
                anchors.leftmargin: 50
                anchors.bottommargin: 30

                // spring-like animation physics curves for fluid motion
                behavior on width {
                    springanimation { spring: 3.5; damping: 0.45; epsilon: 0.25 }
                }
                behavior on height {
                    springanimation { spring: 3.5; damping: 0.45; epsilon: 0.25 }
                }
            }
        }
    }
}
