import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQml.Models 2.12

import CM 1.0
import "../components"
import "../../../core"
import QtQuick.Controls 2.2
import "."
import "../server.js" as Activity



Item {
    id: managePupilsView

    width: activity.width

  //  property Client newClient: masterController.ui_newClient

    Rectangle {
        anchors.fill: parent
        color: Style.colourBackground
        Text {
            anchors.centerIn: parent
            text: "Manage Pupils View"
        }
    }

    TopBanner {
        id: topBanner

        text: "Groups and pupils management"
    }

    ManageGroupsBar {
        id: pupilsNavigationBar

        anchors.top: topBanner.bottom
    }

    Rectangle {
        id: managePupilsViewRectangle

        anchors.left: pupilsNavigationBar.right
        anchors.top: topBanner.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        width: managePupilsView.width

        //color: "red"


        ColumnLayout{
            id: pupilsDetailsColumn

            spacing: 2
            anchors.top: parent.top
            width: parent.width - 10

            property int pupilNameColWidth : pupilsDetailsColumn.width/3
            property int yearOfBirthColWidth : pupilsDetailsColumn.width/8


            //pupils header
            Rectangle {
                id: pupilsHeaderRectangle

                height: 60
                width: parent.width


                RowLayout {
                    width: managePupilsViewRectangle.width - 10
                    height: parent.height

                    Rectangle {
                        id: pupilNameHeader
                        Layout.fillHeight: true
                        Layout.minimumWidth: pupilsDetailsColumn.pupilNameColWidth
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            color: Style.colourNavigationBarBackground
                            text: "Pupils Names"
                            font.bold: true
                            leftPadding: 60
                            topPadding: 20
                        }
                    }
                    Rectangle {
                        id: yearOfBirthHeader
                        Layout.fillHeight: true
                        Layout.minimumWidth: pupilsDetailsColumn.yearOfBirthColWidth     //any way to find "year of birth text width" if translations ?
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: "Year of Birth"
                            font.bold: true
                            color: Style.colourNavigationBarBackground
                            topPadding: 20
                        }
                    }
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            leftPadding: 10
                            text: "Groups"
                            font.bold: true
                            color: Style.colourNavigationBarBackground
                            topPadding: 20
                        }
                    }
                }
            }

            //pupils data
            Repeater {
                id: pupilsDetailsRepeater
                model: Activity.pupilsNamesArray

                Rectangle {
                    id: pupilDetailsRectangle
                    width: managePupilsViewRectangle.width - navigationBar.width
                    height: 40

                    //Layout.preferredHeight: 40

                    color: "blue"
                    border.color: "green"
                    border.width: 5

                    RowLayout {
                        width: parent.width
                        height: 40

                        Rectangle {
                            id: pupilName
                            Layout.fillHeight: true
                            Layout.minimumWidth: pupilsDetailsColumn.pupilNameColWidth
                            color: "transparent"
                            CheckBox {
                                text: modelData[0]
                                anchors.verticalCenter: parent.verticalCenter
                                leftPadding: 20
                            }
                        }
                        Rectangle {
                            id: yearOfBirth
                            Layout.fillHeight: true
                            Layout.minimumWidth: pupilsDetailsColumn.yearOfBirthColWidth   //any way to find "year of birth text width" if translations ?
                            color: "transparent"
                            Text {
                                id: yearText
                                text: modelData[1]
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.horizontalCenter: parent.horizontalCenter
                                color: "grey"
                            }
                        }
                        Rectangle {
                            id: groups
                            Layout.minimumWidth: 30
                            Layout.fillHeight: true
                            height: 40
                            color: "transparent"
                            Text {
                                id: elipsisText
                                text: "yy" //modelData[2]
                                leftPadding: 10
                                anchors.verticalCenter: parent.verticalCenter
                                color: "grey"
                            }
                        }
                        Rectangle {
                            id: pupilCommandOptions
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            height: 40
                            color: "transparent"
                            Text {
                                id: pupilElipsisV
                                text: "options"
                                leftPadding: 10
                                anchors.verticalCenter: parent.verticalCenter
                                color: "grey"
                            }
                        }
                    }

                    MouseArea {

                        anchors.right: pupilDetailsRectangle.right
                        anchors.top: pupilDetailsRectangle.top
                        height: pupilDetailsRectangle.height
                        width: pupilDetailsRectangle.width - 50

                        //anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {    modifyPupilCommandsRectangle.visible = true
                                        pupilDetailsRectangle.color = Style.colourPanelBackgroundHover
                        }
                        onExited: {
                                        modifyPupilCommandsRectangle.visible = false
                                        pupilDetailsRectangle.color = Style.colourBackground
                        }

                        Rectangle {
                            id: modifyPupilCommandsRectangle

                            anchors.right: parent.right
                            visible: false
                            height: pupilDetailsRow.height
                            width: 100
                            color: "transparent"

                            RowLayout {
                                id: pupilDetailsRow
                                width: parent.width
                                height: parent.height

                                Rectangle {
                                    id: editIconRectangle

                                    Layout.fillWidth: true
                                    Layout.preferredWidth: modifyPupilCommandsRectangle/2
                                    Layout.preferredHeight: editIcon.height
                                    color: "transparent"

                                    Text {
                                        id: editIcon
                                        text: "\uf304"
                                        anchors.centerIn: parent
                                        color: "grey"
                                        font {
                                            family: Style.fontAwesome
                                            pixelSize: Style.pixelSizeNavigationBarIcon / 2
                                        }
                                    }
                                    MouseArea {
                                       anchors.fill: parent
                                       hoverEnabled: true
                                       onClicked: {
                                           modifyPupilDialog.inputText = modelData[0]
                                           console.log("--" + index)
                                           modifyPupilDialog.pupilDetailsIndex = index
                                           modifyPupilDialog.open()
                                           console.log("clicked ...")
                                       }
                                       onEntered: { editIcon.color = Style.colourNavigationBarBackground }
                                       onExited: { editIcon.color = Style.colourCommandBarFontDisabled }
                                    }
                                }
                                Rectangle {
                                    Layout.preferredWidth: modifyPupilCommandsRectangle/2
                                    Layout.preferredHeight: editIcon.height
                                    Layout.fillWidth: true
                                    color: "transparent"

                                    Text {
                                        id: trashIcon
                                        text: "\uf2ed"
                                        anchors.centerIn: parent
                                        color: "grey"
                                        font {
                                            family: Style.fontAwesome
                                            pixelSize: Style.pixelSizeNavigationBarIcon / 2
                                        }
                                    }
                                    MouseArea {
                                       anchors.fill: parent
                                       hoverEnabled: true
                                       onClicked: {
                                           addAGroupText.color = Style.colourNavigationBarBackground
                                           removeGroupDialog.pupilDetailsIndex = index
                                           removeGroupDialog.open()
                                           console.log("clicked ...")
                                       }
                                       onEntered: { trashIcon.color = Style.colourNavigationBarBackground }
                                       onExited: { trashIcon.color = Style.colourCommandBarFontDisabled }
                                    }
                                }
                            }
                        }


                        AddModifyGroupDialog {
                            id: modifyPupilDialog

                            property int pupilDetailsIndex

                            label: "Modify Pupil Details"
                            inputText: "testdefault"

                            onAccepted: {
                               console.log("save.dfg..")
                               console.log(textInputValue)
                               Activity.pupilsNamesArray[pupilDetailsIndex][0] = textInputValue
                               Activity.pupilsNamesArray[pupilDetailsIndex][1] = "2004"
                               console.log(Activity.pupilsNamesArray)
                               pupilsDetailsRepeater.model = Activity.pupilsNamesArray
                               modifyPupilDialog.close()
                            }
                        }

                        AddModifyGroupDialog {
                            id: removeGroupDialog

                            property int groupNameIndex

                            label: qsTr("Are you sure you want to remove the group")
                            inputText: Activity.groupsNamesArray[groupNameIndex]

                            textInputReadOnly: true

                            onAccepted: {
                               console.log("save.dfg..")
                               console.log(textInputValue)
                               Activity.groupsNamesArray[groupNameIndex][0] = textInputValue
                               Activity.groupsNamesArray[groupNameIndex][1] = "2004"
                               console.log(Activity.groupsNamesArray)
                               pupilsDetailsRepeater.model = Activity.pupilsNamesArray
                               modifyGroupDialog.close()
                            }
                        }



                    }


                }

            }
        }


    }

    CommandBar {
        commandList: masterController.ui_commandController.ui_managePupilsViewContextCommands
    }



/*    ScrollView {
        id: scrollView
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            //bottom: commandBar.top
            margins: Style.sizeScreenMargin
        }
        clip: true

        Column {
            spacing: Style.sizeScreenMargin
            width: scrollView.width

            Panel {
                headerText: "Client Details"
                contentComponent:
                    Column {
                        spacing: Style.sizeControlSpacing
                        StringEditorSingleLine {
                            stringDecorator: newClient.ui_reference
                            anchors {
                                left: parent.left
                                right: parent.right
                            }
                        }
                        StringEditorSingleLine {
                            stringDecorator: newClient.ui_name
                            anchors {
                                left: parent.left
                                right: parent.right
                            }
                        }
                    }
            }
            AddressEditor {
                address: newClient.ui_supplyAddress
                headerText: "Supply Address"
            }
            AddressEditor {
                address: newClient.ui_billingAddress
                headerText: "Billing Address"
            }
        }
    }
*/

}
