#include <QtGui/QApplication>
#include <QDeclarativeContext>
#include <QDeclarativeView>
#include "qmlapplicationviewer.h"
#include "safety.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));

    safety safe;

    QDeclarativeContext *ctxt = safe.viewer.rootContext();
    ctxt->setContextProperty("safety", &safe);

    safe.viewer.setMainQmlFile(QLatin1String("qml/safety/main.qml"));
    safe.viewer.showFullScreen();

    return app->exec();
}
