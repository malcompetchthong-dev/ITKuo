local KuoHub = {}

-- Services
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

-- =========================
-- ICONS
-- =========================
local Icons = (function()
	return {
		["accessibility"] = "rbxassetid://10709751939",
		["activity"] = "rbxassetid://10709752035",
		["airvent"] = "rbxassetid://10709752131",
		["airplay"] = "rbxassetid://10709752254",
		["alarmcheck"] = "rbxassetid://10709752405",
		["alarmclock"] = "rbxassetid://10709752630",
		["alarmclockoff"] = "rbxassetid://10709752508",
		["alarmminus"] = "rbxassetid://10709752732",
		["alarmplus"] = "rbxassetid://10709752825",
		["album"] = "rbxassetid://10709752906",
		["alertcircle"] = "rbxassetid://10709752996",
		["alertoctagon"] = "rbxassetid://10709753064",
		["alerttriangle"] = "rbxassetid://10709753149",
		["aligncenter"] = "rbxassetid://10709753570",
		["aligncenterhorizontal"] = "rbxassetid://10709753272",
		["aligncentervertical"] = "rbxassetid://10709753421",
		["alignendhorizontal"] = "rbxassetid://10709753692",
		["alignendvertical"] = "rbxassetid://10709753808",
		["alignhorizontaldistributecenter"] = "rbxassetid://10747779791",
		["alignhorizontaldistributeend"] = "rbxassetid://10747784534",
		["alignhorizontaldistributestart"] = "rbxassetid://10709754118",
		["alignhorizontaljustifycenter"] = "rbxassetid://10709754204",
		["alignhorizontaljustifyend"] = "rbxassetid://10709754317",
		["alignhorizontaljustifystart"] = "rbxassetid://10709754436",
		["alignhorizontalspacearound"] = "rbxassetid://10709754590",
		["alignhorizontalspacebetween"] = "rbxassetid://10709754749",
		["alignjustify"] = "rbxassetid://10709759610",
		["alignleft"] = "rbxassetid://10709759764",
		["alignright"] = "rbxassetid://10709759895",
		["alignstarthorizontal"] = "rbxassetid://10709760051",
		["alignstartvertical"] = "rbxassetid://10709760244",
		["alignverticaldistributecenter"] = "rbxassetid://10709760351",
		["alignverticaldistributeend"] = "rbxassetid://10709760434",
		["alignverticaldistributestart"] = "rbxassetid://10709760612",
		["alignverticaljustifycenter"] = "rbxassetid://10709760814",
		["alignverticaljustifyend"] = "rbxassetid://10709761003",
		["alignverticaljustifystart"] = "rbxassetid://10709761176",
		["alignverticalspacearound"] = "rbxassetid://10709761324",
		["alignverticalspacebetween"] = "rbxassetid://10709761434",
		["anchor"] = "rbxassetid://10709761530",
		["angry"] = "rbxassetid://10709761629",
		["annoyed"] = "rbxassetid://10709761722",
		["aperture"] = "rbxassetid://10709761813",
		["apple"] = "rbxassetid://10709761889",
		["archive"] = "rbxassetid://10709762233",
		["archiverestore"] = "rbxassetid://10709762058",
		["armchair"] = "rbxassetid://10709762327",
		["arrowbigdown"] = "rbxassetid://10747796644",
		["arrowbigleft"] = "rbxassetid://10709762574",
		["arrowbigright"] = "rbxassetid://10709762727",
		["arrowbigup"] = "rbxassetid://10709762879",
		["arrowdown"] = "rbxassetid://10709767827",
		["arrowdowncircle"] = "rbxassetid://10709763034",
		["arrowdownleft"] = "rbxassetid://10709767656",
		["arrowdownright"] = "rbxassetid://10709767750",
		["arrowleft"] = "rbxassetid://10709768114",
		["arrowleftcircle"] = "rbxassetid://10709767936",
		["arrowleftright"] = "rbxassetid://10709768019",
		["arrowright"] = "rbxassetid://10709768347",
		["arrowrightcircle"] = "rbxassetid://10709768226",
		["arrowup"] = "rbxassetid://10709768939",
		["arrowupcircle"] = "rbxassetid://10709768432",
		["arrowupdown"] = "rbxassetid://10709768538",
		["arrowupleft"] = "rbxassetid://10709768661",
		["arrowupright"] = "rbxassetid://10709768787",
		["asterisk"] = "rbxassetid://10709769095",
		["atsign"] = "rbxassetid://10709769286",
		["award"] = "rbxassetid://10709769406",
		["axe"] = "rbxassetid://10709769508",
		["axis3d"] = "rbxassetid://10709769598",
		["baby"] = "rbxassetid://10709769732",
		["backpack"] = "rbxassetid://10709769841",
		["baggageclaim"] = "rbxassetid://10709769935",
		["banana"] = "rbxassetid://10709770005",
		["banknote"] = "rbxassetid://10709770178",
		["barchart"] = "rbxassetid://10709773755",
		["barchart2"] = "rbxassetid://10709770317",
		["barchart3"] = "rbxassetid://10709770431",
		["barchart4"] = "rbxassetid://10709770560",
		["barcharthorizontal"] = "rbxassetid://10709773669",
		["barcode"] = "rbxassetid://10747360675",
		["baseline"] = "rbxassetid://10709773863",
		["bath"] = "rbxassetid://10709773963",
		["battery"] = "rbxassetid://10709774640",
		["batterycharging"] = "rbxassetid://10709774068",
		["batteryfull"] = "rbxassetid://10709774206",
		["batterylow"] = "rbxassetid://10709774370",
		["batterymedium"] = "rbxassetid://10709774513",
		["beaker"] = "rbxassetid://10709774756",
		["bed"] = "rbxassetid://10709775036",
		["beddouble"] = "rbxassetid://10709774864",
		["bedsingle"] = "rbxassetid://10709774968",
		["beer"] = "rbxassetid://10709775167",
		["bell"] = "rbxassetid://10709775704",
		["bellminus"] = "rbxassetid://10709775241",
		["belloff"] = "rbxassetid://10709775320",
		["bellplus"] = "rbxassetid://10709775448",
		["bellring"] = "rbxassetid://10709775560",
		["bike"] = "rbxassetid://10709775894",
		["binary"] = "rbxassetid://10709776050",
		["bitcoin"] = "rbxassetid://10709776126",
		["bluetooth"] = "rbxassetid://10709776655",
		["bluetoothconnected"] = "rbxassetid://10709776240",
		["bluetoothoff"] = "rbxassetid://10709776344",
		["bluetoothsearching"] = "rbxassetid://10709776501",
		["bold"] = "rbxassetid://10747813908",
		["bomb"] = "rbxassetid://10709781460",
		["bone"] = "rbxassetid://10709781605",
		["book"] = "rbxassetid://10709781824",
		["bookopen"] = "rbxassetid://10709781717",
		["bookmark"] = "rbxassetid://10709782154",
		["bookmarkminus"] = "rbxassetid://10709781919",
		["bookmarkplus"] = "rbxassetid://10709782044",
		["bot"] = "rbxassetid://10709782230",
		["box"] = "rbxassetid://10709782497",
		["boxselect"] = "rbxassetid://10709782342",
		["boxes"] = "rbxassetid://10709782582",
		["briefcase"] = "rbxassetid://10709782662",
		["brush"] = "rbxassetid://10709782758",
		["bug"] = "rbxassetid://10709782845",
		["building"] = "rbxassetid://10709783051",
		["building2"] = "rbxassetid://10709782939",
		["bus"] = "rbxassetid://10709783137",
		["cake"] = "rbxassetid://10709783217",
		["calculator"] = "rbxassetid://10709783311",
		["calendar"] = "rbxassetid://10709789505",
		["calendarcheck"] = "rbxassetid://10709783474",
		["calendarcheck2"] = "rbxassetid://10709783392",
		["calendarclock"] = "rbxassetid://10709783577",
		["calendardays"] = "rbxassetid://10709783673",
		["calendarheart"] = "rbxassetid://10709783835",
		["calendarminus"] = "rbxassetid://10709783959",
		["calendaroff"] = "rbxassetid://10709788784",
		["calendarplus"] = "rbxassetid://10709788937",
		["calendarrange"] = "rbxassetid://10709789053",
		["calendarsearch"] = "rbxassetid://10709789200",
		["calendarx"] = "rbxassetid://10709789407",
		["calendarx2"] = "rbxassetid://10709789329",
		["camera"] = "rbxassetid://10709789686",
		["cameraoff"] = "rbxassetid://10747822677",
		["car"] = "rbxassetid://10709789810",
		["carrot"] = "rbxassetid://10709789960",
		["cast"] = "rbxassetid://10709790097",
		["charge"] = "rbxassetid://10709790202",
		["check"] = "rbxassetid://10709790644",
		["checkcircle"] = "rbxassetid://10709790387",
		["checkcircle2"] = "rbxassetid://10709790298",
		["checksquare"] = "rbxassetid://10709790537",
		["chefhat"] = "rbxassetid://10709790757",
		["cherry"] = "rbxassetid://10709790875",
		["chevrondown"] = "rbxassetid://10709790948",
		["chevronfirst"] = "rbxassetid://10709791015",
		["chevronlast"] = "rbxassetid://10709791130",
		["chevronleft"] = "rbxassetid://10709791281",
		["chevronright"] = "rbxassetid://10709791437",
		["chevronup"] = "rbxassetid://10709791523",
		["chevronsdown"] = "rbxassetid://10709796864",
		["chevronsdownup"] = "rbxassetid://10709791632",
		["chevronsleft"] = "rbxassetid://10709797151",
		["chevronsleftright"] = "rbxassetid://10709797006",
		["chevronsright"] = "rbxassetid://10709797382",
		["chevronsrightleft"] = "rbxassetid://10709797274",
		["chevronsup"] = "rbxassetid://10709797622",
		["chevronsupdown"] = "rbxassetid://10709797508",
		["chrome"] = "rbxassetid://10709797725",
		["circle"] = "rbxassetid://10709798174",
		["circledot"] = "rbxassetid://10709797837",
		["circleellipsis"] = "rbxassetid://10709797985",
		["circleslashed"] = "rbxassetid://10709798100",
		["citrus"] = "rbxassetid://10709798276",
		["clapperboard"] = "rbxassetid://10709798350",
		["clipboard"] = "rbxassetid://10709799288",
		["clipboardcheck"] = "rbxassetid://10709798443",
		["clipboardcopy"] = "rbxassetid://10709798574",
		["clipboardedit"] = "rbxassetid://10709798682",
		["clipboardlist"] = "rbxassetid://10709798792",
		["clipboardsignature"] = "rbxassetid://10709798890",
		["clipboardtype"] = "rbxassetid://10709798999",
		["clipboardx"] = "rbxassetid://10709799124",
		["clock"] = "rbxassetid://10709805144",
		["clock1"] = "rbxassetid://10709799535",
		["clock10"] = "rbxassetid://10709799718",
		["clock11"] = "rbxassetid://10709799818",
		["clock12"] = "rbxassetid://10709799962",
		["clock2"] = "rbxassetid://10709803876",
		["clock3"] = "rbxassetid://10709803989",
		["clock4"] = "rbxassetid://10709804164",
		["clock5"] = "rbxassetid://10709804291",
		["clock6"] = "rbxassetid://10709804435",
		["clock7"] = "rbxassetid://10709804599",
		["clock8"] = "rbxassetid://10709804784",
		["clock9"] = "rbxassetid://10709804996",
		["cloud"] = "rbxassetid://10709806740",
		["cloudcog"] = "rbxassetid://10709805262",
		["clouddrizzle"] = "rbxassetid://10709805371",
		["cloudfog"] = "rbxassetid://10709805477",
		["cloudhail"] = "rbxassetid://10709805596",
		["cloudlightning"] = "rbxassetid://10709805727",
		["cloudmoon"] = "rbxassetid://10709805942",
		["cloudmoonrain"] = "rbxassetid://10709805838",
		["cloudoff"] = "rbxassetid://10709806060",
		["cloudrain"] = "rbxassetid://10709806277",
		["cloudrainwind"] = "rbxassetid://10709806166",
		["cloudsnow"] = "rbxassetid://10709806374",
		["cloudsun"] = "rbxassetid://10709806631",
		["cloudsunrain"] = "rbxassetid://10709806475",
		["cloudy"] = "rbxassetid://10709806859",
		["clover"] = "rbxassetid://10709806995",
		["code"] = "rbxassetid://10709810463",
		["code2"] = "rbxassetid://10709807111",
		["codepen"] = "rbxassetid://10709810534",
		["codesandbox"] = "rbxassetid://10709810676",
		["coffee"] = "rbxassetid://10709810814",
		["cog"] = "rbxassetid://10709810948",
		["coins"] = "rbxassetid://10709811110",
		["columns"] = "rbxassetid://10709811261",
		["command"] = "rbxassetid://10709811365",
		["compass"] = "rbxassetid://10709811445",
		["component"] = "rbxassetid://10709811595",
		["conciergebell"] = "rbxassetid://10709811706",
		["connection"] = "rbxassetid://10747361219",
		["contact"] = "rbxassetid://10709811834",
		["contrast"] = "rbxassetid://10709811939",
		["cookie"] = "rbxassetid://10709812067",
		["copy"] = "rbxassetid://10709812159",
		["copyleft"] = "rbxassetid://10709812251",
		["copyright"] = "rbxassetid://10709812311",
		["cornerdownleft"] = "rbxassetid://10709812396",
		["cornerdownright"] = "rbxassetid://10709812485",
		["cornerleftdown"] = "rbxassetid://10709812632",
		["cornerleftup"] = "rbxassetid://10709812784",
		["cornerrightdown"] = "rbxassetid://10709812939",
		["cornerrightup"] = "rbxassetid://10709813094",
		["cornerupleft"] = "rbxassetid://10709813185",
		["cornerupright"] = "rbxassetid://10709813281",
		["cpu"] = "rbxassetid://10709813383",
		["croissant"] = "rbxassetid://10709818125",
		["crop"] = "rbxassetid://10709818245",
		["cross"] = "rbxassetid://10709818399",
		["crosshair"] = "rbxassetid://10709818534",
		["crown"] = "rbxassetid://10709818626",
		["cupsoda"] = "rbxassetid://10709818763",
		["curlybraces"] = "rbxassetid://10709818847",
		["currency"] = "rbxassetid://10709818931",
		["database"] = "rbxassetid://10709818996",
		["delete"] = "rbxassetid://10709819059",
		["diamond"] = "rbxassetid://10709819149",
		["dice1"] = "rbxassetid://10709819266",
		["dice2"] = "rbxassetid://10709819361",
		["dice3"] = "rbxassetid://10709819508",
		["dice4"] = "rbxassetid://10709819670",
		["dice5"] = "rbxassetid://10709819801",
		["dice6"] = "rbxassetid://10709819896",
		["dices"] = "rbxassetid://10723343321",
		["diff"] = "rbxassetid://10723343416",
		["disc"] = "rbxassetid://10723343537",
		["divide"] = "rbxassetid://10723343805",
		["dividecircle"] = "rbxassetid://10723343636",
		["dividesquare"] = "rbxassetid://10723343737",
		["dollarsign"] = "rbxassetid://10723343958",
		["download"] = "rbxassetid://10723344270",
		["downloadcloud"] = "rbxassetid://10723344088",
		["droplet"] = "rbxassetid://10723344432",
		["droplets"] = "rbxassetid://10734883356",
		["drumstick"] = "rbxassetid://10723344737",
		["edit"] = "rbxassetid://10734883598",
		["edit2"] = "rbxassetid://10723344885",
		["edit3"] = "rbxassetid://10723345088",
		["egg"] = "rbxassetid://10723345518",
		["eggfried"] = "rbxassetid://10723345347",
		["electricity"] = "rbxassetid://10723345749",
		["electricityoff"] = "rbxassetid://10723345643",
		["equal"] = "rbxassetid://10723345990",
		["equalnot"] = "rbxassetid://10723345866",
		["eraser"] = "rbxassetid://10723346158",
		["euro"] = "rbxassetid://10723346372",
		["expand"] = "rbxassetid://10723346553",
		["externallink"] = "rbxassetid://10723346684",
		["eye"] = "rbxassetid://10723346959",
		["eyeoff"] = "rbxassetid://10723346871",
		["factory"] = "rbxassetid://10723347051",
		["fan"] = "rbxassetid://10723354359",
		["fastforward"] = "rbxassetid://10723354521",
		["feather"] = "rbxassetid://10723354671",
		["figma"] = "rbxassetid://10723354801",
		["file"] = "rbxassetid://10723374641",
		["filearchive"] = "rbxassetid://10723354921",
		["fileaudio"] = "rbxassetid://10723355148",
		["fileaudio2"] = "rbxassetid://10723355026",
		["fileaxis3d"] = "rbxassetid://10723355272",
		["filebadge"] = "rbxassetid://10723355622",
		["filebadge2"] = "rbxassetid://10723355451",
		["filebarchart"] = "rbxassetid://10723355887",
		["filebarchart2"] = "rbxassetid://10723355746",
		["filebox"] = "rbxassetid://10723355989",
		["filecheck"] = "rbxassetid://10723356210",
		["filecheck2"] = "rbxassetid://10723356100",
		["fileclock"] = "rbxassetid://10723356329",
		["filecode"] = "rbxassetid://10723356507",
		["filecog"] = "rbxassetid://10723356830",
		["filecog2"] = "rbxassetid://10723356676",
		["filediff"] = "rbxassetid://10723357039",
		["filedigit"] = "rbxassetid://10723357151",
		["filedown"] = "rbxassetid://10723357322",
		["fileedit"] = "rbxassetid://10723357495",
		["fileheart"] = "rbxassetid://10723357637",
		["fileimage"] = "rbxassetid://10723357790",
		["fileinput"] = "rbxassetid://10723357933",
		["filejson"] = "rbxassetid://10723364435",
		["filejson2"] = "rbxassetid://10723364361",
		["filekey"] = "rbxassetid://10723364605",
		["filekey2"] = "rbxassetid://10723364515",
		["filelinechart"] = "rbxassetid://10723364725",
		["filelock"] = "rbxassetid://10723364957",
		["filelock2"] = "rbxassetid://10723364861",
		["fileminus"] = "rbxassetid://10723365254",
		["fileminus2"] = "rbxassetid://10723365086",
		["fileoutput"] = "rbxassetid://10723365457",
		["filepiechart"] = "rbxassetid://10723365598",
		["fileplus"] = "rbxassetid://10723365877",
		["fileplus2"] = "rbxassetid://10723365766",
		["filequestion"] = "rbxassetid://10723365987",
		["filescan"] = "rbxassetid://10723366167",
		["filesearch"] = "rbxassetid://10723366550",
		["filesearch2"] = "rbxassetid://10723366340",
		["filesignature"] = "rbxassetid://10723366741",
		["filespreadsheet"] = "rbxassetid://10723366962",
		["filesymlink"] = "rbxassetid://10723367098",
		["fileterminal"] = "rbxassetid://10723367244",
		["filetext"] = "rbxassetid://10723367380",
		["filetype"] = "rbxassetid://10723367606",
		["filetype2"] = "rbxassetid://10723367509",
		["fileup"] = "rbxassetid://10723367734",
		["filevideo"] = "rbxassetid://10723373884",
		["filevideo2"] = "rbxassetid://10723367834",
		["filevolume"] = "rbxassetid://10723374172",
		["filevolume2"] = "rbxassetid://10723374030",
		["filewarning"] = "rbxassetid://10723374276",
		["filex"] = "rbxassetid://10723374544",
		["filex2"] = "rbxassetid://10723374378",
		["files"] = "rbxassetid://10723374759",
		["film"] = "rbxassetid://10723374981",
		["filter"] = "rbxassetid://10723375128",
		["fingerprint"] = "rbxassetid://10723375250",
		["flag"] = "rbxassetid://10723375890",
		["flagoff"] = "rbxassetid://10723375443",
		["flagtriangleleft"] = "rbxassetid://10723375608",
		["flagtriangleright"] = "rbxassetid://10723375727",
		["flame"] = "rbxassetid://10723376114",
		["flashlight"] = "rbxassetid://10723376471",
		["flashlightoff"] = "rbxassetid://10723376365",
		["flaskconical"] = "rbxassetid://10734883986",
		["flaskround"] = "rbxassetid://10723376614",
		["fliphorizontal"] = "rbxassetid://10723376884",
		["fliphorizontal2"] = "rbxassetid://10723376745",
		["flipvertical"] = "rbxassetid://10723377138",
		["flipvertical2"] = "rbxassetid://10723377026",
		["flower"] = "rbxassetid://10747830374",
		["flower2"] = "rbxassetid://10723377305",
		["focus"] = "rbxassetid://10723377537",
		["folder"] = "rbxassetid://10723387563",
		["folderarchive"] = "rbxassetid://10723384478",
		["foldercheck"] = "rbxassetid://10723384605",
		["folderclock"] = "rbxassetid://10723384731",
		["folderclosed"] = "rbxassetid://10723384893",
		["foldercog"] = "rbxassetid://10723385213",
		["foldercog2"] = "rbxassetid://10723385036",
		["folderdown"] = "rbxassetid://10723385338",
		["folderedit"] = "rbxassetid://10723385445",
		["folderheart"] = "rbxassetid://10723385545",
		["folderinput"] = "rbxassetid://10723385721",
		["folderkey"] = "rbxassetid://10723385848",
		["folderlock"] = "rbxassetid://10723386005",
		["folderminus"] = "rbxassetid://10723386127",
		["folderopen"] = "rbxassetid://10723386277",
		["folderoutput"] = "rbxassetid://10723386386",
		["folderplus"] = "rbxassetid://10723386531",
		["foldersearch"] = "rbxassetid://10723386787",
		["foldersearch2"] = "rbxassetid://10723386674",
		["foldersymlink"] = "rbxassetid://10723386930",
		["foldertree"] = "rbxassetid://10723387085",
		["folderup"] = "rbxassetid://10723387265",
		["folderx"] = "rbxassetid://10723387448",
		["folders"] = "rbxassetid://10723387721",
		["forminput"] = "rbxassetid://10723387841",
		["forward"] = "rbxassetid://10723388016",
		["frame"] = "rbxassetid://10723394389",
		["framer"] = "rbxassetid://10723394565",
		["frown"] = "rbxassetid://10723394681",
		["fuel"] = "rbxassetid://10723394846",
		["functionsquare"] = "rbxassetid://10723395041",
		["gamepad"] = "rbxassetid://10723395457",
		["gamepad2"] = "rbxassetid://10723395215",
		["gauge"] = "rbxassetid://10723395708",
		["gavel"] = "rbxassetid://10723395896",
		["gem"] = "rbxassetid://10723396000",
		["ghost"] = "rbxassetid://10723396107",
		["gift"] = "rbxassetid://10723396402",
		["giftcard"] = "rbxassetid://10723396225",
		["gitbranch"] = "rbxassetid://10723396676",
		["gitbranchplus"] = "rbxassetid://10723396542",
		["gitcommit"] = "rbxassetid://10723396812",
		["gitcompare"] = "rbxassetid://10723396954",
		["gitfork"] = "rbxassetid://10723397049",
		["gitmerge"] = "rbxassetid://10723397165",
		["gitpullrequest"] = "rbxassetid://10723397431",
		["gitpullrequestclosed"] = "rbxassetid://10723397268",
		["gitpullrequestdraft"] = "rbxassetid://10734884302",
		["glass"] = "rbxassetid://10723397788",
		["glass2"] = "rbxassetid://10723397529",
		["glasswater"] = "rbxassetid://10723397678",
		["glasses"] = "rbxassetid://10723397895",
		["globe"] = "rbxassetid://10723404337",
		["globe2"] = "rbxassetid://10723398002",
		["grab"] = "rbxassetid://10723404472",
		["graduationcap"] = "rbxassetid://10723404691",
		["grape"] = "rbxassetid://10723404822",
		["grid"] = "rbxassetid://10723404936",
		["griphorizontal"] = "rbxassetid://10723405089",
		["gripvertical"] = "rbxassetid://10723405236",
		["hammer"] = "rbxassetid://10723405360",
		["hand"] = "rbxassetid://10723405649",
		["handmetal"] = "rbxassetid://10723405508",
		["harddrive"] = "rbxassetid://10723405749",
		["hardhat"] = "rbxassetid://10723405859",
		["hash"] = "rbxassetid://10723405975",
		["haze"] = "rbxassetid://10723406078",
		["headphones"] = "rbxassetid://10723406165",
		["heart"] = "rbxassetid://10723406885",
		["heartcrack"] = "rbxassetid://10723406299",
		["hearthandshake"] = "rbxassetid://10723406480",
		["heartoff"] = "rbxassetid://10723406662",
		["heartpulse"] = "rbxassetid://10723406795",
		["helpcircle"] = "rbxassetid://10723406988",
		["hexagon"] = "rbxassetid://10723407092",
		["highlighter"] = "rbxassetid://10723407192",
		["history"] = "rbxassetid://10723407335",
		["home"] = "rbxassetid://10723407389",
		["hourglass"] = "rbxassetid://10723407498",
		["icecream"] = "rbxassetid://10723414308",
		["image"] = "rbxassetid://10723415040",
		["imageminus"] = "rbxassetid://10723414487",
		["imageoff"] = "rbxassetid://10723414677",
		["imageplus"] = "rbxassetid://10723414827",
		["import"] = "rbxassetid://10723415205",
		["inbox"] = "rbxassetid://10723415335",
		["indent"] = "rbxassetid://10723415494",
		["indianrupee"] = "rbxassetid://10723415642",
		["infinity"] = "rbxassetid://10723415766",
		["info"] = "rbxassetid://10723415903",
		["inspect"] = "rbxassetid://10723416057",
		["italic"] = "rbxassetid://10723416195",
		["japaneseyen"] = "rbxassetid://10723416363",
		["joystick"] = "rbxassetid://10723416527",
		["key"] = "rbxassetid://10723416652",
		["keyboard"] = "rbxassetid://10723416765",
		["lamp"] = "rbxassetid://10723417513",
		["lampceiling"] = "rbxassetid://10723416922",
		["lampdesk"] = "rbxassetid://10723417016",
		["lampfloor"] = "rbxassetid://10723417131",
		["lampwalldown"] = "rbxassetid://10723417240",
		["lampwallup"] = "rbxassetid://10723417356",
		["landmark"] = "rbxassetid://10723417608",
		["languages"] = "rbxassetid://10723417703",
		["laptop"] = "rbxassetid://10723423881",
		["laptop2"] = "rbxassetid://10723417797",
		["lasso"] = "rbxassetid://10723424235",
		["lassoselect"] = "rbxassetid://10723424058",
		["laugh"] = "rbxassetid://10723424372",
		["layers"] = "rbxassetid://10723424505",
		["layout"] = "rbxassetid://10723425376",
		["layoutdashboard"] = "rbxassetid://10723424646",
		["layoutgrid"] = "rbxassetid://10723424838",
		["layoutlist"] = "rbxassetid://10723424963",
		["layouttemplate"] = "rbxassetid://10723425187",
		["leaf"] = "rbxassetid://10723425539",
		["library"] = "rbxassetid://10723425615",
		["lifebuoy"] = "rbxassetid://10723425685",
		["lightbulb"] = "rbxassetid://10723425852",
		["lightbulboff"] = "rbxassetid://10723425762",
		["linechart"] = "rbxassetid://10723426393",
		["link"] = "rbxassetid://10723426722",
		["link2"] = "rbxassetid://10723426595",
		["link2off"] = "rbxassetid://10723426513",
		["list"] = "rbxassetid://10723433811",
		["listchecks"] = "rbxassetid://10734884548",
		["listend"] = "rbxassetid://10723426886",
		["listminus"] = "rbxassetid://10723426986",
		["listmusic"] = "rbxassetid://10723427081",
		["listordered"] = "rbxassetid://10723427199",
		["listplus"] = "rbxassetid://10723427334",
		["liststart"] = "rbxassetid://10723427494",
		["listvideo"] = "rbxassetid://10723427619",
		["listx"] = "rbxassetid://10723433655",
		["loader"] = "rbxassetid://10723434070",
		["loader2"] = "rbxassetid://10723433935",
		["locate"] = "rbxassetid://10723434557",
		["locatefixed"] = "rbxassetid://10723434236",
		["locateoff"] = "rbxassetid://10723434379",
		["lock"] = "rbxassetid://10723434711",
		["login"] = "rbxassetid://10723434830",
		["logout"] = "rbxassetid://10723434906",
		["luggage"] = "rbxassetid://10723434993",
		["magnet"] = "rbxassetid://10723435069",
		["mail"] = "rbxassetid://10734885430",
		["mailcheck"] = "rbxassetid://10723435182",
		["mailminus"] = "rbxassetid://10723435261",
		["mailopen"] = "rbxassetid://10723435342",
		["mailplus"] = "rbxassetid://10723435443",
		["mailquestion"] = "rbxassetid://10723435515",
		["mailsearch"] = "rbxassetid://10734884739",
		["mailwarning"] = "rbxassetid://10734885015",
		["mailx"] = "rbxassetid://10734885247",
		["mails"] = "rbxassetid://10734885614",
		["map"] = "rbxassetid://10734886202",
		["mappin"] = "rbxassetid://10734886004",
		["mappinoff"] = "rbxassetid://10734885803",
		["maximize"] = "rbxassetid://10734886735",
		["maximize2"] = "rbxassetid://10734886496",
		["medal"] = "rbxassetid://10734887072",
		["megaphone"] = "rbxassetid://10734887454",
		["megaphoneoff"] = "rbxassetid://10734887311",
		["meh"] = "rbxassetid://10734887603",
		["menu"] = "rbxassetid://10734887784",
		["messagecircle"] = "rbxassetid://10734888000",
		["messagesquare"] = "rbxassetid://10734888228",
		["mic"] = "rbxassetid://10734888864",
		["mic2"] = "rbxassetid://10734888430",
		["micoff"] = "rbxassetid://10734888646",
		["microscope"] = "rbxassetid://10734889106",
		["microwave"] = "rbxassetid://10734895076",
		["milestone"] = "rbxassetid://10734895310",
		["minimize"] = "rbxassetid://10734895698",
		["minimize2"] = "rbxassetid://10734895530",
		["minus"] = "rbxassetid://10734896206",
		["minuscircle"] = "rbxassetid://10734895856",
		["minussquare"] = "rbxassetid://10734896029",
		["monitor"] = "rbxassetid://10734896881",
		["monitoroff"] = "rbxassetid://10734896360",
		["monitorspeaker"] = "rbxassetid://10734896512",
		["moon"] = "rbxassetid://10734897102",
		["morehorizontal"] = "rbxassetid://10734897250",
		["morevertical"] = "rbxassetid://10734897387",
		["mountain"] = "rbxassetid://10734897956",
		["mountainsnow"] = "rbxassetid://10734897665",
		["mouse"] = "rbxassetid://10734898592",
		["mousepointer"] = "rbxassetid://10734898476",
		["mousepointer2"] = "rbxassetid://10734898194",
		["mousepointerclick"] = "rbxassetid://10734898355",
		["move"] = "rbxassetid://10734900011",
		["move3d"] = "rbxassetid://10734898756",
		["movediagonal"] = "rbxassetid://10734899164",
		["movediagonal2"] = "rbxassetid://10734898934",
		["movehorizontal"] = "rbxassetid://10734899414",
		["movevertical"] = "rbxassetid://10734899821",
		["music"] = "rbxassetid://10734905958",
		["music2"] = "rbxassetid://10734900215",
		["music3"] = "rbxassetid://10734905665",
		["music4"] = "rbxassetid://10734905823",
		["navigation"] = "rbxassetid://10734906744",
		["navigation2"] = "rbxassetid://10734906332",
		["navigation2off"] = "rbxassetid://10734906144",
		["navigationoff"] = "rbxassetid://10734906580",
		["network"] = "rbxassetid://10734906975",
		["newspaper"] = "rbxassetid://10734907168",
		["octagon"] = "rbxassetid://10734907361",
		["option"] = "rbxassetid://10734907649",
		["outdent"] = "rbxassetid://10734907933",
		["package"] = "rbxassetid://10734909540",
		["package2"] = "rbxassetid://10734908151",
		["packagecheck"] = "rbxassetid://10734908384",
		["packageminus"] = "rbxassetid://10734908626",
		["packageopen"] = "rbxassetid://10734908793",
		["packageplus"] = "rbxassetid://10734909016",
		["packagesearch"] = "rbxassetid://10734909196",
		["packagex"] = "rbxassetid://10734909375",
		["paintbucket"] = "rbxassetid://10734909847",
		["paintbrush"] = "rbxassetid://10734910187",
		["paintbrush2"] = "rbxassetid://10734910030",
		["palette"] = "rbxassetid://10734910430",
		["palmtree"] = "rbxassetid://10734910680",
		["paperclip"] = "rbxassetid://10734910927",
		["partypopper"] = "rbxassetid://10734918735",
		["pause"] = "rbxassetid://10734919336",
		["pausecircle"] = "rbxassetid://10735024209",
		["pauseoctagon"] = "rbxassetid://10734919143",
		["pentool"] = "rbxassetid://10734919503",
		["pencil"] = "rbxassetid://10734919691",
		["percent"] = "rbxassetid://10734919919",
		["personstanding"] = "rbxassetid://10734920149",
		["phone"] = "rbxassetid://10734921524",
		["phonecall"] = "rbxassetid://10734920305",
		["phoneforwarded"] = "rbxassetid://10734920508",
		["phoneincoming"] = "rbxassetid://10734920694",
		["phonemissed"] = "rbxassetid://10734920845",
		["phoneoff"] = "rbxassetid://10734921077",
		["phoneoutgoing"] = "rbxassetid://10734921288",
		["piechart"] = "rbxassetid://10734921727",
		["piggybank"] = "rbxassetid://10734921935",
		["pin"] = "rbxassetid://10734922324",
		["pinoff"] = "rbxassetid://10734922180",
		["pipette"] = "rbxassetid://10734922497",
		["pizza"] = "rbxassetid://10734922774",
		["plane"] = "rbxassetid://10734922971",
		["play"] = "rbxassetid://10734923549",
		["playcircle"] = "rbxassetid://10734923214",
		["plus"] = "rbxassetid://10734924532",
		["pluscircle"] = "rbxassetid://10734923868",
		["plussquare"] = "rbxassetid://10734924219",
		["podcast"] = "rbxassetid://10734929553",
		["pointer"] = "rbxassetid://10734929723",
		["poundsterling"] = "rbxassetid://10734929981",
		["power"] = "rbxassetid://10734930466",
		["poweroff"] = "rbxassetid://10734930257",
		["printer"] = "rbxassetid://10734930632",
		["puzzle"] = "rbxassetid://10734930886",
		["quote"] = "rbxassetid://10734931234",
		["radio"] = "rbxassetid://10734931596",
		["radioreceiver"] = "rbxassetid://10734931402",
		["rectanglehorizontal"] = "rbxassetid://10734931777",
		["rectanglevertical"] = "rbxassetid://10734932081",
		["recycle"] = "rbxassetid://10734932295",
		["redo"] = "rbxassetid://10734932822",
		["redo2"] = "rbxassetid://10734932586",
		["refreshccw"] = "rbxassetid://10734933056",
		["refreshcw"] = "rbxassetid://10734933222",
		["refrigerator"] = "rbxassetid://10734933465",
		["regex"] = "rbxassetid://10734933655",
		["repeat"] = "rbxassetid://10734933966",
		["repeat1"] = "rbxassetid://10734933826",
		["reply"] = "rbxassetid://10734934252",
		["replyall"] = "rbxassetid://10734934132",
		["rewind"] = "rbxassetid://10734934347",
		["rocket"] = "rbxassetid://10734934585",
		["rockingchair"] = "rbxassetid://10734939942",
		["rotate3d"] = "rbxassetid://10734940107",
		["rotateccw"] = "rbxassetid://10734940376",
		["rotatecw"] = "rbxassetid://10734940654",
		["rss"] = "rbxassetid://10734940825",
		["ruler"] = "rbxassetid://10734941018",
		["russianruble"] = "rbxassetid://10734941199",
		["sailboat"] = "rbxassetid://10734941354",
		["save"] = "rbxassetid://10734941499",
		["scale"] = "rbxassetid://10734941912",
		["scale3d"] = "rbxassetid://10734941739",
		["scaling"] = "rbxassetid://10734942072",
		["scan"] = "rbxassetid://10734942565",
		["scanface"] = "rbxassetid://10734942198",
		["scanline"] = "rbxassetid://10734942351",
		["scissors"] = "rbxassetid://10734942778",
		["screenshare"] = "rbxassetid://10734943193",
		["screenshareoff"] = "rbxassetid://10734942967",
		["scroll"] = "rbxassetid://10734943448",
		["search"] = "rbxassetid://10734943674",
		["send"] = "rbxassetid://10734943902",
		["separatorhorizontal"] = "rbxassetid://10734944115",
		["separatorvertical"] = "rbxassetid://10734944326",
		["server"] = "rbxassetid://10734949856",
		["servercog"] = "rbxassetid://10734944444",
		["servercrash"] = "rbxassetid://10734944554",
		["serveroff"] = "rbxassetid://10734944668",
		["settings"] = "rbxassetid://10734950309",
		["settings2"] = "rbxassetid://10734950020",
		["share"] = "rbxassetid://10734950813",
		["share2"] = "rbxassetid://10734950553",
		["sheet"] = "rbxassetid://10734951038",
		["shield"] = "rbxassetid://10734951847",
		["shieldalert"] = "rbxassetid://10734951173",
		["shieldcheck"] = "rbxassetid://10734951367",
		["shieldclose"] = "rbxassetid://10734951535",
		["shieldoff"] = "rbxassetid://10734951684",
		["shirt"] = "rbxassetid://10734952036",
		["shoppingbag"] = "rbxassetid://10734952273",
		["shoppingcart"] = "rbxassetid://10734952479",
		["shovel"] = "rbxassetid://10734952773",
		["showerhead"] = "rbxassetid://10734952942",
		["shrink"] = "rbxassetid://10734953073",
		["shrub"] = "rbxassetid://10734953241",
		["shuffle"] = "rbxassetid://10734953451",
		["sidebar"] = "rbxassetid://10734954301",
		["sidebarclose"] = "rbxassetid://10734953715",
		["sidebaropen"] = "rbxassetid://10734954000",
		["sigma"] = "rbxassetid://10734954538",
		["signal"] = "rbxassetid://10734961133",
		["signalhigh"] = "rbxassetid://10734954807",
		["signallow"] = "rbxassetid://10734955080",
		["signalmedium"] = "rbxassetid://10734955336",
		["signalzero"] = "rbxassetid://10734960878",
		["siren"] = "rbxassetid://10734961284",
		["skipback"] = "rbxassetid://10734961526",
		["skipforward"] = "rbxassetid://10734961809",
		["skull"] = "rbxassetid://10734962068",
		["slack"] = "rbxassetid://10734962339",
		["slash"] = "rbxassetid://10734962600",
		["slice"] = "rbxassetid://10734963024",
		["sliders"] = "rbxassetid://10734963400",
		["slidershorizontal"] = "rbxassetid://10734963191",
		["smartphone"] = "rbxassetid://10734963940",
		["smartphonecharging"] = "rbxassetid://10734963671",
		["smile"] = "rbxassetid://10734964441",
		["smileplus"] = "rbxassetid://10734964188",
		["snowflake"] = "rbxassetid://10734964600",
		["sofa"] = "rbxassetid://10734964852",
		["sortasc"] = "rbxassetid://10734965115",
		["sortdesc"] = "rbxassetid://10734965287",
		["speaker"] = "rbxassetid://10734965419",
		["sprout"] = "rbxassetid://10734965572",
		["square"] = "rbxassetid://10734965702",
		["star"] = "rbxassetid://10734966248",
		["starhalf"] = "rbxassetid://10734965897",
		["staroff"] = "rbxassetid://10734966097",
		["stethoscope"] = "rbxassetid://10734966384",
		["sticker"] = "rbxassetid://10734972234",
		["stickynote"] = "rbxassetid://10734972463",
		["stopcircle"] = "rbxassetid://10734972621",
		["stretchhorizontal"] = "rbxassetid://10734972862",
		["stretchvertical"] = "rbxassetid://10734973130",
		["strikethrough"] = "rbxassetid://10734973290",
		["subscript"] = "rbxassetid://10734973457",
		["sun"] = "rbxassetid://10734974297",
		["sundim"] = "rbxassetid://10734973645",
		["sunmedium"] = "rbxassetid://10734973778",
		["sunmoon"] = "rbxassetid://10734973999",
		["sunsnow"] = "rbxassetid://10734974130",
		["sunrise"] = "rbxassetid://10734974522",
		["sunset"] = "rbxassetid://10734974689",
		["superscript"] = "rbxassetid://10734974850",
		["swissfranc"] = "rbxassetid://10734975024",
		["switchcamera"] = "rbxassetid://10734975214",
		["sword"] = "rbxassetid://10734975486",
		["swords"] = "rbxassetid://10734975692",
		["syringe"] = "rbxassetid://10734975932",
		["table"] = "rbxassetid://10734976230",
		["table2"] = "rbxassetid://10734976097",
		["tablet"] = "rbxassetid://10734976394",
		["tag"] = "rbxassetid://10734976528",
		["tags"] = "rbxassetid://10734976739",
		["target"] = "rbxassetid://10734977012",
		["tent"] = "rbxassetid://10734981750",
		["terminal"] = "rbxassetid://10734982144",
		["terminalsquare"] = "rbxassetid://10734981995",
		["textcursor"] = "rbxassetid://10734982395",
		["textcursorinput"] = "rbxassetid://10734982297",
		["thermometer"] = "rbxassetid://10734983134",
		["thermometersnowflake"] = "rbxassetid://10734982571",
		["thermometersun"] = "rbxassetid://10734982771",
		["thumbsdown"] = "rbxassetid://10734983359",
		["thumbsup"] = "rbxassetid://10734983629",
		["ticket"] = "rbxassetid://10734983868",
		["timer"] = "rbxassetid://10734984606",
		["timeroff"] = "rbxassetid://10734984138",
		["timerreset"] = "rbxassetid://10734984355",
		["toggleleft"] = "rbxassetid://10734984834",
		["toggleright"] = "rbxassetid://10734985040",
		["tornado"] = "rbxassetid://10734985247",
		["toybrick"] = "rbxassetid://10747361919",
		["train"] = "rbxassetid://10747362105",
		["trash"] = "rbxassetid://10747362393",
		["trash2"] = "rbxassetid://10747362241",
		["treedeciduous"] = "rbxassetid://10747362534",
		["treepine"] = "rbxassetid://10747362748",
		["trees"] = "rbxassetid://10747363016",
		["trendingdown"] = "rbxassetid://10747363205",
		["trendingup"] = "rbxassetid://10747363465",
		["triangle"] = "rbxassetid://10747363621",
		["trophy"] = "rbxassetid://10747363809",
		["truck"] = "rbxassetid://10747364031",
		["tv"] = "rbxassetid://10747364593",
		["tv2"] = "rbxassetid://10747364302",
		["type"] = "rbxassetid://10747364761",
		["umbrella"] = "rbxassetid://10747364971",
		["underline"] = "rbxassetid://10747365191",
		["undo"] = "rbxassetid://10747365484",
		["undo2"] = "rbxassetid://10747365359",
		["unlink"] = "rbxassetid://10747365771",
		["unlink2"] = "rbxassetid://10747397871",
		["unlock"] = "rbxassetid://10747366027",
		["upload"] = "rbxassetid://10747366434",
		["uploadcloud"] = "rbxassetid://10747366266",
		["usb"] = "rbxassetid://10747366606",
		["user"] = "rbxassetid://10747373176",
		["usercheck"] = "rbxassetid://10747371901",
		["usercog"] = "rbxassetid://10747372167",
		["userminus"] = "rbxassetid://10747372346",
		["userplus"] = "rbxassetid://10747372702",
		["userx"] = "rbxassetid://10747372992",
		["users"] = "rbxassetid://10747373426",
		["utensils"] = "rbxassetid://10747373821",
		["utensilscrossed"] = "rbxassetid://10747373629",
		["venetianmask"] = "rbxassetid://10747374003",
		["verified"] = "rbxassetid://10747374131",
		["vibrate"] = "rbxassetid://10747374489",
		["vibrateoff"] = "rbxassetid://10747374269",
		["video"] = "rbxassetid://10747374938",
		["videooff"] = "rbxassetid://10747374721",
		["view"] = "rbxassetid://10747375132",
		["voicemail"] = "rbxassetid://10747375281",
		["volume"] = "rbxassetid://10747376008",
		["volume1"] = "rbxassetid://10747375450",
		["volume2"] = "rbxassetid://10747375679",
		["volumex"] = "rbxassetid://10747375880",
		["wallet"] = "rbxassetid://10747376205",
		["wand"] = "rbxassetid://10747376565",
		["wand2"] = "rbxassetid://10747376349",
		["watch"] = "rbxassetid://10747376722",
		["waves"] = "rbxassetid://10747376931",
		["webcam"] = "rbxassetid://10747381992",
		["wifi"] = "rbxassetid://10747382504",
		["wifioff"] = "rbxassetid://10747382268",
		["wind"] = "rbxassetid://10747382750",
		["wraptext"] = "rbxassetid://10747383065",
		["wrench"] = "rbxassetid://10747383470",
		["x"] = "rbxassetid://10747384394",
		["xcircle"] = "rbxassetid://10747383819",
		["xoctagon"] = "rbxassetid://10747384037",
		["xsquare"] = "rbxassetid://10747384217",
		["zoomin"] = "rbxassetid://10747384552",
		["zoomout"] = "rbxassetid://10747384679"
	}
end)()
-- =========================
-- RESPONSIVE ENGINE v3
-- =========================
local Responsive = {}
Responsive.BaseResolution = Vector2.new(1920,1080)
Responsive.Scale = 1
Responsive.Items = {}
Responsive.Layouts = {}
Responsive.Scrolls = {}
Responsive.Window = nil
Responsive.Positions = {}
Responsive.ThemeObjects = {}
Responsive.ViewportConnection = nil

