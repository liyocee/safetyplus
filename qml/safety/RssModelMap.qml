import QtQuick 1.1

XmlListModel {
    id: feedModelMap
    property string xmlData:"";


     source:""
     xml: xmlData
     query: "/carto/markers/marker"
     namespaceDeclarations:  ""


     XmlRole { name: "lat"; query: "@lat/string()" }
     XmlRole { name: "lng"; query: "@lng/string()" }
     XmlRole { name: "desc"; query: "@desc/string()" }
     onStatusChanged: {
             if (status === XmlListModel.Ready) {
                 console.log("xmlModel OK - count =", count);
                 mapRect.xmlMapReady();
             }
         }



}
