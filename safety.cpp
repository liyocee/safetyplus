#include "safety.h"
#include <QDeclarativeContext>

safety::safety(QWidget *parent) : QMainWindow(parent)
{
   startLocationAPI();
   loadPreferences();

   QDeclarativeContext *ctxt2 = viewer.rootContext();
   ctxt2->setContextProperty("speed", QVariant::fromValue(speedPref));

   QDeclarativeContext *ctxt3 = viewer.rootContext();
   ctxt3->setContextProperty("distance", QVariant::fromValue(distancePref));
}


void safety::blackspotAlert(qreal latitude, qreal longitude) {
    QNetworkAccessManager *manager = new QNetworkAccessManager(this);

    QSettings settings("Safety+","Safety+");
    QString distance = settings.value("distance", "1 KM").toString();

     if(QString::compare(distance,"1KM")==0){
        distance = "1000";
    } else if (QString::compare(distance,"2KM")==0){
        distance = "2000";
    } else {
        distance = "3000";
    }
    QString str("http://safety.campomoja.com/blackspotalert.php?latitude=");
    str.append(QString("%1").arg(latitude)); str.append("&longitude="); str.append(QString("%1").arg(longitude));
    str.append("&distance="); str.append(distance);
    QUrl url(str);
    QNetworkRequest req(url);
    QNetworkReply *reply = manager->get(req);
    connect(reply, SIGNAL(finished()), this, SLOT(reply()));
}

void safety::reply()
{
   QNetworkReply *reply = qobject_cast<QNetworkReply*>(sender());
   if (reply) {
       if ((reply->error()) == QNetworkReply::NoError) {
            QString str = reply->readAll();
            if(QString::compare(str,"None")==0) {
                  //do nothing
            }else {
                QStringList blacksposts = str.split('+');
                foreach (const QString &st, blacksposts){
                    QMessageBox msgBox;
                    msgBox.setText(st);
                    msgBox.exec();
                }
            }

       } else {
           //get http status code
           int httpStatus = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt();
           QMessageBox msgBox;
           msgBox.setText(QString("httpStatusCode: %1").arg(httpStatus));
           msgBox.exec();
       }
       reply->deleteLater();
   }
}

void safety::startLocationAPI() {
    // Obtain the location data source if it is not obtained already
    if (!m_pLocationInfo)
    {
        m_pLocationInfo =
            QGeoPositionInfoSource::createDefaultSource(this);

        //Select positioning method
        m_pLocationInfo->setPreferredPositioningMethods(QGeoPositionInfoSource::NonSatellitePositioningMethods);

        // When the position is changed the positionUpdated function is called
        connect(m_pLocationInfo, SIGNAL(positionUpdated(QGeoPositionInfo)),
                      this, SLOT(positionUpdated(QGeoPositionInfo)));

        // Start listening for position updates
        m_pLocationInfo->startUpdates();
    }
}

void safety::positionUpdated(QGeoPositionInfo geoPositionInfo){
    if (geoPositionInfo.isValid())
    {
        // Get the current location coordinates
        QGeoCoordinate geoCoordinate = geoPositionInfo.coordinate();
        qreal velocity = geoPositionInfo.attribute(QGeoPositionInfo::GroundSpeed);
        qreal latitude = geoCoordinate.latitude();
        qreal longitude = geoCoordinate.longitude();

        QSettings settings("Safety+","Safety+");
        float speed = settings.value("speed", "80.0").toFloat();

        if(velocity >= speed) {
           QMessageBox msgBox;
           msgBox.setText("Warning: You are overspeeding!");
           msgBox.exec();
        }
        blackspotAlert(latitude, longitude);
    }
}

void safety::loadPreferences(){
   QSettings settings("Safety+","Safety+");
   QString distance = settings.value("distance", "1 KM").toString();
   QString speed = settings.value("speed", "80 ").toString();
   speed.append("Km/Hr");
   speedPref = speed;
   distancePref = distance;
}

void safety::savePreferences(QString sText, QString sText2){

    QSettings settings("Safety+","Safety+");
    settings.setValue("distance", sText);
    settings.setValue("speed", sText2);
    speedPref = sText;
    distancePref = sText2;

    QDeclarativeContext *ctxt2 = viewer.rootContext();
    ctxt2->setContextProperty("speed", QVariant::fromValue(speedPref));

    QDeclarativeContext *ctxt3 = viewer.rootContext();
    ctxt3->setContextProperty("distance", QVariant::fromValue(distancePref));
}
