/* GCompris - GCButton.qml
 *
 * Copyright (C) 2020 Johnny Jazeix <jazeix@gmail.com>
 *
 * Authors:
 *   Johnny Jazeix <jazeix@gmail.com>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program; if not, see <https://www.gnu.org/licenses/>.
 */
import QtQuick 2.6
import GCompris 1.0
import QtQuick.Controls 1.5
import QtQuick.Controls.Styles 1.4

/**
 * A QML component representing GCompris' buttons.
 * @ingroup components
 *
 * @inherit QtQuick.Button
 */
Button {
    id: buttonControl

    /**
     * type:real
     * Fixed font size of the label in pt.
     *
     * Set to a value > 0 for enforcing a fixed font.pointSize for the label,
     * that won't be updated with ApplicationSettings.baseFontSize.
     * @sa ApplicationSettings.baseFontSize, GCText.fixFontSize
     */
    property real fixedFontSize: -1

    /**
     * type:string
     * theme of the button. For now, three themes are accepted: "light" and "dark" and "highContrast"
     *
     * Default is dark.
    */
    property string theme: "dark"

    /**
     * type:bool
     * if there is an icon on the right, we need to add a rightMargin for the text label
     * 
     * Default is false.
     */
    property bool haveIconRight: false

    /**
     * type:var
     * existing themes for the button.
     * A theme is composed of:
     *   the colors of the button when selected: selectedColorGradient0 and selectedColorGradient1.
     *   the colors of the button when not selected: backgroundColorGradient0 and backgroundColorGradient1.
     *   the button's border color
     *   the text color
    */
    property var themes: {
        "dark": {
            backgroundColorGradient0: "#23373737",
            selectedColorGradient0: "#C03ACAFF",
            backgroundColorGradient1: "#13373737",
            selectedColorGradient1: "#803ACAFF",
            borderColor: "#FF373737",
            textColor: "#FF373737"
        },
        "light": {
            backgroundColorGradient0: "#42FFFFFF",
            selectedColorGradient0: "#C03ACAFF",
            backgroundColorGradient1: "#23FFFFFF",
            selectedColorGradient1: "#803ACAFF",
            borderColor: "white",
            textColor: "white"
        },
        "highContrast": {
            backgroundColorGradient0: "#EEFFFFFF",
            selectedColorGradient0: "#C03ACAFF",
            backgroundColorGradient1: "#AAFFFFFF",
            selectedColorGradient1: "#803ACAFF",
            borderColor: "white",
            textColor: "#FF373737"
        },
        "categories": {
            backgroundColorGradient0: "#80F6FBFC",
            selectedColorGradient0: "#FFF6FBFC",
            backgroundColorGradient1: "#80F6FBFC",
            selectedColorGradient1: "#FFF6FBFC",
            borderColor: "#FF87A6DD",
            textColor: "#FF373737"
        },
        "settingsButton": {
            backgroundColorGradient0: "#bdbed0",
            selectedColorGradient0: "#e6e6e6",
            backgroundColorGradient1: "#bdbed0",
            selectedColorGradient1: "#e6e6e6",
            borderColor: selected ? "#ffffffff" : "#00ffffff",
            textColor: "black"
        },
        "noStyle": {
            backgroundColorGradient0: "#00FFFFFF",
            selectedColorGradient0: "#00FFFFFF",
            backgroundColorGradient1: "#00FFFFFF",
            selectedColorGradient1: "#00FFFFFF",
            borderColor: "#00FFFFFF",
            textColor: "#00000000"
        }
    }

    property bool selected: false

    property string textSize: "regular"
    
    property var textSizes: {
        "regular": {
            fontSize: 14,
            fontBold: false
        },
        "subtitle": {
            fontSize: 16,
            fontBold: true
        },
        "title": {
            fontSize: 24,
            fontBold: true
        }
    }
    
    style: ButtonStyle {
        background: Rectangle {
            border.width: theme === "settingsButton" ? 3 * ApplicationInfo.ratio : control.activeFocus ? 3 * ApplicationInfo.ratio : 1 * ApplicationInfo.ratio
            border.color: themes[theme].borderColor
            radius: 10 * ApplicationInfo.ratio
            gradient: Gradient {
                GradientStop { position: 0 ; color: (control.pressed || buttonControl.selected) ? themes[theme].selectedColorGradient0 : themes[theme].backgroundColorGradient0 }
                GradientStop { position: 1 ; color: (control.pressed || buttonControl.selected) ? themes[theme].selectedColorGradient1 : themes[theme].backgroundColorGradient1 }
            }
        }
        label: Item {
            id: labelItem
            anchors.fill: parent
            implicitWidth: labelText.implicitWidth
            implicitHeight: labelText.implicitHeight

            GCText {
                id: labelText
                color: themes[theme].textColor
                text: control.text
                fontSize: textSizes[textSize].fontSize
                font.bold: textSizes[textSize].fontBold
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.WordWrap
                fontSizeMode: Text.Fit

                Component.onCompleted: {
                    if (fixedFontSize > 0) {
                        labelText.fixFontSize = true;
                        labelText.fontSize = fixedFontSize;
                    }
                }
            }
        }
    }
}