function Responsive:GetViewport()
	local Camera = workspace.CurrentCamera
	if not Camera then return Vector2.new(1920,1080) end
	return Camera.ViewportSize
end

function Responsive:GetScale()
	local Viewport = self:GetViewport()
	local WidthScale = Viewport.X / self.BaseResolution.X
	local HeightScale = Viewport.Y / self.BaseResolution.Y
	return math.clamp(math.min(WidthScale, HeightScale), 0.72, 1.35)
end

function Responsive:GetFont(Size)
	return math.clamp(math.floor(Size * self.Scale), 12, 36)
end

function Responsive:IsMobile()
	return self:GetViewport().X < 900
end

function Responsive:IsTablet()
	local W = self:GetViewport().X
	return W >= 900 and W < 1400
end

function Responsive:IsPC()
	return self:GetViewport().X >= 1400
end

function Responsive:Register(Object, Data)
	if not Object then return end
	Data = Data or {}
	for _,v in ipairs(self.Items) do
		if v.Object == Object then return end
	end
	table.insert(self.Items, {
		Object = Object,
		Size = Data.Size,
		Position = Data.Position,
		TextSize = Data.TextSize,
		Corner = Data.Corner,
		Radius = Data.Radius,
		Stroke = Data.Stroke,
		Thickness = Data.Thickness,
		Padding = Data.Padding,
		Left = Data.Left,
		Right = Data.Right,
		Top = Data.Top,
		Bottom = Data.Bottom,
		Icon = Data.Icon,
		IconSize = Data.IconSize
	})
