Attribute VB_Name = "AppEEARSFlow"
'=== Módulo: AppEEARSFlow ===
Option Explicit

Private Const API_BASE As String = "https://appeears.earthdatacloud.nasa.gov/api"

' Saída
Private Const OUT_ROOT As String = "\out"
Private Const BUNDLES_DIR As String = "\out\appeears"
Private Const LOG_FILE As String = "\out\appeears\log.txt"
Private Const TOOLS_DIR As String = "\out\tools"
Private Const FRAMES_DIR As String = "\out\frames"

' Timecodes
Private Const T00 As String = "0000"
Private Const T10 As String = "0010"
Private Const T25 As String = "0025"
Private Const T40 As String = "0040"
Private Const T65 As String = "0065"
Private Const T90 As String = "0090"
Private Const T115 As String = "0115"

' BBoxes
Private Type BBox
    W As Double: s As Double: E As Double: n As Double
End Type
Private CR As BBox, CF As BBox, BR As BBox

'============== ENTRYPOINT =============='
Public Sub Run_All()
    EnsureFolder ThisWorkbook.Path & OUT_ROOT
    EnsureFolder ThisWorkbook.Path & BUNDLES_DIR
    EnsureFolder ThisWorkbook.Path & TOOLS_DIR
    EnsureFolder ThisWorkbook.Path & FRAMES_DIR
    LogLine "=== Run_All iniciado ==="

    ' init BBoxes
    CR.W = -85.6: CR.s = 10.7: CR.E = -85.4: CR.n = 10.9
    CF.W = -82.902: CF.s = 8.831: CF.E = -82.892: CF.n = 8.841
    BR.W = -54: BR.s = -12: BR.E = -53: BR.n = -11

    ' scripts Python
    WritePythonScripts

    Dim token As String: token = GetAppEEARSBearer()

'    ' Título
'    BuildTitleCard T00, "From Waste to Forest", "Costa Rica • 12 mil t de cascas de laranja ? floresta"

    ' Costa Rica
    Dim taskCR As String: taskCR = SubmitTask(TaskJson_CR(), token)
    WaitTaskAndMakeFrames taskCR, token, "CR_orange", T10, CR, Array("2001-02-10", "2014-02-10")
'
'    ' Café
    Dim taskCF As String: taskCF = SubmitTask(TaskJson_CF(), token)
    WaitTaskAndMakeFrames taskCF, token, "CR_coffee", T25, CF, Array("2018-06-01", "2019-06-01")

    ' Brasil (cards)
    BuildTextCard T40, "Brasil: um gigante agroalimentar", "Café • Cana-de-açúcar • Laranja • Banana • Açaí"
    BuildTextCard T65, "Logística + Comunidades", "Resíduos ? compostagem local ? regeneração do solo"

    ' NASA overlay
    BuildNASAOverlay T90, "Science ? Action", CR, "2014-02-10"

    ' Fechamento
    BuildTextCard T115, "From Waste to Forest. From Forest to Future.", "Ciência, tecnologia e pessoas regenerando paisagens."

    LogLine "=== Run_All finalizado ==="
    MsgBox "Pronto! Frames em: " & ThisWorkbook.Path & FRAMES_DIR & vbCrLf & _
           "Log: " & ThisWorkbook.Path & LOG_FILE
End Sub

