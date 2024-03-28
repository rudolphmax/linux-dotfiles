import QtQuick 2.8
import QtQuick.Controls 2.8
// import QtQuick.Controls 1.4 as Q1
// import QtQuick.Controls.Styles 1.4
import SddmComponents 2.0
import "."

Rectangle {
    id : container
    LayoutMirroring.enabled : Qt.locale().textDirection == Qt.RightToLeft
    LayoutMirroring.childrenInherit : true
    property int sessionIndex : session.index
    TextConstants {
        id : textConstants
    }
    FontLoader {
        id : loginfont
        source : "ClearSans-Regular.ttf"
    }
    Connections {
        target : sddm
        onLoginSucceeded : {
            errorMessage.color = "green"
            errorMessage.text = textConstants.loginSucceeded
        }
        onLoginFailed : {
            password.text = ""
            errorMessage.color = "red"
            errorMessage.text = textConstants.loginFailed
            errorMessage.bold = true
        }
    }

    anchors.fill : parent

    Background {
        anchors.fill: parent
        source: config.background
        fillMode: Image.Stretch

        onStatusChanged: {
            if (status == Image.Error && source != config.defaultBackground) {
                source = config.defaultBackground
            }
        }
    }

    Image {
        anchors.centerIn : parent
        id : promptbox
        source : "promptbox.svg"
        width : 544
        height : 344

        Text {
            x: 7
            y: 3
            color : "white"
            text : textConstants
                .welcomeText
                .arg(sddm.hostName)
                font
                .family : loginfont.name
            font.bold : true
            font.pixelSize : 14
        }

        Column {
            id : entryColumn
            anchors.horizontalCenter : parent.horizontalCenter
            anchors.verticalCenter : parent.verticalCenter
            spacing : 4

            Row {
                topPadding: 22

                Clock2 {
                    id : clock
                    color : "#303030"
                    timeFont.family : loginfont.name
                }
            }

            Text {
                id : errorMessage
                text : textConstants.prompt
                font.pixelSize : 12
                color : "#303030"
                font.family : loginfont.name
                bottomPadding : 16
            }

            Row {
                spacing : 32
                Text {
                    id : lblLoginName
                    height : 32
                    width : 72
                    text : textConstants.userName
                    font.pixelSize : 12
                    verticalAlignment : Text.AlignVCenter
                    color : "#303030"
                    font.family : loginfont.name
                }
                TextField {
                    id : name
                    font.family : loginfont.name
                    width : 292
                    height : 32
                    text : userModel.lastUser
                    font.pixelSize : 14
                    color : "black"
                    background : Image {
                        source : "input.svg"
                    }
                    KeyNavigation.tab : password
                    Keys.onPressed : {
                        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                            password.focus = true
                            event.accepted = true
                        }
                    }
                }
            }

            Row {
                spacing : 32
                bottomPadding: 8

                Text {
                    id : lblLoginPassword
                    height : 32
                    width : 72
                    text : textConstants.password
                    verticalAlignment : Text.AlignVCenter
                    color : "#303030"
                    font.pixelSize : 12
                    font.family : loginfont.name
                }

                TextField {
                    id : password
                    font.pixelSize : 14
                    echoMode : TextInput.Password
                    font.family : loginfont.name
                    color : "black"
                    width : 292
                    height : 32

                    background : Image {
                        source : "input.svg"
                    }

                    KeyNavigation.backtab : name
                    KeyNavigation.tab : loginButton
                    focus : true

                    Keys.onPressed : {
                        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                            sddm.login(name.text, password.text, sessionIndex)
                            event.accepted = true
                        }
                    }
                }
            }

            Image {
                id : loginButton
                source : "buttonup.svg"
                height: 24
                width: 96
                anchors.right : parent.right

                MouseArea {
                    anchors.fill : parent
                    hoverEnabled : true
                    onEntered : {
                        parent.source = "buttonhover.svg"
                    }
                    onExited : {
                        parent.source = "buttonup.svg"
                    }
                    onPressed : {
                        parent.source = "buttondown.svg"
                        sddm.login(name.text, password.text, sessionIndex)
                    }
                    onReleased : {
                        parent.source = "buttonup.svg"
                    }
                }

                Text {
                    text : textConstants.login
                    anchors.centerIn : parent
                    font.family : loginfont.name
                    font.pixelSize : 12
                    color : "#303030"
                }

                KeyNavigation.backtab : password
                KeyNavigation.tab : shutdownButton
            }
        Image {
            source: "separator.svg"
            width: parent.width
            height: 12
        }

        Row {
            spacing : 32
            Text {
                id : lblSession
                height : 22
                width : 72
                text : textConstants.session
                font.pixelSize : 12
                // verticalAlignment : Text.AlignVCenter
                font.family : loginfont.name
                color : "#303030"
            }
            ComboBox {
                id : session
                color : "#f6f6f6"
                borderColor : "#808080"
                hoverColor : "#3d71a3"
                focusColor : "#3d71a3"
                textColor : "#303030"
                menuColor : "#f6f6f6"
                width : 292
                height : 22
                font.pixelSize : 12
                font.family : loginfont.name
                arrowIcon : "comboarrow.svg"
                model : sessionModel
                index : sessionModel.lastIndex
                KeyNavigation.backtab : name
                KeyNavigation.tab : password
            }
        }

        Row{
            topPadding: 12
            z: -1
            anchors.right: parent.right
            Image {
                id : shutdownButton
                source : "buttonup.svg"
                height : 24
                width: 96
                MouseArea {
                    anchors.fill : parent
                    hoverEnabled : true
                    onEntered : {
                        parent.source = "buttonhover.svg"
                    }
                    onExited : {
                        parent.source = "buttonup.svg"
                    }
                    onPressed : {
                        parent.source = "buttondown.svg"
                        sddm.powerOff()
                    }
                    onReleased : {
                        parent.source = "buttonup.svg"
                    }
                }
                Text {
                    text : textConstants.shutdown
                    anchors.centerIn : parent
                    font.family : loginfont.name
                    // font.italic : true
                    font.pixelSize : 12
                    color : "#212121"
                }
                KeyNavigation.backtab : rebootButton
                KeyNavigation.tab : shutdownButton
            }
                Image {
            id : rebootButton
            source : "buttonup.svg"
            // anchors.right : parent.right
            // anchors.verticalCenter : parent.verticalCenter
            // anchors.rightMargin : 100
            height : 24
            width: 96
            MouseArea {
                anchors.fill : parent
                hoverEnabled : true
                onEntered : {
                    parent.source = "buttonhover.svg"
                }
                onExited : {
                    parent.source = "buttonup.svg"
                }
                onPressed : {
                    parent.source = "buttondown.svg"
                    sddm.reboot()
                }
                onReleased : {
                    parent.source = "buttonup.svg"
                }
            }
            Text {
                text : textConstants.reboot
                anchors.centerIn : parent
                font.family : loginfont.name
                // font.italic : true
                font.pixelSize : 12
                color : "#212121"
            }
            KeyNavigation.backtab : password
            KeyNavigation.tab : shutdownButton
        }
        }

        }
    }
}