end

function Responsive:Auto(Object)
	if not Object then return Object end
	local Data = {}
	if Object:IsA("GuiObject") then
		Data.Size = Object.Size
		Data.Position = Object.Position
	end
	if Object:IsA("TextLabel") or Object:IsA("TextButton") or Object:IsA("TextBox") then
		Data.TextSize = Object.TextSize
	end
	if Object:IsA("ImageLabel") or Object:IsA("ImageButton") then
		Data.Icon = Object
		Data.IconSize = Object.Size
	end
	local Corner = Object:FindFirstChildOfClass("UICorner")
	if Corner then
		Data.Corner = Corner
		Data.Radius = Corner.CornerRadius.Offset
	end
	local Stroke = Object:FindFirstChildOfClass("UIStroke")
	if Stroke then
		Data.Stroke = Stroke
		Data.Thickness = Stroke.Thickness
	end
	local Padding = Object:FindFirstChildOfClass("UIPadding")
	if Padding then
		Data.Padding = Padding
		Data.Left = Padding.PaddingLeft.Offset
		Data.Right = Padding.PaddingRight.Offset
		Data.Top = Padding.PaddingTop.Offset
		Data.Bottom = Padding.PaddingBottom.Offset
	end
	self:Register(Object, Data)
	return Object
end

