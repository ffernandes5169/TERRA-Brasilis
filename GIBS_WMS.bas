Attribute VB_Name = "GIBS_WMS"
'=== Módulo: GIBS_WMS ===
Option Explicit

Private Const FRAME_SIZE As Long = 1024  ' >= 800

' Baixa MODIS Terra TrueColor (WMS) p/ bbox e data (YYYY-MM-DD) em 1024x1024
Public Function GIBS_TrueColor_Get(ByVal west As Double, ByVal south As Double, _
                                   ByVal east As Double, ByVal north As Double, _
                                   ByVal isoDate As String) As Byte()
    Dim url As String
    url = "https://gibs.earthdata.nasa.gov/wms/epsg4326/best/wms.cgi?" & _
          "service=WMS&request=GetMap&version=1.3.0" & _
          "&layers=MODIS_Terra_CorrectedReflectance_TrueColor" & _
          "&styles=&format=image%2Fpng&transparent=false" & _
          "&height=" & FRAME_SIZE & "&width=" & FRAME_SIZE & "&crs=EPSG:4326" & _
          "&bbox=" & south & "," & west & "," & north & "," & east & _
          "&time=" & isoDate
    GIBS_TrueColor_Get = HttpGetBytes(url)
End Function

Public Sub GIBS_SaveTrueColor(ByVal west As Double, ByVal south As Double, _
                              ByVal east As Double, ByVal north As Double, _
                              ByVal isoDate As String, ByVal outPath As String)
    Dim b() As Byte
    b = GIBS_TrueColor_Get(west, south, east, north, isoDate)
    SaveBytesToFile b, outPath
End Sub


