

   MEMBER('AI.clw')                                        ! This is a MEMBER module

                     MAP
                       INCLUDE('AI011.INC'),ONCE        !Local module procedure declarations
                     END


!!! <summary>
!!! Generated from procedure template - Source
!!! </summary>
MakeApiRequest       PROCEDURE  (STRING Par:url, STRING Par:method, STRING Par:Header, STRING Par:postData, *STRING Par:response) ! Declare Procedure
ClaTlk              ClaRunExtClass
httpVerbMethod      BYTE
httpWebAddress      CSTRING(512)    ! <param name="httpWebAddress"> the address to send the webRequest</param>
contentType         CSTRING(100)
requestParameters   CSTRING(512)    ! <param name="requestParameters"> parameters passed to the the webRequest appended to the http address after the ?</param>
basicUserName       CSTRING(100)
basicPassword       CSTRING(100)
headers             CSTRING(256)
postData            CSTRING(1024)   ! <param name="postData"> data passed to the webRequest when using the POST verb</param>
responseOut         CSTRING(64000)  ! <param name="responseOut"> the buffer to be filled with the response, the buffer needs to be big enough to contain the response value</param>
result              LONG

  CODE
    contentType = 'application/json'
    requestParameters = ''
    basicUserName = ''
    basicPassword = ''
    headers = Par:Header
    httpWebAddress=Par:url
    postData=Par:postData

    CASE UPPER(Par:method)
    OF 'GET'
      httpVerbMethod = HttpVerb:GET
    OF 'POST'
      httpVerbMethod = HttpVerb:POST
    OF 'PUT'
      httpVerbMethod = HttpVerb:PUT
    OF 'DELETE'
      httpVerbMethod = HttpVerb:DELETE
    ELSE
      httpVerbMethod = HttpVerb:GET  ! Default to GET
    END
    result = ClaTlk.HttpWebRequest(httpWebAddress, httpVerbMethod, postData, requestParameters, contentType, basicUserName, basicPassword, headers, responseOut)
    Par:response=responseOut
    
    RETURN result