function Responsive:Remove(Object)
	for i = #self.Layouts, 1, -1 do
		if self.Layouts[i].Layout == Object then table.remove(self.Layouts, i) end
	end
	for i = #self.Scrolls, 1, -1 do
		if self.Scrolls[i].Object == Object then table.remove(self.Scrolls, i) end
	end
	for i = #self.Positions, 1, -1 do
		if self.Positions[i].Object == Object then table.remove(self.Positions, i) end
	end
	for i = #self.ThemeObjects, 1, -1 do
		if self.ThemeObjects[i].Object == Object then table.remove(self.ThemeObjects, i) end
	end
	for i,v in ipairs(self.Items) do
		if v.Object == Object then
			table.remove(self.Items, i)
			break
		end
	end
end

function Responsive:Clear()
	table.clear(self.Items)
	table.clear(self.Layouts)
	table.clear(self.Scrolls)
	table.clear(self.Positions)
	table.clear(self.ThemeObjects)
	if self.ViewportConnection then
		self.ViewportConnection:Disconnect()
		self.ViewportConnection = nil
	end
	self.Window = nil
	self.Scale = 1
end

function Responsive:Update()
	self.Scale = self:GetScale()
	for i = #self.Items, 1, -1 do
		local Data = self.Items[i]
		local Object = Data.Object
		if not Object or not Object.Parent then
			table.remove(self.Items, i)
			continue
		end
		if Data.Size then
			Object.Size = UDim2.new(
				Data.Size.X.Scale, math.floor(Data.Size.X.Offset * self.Scale),
				Data.Size.Y.Scale, math.floor(Data.Size.Y.Offset * self.Scale)
			)
		end
		if Data.Position then
			Object.Position = UDim2.new(
				Data.Position.X.Scale, math.floor(Data.Position.X.Offset * self.Scale),
				Data.Position.Y.Scale, math.floor(Data.Position.Y.Offset * self.Scale)
			)
		end
		if Data.TextSize and Object:IsA("GuiObject") then
			Object.TextSize = self:GetFont(Data.TextSize)
		end
		if Data.Corner then
			Data.Corner.CornerRadius = UDim.new(0, math.floor(Data.Radius * self.Scale))
		end
		if Data.Stroke then
			Data.Stroke.Thickness = math.max(1, Data.Thickness * self.Scale)
		end
		if Data.Padding then
			Data.Padding.PaddingLeft = UDim.new(0, math.floor(Data.Left * self.Scale))
			Data.Padding.PaddingRight = UDim.new(0, math.floor(Data.Right * self.Scale))
			Data.Padding.PaddingTop = UDim.new(0, math.floor(Data.Top * self.Scale))
			Data.Padding.PaddingBottom = UDim.new(0, math.floor(Data.Bottom * self.Scale))
		end
		if Data.Icon and Data.IconSize then
			Data.Icon.Size = UDim2.new(
				Data.IconSize.X.Scale, math.floor(Data.IconSize.X.Offset * self.Scale),
				Data.IconSize.Y.Scale, math.floor(Data.IconSize.Y.Offset * self.Scale)
			)
		end
	end
	self:UpdateWindow()
	self:UpdateLayouts()
	self:UpdateScrolls()
	self:UpdatePositions()
	if self.Window then
		self:ApplySafeArea(self.Window)
		self:KeepInside(self.Window)
	end
	self:UpdateTheme()
end

function Responsive:SetWindow(Window)
	self.Window = Window
	self:UpdateWindow()
end

function Responsive:UpdateWindow()
	if not self.Window then return end
	local Viewport = self:GetViewport()
	local Width = Viewport.X
	local Height = Viewport.Y
	local WindowWidth, WindowHeight
	if Width <= 600 then
		WindowWidth = math.floor(Width * 0.92)
		WindowHeight = math.floor(Height * 0.82)
	elseif Width <= 1000 then
		WindowWidth = math.floor(Width * 0.78)
		WindowHeight = math.floor(Height * 0.78)
	elseif Width <= 1500 then
		WindowWidth = math.floor(Width * 0.65)
		WindowHeight = math.floor(Height * 0.76)
	else
		WindowWidth = math.clamp(math.floor(Width * 0.45), 650, 920)
		WindowHeight = math.clamp(math.floor(Height * 0.72), 450, 720)
	end
	self.Window.Size = UDim2.fromOffset(WindowWidth, WindowHeight)
	self.Window.Position = UDim2.new(0.5, -WindowWidth/2, 0.5, -WindowHeight/2)
end

function Responsive:RegisterLayout(Layout)
	if not Layout then return end
	for _,v in ipairs(self.Layouts) do
		if v.Layout == Layout then return end
	end
	table.insert(self.Layouts, {
		Layout = Layout,
		Padding = Layout:IsA("UIListLayout") and Layout.Padding or nil,
		CellPadding = Layout:IsA("UIGridLayout") and Layout.CellPadding or nil,
		CellSize = Layout:IsA("UIGridLayout") and Layout.CellSize or nil
	})
end

