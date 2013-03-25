#ifndef SAFETY_H
#define SAFETY_H

#include <QtCore>
#include <QtCore/QCoreApplication>
#include <QtGui/QMainWindow>
#include <QSettings>
#include <QString>
#include <QUrl>
#include <QtNetwork/QNetworkAccessManager>
#include <QtNetwork/QNetworkRequest>
#include <QtNetwork/QNetworkReply>
#include <QtNetwork/QtNetwork>
#include <QMessageBox>

#include <QGeoPositionInfo>
#include <QGeoPositionInfoSource>

#include "qmlapplicationviewer.h"

QTM_USE_NAMESPACE

class safety : public QMainWindow
{
    Q_OBJECT
public:
    explicit safety(QWidget *parent = 0);

    void loadPreferences();
    void startLocationAPI();
    QDeclarativeContext* context;
    QString speedPref;
    QString distancePref;
    QmlApplicationViewer viewer;

public slots:    
    void blackspotAlert(qreal latitude, qreal longitude);
    void reply();
    void positionUpdated(QGeoPositionInfo geoPositionInfo);
    void savePreferences(QString sText, QString sText2);

private:
    QGeoPositionInfoSource  *m_pLocationInfo;
};
#endif // SAFETY_H