'============== TASK JSONs ==============
Private Function TaskJson_CR() As String
    TaskJson_CR = "{" & _
      """task_type"":""area"",""task_name"":""CR_orangecase_mod13q1""," & _
      """params"":{""dates"":[{""startDate"":""01-01-2000"",""endDate"":""12-31-2002""}," & _
      "{""startDate"":""01-01-2012"",""endDate"":""12-31-2014""}]," & _
      """layers"":[{""product"":""MOD13Q1.061"",""layer"":""_250m_16_days_NDVI""}]," & _
      """geo"":{""type"":""FeatureCollection"",""features"":[{""type"":""Feature"",""properties"":{},""geometry"":{""type"":""Polygon"",""coordinates"":[[[" & _
      CR.W & "," & CR.s & "],[" & CR.E & "," & CR.s & "],[" & CR.E & "," & CR.n & "],[" & CR.W & "," & CR.n & "],[" & CR.W & "," & CR.s & "]]]}}]}," & _
      """output"":{""format"":{""type"":""geotiff""},""projection"":""geographic""}}" & _
      "}"
End Function

Private Function TaskJson_CF() As String
    TaskJson_CF = "{" & _
      """task_type"":""area"",""task_name"":""CR_coffee_mod13q1""," & _
      """params"":{""dates"":[{""startDate"":""01-01-2018"",""endDate"":""12-31-2019""}]," & _
      """layers"":[{""product"":""MOD13Q1.061"",""layer"":""_250m_16_days_NDVI""}]," & _
      """geo"":{""type"":""FeatureCollection"",""features"":[{""type"":""Feature"",""properties"":{},""geometry"":{""type"":""Polygon"",""coordinates"":[[[" & _
      CF.W & "," & CF.s & "],[" & CF.E & "," & CF.s & "],[" & CF.E & "," & CF.n & "],[" & CF.W & "," & CF.n & "],[" & CF.W & "," & CF.s & "]]]}}]}," & _
      """output"":{""format"":{""type"":""geotiff""},""projection"":""geographic""}}" & _
      "}"
End Function

'============== SUBMIT / WAIT / DOWNLOAD / FRAMES ==============
Private Function SubmitTask(taskJson As String, token As String) As String
    Dim createResp As String
    createResp = HttpPostJson(API_BASE & "/task", taskJson, token)
    Dim taskId As String: taskId = ExtractFirst(createResp, """task_id"":\s*""([^""]+)""")
    If Len(taskId) = 0 Then Err.Raise vbObjectError + 4000, , "Sem task_id. Resp: " & createResp
    LogLine "Task criada: " & taskId
    SubmitTask = taskId
End Function

Private Sub WaitTaskAndMakeFrames(taskId As String, token As String, _
                                  taskKey As String, tsPrefix As String, _
                                  area As BBox, ByVal rgbDates As Variant)
    Dim waitSec As Long: waitSec = 5
    Dim maxWait As Long: maxWait = 5400
    Dim elapsed As Long: elapsed = 0
    Dim probe As Long: probe = 0

    Do
        Dim st As String: st = HttpGetText(API_BASE & "/status/" & taskId, token)
        Dim statusVal As String: statusVal = ExtractFirst(st, """status"":\s*""([^""]+)""")
        Dim prog As String: prog = ExtractFirst(st, """progress"":\s*([0-9]+)")
        If Len(prog) = 0 Then prog = "?"
        LogLine "Status: " & statusVal & " | progress=" & prog & "%"

        If statusVal = "done" Then
            Dim bundleId As String
            bundleId = ExtractFirst(st, """bundle_id"":\s*""([^""]+)""")
            If Len(bundleId) = 0 Then bundleId = taskId
            Dim outDir As String
            outDir = DownloadBundleAndReturnDir(bundleId, token, taskKey, tsPrefix)
            MakeStoryboardShots outDir, taskKey, tsPrefix, area, rgbDates
            Exit Sub

        ElseIf statusVal = "error" Then
            LogLine "Task erro: " & st
            Err.Raise vbObjectError + 4001, , "Task com erro: " & st
        End If

        ' sonda bundle periodicamente
        probe = probe + 1
        If probe Mod 3 = 0 Then
            Dim maybeDir As String
            maybeDir = TryProbeBundleAndMaybeDownload(taskId, token, taskKey, tsPrefix)
            If Len(maybeDir) > 0 Then
                MakeStoryboardShots maybeDir, taskKey, tsPrefix, area, rgbDates
                Exit Sub
            End If
        End If

        DoEvents
        Application.Wait Now + TimeSerial(0, 0, waitSec)
        elapsed = elapsed + waitSec
        If waitSec < 30 Then waitSec = waitSec + 5
        If elapsed >= maxWait Then
            LogLine "Timeout aguardando task."
            WriteTextFile ThisWorkbook.Path & BUNDLES_DIR & "\__last_status.json", st
            Err.Raise vbObjectError + 4002, , "Timeout aguardando task."
        End If
    Loop
End Sub

Private Function TryProbeBundleAndMaybeDownload(bundleId As String, token As String, _
                                                taskKey As String, tsPrefix As String) As String
    On Error GoTo fail
    Dim meta As String: meta = HttpGetText(API_BASE & "/bundle/" & bundleId, token)
    Dim ids() As String: ids = ExtractMatches(meta, """file_id"":\s*""([^""]+)""")
    If ArrCount(ids) > 0 Then
        TryProbeBundleAndMaybeDownload = DownloadBundleAndReturnDir(bundleId, token, taskKey, tsPrefix)
        Exit Function
    End If
    Exit Function
fail:
    TryProbeBundleAndMaybeDownload = ""
End Function

Private Function DownloadBundleAndReturnDir(bundleId As String, token As String, _
                                            taskKey As String, tsPrefix As String) As String
    Dim meta As String: meta = HttpGetText(API_BASE & "/bundle/" & bundleId, token)
    LogLine "Bundle meta carregado: " & bundleId
    Dim ids() As String, names() As String
    ids = ExtractMatches(meta, """file_id"":\s*""([^""]+)""")
    names = ExtractMatches(meta, """file_name"":\s*""([^""]+)""")
    Dim n As Long: n = ArrCount(ids)

    Dim outDir As String: outDir = ThisWorkbook.Path & BUNDLES_DIR & "\" & bundleId
    EnsureFolder outDir
    DownloadBundleAndReturnDir = outDir

    LogLine "Arquivos no bundle: " & n
    If n = 0 Then
        WriteTextFile outDir & "\__bundle_meta.json", meta
        Exit Function
    End If

    Dim i As Long
    For i = 0 To n - 1
        Dim fid As String: fid = ids(i)
        Dim fname As String
        If ArrCount(names) > i Then fname = names(i) Else fname = fid & ".dat"
        Dim b() As Byte: b = HttpGetBytes(API_BASE & "/bundle/" & bundleId & "/" & fid, token)
        Dim safeName As String: safeName = tsPrefix & "_" & taskKey & "_" & SanitizeFileName(fname)
        SaveBytesToFile b, outDir & "\" & safeName
        LogLine "Baixado: " & safeName
    Next i
End Function

'============== STORYBOARD ==============
Private Sub BuildTitleCard(ts As String, title As String, subtitle As String)
    Dim manifest As String
    manifest = "{""ops"":[{""op"":""title"",""ts"":""" & ts & """,""text"":""" & EscJson(title) & """,""sub"":""" & EscJson(subtitle) & """}]}"
    WriteTextFile ThisWorkbook.Path & TOOLS_DIR & "\manifest.json", manifest
    RunPythonCompose ThisWorkbook.Path & FRAMES_DIR, ThisWorkbook.Path & TOOLS_DIR & "\manifest.json"
End Sub

Private Sub BuildTextCard(ts As String, title As String, subtitle As String)
    Dim manifest As String
    manifest = "{""ops"":[{""op"":""card"",""ts"":""" & ts & """,""text"":""" & EscJson(title) & """,""sub"":""" & EscJson(subtitle) & """}]}"
    WriteTextFile ThisWorkbook.Path & TOOLS_DIR & "\manifest.json", manifest
    RunPythonCompose ThisWorkbook.Path & FRAMES_DIR, ThisWorkbook.Path & TOOLS_DIR & "\manifest.json"
End Sub

Private Sub MakeStoryboardShots(ByVal bundleFolder As String, ByVal taskKey As String, ByVal ts As String, _
                                area As BBox, ByVal rgbDates As Variant)
    ' 1) coloriza NDVI (gera _png dentro do bundle) — ESPERA TERMINAR
    RunPythonColorize bundleFolder

    ' 2) baixa TrueColor (1024x1024) — duas datas
    Dim i As Long, tcPath As String
    For i = LBound(rgbDates) To UBound(rgbDates)
        tcPath = ThisWorkbook.Path & FRAMES_DIR & "\" & ts & "_" & taskKey & "_truecolor_" & Replace(CStr(rgbDates(i)), "-", "") & ".png"
        GIBS_SaveTrueColor area.W, area.s, area.E, area.n, CStr(rgbDates(i)), tcPath
    Next i

    ' 3) composições: painel e overlay — ESPERA TERMINAR
    Dim pngDir As String: pngDir = bundleFolder & "\_png"
    Dim manifest As String
    manifest = "{""ops"":[" & _
        "{""op"":""panel"",""ts"":""" & ts & """,""src"":""" & EscJson(pngDir) & """}," & _
        "{""op"":""overlay"",""ts"":""" & ts & "_ov"",""src"":""" & EscJson(pngDir) & """,""bg"":""" & _
             EscJson(ThisWorkbook.Path & FRAMES_DIR & "\" & ts & "_" & taskKey & "_truecolor_" & Replace(CStr(rgbDates(UBound(rgbDates))), "-", "") & ".png") & """}" & _
        "]}"
    WriteTextFile ThisWorkbook.Path & TOOLS_DIR & "\manifest.json", manifest
    RunPythonCompose ThisWorkbook.Path & FRAMES_DIR, ThisWorkbook.Path & TOOLS_DIR & "\manifest.json"
End Sub

Private Sub BuildNASAOverlay(ts As String, label As String, area As BBox, isoDate As String)
    Dim bg As String
    bg = ThisWorkbook.Path & FRAMES_DIR & "\" & ts & "_nasa_truecolor_" & Replace(isoDate, "-", "") & ".png"
    GIBS_SaveTrueColor area.W, area.s, area.E, area.n, isoDate, bg
    Dim manifest As String
    manifest = "{""ops"":[{""op"":""label"",""ts"":""" & ts & """,""text"":""" & EscJson(label) & """}]}"
    WriteTextFile ThisWorkbook.Path & TOOLS_DIR & "\manifest.json", manifest
    RunPythonCompose ThisWorkbook.Path & FRAMES_DIR, ThisWorkbook.Path & TOOLS_DIR & "\manifest.json"
End Sub

Private Function EscJson(ByVal s As String) As String
    s = Replace(s, "\", "\\")
    s = Replace(s, """", "\""")
    EscJson = s
End Function

'============== LOG ==============
Private Sub LogLine(ByVal s As String)
    Dim f As String: f = ThisWorkbook.Path & LOG_FILE
    Dim stamp As String: stamp = Format(Now, "yyyy-mm-dd HH:nn:ss")
    Dim h As Integer: h = FreeFile
    EnsureFolder ThisWorkbook.Path & OUT_ROOT
    EnsureFolder ThisWorkbook.Path & BUNDLES_DIR
    Open f For Append As #h
    Print #h, "[" & stamp & "] " & s
    Close #h
    Debug.Print stamp
    
End Sub

'============== Python: grava e EXECUTA (com espera) ==============
Private Sub WritePythonScripts()
    WriteTextFile ThisWorkbook.Path & TOOLS_DIR & "\ndvi_colorize.py", PyColorizeNDVI()
    WriteTextFile ThisWorkbook.Path & TOOLS_DIR & "\compose_storyboard.py", PyComposeStoryboard()
    Dim req As String
    req = "rasterio" & vbCrLf & "numpy" & vbCrLf & "matplotlib" & vbCrLf & "Pillow"
    WriteTextFile ThisWorkbook.Path & TOOLS_DIR & "\requirements.txt", req
End Sub

'=== Helpers robustos para rodar Python ===
Private Function Q(ByVal s As String) As String
    Q = """" & s & """"
End Function

Private Function VenvPy() As String
    VenvPy = ThisWorkbook.Path & TOOLS_DIR & "\.venv\Scripts\python.exe"
End Function

Private Sub EnsureVenvReady()
    Dim py As String: py = VenvPy()
    Dim bat As String, batPath As String
    batPath = ThisWorkbook.Path & TOOLS_DIR & "\_prepare_venv.bat"
    
    If Dir(py) = "" Then
        ' cria venv e instala requirements apenas se ainda não existir
        bat = "cd /d " & Q(ThisWorkbook.Path & TOOLS_DIR) & vbCrLf & _
              "python -m venv .venv" & vbCrLf & _
              Q(VenvPy()) & " -m pip install -U pip" & vbCrLf & _
              Q(VenvPy()) & " -m pip install -r " & Q(ThisWorkbook.Path & TOOLS_DIR & "\requirements.txt")
        WriteTextFile batPath, bat
        RunBatAndWait batPath, "prepare_venv"
    End If
End Sub

Private Sub RunBatAndWait(batPath As String, tag As String)
    Dim sh As Object: Set sh = CreateObject("WScript.Shell")
    Dim cmd As String
    cmd = "cmd /c " & Q(batPath)
    LogLine "RUN [" & tag & "]: " & batPath
    Dim rc As Long
    rc = sh.Run(cmd, 0, True) ' 0=hidden, True=espera terminar
    If rc <> 0 Then Err.Raise vbObjectError + 5101, , "Falha ao executar " & tag & " (exit=" & rc & ")"
End Sub

Private Sub RunPythonColorize(ByVal bundleFolder As String)
    ' garante que o venv e libs existem
    EnsureVenvReady
    
    ' grava um .bat que roda o script de colorização e loga a saída
    Dim bat As String, batPath As String, outLog As String
    batPath = ThisWorkbook.Path & TOOLS_DIR & "\_run_colorize.bat"
    outLog = ThisWorkbook.Path & TOOLS_DIR & "\_run_colorize.out"
    
    bat = "cd /d " & Q(ThisWorkbook.Path & TOOLS_DIR) & vbCrLf & _
          Q(VenvPy()) & " " & Q(ThisWorkbook.Path & TOOLS_DIR & "\ndvi_colorize.py") & _
          " " & Q(bundleFolder) & " > " & Q(outLog) & " 2>&1"
    WriteTextFile batPath, bat
    
    LogLine "Executando Python (colorize)…"
    RunBatAndWait batPath, "colorize"
End Sub

Private Sub RunPythonCompose(ByVal outFrames As String, ByVal manifestPath As String)
    ' garante venv (caso seja a primeira função chamada)
    EnsureVenvReady
    
    ' instala só o que falta para o compose (rápido; pip ignora já instalados)
    Dim prep As String, prepBat As String, prepLog As String
    prepBat = ThisWorkbook.Path & TOOLS_DIR & "\_prepare_compose.bat"
    prepLog = ThisWorkbook.Path & TOOLS_DIR & "\_prepare_compose.out"
    prep = "cd /d " & Q(ThisWorkbook.Path & TOOLS_DIR) & vbCrLf & _
           Q(VenvPy()) & " -m pip install Pillow matplotlib > " & Q(prepLog) & " 2>&1"
    WriteTextFile prepBat, prep
    RunBatAndWait prepBat, "prepare_compose"
    
    ' agora roda o compositor
    Dim bat As String, batPath As String, outLog As String
    batPath = ThisWorkbook.Path & TOOLS_DIR & "\_run_compose.bat"
    outLog = ThisWorkbook.Path & TOOLS_DIR & "\_run_compose.out"
    
    bat = "cd /d " & Q(ThisWorkbook.Path & TOOLS_DIR) & vbCrLf & _
          Q(VenvPy()) & " " & Q(ThisWorkbook.Path & TOOLS_DIR & "\compose_storyboard.py") & _
          " " & Q(outFrames) & " " & Q(manifestPath) & " > " & Q(outLog) & " 2>&1"
    WriteTextFile batPath, bat
    
    LogLine "Executando Python (compose)…"
    RunBatAndWait batPath, "compose"
End Sub


'------ Python sources embedded ------
Private Function PyColorizeNDVI() As String
    Dim s As String
    s = s & "import sys, os, glob" & vbCrLf
    s = s & "import numpy as np" & vbCrLf
    s = s & "import rasterio" & vbCrLf
    s = s & "import matplotlib; matplotlib.use('Agg')" & vbCrLf
    s = s & "import matplotlib.pyplot as plt" & vbCrLf
    s = s & "from PIL import Image" & vbCrLf
    s = s & "def colorize_ndvi(arr, nodata=None):" & vbCrLf
    s = s & "  a = arr.astype('float32')" & vbCrLf
    s = s & "  if nodata is not None: a = np.where(a==nodata, np.nan, a)" & vbCrLf
    s = s & "  a = a * 0.0001" & vbCrLf
    s = s & "  a[(a<-0.2)|(a>1.0)] = np.nan" & vbCrLf
    s = s & "  cmap = plt.get_cmap('YlGn'); norm = plt.Normalize(vmin=0.0, vmax=0.8)" & vbCrLf
    s = s & "  rgba = cmap(norm(a)); rgba[...,3] = np.where(np.isnan(a),0.0,1.0)" & vbCrLf
    s = s & "  rgb = (rgba[...,:3]*255).astype('uint8'); alpha = (rgba[...,3]*255).astype('uint8')" & vbCrLf
    s = s & "  return rgb, alpha" & vbCrLf
    s = s & "def save_png(rgb, alpha, out_path):" & vbCrLf
    s = s & "  im = Image.fromarray(rgb,'RGB'); im.putalpha(Image.fromarray(alpha,'L'))" & vbCrLf
    s = s & "  os.makedirs(os.path.dirname(out_path), exist_ok=True); im.save(out_path,'PNG')" & vbCrLf
    s = s & "def process_folder(root):" & vbCrLf
    s = s & "  tifs = sorted(glob.glob(os.path.join(root,'*.tif')))" & vbCrLf
    s = s & "  out_dir = os.path.join(root,'_png'); os.makedirs(out_dir, exist_ok=True)" & vbCrLf
    s = s & "  made=[]" & vbCrLf
    s = s & "  for tif in tifs:" & vbCrLf
    s = s & "    with rasterio.open(tif) as ds: arr = ds.read(1); nd = ds.nodatavals[0]" & vbCrLf
    s = s & "    rgb, a = colorize_ndvi(arr, nd)" & vbCrLf
    s = s & "    name = os.path.splitext(os.path.basename(tif))[0]+'.png'" & vbCrLf
    s = s & "    save_png(rgb, a, os.path.join(out_dir,name)); made.append(os.path.join(out_dir,name))" & vbCrLf
    s = s & "  print('PNG NDVI gerados:', len(made))" & vbCrLf
    s = s & "if __name__=='__main__':" & vbCrLf
    s = s & "  folder = sys.argv[1] if len(sys.argv)>1 else '.'" & vbCrLf
    s = s & "  process_folder(folder)" & vbCrLf
    PyColorizeNDVI = s
End Function

Private Function PyComposeStoryboard() As String
    Dim s As String
    s = s & "import sys, os, json, glob" & vbCrLf
    s = s & "from PIL import Image, ImageDraw, ImageFont" & vbCrLf
    s = s & "FRAME_SIZE = 1024  # >=800" & vbCrLf
    s = s & "def load_font(size):" & vbCrLf
    s = s & "  try: return ImageFont.truetype('arial.ttf', size)" & vbCrLf
    s = s & "  except: return ImageFont.load_default()" & vbCrLf
    s = s & "def ensure_size(img):" & vbCrLf
    s = s & "  return img.resize((FRAME_SIZE, FRAME_SIZE), Image.NEAREST)" & vbCrLf
    s = s & "def save_card(out_path, title, sub=''):" & vbCrLf
    s = s & "  W=H=FRAME_SIZE; img=Image.new('RGB',(W,H),(15,18,20)); d=ImageDraw.Draw(img)" & vbCrLf
    s = s & "  f1=load_font(72); f2=load_font(32)" & vbCrLf
    s = s & "  w1,h1=d.textsize(title,font=f1); d.text(((W-w1)//2, H//3), title, fill=(230,255,230), font=f1)" & vbCrLf
    s = s & "  if sub: w2,h2=d.textsize(sub,font=f2); d.text(((W-w2)//2, H//3+h1+20), sub, fill=(180,200,180), font=f2)" & vbCrLf
    s = s & "  os.makedirs(os.path.dirname(out_path), exist_ok=True); img.save(out_path,'PNG')" & vbCrLf
    s = s & "def panel_from_dir(ndvi_dir, out_path):" & vbCrLf
    s = s & "  pngs = sorted(glob.glob(os.path.join(ndvi_dir,'*.png')))" & vbCrLf
    s = s & "  if len(pngs)<2: return" & vbCrLf
    s = s & "  left=Image.open(pngs[0]).convert('RGBA'); right=Image.open(pngs[-1]).convert('RGBA')" & vbCrLf
    s = s & "  left=ensure_size(left); right=ensure_size(right)" & vbCrLf
    s = s & "  H=max(left.height,right.height); W=left.width+right.width" & vbCrLf
    s = s & "  canvas=Image.new('RGBA',(W,H),(255,255,255,255)); canvas.paste(left,(0,0),left); canvas.paste(right,(left.width,0),right)" & vbCrLf
    s = s & "  os.makedirs(os.path.dirname(out_path), exist_ok=True); canvas.save(out_path,'PNG')" & vbCrLf
    s = s & "def overlay_ndvi_on_bg(ndvi_dir, bg_path, out_path):" & vbCrLf
    s = s & "  pngs = sorted(glob.glob(os.path.join(ndvi_dir,'*.png')))" & vbCrLf
    s = s & "  if not pngs: return" & vbCrLf
    s = s & "  nd = Image.open(pngs[-1]).convert('RGBA')" & vbCrLf
    s = s & "  bg = Image.open(bg_path).convert('RGBA')" & vbCrLf
    s = s & "  bg = ensure_size(bg)" & vbCrLf
    s = s & "  nd = nd.resize(bg.size, Image.NEAREST)" & vbCrLf
    s = s & "  comp = Image.alpha_composite(bg, nd)" & vbCrLf
    s = s & "  os.makedirs(os.path.dirname(out_path), exist_ok=True); comp.save(out_path,'PNG')" & vbCrLf
    s = s & "def main(out_dir, manifest_path):" & vbCrLf
    s = s & "  with open(manifest_path,'r',encoding='utf-8') as f: m=json.load(f)" & vbCrLf
    s = s & "  for op in m.get('ops',[]):" & vbCrLf
    s = s & "    ts = op.get('ts','0000'); kind = op.get('op')" & vbCrLf
    s = s & "    if kind=='title':" & vbCrLf
    s = s & "      save_card(os.path.join(out_dir,f'{ts}_title.png'), op.get('text',''), op.get('sub',''))" & vbCrLf
    s = s & "    elif kind=='card':" & vbCrLf
    s = s & "      save_card(os.path.join(out_dir,f'{ts}_card.png'), op.get('text',''), op.get('sub',''))" & vbCrLf
    s = s & "    elif kind=='panel':" & vbCrLf
    s = s & "      panel_from_dir(op['src'], os.path.join(out_dir,f'{ts}_panel_before_after.png'))" & vbCrLf
    s = s & "    elif kind=='overlay':" & vbCrLf
    s = s & "      overlay_ndvi_on_bg(op['src'], op['bg'], os.path.join(out_dir,f'{ts}_overlay_ndvi.png'))" & vbCrLf
    s = s & "    elif kind=='label':" & vbCrLf
    s = s & "      save_card(os.path.join(out_dir,f'{ts}_label.png'), op.get('text',''), '')" & vbCrLf
    s = s & "  print('Storyboard frames prontos em', out_dir)" & vbCrLf
    s = s & "if __name__=='__main__':" & vbCrLf
    s = s & "  out_dir=sys.argv[1]; manifest=sys.argv[2]; main(out_dir,manifest)" & vbCrLf
    PyComposeStoryboard = s
End Function

'=============== Utilitários públicos ===============
Public Function GetCurrentBearer() As String
    GetCurrentBearer = GetAppEEARSBearer()
End Function

Public Sub DownloadBundleById(ByVal bundleId As String, _
                              Optional ByVal taskKey As String = "manual", _
                              Optional ByVal tsPrefix As String = "0000")
    ' >>> garante .py atualizados e paleta correta
    WritePythonScripts

    Dim outDir As String
    outDir = DownloadBundleAndReturnDir(bundleId, GetAppEEARSBearer(), taskKey, tsPrefix)

    ' coloriza NDVI (espera terminar)
    RunPythonColorize outDir

    ' compõe exemplares (overlay/painel) com BG TrueColor 1024×1024
    Dim dummy As BBox: dummy.W = -85.6: dummy.s = 10.7: dummy.E = -85.4: dummy.n = 10.9
    MakeStoryboardShots outDir, taskKey, tsPrefix, dummy, Array("2014-02-10", "2014-07-10")
End Sub


