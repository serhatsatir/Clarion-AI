

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
    ! ANSI string uzunlu�unu al
    AnsiLength = LEN(CLIP(AnsiString))
    Utf8Length = AnsiLength*2

    !! Gerekli UTF-8 uzunlu�unu hesapla
    !Utf8Length = MultiByteToWideChar(CodePageAnsi, 0, AnsiString, AnsiLength, '', 0)
    !Utf8Length = WideCharToMultiByte(CP_UTF8, 0, ADDRESS(TempUtf8), Utf8Length, '', 0, '', '')

    ! Ge�ici UTF-8 buffer'� olu�tur
    TempUtf8 &= NEW CSTRING(Utf8Length + 1)

    ! ANSI string'i geni� karakterli string'e d�n��t�r
    MultiByteToWideChar(CodePageAnsi, 0, AnsiString, AnsiLength, ADDRESS(TempUtf8), Utf8Length)

    ! Geni� karakterli string'i UTF-8 string'e d�n��t�r
    WideCharToMultiByte(CP_UTF8, 0, ADDRESS(TempUtf8), Utf8Length, TempUtf8, Utf8Length, '', '')

    ! Sonucu d�nd�r
    RETURN CLIP(TempUtf8)
