Attribute VB_Name = "TokenManager"
'=== Módulo: TokenManager ===
Option Explicit

Private Const API_BASE As String = "https://appeears.earthdatacloud.nasa.gov/api"
Private Const TOKEN_FILE As String = "appeears_bearer.txt"
Private Const DEFAULT_USERNAME As String = ""

Public Function GetAppEEARSBearer() As String
    Dim f As String: f = ThisWorkbook.Path & "\" & TOKEN_FILE
    If Dir(f) <> "" Then
        GetAppEEARSBearer = Trim(ReadTextFile(f))
        If Len(GetAppEEARSBearer) > 0 Then Exit Function
    End If
    GetAppEEARSBearer = LoginAndStoreBearer()
End Function

Public Function ForceRefreshBearer() As String
    Dim f As String: f = ThisWorkbook.Path & "\" & TOKEN_FILE
    On Error Resume Next: If Dir(f) <> "" Then Kill f: On Error GoTo 0
    ForceRefreshBearer = LoginAndStoreBearer()
End Function

Private Function LoginAndStoreBearer() As String
    Dim usr As String, pwd As String, resp As String, tok As String
    usr = DEFAULT_USERNAME
    If Len(usr) = 0 Then usr = InputBox("Earthdata username:", "AppEEARS Login")
    If Len(usr) = 0 Then Err.Raise vbObjectError + 2101, , "Username vazio."
    pwd = InputBox("Earthdata password:", "AppEEARS Login (senha não é mascarada)")
    If Len(pwd) = 0 Then Err.Raise vbObjectError + 2102, , "Password vazio."
    resp = HttpPostEmptyBasic(API_BASE & "/login", usr, pwd)
    tok = ExtractFirst(resp, """token"":\s*""([^""]+)""")
    If Len(tok) = 0 Then Err.Raise vbObjectError + 2103, , "Login não retornou token. Resp: " & resp
    WriteTextFile ThisWorkbook.Path & "\" & TOKEN_FILE, tok
    LoginAndStoreBearer = tok
End Function