function Responsive:UpdateLayouts()
	local Scale = self.Scale
	for i = #self.Layouts, 1, -1 do
		local Data = self.Layouts[i]
		local Layout = Data.Layout
		if not Layout or not Layout.Parent then
			table.remove(self.Layouts, i)
			continue
		end
		if Layout:IsA("UIListLayout") then
			Layout.Padding = UDim.new(0, math.floor(Data.Padding.Offset * Scale))
		end
		if Layout:IsA("UIGridLayout") then
			Layout.CellPadding = UDim2.new(
				Data.CellPadding.X.Scale, math.floor(Data.CellPadding.X.Offset * Scale),
				Data.CellPadding.Y.Scale, math.floor(Data.CellPadding.Y.Offset * Scale)
			)
			Layout.CellSize = UDim2.new(
				Data.CellSize.X.Scale, math.floor(Data.CellSize.X.Offset * Scale),
				Data.CellSize.Y.Scale, math.floor(Data.CellSize.Y.Offset * Scale)
			)
		end
	end
end

function Responsive:RegisterScroll(Scroll)
	if not Scroll then return end
	for _,v in ipairs(self.Scrolls) do
		if v.Object == Scroll then return end
	end
	table.insert(self.Scrolls, {Object = Scroll, LastCanvas = 0})
end

function Responsive:UpdateScrolls()
	for i = #self.Scrolls, 1, -1 do
		local Data = self.Scrolls[i]
		local Scroll = Data.Object
		if not Scroll or not Scroll.Parent then
			table.remove(self.Scrolls, i)
			continue
		end
		local Layout = Scroll:FindFirstChildOfClass("UIListLayout") or Scroll:FindFirstChildOfClass("UIGridLayout")
		if Layout then
			local Height
			if Layout:IsA("UIGridLayout") then
				Height = Layout.AbsoluteContentSize.Y + Layout.CellPadding.Y.Offset
			else
				Height = Layout.AbsoluteContentSize.Y + Layout.Padding.Offset
			end
			if Height ~= Data.LastCanvas then
				Data.LastCanvas = Height
				Scroll.CanvasSize = UDim2.new(0, 0, 0, Height + 8)
			end
		end
	end
end

function Responsive:Scan(Object)
	if not Object then return end
	self:RegisterPosition(Object)
	self:RefreshPosition(Object)
	if Object:IsA("GuiObject") then
		self:RegisterPosition(Object)
	end
	if Object:IsA("Frame") then
		self:RegisterTheme(Object, "Background")
	elseif Object:IsA("TextButton") then
		self:RegisterTheme(Object, "Button")
	elseif Object:IsA("TextLabel") then
		self:RegisterTheme(Object, "Text")
	end
	if Object:IsA("UIListLayout") or Object:IsA("UIGridLayout") then
		self:RegisterLayout(Object)
	end
	if Object:IsA("ScrollingFrame") then
		self:RegisterScroll(Object)
	end
	for _, Child in ipairs(Object:GetChildren()) do
		self:Scan(Child)
	end
end

function Responsive:RegisterWindow(Window)
	if not Window then return end
	self.Window = Window
	self:Scan(Window)
	self:SetWindow(Window)
	self:Update()
	Window.DescendantAdded:Connect(function(Object)
		task.defer(function()
			self:Auto(Object)
			self:ApplyUIScale(Object)
			if Object:IsA("GuiObject") then
				self:RegisterPosition(Object)
				self:RefreshPosition(Object)
			end
			if Object:IsA("Frame") then
				self:RegisterTheme(Object, "Background")
			elseif Object:IsA("TextButton") then
				self:RegisterTheme(Object, "Button")
			elseif Object:IsA("TextLabel") then
				self:RegisterTheme(Object, "Text")
			end
			if Object:IsA("UIListLayout") or Object:IsA("UIGridLayout") then
				self:RegisterLayout(Object)
			end
			if Object:IsA("ScrollingFrame") then
				self:RegisterScroll(Object)
			end
		end)
	end)
	Window.DescendantRemoving:Connect(function(Object)
		self:Remove(Object)
	end)
end

function Responsive:RegisterPosition(Object)
	if not Object then return end
	for _,v in ipairs(self.Positions) do
		if v.Object == Object then return end
	end
	table.insert(self.Positions, {
		Object = Object,
		Position = Object.Position,
		Anchor = Object.AnchorPoint
	})
end

function Responsive:RefreshPosition(Object)
	for _,Data in ipairs(self.Positions) do
		if Data.Object == Object then
			Data.Position = Object.Position
			return
		end
	end
end

function Responsive:AutoAnchor(Object)
	if not Object then return end
	Object.AnchorPoint = Vector2.new(0.5, 0.5)
	Object.Position = UDim2.new(0.5, 0, 0.5, 0)
	self:RegisterPosition(Object)
end

function Responsive:UpdatePositions()
	local Viewport = self:GetViewport()
	for _,Data in ipairs(self.Positions) do
		local Object = Data.Object
		if Object and Object.Parent then
			local X = Viewport.X / self.BaseResolution.X
			local Y = Viewport.Y / self.BaseResolution.Y
			Object.Position = UDim2.new(
				Data.Position.X.Scale,
				Data.Position.X.Offset * X,
				Data.Position.Y.Scale,
				Data.Position.Y.Offset * Y
			)
		end
	end
end

function Responsive:GetSafePadding()
	local View = self:GetViewport()
	if View.Y > View.X then return 8 end
	return 0
end

function Responsive:ApplySafeArea(Object)
	if not Object then return end
	local Padding = self:GetSafePadding()
	if not Object:GetAttribute("OriginalY") then
		Object:SetAttribute("OriginalY", Object.Position.Y.Offset)
	end
	local OriginalY = Object:GetAttribute("OriginalY")
	Object.Position = UDim2.new(
		Object.Position.X.Scale,
		Object.Position.X.Offset,
		Object.Position.Y.Scale,
		OriginalY + Padding
	)
end

function Responsive:IsLandscape()
	local View = self:GetViewport()
	return View.X > View.Y
end

function Responsive:IsPortrait()
	return not self:IsLandscape()
end

function Responsive:KeepInside(Object)
	if not Object then return end
	local View = self:GetViewport()
	local Size = Object.AbsoluteSize
	local Pos = Object.AbsolutePosition
	local X = math.clamp(Pos.X, 0, View.X - Size.X)
	local Y = math.clamp(Pos.Y, 0, View.Y - Size.Y)
	Object.Position = UDim2.new(Object.Position.X.Scale, X, Object.Position.Y.Scale, Y)
end

Responsive.Theme = {
	Background = Color3.fromRGB(25,25,25),
	Button = Color3.fromRGB(35,35,35),
	Text = Color3.fromRGB(240,240,240)
}

function Responsive:RegisterTheme(Object, Type)
	if not Object then return end
	for _,v in ipairs(self.ThemeObjects) do
		if v.Object == Object then return end
	end
	table.insert(self.ThemeObjects, {Object = Object, Type = Type})
end

function Responsive:GetPerformance()
	if self:IsMobile() then
		return {Animation = 0.12, Transparency = 0.05, Blur = false}
	elseif self:IsTablet() then
		return {Animation = 0.18, Transparency = 0.1, Blur = true}
	else
		return {Animation = 0.25, Transparency = 0.15, Blur = true}
	end
end

function Responsive:UpdateTheme()
	local Mode = self:GetPerformance()
	for _,Data in ipairs(self.ThemeObjects) do
		local Object = Data.Object
		if Object and Object.Parent then
			if Data.Type == "Background" then
				Object.BackgroundColor3 = self.Theme.Background
			elseif Data.Type == "Button" then
				Object.BackgroundColor3 = self.Theme.Button
			elseif Data.Type == "Text" then
				Object.TextColor3 = self.Theme.Text
			end
			if Object:IsA("Frame") or Object:IsA("TextButton") or Object:IsA("ImageButton") then
				Object.BackgroundTransparency = Mode.Transparency
			end
		end
	end
end

function Responsive:GetTweenInfo(Style, Direction)
	local Speed
	if self:IsMobile() then
		Speed = 0.12
	elseif self:IsTablet() then
		Speed = 0.18
	else
		Speed = 0.25
	end
	return TweenInfo.new(Speed, Style or Enum.EasingStyle.Quad, Direction or Enum.EasingDirection.Out)
end

function Responsive:Tween(Object, Properties, Style, Direction)
	if not Object then return end
	local Tween = TweenService:Create(Object, self:GetTweenInfo(Style, Direction), Properties)
	Tween:Play()
	return Tween
end

function Responsive:TweenSize(Object, Size)
	return self:Tween(Object, {Size = Size})
end

function Responsive:TweenPosition(Object, Position)
	return self:Tween(Object, {Position = Position})
end

function Responsive:TweenTransparency(Object, Value)
	if Object:IsA("GuiObject") then
		return self:Tween(Object, {BackgroundTransparency = Value})
	end
end

function Responsive:TweenRotation(Object, Rotation)
	return self:Tween(Object, {Rotation = Rotation})
end

function Responsive:TweenColor(Object, Color)
	if Object:IsA("GuiObject") then
		return self:Tween(Object, {BackgroundColor3 = Color})
	end
end

function Responsive:Pulse(Button)
	if not Button then return end
	local Base = Button.Size
	self:Tween(Button, {Size = Base + UDim2.fromOffset(4,4)}).Completed:Wait()
	self:Tween(Button, {Size = Base})
end

function Responsive:FadeIn(Frame)
	Frame.BackgroundTransparency = 1
	self:Tween(Frame, {BackgroundTransparency = 0})
end

function Responsive:FadeOut(Frame)
	self:Tween(Frame, {BackgroundTransparency = 1})
end

function Responsive:ApplyUIScale(Object)
	if not Object or not Object:IsA("GuiObject") then return end
	local Scale = Object:FindFirstChildOfClass("UIScale")
	if not Scale then
		Scale = Instance.new("UIScale")
		Scale.Parent = Object
	end
	Scale.Scale = self.Scale
end

-- =========================
-- KuoHub Core Helpers
-- =========================
local Funcs = {}
local ThemeObjects = {}

function Create(class, parent, props)
	local obj = Instance.new(class)
	if parent then obj.Parent = parent end
	if props then
		for i,v in pairs(props) do
			obj[i] = v
		end
	end
	return obj
end

function SetProps(obj, props)
	for i,v in pairs(props) do
		obj[i] = v
	end
end

function InsertTheme(obj, themeType)
	table.insert(ThemeObjects, {Object = obj, Type = themeType})
	if themeType == "Frame" then
		obj.BackgroundColor3 = Color3.fromRGB(25,25,25)
	elseif themeType == "Text" then
		obj.TextColor3 = Color3.fromRGB(220,220,220)
	elseif themeType == "DarkText" then
		obj.TextColor3 = Color3.fromRGB(150,150,150)
	end
end

function Make(typeName, parent, value)
	if typeName == "Corner" then
		local c = Instance.new("UICorner", parent)
		c.CornerRadius = value or UDim.new(0,8)
	elseif typeName == "Stroke" then
		local s = Instance.new("UIStroke", parent)
		s.Color = Color3.fromRGB(170,0,255)
		s.Thickness = 1.5
		s.Transparency = 0.3
	end
end

function Funcs:ToggleVisible(obj, state)
	if state == nil then
		obj.Visible = not obj.Visible
	else
		obj.Visible = state
	end
end

-- =========================
-- Icon System
-- =========================
local IconKeys = {}
for name,_ in pairs(Icons) do
	table.insert(IconKeys, name)
end

