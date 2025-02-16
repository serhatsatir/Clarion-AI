

   MEMBER('AI.clw')                                        ! This is a MEMBER module


   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('AI007.INC'),ONCE        !Local module procedure declarations
                     END


!!! <summary>
!!! Generated from procedure template - Window
!!! You can talk to ChatGPT-4o from this window
!!! </summary>
AI_ChatGPT_WR PROCEDURE 

ClaTalk              ClaRunExtClass                        ! 
DynString            SystemStringClass                     ! 
Loc:ReturnValue      LONG                                  ! 
API_Key              CSTRING(81)                           ! 
API_temp             REAL(0.7)                             ! 
Talk                 BYTE                                  ! 
MyQuestion           CSTRING(5001)                         ! 
ChatGPTResponse      CSTRING(300001)                       ! 
FileName             CSTRING(261)                          ! 
Loc:URL              CSTRING(101)                          ! 
Loc:Status           CSTRING(501)                          ! 
Loc:PostString       CSTRING(50000)                        ! 
Loc:GetString        CSTRING(500000)                       ! 
Loc:RequestParameters CSTRING(51)                          ! 
Loc:ContentType      CSTRING(51)                           ! 
Loc:Headers          CSTRING(101)                          ! 
MCICommand           CSTRING(256)                          ! 
MCIReturn            CSTRING(256)                          ! 
Loc:VoiceQ           QUEUE,PRE(LVQ)                        ! 
Filename             CSTRING(261)                          ! 
SoundID              CSTRING(51)                           ! 
Duration             LONG                                  ! 
Started              TIME                                  ! 
                     END                                   ! 
Window               WINDOW('ChatGPT Example'),AT(,,386,224),FONT('Segoe UI',10,,FONT:regular),DOUBLE,CENTER,ICON('chatgpt.ico'), |
  GRAY,IMM,SYSTEM,TIMER(100)
                       BOX,AT(3,4,380,216),USE(?Box1),COLOR(COLOR:Gray),LINEWIDTH(1),ROUND
                       STRING(@s255),AT(8,205,345),USE(Loc:Status),CENTER,TRN
                       TEXT,AT(9,9,369,37),USE(MyQuestion),VSCROLL
                       TEXT,AT(9,85,369,117),USE(ChatGPTResponse),VSCROLL,COLOR(00DCDCDCh),READONLY
                       CHECK('Talk'),AT(345,72),USE(Talk),TRN
                       BUTTON('Post'),AT(328,49,50,12),USE(?GetPage),LEFT,ICON('chatgpt.ico'),TIP('Send your r' & |
  'equest to ChatGPT')
                       PROMPT('Key:'),AT(23,50),USE(?API_Key:Prompt),TRN
                       ENTRY(@s80),AT(73,50,227,10),USE(API_Key),TIP('Create your own API key using following ' & |
  'web page: https://platform.openai.com/account/api-keys<0DH,0AH,0DH,0AH>like; sk-VyUX' & |
  '.{18}5Y3aw')
                       BUTTON,AT(363,205,15,10),USE(?BUTTON:Copy),ICON(ICON:Copy),FLAT,TIP('Copy response to clipboard'), |
  TRN
                       PROMPT('Temperature:'),AT(24,64),USE(?API_temp:Prompt),TRN
                       SPIN(@n3.1),AT(73,64,,10),USE(API_temp),RIGHT(1),RANGE(0,1),STEP(0.1),TIP('* Low temper' & |
  'ature (0 to 0.3): More focused, coherent, and conservative outputs.<0DH,0AH>* Medium' & |
  ' temperature (0.3 to 0.7): Balanced creativity and coherence.<0DH,0AH>* High tempera' & |
  'ture (0.7 to 1): Highly creative and diverse, but potentially less coherent.')
                       STRING('API'),AT(7,49,,24),USE(?STRING1),FONT(,,,FONT:bold,CHARSET:DEFAULT),CENTER,ANGLE(900), |
  COLOR(00D3D3D3h)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
TakeWindowEvent        PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
! ----- st --------------------------------------------------------------------------
st                   Class(StringTheory)
                     End  ! st
