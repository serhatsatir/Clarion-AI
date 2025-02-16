

   MEMBER('AI.clw')                                        ! This is a MEMBER module

                     MAP
                       INCLUDE('AI010.INC'),ONCE        !Local module procedure declarations
                       INCLUDE('AI011.INC'),ONCE        !Req'd for module callout resolution
                     END


!!! <summary>
!!! Generated from procedure template - Source
!!! </summary>
ChatGPT_Claude       PROCEDURE                             ! Declare Procedure
url             STRING(512)
method          STRING(10)
header          STRING(100)
postData        STRING(10240)
response        STRING(50000)
result          LONG
API_Key              CSTRING(81)                           ! 

  CODE
    !!! UNDER CONSTRUCTION
    url = 'https://api.openai.com/v1/chat/completions'  ! Gerçek API endpoint'i buraya gelecek
    header = 'Authorization|Bearer '&API_Key
    method = 'POST'
    !postData = '{"key": "value"}'  ! API'ye gönderilecek veri
    postData = '{{"model": "gpt-4o","messages": [{{"role": "user", "content": "Could you write a lyrical poem about Clarion programming language?"}],"temperature": 0.3}'
    result = MakeApiRequest(url, method, header, postData, response)
    
    IF result = 0
      MESSAGE('API Yanýtý: ' & response)
    ELSE
      MESSAGE('API isteði baþarýsýz oldu. Hata kodu: ' & result&'|'&response)
    END

