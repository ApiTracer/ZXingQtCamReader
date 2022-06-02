/*
 * Copyright 2020 Axel Waggershauser
*/
// SPDX-License-Identifier: Apache-2.0

#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "ZXingQtReader.h"

int main(int argc, char *argv[])
{
    ZXingQt::registerQmlAndMetaTypes();

    QGuiApplication app(argc, argv);
    app.setApplicationName("ZXingQtCamReader");

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/ZXingQtCamReader/ZXingQtCamReader.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
