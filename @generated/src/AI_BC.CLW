  MEMBER('AI.clw')

  PRAGMA('define(init_priority=>3)')

  MAP
    MODULE('AI_BC0.CLW')
AI_BC0:DctInit             PROCEDURE()
AI_BC0:DctKill             PROCEDURE()
AI_BC0:FilesInit           PROCEDURE()
    END
  END

DctInit PROCEDURE()
  CODE
  AI_BC0:DctInit
  AI_BC0:FilesInit


DctKill PROCEDURE()
  CODE
  AI_BC0:DctKill

