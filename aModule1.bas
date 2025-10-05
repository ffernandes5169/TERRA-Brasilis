Attribute VB_Name = "aModule1"
Option Explicit

Sub Orquestrador_GEE_Downloader()
    Dim shell As Object
    Set shell = CreateObject("WScript.Shell")
    
    ' --- CONFIGURAÇÕES ---
    ' Altere para o caminho onde você instalou o Python (descubra no CMD com "where python")
    Const CAMINHO_PYTHON As String = "C:\Users\LowCost\AppData\Local\Programs\Python\Python313\python.exe"
    ' Altere para o caminho onde você salvou o script .py
    Const CAMINHO_SCRIPT As String = "C:\hackathon\get_gee_image.py"
    ' Altere para a pasta onde as imagens serão salvas
    Const PASTA_SAIDA As String = "C:\hackathon\imagens_gee\"
    
    ' Coordenadas do projeto
    Const LATITUDE As String = "10.839340"
    Const LONGITUDE As String = "-85.618266"
    
    ' --- PREPARA O AMBIENTE ---
    If Dir(PASTA_SAIDA, vbDirectory) = "" Then MkDir PASTA_SAIDA
    Application.ScreenUpdating = False
    
    ' --- LOOP PARA CADA ANO ---
    Dim ano As Long
    For ano = 1995 To 2025
        Dim nomeArquivo As String
        nomeArquivo = "frame_" & ano & ".jpg"
        
        ' Monta o comando que será executado no Prompt de Comando
        Dim comando As String
        comando = CAMINHO_PYTHON & " " & CAMINHO_SCRIPT & " " & ano & " " & LATITUDE & " " & LONGITUDE & " " & PASTA_SAIDA & " " & nomeArquivo
        
        Debug.Print "Executando: " & comando
        
        ' Executa o comando e espera ele terminar (o 'True' no final faz isso)
        shell.Run comando, 0, True ' O '0' esconde a janela do prompt
        
        ' Adiciona uma pequena pausa para não sobrecarregar
        Application.Wait Now + TimeSerial(0, 0, 1)
    
        VBA.DoEvents
    Next ano
    
    Application.ScreenUpdating = True
    MsgBox "Download das imagens do GEE concluído!"
    
End Sub
