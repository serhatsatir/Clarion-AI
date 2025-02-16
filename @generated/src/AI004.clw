

   MEMBER('AI.clw')                                        ! This is a MEMBER module


   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('AI004.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('AI001.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('AI002.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('AI003.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('AI005.INC'),ONCE        !Req'd for module callout resolution
                       INCLUDE('AI012.INC'),ONCE        !Req'd for module callout resolution
                     END


!!! <summary>
!!! Generated from procedure template - Window
!!! Window
!!! </summary>
Main PROCEDURE 

QuickWindow          WINDOW('Choose AI Engine'),AT(,,166,132),FONT('Microsoft Sans Serif',10,,FONT:regular,CHARSET:DEFAULT), |
  RESIZE,CENTER,ICON('GenericAI.ico'),GRAY,IMM,HLP('Main'),SYSTEM
                       BUTTON('Chat GPT'),AT(36,12,95,18),USE(?Button:ChatGPT),FONT(,,,FONT:bold),LEFT,ICON('chatgpt.ico'), |
  TIP('Talk using API with OpenAI''s ChatGPT-4o')
                       BUTTON('Gemini'),AT(36,83,95,18),USE(?Button:Gemini),FONT(,,,FONT:bold),LEFT,ICON('gemini.ico')
                       BUTTON('Ollama (Local GPT)'),AT(36,61,95,18),USE(?Button:Ollama),FONT(,,,FONT:bold),LEFT,ICON('ollama.ico'), |
  TIP('Talk using API with Ollama models<0DH,0AH>Ollama is free Local GPT application.')
                       BUTTON('Chat GPT (Assistant)'),AT(36,34,95,18),USE(?Button:Assistant),FONT(,,,FONT:bold),LEFT, |
  ICON('chatgpt.ico'),TIP('Talk using API with a special assistant you create with ChatGPT')
                       BUTTON('DeepSeek'),AT(36,110,95,18),USE(?Button:ChatGPT:2),FONT(,,,FONT:bold),LEFT,ICON('chatgpt.ico'), |
  TIP('Talk using API with OpenAI''s ChatGPT-4o')
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
Resizer              CLASS(WindowResizeClass)
Init                   PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)
                     END


  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('Main')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Button:ChatGPT
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  SELF.Open(QuickWindow)                                   ! Open window
  !Setting the LineHeight for every control of type LIST/DROP or COMBO in the window using the global setting.
  Do DefineListboxStyle
  Resizer.Init(AppStrategy:Surface,Resize:SetMinSize)      ! Controls like list boxes will resize, whilst controls like buttons will move
  SELF.AddItem(Resizer)                                    ! Add resizer to window manager
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
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
    CASE ACCEPTED()
    OF ?Button:Gemini
      MESSAGE('This section is not ready yet.','Gemini AI',ICON:Exclamation)
      CYCLE
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?Button:ChatGPT
      ThisWindow.Update()
      AI_ChatGPT()
      ThisWindow.Reset
    OF ?Button:Gemini
      ThisWindow.Update()
      AI_Gemini()
      ThisWindow.Reset
    OF ?Button:Ollama
      ThisWindow.Update()
      Ollama()
      ThisWindow.Reset
    OF ?Button:Assistant
      ThisWindow.Update()
      AI_ChatGPT_Assistant()
      ThisWindow.Reset
    OF ?Button:ChatGPT:2
      ThisWindow.Update()
      AI_DeepSeek()
      ThisWindow.Reset
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


Resizer.Init PROCEDURE(BYTE AppStrategy=AppStrategy:Resize,BYTE SetWindowMinSize=False,BYTE SetWindowMaxSize=False)


  CODE
  PARENT.Init(AppStrategy,SetWindowMinSize,SetWindowMaxSize)
  SELF.SetParentDefaults()                                 ! Calculate default control parent-child relationships based upon their positions on the window