local function GetRandomIcon()
	return Icons[IconKeys[math.random(1, #IconKeys)]]
end

local function GetAutoIcon(title)
	local key = string.lower(title or "")
	return Icons[key] or GetRandomIcon()
end

-- =========================
-- Main Window Creator
-- =========================
function KuoHub:MakeWindow(config)
	config = config or {}
	
	-- Cleanup old
	local old = CoreGui:FindFirstChild("KuoHub")
	if old then old:Destroy() end
	pcall(function()
		CoreGui:FindFirstChild("KUOHUB_WELCOME"):Destroy()
	end)
	
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "KuoHub"
	ScreenGui.ResetOnSpawn = false
	ScreenGui.Parent = CoreGui
	
	-- MAIN
	local Main = Instance.new("Frame", ScreenGui)
	Main.Name = "Main"
	Main.Size = UDim2.new(0, 550, 0, 350)
	Main.Position = UDim2.new(0.5, -275, 0.5, -175)
	Main.BackgroundColor3 = Color3.fromRGB(15,15,15)
	Main.BackgroundTransparency = 0.15
	Main.Active = true
	Main.AnchorPoint = Vector2.new(0.5, 0.5)
	Instance.new("UICorner", Main).CornerRadius = UDim.new(0,16)
	
	-- Global UIScale for uniform scaling
	local MainScale = Instance.new("UIScale", Main)
	
	-- GLOW BORDER
	local Stroke = Instance.new("UIStroke", Main)
	Stroke.Color = Color3.fromRGB(170,0,255)
	Stroke.Thickness = 2
	Stroke.Transparency = 0.2
	
	-- TOP
	local Top = Instance.new("Frame", Main)
	Top.Name = "Top"
	Top.Size = UDim2.new(1,0,0,45)
	Top.BackgroundTransparency = 1
	Top.Active = true
	Top.Selectable = true
	
	-- Draggable
	local dragging = false
	local dragInput
	local dragStart
	local startPos
	local smoothness = 0.18
	local targetPos = Main.Position
	
	local DragArea = Instance.new("Frame", Main)
	DragArea.Name = "DragArea"
	DragArea.Size = UDim2.new(1,0,1,0)
	DragArea.BackgroundTransparency = 1
	DragArea.ZIndex = 0
	DragArea.Active = false
	
	local function StartDrag(input)
		dragging = true
		dragStart = input.Position
		startPos = Main.Position
		targetPos = Main.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
	
	Top.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
			StartDrag(input)
		end
	end)
	
	Top.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	
	UIS.InputChanged:Connect(function(input)
		if dragging and input == dragInput then
			local delta = input.Position - dragStart
			targetPos = UDim2.new(
				startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y
			)
		end
	end)
	
	RunService.RenderStepped:Connect(function()
		Main.Position = Main.Position:Lerp(targetPos, smoothness)
	end)
	
	-- TITLE + GRADIENT
	local Title = Instance.new("TextLabel", Top)
	Title.Name = "Title"
	Title.Text = config.Title or "KuoHub"
	Title.Size = UDim2.new(1,-100,1,0)
	Title.Position = UDim2.new(0,10,0,0)
	Title.BackgroundTransparency = 1
	Title.Font = Enum.Font.GothamBold
	Title.TextSize = 20
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.TextColor3 = Color3.fromRGB(170,0,255)
	
	local Gradient = Instance.new("UIGradient", Title)
	Gradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(170,0,255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(0,200,255))
	}
	
	-- LINE
	local Line = Instance.new("Frame", Top)
	Line.Name = "Line"
	Line.Size = UDim2.new(0,80,0,2)
	Line.Position = UDim2.new(0,10,1,-2)
	Line.BackgroundColor3 = Color3.fromRGB(170,0,255)
	Line.BorderSizePixel = 0
	
	-- SIDE
	local Side = Instance.new("Frame", Main)
	Side.Name = "Side"
	Side.Size = UDim2.new(0,140,1,-45)
	Side.Position = UDim2.new(0,0,0,45)
	Side.BackgroundTransparency = 1
	
	-- PAGES FOLDER
	local Pages = Instance.new("Folder", Main)
	Pages.Name = "Pages"
	
	-- CURRENT PAGE TRACKER
	local CurrentPage = nil
	
	-- MINIMIZE & CLOSE
	local Minimize = Instance.new("TextButton", Top)
	Minimize.Name = "Minimize"
	Minimize.Size = UDim2.new(0,40,1,0)
	Minimize.Position = UDim2.new(1,-80,0,0)
	Minimize.Text = "–"
	Minimize.BackgroundTransparency = 1
	Minimize.TextColor3 = Color3.fromRGB(200,200,200)
	Minimize.Font = Enum.Font.GothamBold
	Minimize.TextSize = 18
	
	local Close = Instance.new("TextButton", Top)
	Close.Name = "Close"
	Close.Size = UDim2.new(0,40,1,0)
	Close.Position = UDim2.new(1,-40,0,0)
	Close.Text = "X"
	Close.BackgroundTransparency = 1
	Close.TextColor3 = Color3.fromRGB(255,80,80)
	Close.Font = Enum.Font.GothamBold
	Close.TextSize = 16
	
	-- =========================
	-- ADVANCED CLOSE CONFIRM
	-- =========================
	local Overlay = Instance.new("Frame")
	Overlay.Parent = ScreenGui
	Overlay.Name = "Overlay"
	Overlay.Size = UDim2.new(1,0,1,0)
	Overlay.BackgroundColor3 = Color3.new(0,0,0)
	Overlay.BackgroundTransparency = 0.4
	Overlay.BorderSizePixel = 0
	Overlay.Visible = false
	Overlay.ZIndex = 998
	Overlay.Active = true
	
	local ConfirmFrame = Instance.new("Frame")
	ConfirmFrame.Parent = ScreenGui
	ConfirmFrame.Name = "ConfirmFrame"
	ConfirmFrame.AnchorPoint = Vector2.new(0.5,0.5)
	ConfirmFrame.Position = UDim2.new(0.5,0,0.5,0)
	ConfirmFrame.Size = UDim2.new(0,0,0,0)
	ConfirmFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
	ConfirmFrame.Visible = false
	ConfirmFrame.ZIndex = 999
	ConfirmFrame.ClipsDescendants = true
	Instance.new("UICorner", ConfirmFrame).CornerRadius = UDim.new(0,12)
	
	local ConfirmStroke = Instance.new("UIStroke")
	ConfirmStroke.Parent = ConfirmFrame
	ConfirmStroke.Color = Color3.fromRGB(170,0,255)
	ConfirmStroke.Thickness = 2
	
	local ConfirmTitle = Instance.new("TextLabel")
	ConfirmTitle.Parent = ConfirmFrame
	ConfirmTitle.Size = UDim2.new(1,0,0,30)
	ConfirmTitle.BackgroundTransparency = 1
	ConfirmTitle.Text = "⚠ Close Window?"
	ConfirmTitle.Font = Enum.Font.GothamBold
	ConfirmTitle.TextSize = 18
	ConfirmTitle.TextColor3 = Color3.new(1,1,1)
	ConfirmTitle.ZIndex = 1000
	
	local ConfirmText = Instance.new("TextLabel")
	ConfirmText.Parent = ConfirmFrame
	ConfirmText.Size = UDim2.new(1,-20,0,40)
	ConfirmText.Position = UDim2.new(0,10,0,35)
	ConfirmText.BackgroundTransparency = 1
	ConfirmText.TextWrapped = true
	ConfirmText.Text = "Do you want to close KuoHub?\\nคุณต้องการปิด KuoHub หรือไม่?"
	ConfirmText.Font = Enum.Font.Gotham
	ConfirmText.TextSize = 13
	ConfirmText.TextColor3 = Color3.fromRGB(200,200,200)
	ConfirmText.ZIndex = 1000
	
	local YesBtn = Instance.new("TextButton")
	YesBtn.Parent = ConfirmFrame
	YesBtn.Size = UDim2.new(0,90,0,30)
	YesBtn.Position = UDim2.new(0,20,1,-40)
	YesBtn.Text = "Yes"
	YesBtn.Font = Enum.Font.GothamBold
	YesBtn.TextColor3 = Color3.new(1,1,1)
	YesBtn.BackgroundColor3 = Color3.fromRGB(170,0,255)
	YesBtn.ZIndex = 1000
	Instance.new("UICorner", YesBtn).CornerRadius = UDim.new(0,8)
	
	local NoBtn = Instance.new("TextButton")
	NoBtn.Parent = ConfirmFrame
	NoBtn.Size = UDim2.new(0,90,0,30)
	NoBtn.Position = UDim2.new(1,-110,1,-40)
	NoBtn.Text = "No"
	NoBtn.Font = Enum.Font.GothamBold
	NoBtn.TextColor3 = Color3.new(1,1,1)
	NoBtn.BackgroundColor3 = Color3.fromRGB(45,45,45)
	NoBtn.ZIndex = 1000
	Instance.new("UICorner", NoBtn).CornerRadius = UDim.new(0,8)
	
	-- Open Popup
	Close.MouseButton1Click:Connect(function()
		Overlay.Visible = true
		ConfirmFrame.Visible = true
		ConfirmFrame.Size = UDim2.new(0,0,0,0)
		TweenService:Create(ConfirmFrame, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Size = UDim2.new(0,260,0,130)
		}):Play()
	end)
	
	-- Background click cancel
	Overlay.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
			if ConfirmFrame.Visible then
				local tw = TweenService:Create(ConfirmFrame, TweenInfo.new(0.15), {Size = UDim2.new(0,0,0,0)})
				tw:Play()
				tw.Completed:Wait()
				ConfirmFrame.Visible = false
				Overlay.Visible = false
			end
		end
	end)
	
	-- YES
	YesBtn.MouseButton1Click:Connect(function()
		local tw = TweenService:Create(ConfirmFrame, TweenInfo.new(0.15), {Size = UDim2.new(0,0,0,0)})
		tw:Play()
		tw.Completed:Wait()
		ScreenGui:Destroy()
	end)
	
	-- NO
	NoBtn.MouseButton1Click:Connect(function()
		local tw = TweenService:Create(ConfirmFrame, TweenInfo.new(0.15), {Size = UDim2.new(0,0,0,0)})
		tw:Play()
		tw.Completed:Wait()
		ConfirmFrame.Visible = false
		Overlay.Visible = false
	end)
	
	-- Minimize Logic
	local minimized = false
	Minimize.MouseButton1Click:Connect(function()
		minimized = not minimized
		Minimize.Text = minimized and "+" or "–"
		if minimized then
			TweenService:Create(Main, TweenInfo.new(0.3), {Size = UDim2.new(0,550,0,45)}):Play()
			Side.Visible = false
			if CurrentPage then
				CurrentPage.Visible = false
			end
		else
			TweenService:Create(Main, TweenInfo.new(0.3), {Size = UDim2.new(0,550,0,350)}):Play()
			task.wait(0.15)
			Side.Visible = true
			if CurrentPage then
				CurrentPage.Visible = true
			end
		end
	end)
	
	-- =========================
	-- Responsive Setup
	-- =========================
	local function UpdateScale()
		Responsive:Update()
		if MainScale then
			MainScale.Scale = Responsive.Scale
		end
	end
	
	local Camera = workspace.CurrentCamera
	if Camera then
		Camera:GetPropertyChangedSignal("ViewportSize"):Connect(UpdateScale)
	end
	workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
		local cam = workspace.CurrentCamera
		if cam then
			cam:GetPropertyChangedSignal("ViewportSize"):Connect(UpdateScale)
		end
		UpdateScale()
	end)
	
	task.defer(UpdateScale)

	-- =========================
	-- WINDOW SYSTEM
	-- =========================
	local Window = {}
	Window.LastMinimizePosition = nil
	
	function Window:Tab(name, skipAutoIcon)
		local Page = Instance.new("ScrollingFrame", Pages)
		Page.Name = name.."Page"
		Page.Size = UDim2.new(1,-150,1,-55)
		Page.Position = UDim2.new(0,150,0,50)
		Page.ScrollBarThickness = 4
		Page.Visible = false
		Page.BackgroundTransparency = 1
		Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
		Page.ScrollingDirection = Enum.ScrollingDirection.Y
		
		local Layout = Instance.new("UIListLayout", Page)
		Layout.Padding = UDim.new(0,8)
		Layout.SortOrder = Enum.SortOrder.LayoutOrder
		
		-- TAB BUTTON
		local Btn = Instance.new("TextButton", Side)
		Btn.Name = name.."Btn"
		Btn.Size = UDim2.new(1,-10,0,40)
		Btn.Text = name
		Btn.BackgroundColor3 = Color3.fromRGB(30,30,30)
		Btn.TextColor3 = Color3.fromRGB(200,200,200)
		Btn.Font = Enum.Font.GothamBold
		Btn.TextSize = 14
		Instance.new("UICorner", Btn).CornerRadius = UDim.new(0,10)
		
		local count = 0
		for _,v in pairs(Side:GetChildren()) do
			if v:IsA("TextButton") then
				count += 1
			end
		end
		Btn.Position = UDim2.new(0,5,0,(count-1)*45)
		
		Btn.MouseEnter:Connect(function()
			TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(120,0,200)}):Play()
		end)
		Btn.MouseLeave:Connect(function()
			TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30,30,30)}):Play()
		end)
		
		Btn.MouseButton1Click:Connect(function()
			for _,v in pairs(Pages:GetChildren()) do
				if v:IsA("ScrollingFrame") then
					v.Visible = false
				end
			end
			Page.Visible = true
			CurrentPage = Page
		end)
		
		-- Auto Icon
		if not skipAutoIcon then
			local icon = Instance.new("ImageLabel")
			icon.Name = "AutoIcon"
			icon.Parent = Btn
			icon.Size = UDim2.new(0, 18, 0, 18)
			icon.Position = UDim2.new(0, 8, 0.5, -9)
			icon.BackgroundTransparency = 1
			icon.Image = GetAutoIcon(name)
			Btn.TextXAlignment = Enum.TextXAlignment.Center
		end
		
		-- TAB SYSTEM
		local Tab = {}
		
		function Tab:Section(text)
			local Holder = Instance.new("Frame")
			Holder.Parent = Page
			Holder.Size = UDim2.new(1,-10,0,30)
			Holder.BackgroundTransparency = 1
			Holder.BorderSizePixel = 0
			Holder.LayoutOrder = #Page:GetChildren()
			
			local Label = Instance.new("TextLabel")
			Label.Parent = Holder
			Label.Size = UDim2.new(1,0,1,0)
			Label.BackgroundTransparency = 1
			Label.Text = text
			Label.TextColor3 = Color3.fromRGB(170,0,255)
			Label.Font = Enum.Font.GothamBold
			Label.TextSize = 16
			Label.TextXAlignment = Enum.TextXAlignment.Left
		end
		
		function Tab:Button(config)
			config = config or {}
			local Btn = Instance.new("TextButton", Page)
			Btn.Name = config.Title or "Button"
			Btn.Size = UDim2.new(1,-10,0,35)
			Btn.Text = config.Title or "Button"
			Btn.BackgroundColor3 = Color3.fromRGB(100,0,200)
			Btn.TextColor3 = Color3.new(1,1,1)
			Btn.Font = Enum.Font.GothamBold
			Btn.TextSize = 14
			Btn.LayoutOrder = #Page:GetChildren()
			Instance.new("UICorner", Btn).CornerRadius = UDim.new(0,8)
			
			Btn.MouseButton1Click:Connect(function()
				if config.Callback then
					config.Callback()
				end
			end)
		end
		
		function Tab:Toggle(config)
			config = config or {}
			local Frame = Instance.new("Frame", Page)
			Frame.Name = config.Title or "Toggle"
			Frame.Size = UDim2.new(1,-10,0,45)
			Frame.BackgroundTransparency = 1
			Frame.LayoutOrder = #Page:GetChildren()
			
			local TitleLbl = Instance.new("TextLabel", Frame)
			TitleLbl.Size = UDim2.new(1,-60,0,20)
			TitleLbl.Text = config.Title or "Toggle"
			TitleLbl.TextColor3 = Color3.fromRGB(220,220,220)
			TitleLbl.Font = Enum.Font.GothamBold
			TitleLbl.TextSize = 14
			TitleLbl.BackgroundTransparency = 1
			TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
			
			local DescLbl = Instance.new("TextLabel", Frame)
			DescLbl.Size = UDim2.new(1,-60,0,18)
			DescLbl.Position = UDim2.new(0,0,0,20)
			DescLbl.Text = config.Desc or ""
			DescLbl.TextColor3 = Color3.fromRGB(150,150,150)
			DescLbl.Font = Enum.Font.Gotham
			DescLbl.TextSize = 12
			DescLbl.BackgroundTransparency = 1
			DescLbl.TextXAlignment = Enum.TextXAlignment.Left
			
			local ToggleFrame = Instance.new("Frame", Frame)
			ToggleFrame.Size = UDim2.new(0,40,0,20)
			ToggleFrame.Position = UDim2.new(1,-45,0.5,-10)
			ToggleFrame.BackgroundColor3 = Color3.fromRGB(60,60,60)
			ToggleFrame.Active = true
			ToggleFrame.Selectable = true
			Instance.new("UICorner", ToggleFrame).CornerRadius = UDim.new(1,0)
			
			local Circle = Instance.new("Frame", ToggleFrame)
			Circle.Size = UDim2.new(0,18,0,18)
			Circle.Position = UDim2.new(0,1,0.5,-9)
			Circle.BackgroundColor3 = Color3.new(1,1,1)
			Instance.new("UICorner", Circle).CornerRadius = UDim.new(1,0)
			
			local state = config.Value or false
			
			local function update()
				TweenService:Create(Circle, TweenInfo.new(0.2), {
					Position = state and UDim2.new(1,-19,0.5,-9) or UDim2.new(0,1,0.5,-9)
				}):Play()
				TweenService:Create(ToggleFrame, TweenInfo.new(0.2), {
					BackgroundColor3 = state and Color3.fromRGB(170,0,255) or Color3.fromRGB(60,60,60)
				}):Play()
			end
			
			update()
			
			ToggleFrame.InputEnded:Connect(function(i)
				if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
					state = not state
					update()
					if config.Callback then
						config.Callback(state)
					end
				end
			end)
			
			if config.Callback then
				config.Callback(state)
			end
		end
		
		function Tab:AddDiscordInvite(Configs)
			Configs = Configs or {}
			local TitleTxt = Configs[1] or Configs.Name or Configs.Title or "Discord"
			local DescTxt = Configs.Desc or Configs.Description or ""
			local Logo = Configs[2] or Configs.Logo or ""
			local Invite = Configs[3] or Configs.Invite or ""
			
			local InviteHolder = Create("Frame", Page, {
				Size = UDim2.new(1, -10, 0, 85),
				BackgroundTransparency = 1,
				LayoutOrder = #Page:GetChildren()
			})
			
			local InviteLabel = Create("TextLabel", InviteHolder, {
				Size = UDim2.new(1, 0, 0, 15),
				Position = UDim2.new(0, 5, 0, 0),
				Text = Invite,
				Font = Enum.Font.GothamBold,
				TextSize = 10,
				TextXAlignment = Enum.TextXAlignment.Left,
				BackgroundTransparency = 1,
				TextColor3 = Color3.fromRGB(0,170,255)
			})
			
			local FrameHolder = Create("Frame", InviteHolder, {
				Size = UDim2.new(1, 0, 0, 65),
				Position = UDim2.new(0, 0, 0, 20)
			})
			InsertTheme(FrameHolder, "Frame")
			Make("Corner", FrameHolder)
			Make("Stroke", FrameHolder)
			
			local ImageLabel = Create("ImageLabel", FrameHolder, {
				Size = UDim2.new(0, 32, 0, 32),
				Position = UDim2.new(0, 8, 0, 8),
				Image = Logo,
				BackgroundTransparency = 1
			})
			Make("Corner", ImageLabel, UDim.new(0,6))
			Make("Stroke", ImageLabel)
			
			local LTitle = Create("TextLabel", FrameHolder, {
				Size = UDim2.new(1, -60, 0, 16),
				Position = UDim2.new(0, 48, 0, 6),
				Text = TitleTxt,
				Font = Enum.Font.GothamBold,
				TextSize = 12,
				TextXAlignment = Enum.TextXAlignment.Left,
				BackgroundTransparency = 1
			})
			InsertTheme(LTitle, "Text")
			
			local LDesc = Create("TextLabel", FrameHolder, {
				Size = UDim2.new(1, -60, 0, 0),
				Position = UDim2.new(0, 48, 0, 22),
				Text = DescTxt,
				Font = Enum.Font.Gotham,
				TextSize = 10,
				TextWrapped = true,
				AutomaticSize = Enum.AutomaticSize.Y,
				TextXAlignment = Enum.TextXAlignment.Left,
				BackgroundTransparency = 1
			})
			InsertTheme(LDesc, "DarkText")
			
			local JoinButton = Create("TextButton", FrameHolder, {
				Size = UDim2.new(0, 80, 0, 22),
				AnchorPoint = Vector2.new(1,1),
				Position = UDim2.new(1, -10, 1, -10),
				Text = "Join",
				Font = Enum.Font.GothamBold,
				TextSize = 12,
				BackgroundColor3 = Color3.fromRGB(50,150,50),
				TextColor3 = Color3.fromRGB(255,255,255)
			})
			Make("Corner", JoinButton, UDim.new(0,6))
			
			JoinButton.MouseEnter:Connect(function()
				SetProps(JoinButton, {BackgroundColor3 = Color3.fromRGB(70,180,70)})
			end)
			JoinButton.MouseLeave:Connect(function()
				SetProps(JoinButton, {BackgroundColor3 = Color3.fromRGB(50,150,50)})
			end)
			
			local ClickDelay = false
			JoinButton.Activated:Connect(function()
				if setclipboard then
					setclipboard(Invite)
				end
				if ClickDelay then return end
				ClickDelay = true
				SetProps(JoinButton, {
					Text = "Copied!",
					BackgroundColor3 = Color3.fromRGB(100,100,100)
				})
				task.wait(3)
				SetProps(JoinButton, {
					Text = "Join",
					BackgroundColor3 = Color3.fromRGB(50,150,50)
				})
				ClickDelay = false
			end)
			
			local DiscordInvite = {}
			function DiscordInvite:Destroy()
				InviteHolder:Destroy()
			end
			function DiscordInvite:Visible(...)
				Funcs:ToggleVisible(InviteHolder, ...)
			end
			return DiscordInvite
		end
		
		function Tab:AddSlider(config)
			config = config or {}
			local Frame = Instance.new("Frame", Page)
			Frame.Name = config.Name or "Slider"
			Frame.Size = UDim2.new(1,-10,0,55)
			Frame.BackgroundTransparency = 1
			Frame.LayoutOrder = #Page:GetChildren()
			
			local Title = Instance.new("TextLabel", Frame)
			Title.Size = UDim2.new(1,0,0,20)
			Title.BackgroundTransparency = 1
			Title.Text = (config.Name or "Slider") .. ": " .. (config.Default or 0)
			Title.TextColor3 = Color3.fromRGB(220,220,220)
			Title.Font = Enum.Font.GothamBold
			Title.TextSize = 14
			Title.TextXAlignment = Enum.TextXAlignment.Left
			
			local Bar = Instance.new("Frame", Frame)
			Bar.Size = UDim2.new(1,0,0,6)
			Bar.Position = UDim2.new(0,0,0,30)
			Bar.BackgroundColor3 = Color3.fromRGB(60,60,60)
			Instance.new("UICorner", Bar).CornerRadius = UDim.new(1,0)
			
			local Fill = Instance.new("Frame", Bar)
			Fill.Size = UDim2.new(0,0,1,0)
			Fill.BackgroundColor3 = Color3.fromRGB(170,0,255)
			Instance.new("UICorner", Fill).CornerRadius = UDim.new(1,0)
			
			local Drag = Instance.new("TextButton", Bar)
			Drag.Size = UDim2.new(1,0,1,0)
			Drag.BackgroundTransparency = 1
			Drag.Text = ""
			
			local min = config.Min or 0
			local max = config.Max or 100
			local value = config.Default or min
			local sliderDragging = false
			
			local function updateFromX(x)
				local percent = math.clamp((x - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1)
				value = math.floor(min + (max - min) * percent)
				Fill.Size = UDim2.new(percent,0,1,0)
				Title.Text = (config.Name or "Slider") .. ": " .. value
				if config.Callback then
					config.Callback(value)
				end
			end
			
			Drag.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.Touch then
					sliderDragging = true
					updateFromX(input.Position.X)
				end
			end)
			
			UIS.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.Touch then
					sliderDragging = false
				end
			end)
			
			UIS.InputChanged:Connect(function(input)
				if sliderDragging and (
					input.UserInputType == Enum.UserInputType.MouseMovement
					or input.UserInputType == Enum.UserInputType.Touch
				) then
					updateFromX(input.Position.X)
				end
			end)
			
			task.defer(function()
				local percent = (value - min) / (max - min)
				Fill.Size = UDim2.new(percent,0,1,0)
			end)
		end
		
		function Tab:AddInput(config)
			config = config or {}
			local Frame = Instance.new("Frame", Page)
			Frame.Name = config.Title or "Input"
			Frame.Size = UDim2.new(1,-10,0,60)
			Frame.BackgroundTransparency = 1
			Frame.LayoutOrder = #Page:GetChildren()
			
			local Title = Instance.new("TextLabel", Frame)
			Title.Size = UDim2.new(1,0,0,18)
			Title.BackgroundTransparency = 1
			Title.Text = config.Title or "Input"
			Title.TextColor3 = Color3.fromRGB(220,220,220)
			Title.Font = Enum.Font.GothamBold
			Title.TextSize = 14
			Title.TextXAlignment = Enum.TextXAlignment.Left
			
			local Box = Instance.new("TextBox", Frame)
			Box.Size = UDim2.new(1,0,0,32)
			Box.Position = UDim2.new(0,0,0,24)
			Box.BackgroundColor3 = Color3.fromRGB(35,35,35)
			Box.TextColor3 = Color3.new(1,1,1)
			Box.PlaceholderText = config.Placeholder or ""
			Box.ClearTextOnFocus = false
			Box.Font = Enum.Font.Gotham
			Box.TextSize = 14
			Instance.new("UICorner", Box)
			
			Box.FocusLost:Connect(function(enterPressed)
				if config.Callback then
					config.Callback(Box.Text, enterPressed)
				end
			end)
			
			return Box
		end
		
		function Tab:AddDropdown(config)
			config = config or {}
			local Values = config.Values or {}
			local Selected = config.Default or Values[1] or "None"
			
			local Holder = Instance.new("Frame")
			Holder.Parent = Page
			Holder.BackgroundTransparency = 1
			Holder.Size = UDim2.new(1,-10,0,60)
			Holder.ClipsDescendants = false
			Holder.LayoutOrder = #Page:GetChildren()
			
			local Title = Instance.new("TextLabel")
			Title.Parent = Holder
			Title.Size = UDim2.new(1,0,0,18)
			Title.BackgroundTransparency = 1
			Title.Text = config.Title or "Dropdown"
			Title.TextColor3 = Color3.fromRGB(220,220,220)
			Title.Font = Enum.Font.GothamBold
			Title.TextSize = 14
			Title.TextXAlignment = Enum.TextXAlignment.Left
			
			local Button = Instance.new("TextButton")
			Button.Parent = Holder
			Button.Position = UDim2.new(0,0,0,24)
			Button.Size = UDim2.new(1,0,0,32)
			Button.AutoButtonColor = false
			Button.Text = ""
			Button.BackgroundColor3 = Color3.fromRGB(35,35,35)
			Instance.new("UICorner",Button).CornerRadius = UDim.new(0,8)
			
			local Stroke = Instance.new("UIStroke")
			Stroke.Parent = Button
			Stroke.Color = Color3.fromRGB(60,60,60)
			
			local SelectedLabel = Instance.new("TextLabel")
			SelectedLabel.Parent = Button
			SelectedLabel.BackgroundTransparency = 1
			SelectedLabel.Position = UDim2.new(0,10,0,0)
			SelectedLabel.Size = UDim2.new(1,-40,1,0)
			SelectedLabel.Font = Enum.Font.Gotham
			SelectedLabel.TextColor3 = Color3.new(1,1,1)
			SelectedLabel.TextSize = 14
			SelectedLabel.TextXAlignment = Enum.TextXAlignment.Left
			SelectedLabel.Text = Selected
			
			local Arrow = Instance.new("TextLabel")
			Arrow.Parent = Button
			Arrow.BackgroundTransparency = 1
			Arrow.AnchorPoint = Vector2.new(1,0.5)
			Arrow.Position = UDim2.new(1,-10,0.5,0)
			Arrow.Size = UDim2.new(0,18,0,18)
			Arrow.Font = Enum.Font.GothamBold
			Arrow.Text = "▼"
			Arrow.TextSize = 14
			Arrow.TextColor3 = Color3.fromRGB(220,220,220)
			
			local DropFrame = Instance.new("Frame")
			DropFrame.Parent = Holder
			DropFrame.Position = UDim2.new(0,0,0,60)
			DropFrame.Size = UDim2.new(1,0,0,0)
			DropFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
			DropFrame.ClipsDescendants = true
			DropFrame.Visible = false
			DropFrame.ZIndex = 5
			Instance.new("UICorner",DropFrame).CornerRadius = UDim.new(0,8)
			
			local Stroke2 = Instance.new("UIStroke")
			Stroke2.Parent = DropFrame
			Stroke2.Color = Color3.fromRGB(60,60,60)
			
			local Scroll = Instance.new("ScrollingFrame")
			Scroll.Parent = DropFrame
			Scroll.BackgroundTransparency = 1
			Scroll.BorderSizePixel = 0
			Scroll.Size = UDim2.new(1,0,1,0)
			Scroll.ScrollingDirection = Enum.ScrollingDirection.Y
			Scroll.ZIndex = 6
			Scroll.CanvasSize = UDim2.new()
			Scroll.ScrollBarThickness = 3
			Scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
			
			local Layout = Instance.new("UIListLayout")
			Layout.Parent = Scroll
			Layout.Padding = UDim.new(0,2)
			
			local Open = false
			local ItemHeight = 30
			local MaxVisible = 5
			
			local function Toggle()
				Open = not Open
				local Height = math.min(#Values, MaxVisible) * (ItemHeight + 2)
				if Open then
					DropFrame.Visible = true
				end
				TweenService:Create(DropFrame, TweenInfo.new(.2,Enum.EasingStyle.Quad), {
					Size = Open and UDim2.new(1,0,0,Height) or UDim2.new(1,0,0,0)
				}):Play()
				TweenService:Create(Holder, TweenInfo.new(.2,Enum.EasingStyle.Quad), {
					Size = Open and UDim2.new(1,-10,0,60+Height) or UDim2.new(1,-10,0,60)
				}):Play()
				Arrow.Text = Open and "▲" or "▼"
				if not Open then
					task.delay(.2,function()
						DropFrame.Visible = false
					end)
				end
			end
			
			Button.Activated:Connect(Toggle)
			
			local Dropdown = {}
			local Buttons = {}
			
			local function Select(Value)
				Selected = Value
				SelectedLabel.Text = Value
				if config.Callback then
					task.spawn(config.Callback, Value)
				end
				if Open then
					Toggle()
				end
			end
			
			local function CreateOption(Value)
				local Item = Instance.new("TextButton")
				Item.Parent = Scroll
				Item.ZIndex = 7
				Item.Size = UDim2.new(1,-4,0,ItemHeight)
				Item.BackgroundColor3 = Color3.fromRGB(40,40,40)
				Item.AutoButtonColor = false
				Item.Text = Value
				Item.Font = Enum.Font.Gotham
				Item.TextSize = 14
				Item.TextColor3 = Color3.new(1,1,1)
				Instance.new("UICorner",Item).CornerRadius = UDim.new(0,6)
				
				local UIPadding = Instance.new("UIPadding")
				UIPadding.Parent = Item
				UIPadding.PaddingLeft = UDim.new(0,8)
				
				table.insert(Buttons, Item)
				
				Item.MouseEnter:Connect(function()
					TweenService:Create(Item, TweenInfo.new(.15), {BackgroundColor3 = Color3.fromRGB(55,55,55)}):Play()
				end)
				Item.MouseLeave:Connect(function()
					TweenService:Create(Item, TweenInfo.new(.15), {BackgroundColor3 = Color3.fromRGB(40,40,40)}):Play()
				end)
				Item.Activated:Connect(function()
					Select(Value)
				end)
			end
			
			for _,Value in ipairs(Values) do
				CreateOption(Value)
			end
			
			function Dropdown:Set(Value)
				if table.find(Values, Value) then
					Select(Value)
				end
			end
			
			function Dropdown:Get()
				return Selected
			end
			
			function Dropdown:Refresh(NewValues)
				Values = NewValues or {}
				for _,v in ipairs(Buttons) do
					v:Destroy()
				end
				table.clear(Buttons)
				for _,Value in ipairs(Values) do
					CreateOption(Value)
				end
			end
			
			function Dropdown:Destroy()
				Holder:Destroy()
			end
			
			task.defer(function()
				if config.Callback then
					config.Callback(Selected)
				end
			end)
			
			return Dropdown
		end
		
		return Tab
	end
	
	function Window:MakeTab(data)
		data = data or {}
		local name = data[1] or "Tab"
		local iconName = data[2]
		
		local Tab = self:Tab(name, true)
		
		local buttons = {}
		for _, v in ipairs(Side:GetChildren()) do
			if v:IsA("TextButton") then
				table.insert(buttons, v)
			end
		end
		
		local lastBtn = buttons[#buttons]
		if lastBtn and iconName and Icons[string.lower(iconName)] then
			local old = lastBtn:FindFirstChild("AutoIcon")
			if old then old:Destroy() end
			
			local icon = Instance.new("ImageLabel")
			icon.Name = "AutoIcon"
			icon.Parent = lastBtn
			icon.Size = UDim2.new(0, 18, 0, 18)
			icon.Position = UDim2.new(0, 8, 0.5, -9)
			icon.BackgroundTransparency = 1
			icon.Image = Icons[string.lower(iconName)]
			
			lastBtn.TextXAlignment = Enum.TextXAlignment.Center
		end
		
		return Tab
	end
	
	function Window:Notify(config)
		config = config or {}
		local Gui = Instance.new("ScreenGui")
		Gui.Parent = CoreGui
		Gui.ResetOnSpawn = false
		Gui.Name = "KuoHubNotify"
		
		local Frame = Instance.new("Frame", Gui)
		Frame.Size = UDim2.new(0,260,0,70)
		Frame.Position = UDim2.new(1,-280,1,-90)
		Frame.BackgroundColor3 = Color3.fromRGB(35,35,35)
		Instance.new("UICorner", Frame).CornerRadius = UDim.new(0,10)
		
		local Title = Instance.new("TextLabel", Frame)
		Title.Size = UDim2.new(1,-20,0,22)
		Title.Position = UDim2.new(0,10,0,6)
		Title.BackgroundTransparency = 1
		Title.Font = Enum.Font.GothamBold
		Title.TextSize = 16
		Title.TextColor3 = Color3.new(1,1,1)
		Title.TextXAlignment = Enum.TextXAlignment.Left
		Title.Text = config.Title or "Notification"
		
		local Desc = Instance.new("TextLabel", Frame)
		Desc.Size = UDim2.new(1,-20,1,-30)
		Desc.Position = UDim2.new(0,10,0,28)
		Desc.BackgroundTransparency = 1
		Desc.Font = Enum.Font.Gotham
		Desc.TextSize = 13
		Desc.TextWrapped = true
		Desc.TextColor3 = Color3.fromRGB(220,220,220)
		Desc.TextXAlignment = Enum.TextXAlignment.Left
		Desc.TextYAlignment = Enum.TextYAlignment.Top
		Desc.Text = config.Desc or ""
		
		task.delay(config.Time or 3, function()
			Gui:Destroy()
		end)
	end
	
	function Window:AddMinimizeButton(config)
		config = config or {}
		local btn = Instance.new("ImageButton")
		btn.Parent = ScreenGui
		btn.Name = "MinimizeButton"
		btn.Position = self.LastMinimizePosition or config.Position or UDim2.new(0,20,0.5,-30)
		btn.Image = config.Button and config.Button.Image or ""
		btn.BackgroundColor3 = Color3.fromRGB(30,30,30)
		btn.BackgroundTransparency = config.Button and config.Button.BackgroundTransparency or 0
		btn.AutoButtonColor = false
		btn.Active = true
		btn.ZIndex = 999
		
		local UIScale = Instance.new("UIScale")
		UIScale.Parent = btn
		
		local BaseSize = 42
		local function UpdateButtonSize()
			local viewport = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920,1080)
			local scale = math.clamp(viewport.X / 1920, 0.7, 1.2)
			local size = math.floor(BaseSize * scale)
			btn.Size = UDim2.fromOffset(size, size)
			UIScale.Scale = math.clamp(viewport.X/900, 0.85, 1.15)
		end
		
		UpdateButtonSize()
		if workspace.CurrentCamera then
			workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(UpdateButtonSize)
		end
		
		local Corner = Instance.new("UICorner")
		Corner.CornerRadius = config.Corner and config.Corner.CornerRadius or UDim.new(0,10)
		Corner.Parent = btn
		
		local Stroke = Instance.new("UIStroke")
		Stroke.Parent = btn
		Stroke.Color = Color3.fromRGB(170,0,255)
		Stroke.Thickness = 1.5
		
		btn.MouseEnter:Connect(function()
			TweenService:Create(UIScale, TweenInfo.new(.15), {Scale = UIScale.Scale + 0.08}):Play()
		end)
		btn.MouseLeave:Connect(function()
			local viewport = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920,1080)
			TweenService:Create(UIScale, TweenInfo.new(.15), {Scale = math.clamp(viewport.X/900,0.85,1.15)}):Play()
		end)
		
		local Visible = true
		btn.Activated:Connect(function()
			TweenService:Create(UIScale, TweenInfo.new(.08), {Scale = UIScale.Scale * 0.88}):Play()
			task.wait(.08)
			local viewport = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920,1080)
			TweenService:Create(UIScale, TweenInfo.new(.08), {Scale = math.clamp(viewport.X/900,0.85,1.15)}):Play()
			Visible = not Visible
			Main.Visible = Visible
		end)
		
		-- Drag
		local Dragging = false
		local DragInput
		local DragStart
		local StartPos
		
		local function Update(input)
			local Delta = input.Position - DragStart
			btn.Position = UDim2.new(
				StartPos.X.Scale, StartPos.X.Offset + Delta.X,
				StartPos.Y.Scale, StartPos.Y.Offset + Delta.Y
			)
		end
		
		btn.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
				Dragging = true
				DragStart = input.Position
				StartPos = btn.Position
				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						Dragging = false
					end
				end)
			end
		end)
		
		btn.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch then
				DragInput = input
			end
		end)
		
		UIS.InputChanged:Connect(function(input)
			if Dragging and input == DragInput then
				Update(input)
			end
		end)
		
		btn:GetPropertyChangedSignal("Position"):Connect(function()
			self.LastMinimizePosition = btn.Position
		end)
	end
	
	-- =========================
	-- WELCOME SCREEN
	-- =========================
	task.spawn(function()
		local WelcomeGui = Instance.new("ScreenGui")
		WelcomeGui.Name = "KUOHUB_WELCOME"
		WelcomeGui.ResetOnSpawn = false
		WelcomeGui.Parent = CoreGui
		
		local WMain = Instance.new("Frame")
		WMain.Parent = WelcomeGui
		WMain.AnchorPoint = Vector2.new(0.5,0.5)
		WMain.Position = UDim2.new(0.5,0,0.5,0)
		WMain.Size = UDim2.new(0,0,0,0)
		WMain.BackgroundColor3 = Color3.fromRGB(10,10,15)
		WMain.BorderSizePixel = 0
		Instance.new("UICorner", WMain).CornerRadius = UDim.new(0,24)
		
		local WGradient = Instance.new("UIGradient")
		WGradient.Parent = WMain
		WGradient.Color = ColorSequence.new{
			ColorSequenceKeypoint.new(0, Color3.fromRGB(0,170,255)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(170,0,255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255,0,170))
		}
		WGradient.Rotation = 25
		
		local WStroke = Instance.new("UIStroke")
		WStroke.Parent = WMain
		WStroke.Thickness = 2
		WStroke.Color = Color3.fromRGB(255,255,255)
		WStroke.Transparency = 0.15
		
		local WGlow = Instance.new("ImageLabel")
		WGlow.Parent = WMain
		WGlow.BackgroundTransparency = 1
		WGlow.Size = UDim2.new(1,100,1,100)
		WGlow.Position = UDim2.new(0,-50,0,-50)
		WGlow.Image = "rbxassetid://5028857084"
		WGlow.ImageTransparency = 0.45
		WGlow.ScaleType = Enum.ScaleType.Slice
		WGlow.SliceCenter = Rect.new(24,24,276,276)
		WGlow.ImageColor3 = Color3.fromRGB(0,170,255)
		
		local WTitle = Instance.new("TextLabel")
		WTitle.Parent = WMain
		WTitle.BackgroundTransparency = 1
		WTitle.Size = UDim2.new(1,-40,1,-40)
		WTitle.Position = UDim2.new(0,20,0,20)
		WTitle.Font = Enum.Font.GothamBlack
		WTitle.Text = "Welcome to KuoHub"
		WTitle.TextScaled = true
		WTitle.TextWrapped = true
		WTitle.TextColor3 = Color3.fromRGB(255,255,255)
		
		local WTextGradient = Instance.new("UIGradient")
		WTextGradient.Parent = WTitle
		WTextGradient.Color = ColorSequence.new{
			ColorSequenceKeypoint.new(0, Color3.fromRGB(0,255,255)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255,255,255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255,0,255))
		}
		
		TweenService:Create(WMain, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Size = UDim2.new(0,460,0,120)
		}):Play()
		
		task.spawn(function()
			while WMain.Parent do
				TweenService:Create(WGlow, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
					ImageTransparency = 0.7
				}):Play()
				task.wait(1.5)
				TweenService:Create(WGlow, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
					ImageTransparency = 0.35
				}):Play()
				task.wait(1.5)
			end
		end)
		
		task.spawn(function()
			while WMain.Parent do
				TweenService:Create(WMain, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
					Position = UDim2.new(0.5,0,0.5,-5)
				}):Play()
				task.wait(2)
				TweenService:Create(WMain, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
					Position = UDim2.new(0.5,0,0.5,5)
				}):Play()
				task.wait(2)
			end
		end)
		
		task.delay(4, function()
			TweenService:Create(WMain, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
				Size = UDim2.new(0,0,0,0),
				Rotation = 6,
				BackgroundTransparency = 1
			}):Play()
			task.wait(0.55)
			WelcomeGui:Destroy()
		end)
	end)
	
	-- Expose Responsive via Window
	Window.Responsive = Responsive
	
	return Window
end

return KuoHub