! ----- end st -----------------------------------------------------------------------

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------
ReformatTextCompletion      ROUTINE
    CASE Talk 
    OF 0
    OROF 1
        DynString.SetString(MyQuestion)

        !!!Low temperature (0 to 0.3): More focused, coherent, and conservative outputs.
        !!!Medium temperature (0.3 to 0.7): Balanced creativity and coherence.
        !!!High temperature (0.7 to 1): Highly creative and diverse, but potentially less coherent.
        !Loc:PostString='{"model": "gpt-3.5-turbo","messages": [{"role": "user", "content": "'&st.GetValue()&'"}],"temperature": '&API_temp&'}'
        !Loc:PostString='{{"model": "gpt-4o","messages": [{{"role": "user", "content": "'&st.GetValue()&'"}],"temperature": '&API_temp&'}'
        DynString.Prepend('{{"model": "gpt-4o","messages": [{{"role": "user", "content": "')
        DynString.Append('"}],"temperature": '&API_temp&'}')
        !st.Trace('Request: '&st.GetValue())
        !st._StealValue(st.AnsiToUtf8(st.getValuePtr(),uz#,st:CP_ISO_8859_9))
    OF 2
        !Text Response already in memory
        !st.JsonEncode()
        !st.Prepend('{{"model": "tts-1","input": "'); st.Append('","voice": "alloy"}')
        !st.Trace('Request: '&st.GetValue())
        !st._StealValue(st.AnsiToUtf8(st.getValuePtr(),uz#,st:CP_ISO_8859_9))
    END
    
    ! Generate UTF8 from Turkish characters
    Loc:PostString=DynString.GetString()
    
GetTextMessage      ROUTINE
!    ThisWebClient.TextOnly()
!    IF ThisWebClient.ThisPage.Length() <= 0
!        Loc:Status='No response from API service.'
!        Loc:GetString = ''
!    ELSIF ThisWebClient.ThisPage.Length() < size (Loc:GetString)
!        Loc:Status='Your request has been completed.'
!        Loc:GetString = ThisWebClient.ThisPage.GetValue()
!    ELSE
!        Loc:Status = '* Incoming response ' & ThisWebClient.ThisPage.Length() & |
!            ' bytes, the part you can see on the screen ' & size (Loc:GetString) & ' bytes.'
!        Loc:GetString=ThisWebClient.ThisPage.GetValue()
!    END

    ! Generate Turkish ANSI characters from UTF8
    !st._StealValue(st.Utf8ToAnsi(Loc:GetString,uz#,st:CP_ISO_8859_9))
    !st.Trace('Response: '&st.GetValue())
    !if st.setBetween('"content": "', '"logprobs":') = st:notFound
    !if st.setBetween('"content": "', '},') = st:notFound
    !    if st.setBetween('"content": "', '"finish_reason":') = st:notFound
    !        Loc:Status='Couldn''t get legal response from ChatGPT'
    !        EXIT
    !    END
    !END
    
!    ChatGPTResponse=st.Utf8ToAnsi(Loc:GetString,uz#,st:CP_ISO_8859_9)
!    baslangic#=INSTRING('"content": "',ChatGPTResponse,1,1)
!    bitis#=INSTRING('"finish_reason": "',ChatGPTResponse,1,1)
!    IF baslangic#=0 OR bitis#=0 THEN 
!        !ChatGPTResponse=''
!        Loc:Status='Couldn''t get legal response from ChatGPT'
!        EXIT
!    END
!    st.SetValue(SUB(ChatGPTResponse,baslangic#+12,bitis#-baslangic#-29))
    
    !st.Replace('\n','<13,10>'); st.Clip(); st.JsonDecode()
    !IF Talk<2 THEN ChatGPTResponse=st.GetValue().
    DynString.SetString(Loc:GetString); DynString.UnEscape()
    !DynString.Split()
    !LOOP i#=1 TO DynString.CountLines()
    !    MESSAGE(DynString.GetLineValue(i#),'Sat�r-'&i#&'/'&DynString.CountLines())
    !END    
    
    !MESSAGE('Count:'&DynString.CountToken('content')&'|Found:'&DynString.FoundToken('content')&'|Current:'&DynString.GetCurrentToken(),'Debug-Count')
    ChatGPTResponse=DynString.GetString(); DISPLAY()
    
LetsTalk            ROUTINE
    !FileName=CLIP(st.Random(16,st:Upper+st:Lower+st:Number)&'.mp3')
    !ThisWebClient.SavePage(FileName)
    !RENAME(CLIP(FileName),CLIP(FileName)&'.mp3'); FileName=FileName&'.mp3'
    !st.Trace('Downloaded voice clip '&FileName)

    CLEAR(Loc:VoiceQ); LVQ:Filename=FileName; LVQ:SoundID='sound'&CLOCK(); ADD(Loc:VoiceQ)
    Talk=1

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('AI_ChatGPT_WR')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Box1
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  ! Restore preserved local variables from non-volatile store
  MyQuestion = INIMgr.TryFetch('AI_ChatGPT_WR_PreservedVars','MyQuestion')
  Talk = INIMgr.TryFetch('AI_ChatGPT_WR_PreservedVars','Talk')
  API_Key = INIMgr.TryFetch('AI_ChatGPT_WR_PreservedVars','API_Key')
  API_temp = INIMgr.TryFetch('AI_ChatGPT_WR_PreservedVars','API_temp')
  IF MyQuestion='' THEN MyQuestion='Could you write a lyrical poem about Clarion programming language?'.
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  SELF.Open(Window)                                        ! Open window
  !Setting the LineHeight for every control of type LIST/DROP or COMBO in the window using the global setting.
  Do DefineListboxStyle
  INIMgr.Fetch('AI_ChatGPT_WR',Window)                     ! Restore window settings from non-volatile store
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.Opened
    INIMgr.Update('AI_ChatGPT_WR',Window)                  ! Save window data to non-volatile store
  END
  ! Save preserved local variables in non-volatile store
  INIMgr.Update('AI_ChatGPT_WR_PreservedVars','MyQuestion',MyQuestion)
  INIMgr.Update('AI_ChatGPT_WR_PreservedVars','Talk',Talk)
  INIMgr.Update('AI_ChatGPT_WR_PreservedVars','API_Key',API_Key)
  INIMgr.Update('AI_ChatGPT_WR_PreservedVars','API_temp',API_temp)
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?GetPage
      ThisWindow.Update()
      IF API_Key='' THEN
          MESSAGE('Create your own API key using following web page: https://platform.openai.com/account/api-keys','ChatGPT API Key',ICON:Exclamation,,,MSGMODE:CANCOPY)
          CYCLE
      END
      
      Loc:Status = 'Waiting response...'
      SETCURSOR(CURSOR:Wait); DISPLAY()
      
      DO ReformatTextCompletion
      
      Loc:GetString=''
      CASE Talk
      OF 0
      OROF 1
          ChatGPTResponse=''
          Loc:URL='https://api.openai.com/v1/chat/completions'
      OF 2
          Loc:URL='https://api.openai.com/v1/audio/speech'
      END
      st.Trace('URL:'&Loc:URL&' Posting: '&Loc:PostString)
      Loc:RequestParameters=''
      Loc:ContentType='application/json'
      Loc:Headers='Authorization|Bearer '&API_Key
      Loc:ReturnValue=ClaTalk.HttpWebRequest(Loc:URL,HttpVerb:POST,Loc:PostString,Loc:RequestParameters,Loc:ContentType,Loc:Headers,Loc:GetString)
      
      DO GetTextMessage
      
      Loc:Status='Your request has been completed.'
      SETCURSOR(); DISPLAY()
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


ThisWindow.TakeWindowEvent PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receives all window specific events
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
    CASE EVENT()
    OF EVENT:CloseWindow
      SETCURSOR(); DISPLAY()
    END
  ReturnValue = PARENT.TakeWindowEvent()
    CASE EVENT()
    OF EVENT:Timer
      LOOP voice#=RECORDS(Loc:VoiceQ) TO 1 BY -1
          GET(Loc:VoiceQ,voice#)
          IF LVQ:Duration=0   ! Not started yet
              ! Play downloaded voice
              !https://forum.clarionlife.net/viewtopic.php?t=3031
              MCICommand = 'open "' & CLIP(LVQ:Filename) &'" alias '&LVQ:SoundID; MciSendString(MCICommand,MCIReturn,128,0)
              MCICommand = 'play '&LVQ:SoundID; MciSendString(MCICommand,MCIReturn,128,0)
              
              ! Learns the duration of the audio file and puts it on sleep mode.
              MCICommand='status '&LVQ:SoundID&' length'; MCISendString(MCICommand,MCIReturn,128,0)
              LVQ:Duration=MCIReturn/10; LVQ:Started=CLOCK(); PUT(Loc:VoiceQ)
          ELSE
              IF LVQ:Duration<CLOCK()-LVQ:Started THEN
                  MCICommand = 'stop '&LVQ:SoundID; MciSendString(MCICommand,MCIReturn,128,0)
                  MCICommand = 'close '&LVQ:SoundID; MciSendString(MCICommand,MCIReturn,128,0)
              
                  ! and remove file
                  REMOVE(LVQ:Filename)
                  DELETE(Loc:VoiceQ)
              END
          END
      END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

