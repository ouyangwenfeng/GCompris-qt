/* GCompris - ActivityConfig.qml
 *
 * Copyright (C) 2019 Akshay Kumar <email.akshay98@gmail.com>
 *
 * Authors:
 *   Akshay Kumar <email.akshay98@gmail.com>
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

import "../../core"
import "qrc:/gcompris/src/core/core.js" as Core

Item {
    id: activityConfiguration
    property Item background
    property alias localeBox: localeBox
    property alias uppercaseBox: uppercaseBox
    property bool uppercaseOnly: false
    property alias speedSlider: speedSlider
    property int speedSetting: 10
    property string locale: "system"
    property string configurationLocale: "system"
    width: if(background) background.width
    height: childrenRect.height
    property alias availableLangs: langs.languages
    LanguageList {
        id: langs
    }

    Column {
        spacing: 10 * ApplicationInfo.ratio
        width: activityConfiguration.width
        GCComboBox {
            id: localeBox
            model: langs.languages
            background: activityConfiguration.background
            label: qsTr("Select your locale")
        }
        GCDialogCheckBox {
            id: uppercaseBox
            width: parent.width
            text: qsTr("Uppercase only mode")
            checked: activityConfiguration.uppercaseOnly
        }
        GCText {
            id: speedSliderText
            text: qsTr("Speed")
            fontSize: mediumSize
            wrapMode: Text.WordWrap
        }
        GCSlider {
            id: speedSlider
            width: 250 * ApplicationInfo.ratio
            value: speedSetting
            maximumValue: 10
            minimumValue: 1
            scrollEnabled: false
        }
    }

    function setLocale(localeToSet) {
        // Store the locale as-is to be displayed in menu
        configurationLocale = localeToSet
        activityConfiguration.locale = Core.resolveLocale(localeToSet)
    }

    property var dataToSave
    function setDefaultValues() {
        // Recreate the binding
        uppercaseBox.checked = Qt.binding(function(){return activityConfiguration.uppercaseOnly;})
        speedSlider.value = Qt.binding(function() {return activityConfiguration.speedSetting;})

        var localeUtf8 = dataToSave.locale;
        if(localeUtf8 !== "system") {
            localeUtf8 += ".UTF-8";
        }

        if(dataToSave.locale) {
            setLocale(localeUtf8)
        }
        else {
            activityConfiguration.localeBox.currentIndex = 0
            setLocale(activityConfiguration.availableLangs[0].locale)
        }

        for(var i = 0 ; i < activityConfiguration.availableLangs.length ; i ++) {
            if(activityConfiguration.availableLangs[i].locale === localeUtf8) {
                activityConfiguration.localeBox.currentIndex = i;
                break;
            }
        }

        activityConfiguration.uppercaseOnly = (dataToSave.uppercaseMode === "true")
        if(dataToSave.speedSetting) {
            activityConfiguration.speedSetting = dataToSave.speedSetting
        }
        else {
            activityConfiguration.speedSetting = 10
        }
    }

    function saveValues() {
        var newLocale = activityConfiguration.availableLangs[activityConfiguration.localeBox.currentIndex].locale;
        // Remove .UTF-8
        if(newLocale.indexOf('.') != -1) {
            newLocale = newLocale.substring(0, newLocale.indexOf('.'))
        }

        activityConfiguration.uppercaseOnly = activityConfiguration.uppercaseBox.checked

        speedSetting = speedSlider.value

        setLocale(newLocale);
        dataToSave = {"locale": newLocale, "uppercaseMode": "" + activityConfiguration.uppercaseOnly, "speedSetting": speedSetting, "activityLocale": activityConfiguration.locale}
    }
}
