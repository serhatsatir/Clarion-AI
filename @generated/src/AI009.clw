

   MEMBER('AI.clw')                                        ! This is a MEMBER module

                     MAP
                       INCLUDE('AI009.INC'),ONCE        !Local module procedure declarations
                     END


!!! <summary>
!!! Generated from procedure template - Source
!!! </summary>
ConvertANSIToUTF8    PROCEDURE  (*STRING AnsiString)       ! Declare Procedure
CodePageAnsi        EQUATE(125)
CP_UTF8             EQUATE(65001)
AnsiLength          LONG
Utf8Length          LONG
TempUtf8            &CSTRING

  CODE
    ! ANSI string uzunluðunu al
    AnsiLength = LEN(CLIP(AnsiString))
    Utf8Length = AnsiLength*2

    !! Gerekli UTF-8 uzunluðunu hesapla
    !Utf8Length = MultiByteToWideChar(CodePageAnsi, 0, AnsiString, AnsiLength, '', 0)
    !Utf8Length = WideCharToMultiByte(CP_UTF8, 0, ADDRESS(TempUtf8), Utf8Length, '', 0, '', '')

    ! Geçici UTF-8 buffer'ý oluþtur
    TempUtf8 &= NEW CSTRING(Utf8Length + 1)

    ! ANSI string'i geniþ karakterli string'e dönüþtür
    MultiByteToWideChar(CodePageAnsi, 0, AnsiString, AnsiLength, ADDRESS(TempUtf8), Utf8Length)

    ! Geniþ karakterli string'i UTF-8 string'e dönüþtür
    WideCharToMultiByte(CP_UTF8, 0, ADDRESS(TempUtf8), Utf8Length, TempUtf8, Utf8Length, '', '')

    ! Sonucu döndür
    RETURN CLIP(TempUtf8)
