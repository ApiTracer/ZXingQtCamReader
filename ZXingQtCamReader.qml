/*
 * Copyright 2020 Axel Waggershauser
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import QtQuick
//import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
//import QtQuick.Shapes
import QtMultimedia
import ZXing 1.0

Window {
    visible: true
    title: Qt.application.name

    VideoFilter {
        id: zxingFilter

        videoSink: videoOutput.videoSink

        formats: ZXing.Code128 //(oneDSwitch.checked ? (ZXing.OneDCodes) : ZXing.None) | (twoDSwitch.checked ? (ZXing.TwoDCodes) : ZXing.None)
        tryRotate: false//tryRotateSwitch.checked
        tryHarder: false//tryHarderSwitch.checked

        // callback with parameter 'result', called for every successfully processed frame
        // onFoundBarcode: {}

        // callback with parameter 'result', called for every processed frame
        onNewResult: function(result) {
            if (result.isValid)
                console.log(qsTr("Format: \t %1 \nText: \t %2 \nError: \t %3 \nTime: \t %4 ms").arg(result.formatName).arg(result.text).arg(result.status).arg(result.runTime))
        }
    }

    Camera {
        id: camera
    }

    CaptureSession{
        camera: camera
        videoOutput: videoOutput
    }


    VideoOutput {
        id: videoOutput
        anchors.fill: parent
    }
}
