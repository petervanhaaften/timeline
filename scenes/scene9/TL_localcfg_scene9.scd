
//TIMELINE LOCAL SCLANG CONFIG
// # flag for timeline src directory
~srcdir = Platform.userHomeDir +/+ "src/timeline/";
~sceneDuration = 79;

// # flag for timescore location.
~timescore = ~srcdir +/+ "scenes/scene9/TL_score_scene9.scd";
// # flag for min recording length
~minrecordtime = 1;
// # flag for time (in seconds) before min recording breaks, function stops waiting for ~maxrecordtime to pass, and prints wav
~minrecordtimeBreak = 2;
// # flag for max recording length
~maxrecordtime = 7;
// # time to wait on pause (below ~minrecordtime) before triggering error message
~errortime = 2;
// # flags for recording input lvl
~telephoneAmp = 1;
// # flag for telephone mic gate [ non-positive value opens gate ]
~micGate = 1;
// # flags for attack/decay of amp when recording
// # flag for recorder time to wait before stop recording :
// [ release of Amplitude controls how long before stop recording, after audience speaks ]
~recorderAttackTime = 0.0001;
~recorderReleaseTime = 0.4;
// # flag for record sensitivity //trigger record, id 1000
~recorderRecordTrigLo = 0.07;
~recorderRecordTrigHi = 0.15;
// # flag for record pause sensitivity //trigger pause, id 1001
~recorderPauseTrigLo = 0.85;
~recorderPauseTrigHi = 0.93;