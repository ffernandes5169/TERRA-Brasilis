Attribute VB_Name = "UtilsHttp"
'=== Módulo: UtilsHttp ===
Option Explicit

'---- HTTP (WinHTTP) ----
Private Function NewWinHttp() As Object
    Dim W As Object
    Set W = CreateObject("WinHttp.WinHttpRequest.5.1")
    Set NewWinHttp = W
End Function

Public Function HttpGetBytes(url As String, Optional bearer As String = "") As Byte()
    Dim http As Object: Set http = NewWinHttp()
    http.Open "GET", url, False
    If bearer <> "" Then http.SetRequestHeader "Authorization", "Bearer " & bearer
    http.Send
    If http.Status < 200 Or http.Status >= 300 Then Err.Raise vbObjectError + http.Status, , _
        "GET " & http.Status & " - " & http.StatusText & vbCrLf & CStr(http.ResponseText)
    HttpGetBytes = http.ResponseBody
End Function

Public Function HttpGetText(url As String, Optional bearer As String = "") As String
    Dim b() As Byte: b = HttpGetBytes(url, bearer)
    HttpGetText = StrConv(b, vbUnicode)
End Function

Public Function HttpPostJson(url As String, jsonBody As String, Optional bearer As String = "") As String
    Dim http As Object: Set http = NewWinHttp()
    http.Open "POST", url, False
    http.SetRequestHeader "Content-Type", "application/json"
    If bearer <> "" Then http.SetRequestHeader "Authorization", "Bearer " & bearer
    http.Send jsonBody
    If http.Status < 200 Or http.Status >= 300 Then Err.Raise vbObjectError + http.Status, , _
        "POST " & http.Status & " - " & CStr(http.ResponseText)
    HttpPostJson = CStr(http.ResponseText)
End Function

'--- LOGIN BASIC ---
Public Function HttpPostEmptyBasic(url As String, username As String, password As String) As String
    Dim http As Object: Set http = NewWinHttp()
    http.Open "POST", url, False
    http.SetRequestHeader "Authorization", "Basic " & ToBase64(username & ":" & password)
    http.SetRequestHeader "Content-Length", "0"
    http.SetRequestHeader "Accept", "application/json"
    http.Send
    If http.Status < 200 Or http.Status >= 300 Then Err.Raise vbObjectError + http.Status, , _
        "LOGIN " & http.Status & " - " & CStr(http.ResponseText)
    HttpPostEmptyBasic = CStr(http.ResponseText)
End Function

'---- Arquivos/Pastas ----
Public Sub SaveBytesToFile(bytes() As Byte, ByVal filePath As String)
    Dim h As Integer: h = FreeFile
    EnsureFolderTree filePath
    Open filePath For Binary Access Write As #h
    Put #h, , bytes
    Close #h
End Sub

Public Sub EnsureFolder(ByVal pathStr As String)
    On Error Resume Next
    MkDir pathStr
    On Error GoTo 0
End Sub

Public Sub EnsureFolderTree(ByVal fullPath As String)
    Dim p As Long, dirPath As String
    p = InStrRev(fullPath, "\")
    If p = 0 Then Exit Sub
    dirPath = Left$(fullPath, p - 1)
    Dim parts() As String, i As Long, cur As String
    parts = Split(dirPath, "\")
    cur = parts(0)
    For i = 1 To UBound(parts)
        cur = cur & "\" & parts(i)
        On Error Resume Next
        MkDir cur
        On Error GoTo 0
    Next i
End Sub

Public Function ReadTextFile(pathStr As String) As String
    Dim h As Integer: h = FreeFile
    Open pathStr For Input As #h
    ReadTextFile = Input$(LOF(h), h)
    Close #h
End Function

Public Sub WriteTextFile(pathStr As String, content As String)
    EnsureFolderTree pathStr
    Dim h As Integer: h = FreeFile
    Open pathStr For Output As #h
    Print #h, content
    Close #h
End Sub

'---- Regex helpers ----
Public Function ExtractFirst(ByVal text As String, ByVal pattern As String) As String
    Dim re As Object, m As Object
    Set re = CreateObject("VBScript.RegExp")
    re.pattern = pattern
    re.Global = False
    re.IgnoreCase = True
    Set m = re.Execute(text)
    If m.Count > 0 Then ExtractFirst = m(0).SubMatches(0)
End Function

Public Function ExtractMatches(ByVal text As String, ByVal pattern As String) As String()
    Dim re As Object, mc As Object, m As Object
    Dim tmp() As String
    Dim n As Long
    Set re = CreateObject("VBScript.RegExp")
    re.pattern = pattern
    re.Global = True
    re.IgnoreCase = True
    Set mc = re.Execute(text)
    n = -1
    For Each m In mc
        n = n + 1
        If n = 0 Then
            ReDim tmp(0 To 0)
        Else
            ReDim Preserve tmp(0 To n)
        End If
        tmp(n) = m.SubMatches(0)
    Next
    If n = -1 Then Erase tmp
    ExtractMatches = tmp
End Function

Public Function ArrCount(ByRef a() As String) As Long
    On Error GoTo vazio
    ArrCount = UBound(a) - LBound(a) + 1
    Exit Function
vazio:
    ArrCount = 0
End Function

'---- Sanitização ----
Public Function SanitizeFileName(ByVal s As String) As String
    Dim re As Object: Set re = CreateObject("VBScript.RegExp")
    re.pattern = "[<>:""/\\|?*]"
    re.Global = True
    SanitizeFileName = re.Replace(s, "_")
End Function

'---- Base64 ----
Private Function ToBase64(ByVal s As String) As String
    Dim arr() As Byte
    arr = StrConv(s, vbFromUnicode)
    Dim dom As Object, stream As Object
    Set dom = CreateObject("MSXML2.DOMDocument")
    Set stream = CreateObject("ADODB.Stream")
    stream.Type = 1: stream.Open
    stream.Write arr
    stream.Position = 0
    ToBase64 = EncodeBase64(stream)
    stream.Close
End Function

Private Function EncodeBase64(ByVal stream As Object) As String
    Dim xml As Object, node As Object
    Set xml = CreateObject("MSXML2.DOMDocument")
    Set node = xml.createElement("b64")
    node.DataType = "bin.base64"
    node.nodeTypedValue = stream.Read()
    EncodeBase64 = Replace(node.text, vbLf, "")
End Function


