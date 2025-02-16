

   MEMBER('AI.clw')                                        ! This is a MEMBER module

                     MAP
                       INCLUDE('AI008.INC'),ONCE        !Local module procedure declarations
                     END


!!! <summary>
!!! Generated from procedure template - Source
!!! </summary>
ConvertUTF8ToANSI    PROCEDURE  (STRING pUTF8String)       ! Declare Procedure
CodePageAnsi  EQUATE(125)
CP_UTF8 EQUATE(65001)
UTF8String CSTRING(25600)
ANSIString CSTRING(25600)
WideCharArray &CSTRING
CharsCopied LONG
CodePage    LONG

  CODE
    UTF8String = pUTF8String

    CharsCopied = MultiByteToWideChar(CP_UTF8, 0, UTF8String, -1, ADDRESS(WideCharArray), SIZE(WideCharArray) / 2)
    IF CharsCopied
        CharsCopied = WideCharToMultiByte(CodePageAnsi, 0, ADDRESS(WideCharArray), CharsCopied, ADDRESS(ANSIString), SIZE(ANSIString), '', '')
    END
    
    RETURN ANSIString

