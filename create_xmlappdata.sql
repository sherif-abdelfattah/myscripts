create table appxmldata
(
"rec_id"                          serial not null,
"Archived-Issues"                 BIGINT,
"Archived-Issues-Total"           BIGINT,
"Archived-Projects"               BIGINT,
"Attachments"                     BIGINT,   
"Comments"                        BIGINT,
"Components"                      BIGINT,
"Custom-Fields"                   BIGINT,
"Groups"                          BIGINT,
"Individually-Archived-Issues"    BIGINT,
"Issue-Security-Levels"           BIGINT,
"Issue-Types"                     BIGINT,
"Issues"                          BIGINT,
"Issues-In-Archived-Projects"     BIGINT,
"Priorities"                      BIGINT,
"Projects"                        BIGINT,
"Resolutions"                     BIGINT,
"Screen-Schemes"                  BIGINT,
"Screens"                         BIGINT,
"Statuses"                        BIGINT,
"Users"                           BIGINT,
"Versions"                        BIGINT,
"Workflows"                       BIGINT,
"admin.systeminfo.archivedissues" BIGINT,
"admin.systeminfo.archivedprojects" BIGINT,
"admin.systeminfo.issuesarchivedindividually" BIGINT,
"admin.systeminfo.issuesinarchivedprojects" BIGINT,
"available-processors"            BIGINT,
"codecache"                       BIGINT,
"committed-virtual-memory"        BIGINT,
"free-physical-memory"            BIGINT,
"free-swap-space"                 BIGINT,
"max-file-descriptor"             BIGINT,
"max_heap"                        BIGINT,
"name"                            varchar(100),
"open-file-descriptor"            BIGINT,
"os-architecture"                 text,
"os-name"                         text,
"os-version"                      text,
"plugin_count"                    BIGINT,
"process-cpu-load"                float,
"rec_hash"                        varchar(256) not null,
"system-cpu-load"                 float,
"system-load-average"             float,
"total-physical-memory"           BIGINT,
"total-swap-space"                BIGINT,
"version"                         varchar(100),
"virtual-machine-arguments"       text
);
CREATE UNIQUE INDEX rec_hash_appxmldata ON appxmldata (rec_hash ASC);


Drop table appxmldata;
Drop index rec_hash_appxmldata;

insert into appxmldata ("Attachments","Comments","Components","Custom-Fields","Groups","Issue-Security-Levels","Issue-Types","Issues","Priorities","Projects","Resolutions","Screen-Schemes","Screens","Statuses","Users","Versions","Workflows","available-processors","codecache","committed-virtual-memory","free-physical-memory","free-swap-space","max-file-descriptor","max_heap","name","open-file-descriptor","os-architecture","os-name","os-version","plugin_count","process-cpu-load","rec_hash","system-cpu-load","system-load-average","total-physical-memory","total-swap-space","version","virtual-machine-arguments") values (670120,2348845,2695,604,493,12,244,1223179,5,383,23,252,383,102,15753,27654,126,18,245,41588699136,1516445696,4034850816,40000,768000000,'Jira',1159,'amd64','Linux','2.6.32-358.el6.x86_64',279,0.32,'4fd09bd6709e282abb438a2c70d738af52002eed',0.31,5.77,67552337920,4294959104,'7.10.2','too BIGINT to add');

insert into appxmldata ("Archived-Issues-Total","Archived-Projects","Attachments","Comments","Components","Custom-Fields","Groups","Individually-Archived-Issues","Issue-Security-Levels","Issue-Types","Issues","Issues-In-Archived-Projects","Priorities","Projects","Resolutions","Screen-Schemes","Screens","Statuses","Users","Versions","Workflows","available-processors","codecache","committed-virtual-memory","free-physical-memory","free-swap-space","max-file-descriptor","max_heap","name","open-file-descriptor","os-architecture","os-name","os-version","plugin_count","process-cpu-load","rec_hash","system-cpu-load","system-load-average","total-physical-memory","total-swap-space","version","virtual-machine-arguments") values (0,0,2672,15788,0,310,244,0,64,21,4256,0,10,8,3,21,71,53,495,0,21,16,245,23270318080,207613952,2121003008,4096,768000000,'Jira',1295,'amd64','Linux','3.10.0-862.el7.x86_64',285,0.12,'1b3d2504564b51b14787c4d231e038641e071c55',0.12,1.28,16655249408,2147479552,'8.1.0','too long to add')

select count(*) from appxmldata;


