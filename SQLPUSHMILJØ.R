#### Pushing to SQL #### 

library(RMariaDB)
library(dplyr)
library(DBI)

con = dbConnect(MariaDB(),
                db = "vejrdata",
                host = "localhost",
                port = 3306,
                user = "root",
                password = "nuh-uh *svinger pegefingeren*")

#### ANHOLT ####

table.Anholt$`Målt (starttid)` = trimws(table.Anholt$`Målt (starttid)`)
table.Anholt$`Målt (starttid)` = as.POSIXct(table.Anholt$`Målt (starttid)`, format = "%d-%m-%Y %H:%M", tz = "UTC")

table.Anholt2$`Målt (starttid)` = trimws(table.Anholt2$`Målt (starttid)`)
table.Anholt2$`Målt (starttid)` = as.POSIXct(table.Anholt2$`Målt (starttid)`, format = "%d-%m-%Y %H:%M", tz = "UTC")

dbWriteTable(con, "Anholt", table.Anholt, append =T, row.names=F)
sqltable.anholt = anti_join(table.Anholt2, table.Anholt, by = "Målt (starttid)")
dbWriteTable(con, "Anholt", sqltable.anholt, append =T, row.names=F)

#### HCAB #### 

table.HCA$`Målt (starttid)` = trimws(table.HCA$`Målt (starttid)`)
table.HCA$`Målt (starttid)` = as.POSIXct(table.HCA$`Målt (starttid)`, format = "%d-%m-%Y %H:%M", tz = "UTC")

table.HCA2$`Målt (starttid)` = trimws(table.HCA2$`Målt (starttid)`)
table.HCA2$`Målt (starttid)` = as.POSIXct(table.HCA2$`Målt (starttid)`, format = "%d-%m-%Y %H:%M", tz = "UTC")

dbWriteTable(con, "HCAB", table.HCA, append =T, row.names=F)
sqltable.HCA = anti_join(table.HCA2, table.HCA, by = "Målt (starttid)")
dbWriteTable(con, "HCAB", sqltable.HCA, append =T, row.names=F)

#### Aarhus #### 

table.ah$`Målt (starttid)` = trimws(table.ah$`Målt (starttid)`)
table.ah$`Målt (starttid)` = as.POSIXct(table.ah$`Målt (starttid)`, format = "%d-%m-%Y %H:%M", tz = "UTC")

table.ah2$`Målt (starttid)` = trimws(table.ah2$`Målt (starttid)`)
table.ah2$`Målt (starttid)` = as.POSIXct(table.ah2$`Målt (starttid)`, format = "%d-%m-%Y %H:%M", tz = "UTC")

dbWriteTable(con, "Aarhus", table.ah, append =T, row.names=F)
sqltable.ah = anti_join(table.ah2, table.ah, by = "Målt (starttid)")
dbWriteTable(con, "Aarhus", sqltable.ah, append =T, row.names=F)

#### Risø #### 

table.risø$`Målt (starttid)` = trimws(table.risø$`Målt (starttid)`)
table.risø$`Målt (starttid)` = as.POSIXct(table.risø$`Målt (starttid)`, format = "%d-%m-%Y %H:%M", tz = "UTC")

table.risø2$`Målt (starttid)` = trimws(table.risø2$`Målt (starttid)`)
table.risø2$`Målt (starttid)` = as.POSIXct(table.risø2$`Målt (starttid)`, format = "%d-%m-%Y %H:%M", tz = "UTC")

dbWriteTable(con, "Risø", table.risø, append =T, row.names=F)
sqltable.risø = anti_join(table.risø2, table.risø, by = "Målt (starttid)")
dbWriteTable(con, "Risø", sqltable.risø, append =T, row.names=F)
