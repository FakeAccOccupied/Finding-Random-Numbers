@echo off
@setlocal

::The timer has been taken from: https://stackoverflow.com/questions/673523/how-do-i-measure-execution-time-of-a-command-on-the-windows-command-line

set /a CurrentNumberOfLoops=0
set /a OverallNumberOfLoops=1000

set /a AllLinearTimesSecs=0
set /a AllJumpTimesSecs=0
set /a AllBinaryTimesSecs=0
set /a AllFibonacciTimesSecs=0

set /a AllLinearTimesMS=0
set /a AllJumpTimesMS=0
set /a AllBinaryTimesMS=0
set /a AllFibonacciTimesMS=0

:LoopAllAlgorithms
set /a CurrentNumberOfLoops=%CurrentNumberOfLoops% + 1
set /a HighestNumber=1000
set /a RandomNumber=(%random% %% %HighestNumber%) + 1
echo Random Number: %RandomNumber%
echo Number of times repeated %CurrentNumberOfLoops%
set /a RangeBottom=1

::------------------------------------------------------------------------------------------Linear Search-------------------------------------------------
set start=%time%

set /a IsThisTheRandomNumber=1

Goto TopOfLinearSearchUnderAdding



:TopOfLinearSearch

set /a IsThisTheRandomNumberPlusOne=%IsThisTheRandomNumber%+1
set /a IsThisTheRandomNumber=%IsThisTheRandomNumberPlusOne%


:TopOfLinearSearchUnderAdding

if %IsThisTheRandomNumber%==%RandomNumber% goto NumberFoundForLinear
goto TopOfLinearSearch

:NumberFoundForLinear
echo The Number is %IsThisTheRandomNumber%

cmd /c %*

set end=%time%
set options="tokens=1-4 delims=:.,"

::Breakes the start and end time into hours, minutes, seconds, miliseconds
for /f %options% %%a in ("%start%") do set start_h=%%a&set /a start_m=100%%b %% 100&set /a start_s=100%%c %% 100&set /a start_ms=100%%d %% 100
for /f %options% %%a in ("%end%") do set end_h=%%a&set /a end_m=100%%b %% 100&set /a end_s=100%%c %% 100&set /a end_ms=100%%d %% 100

::The end time is subtracted with the start time
set /a hours=%end_h%-%start_h%
set /a mins=%end_m%-%start_m%
set /a secs=%end_s%-%start_s%
set /a ms=%end_ms%-%start_ms%
if %ms% lss 0 set /a secs = %secs% - 1 & set /a ms = 100%ms%
if %secs% lss 0 set /a mins = %mins% - 1 & set /a secs = 60%secs%
if %mins% lss 0 set /a hours = %hours% - 1 & set /a mins = 60%mins%
if %hours% lss 0 set /a hours = 24%hours%
if 1%ms% lss 100 set ms=0%ms%

set /a totalsecs = %hours%*3600 + %mins%*60 + %secs%
echo It took Linear Search %hours%:%mins%:%secs%.%ms% (%totalsecs%.%ms%s total) to find the number.
set /a AllLinearTimesSecs=%AllLinearTimesSecs% +  %totalsecs%
set /a AllLinearTimesMS=%AllLinearTimesMS% +  %ms%

::---------------------------------------------------------------------------------------Jump Search-----------------------------------------------------------
set start=%time%

set /a IsThisTheRandomNumber=1
set /a JumpLength=100

if %IsThisTheRandomNumber%==%RandomNumber% goto NumberFoundForJump

:TopOfJumpSearch
set /a IsThisTheRandomNumberPlusX=%IsThisTheRandomNumber%+%JumpLength%
set /a IsThisTheRandomNumber=%IsThisTheRandomNumberPlusX%

if %IsThisTheRandomNumber%==%RandomNumber% goto NumberFoundForJump
if %IsThisTheRandomNumber% lss %RandomNumber% goto TopOfJumpSearch
if %IsThisTheRandomNumber% gtr %RandomNumber% goto JumpSearchNumberGreater

:JumpSearchNumberGreater
set /a IsThisTheRandomNumberMinusThree=%IsThisTheRandomNumber%-%JumpLength%+1
set /a IsThisTheRandomNumber=%IsThisTheRandomNumberMinusThree%

:JumpSearchIsNumberEqual

if %IsThisTheRandomNumber%==%RandomNumber% goto NumberFoundForJump
set /a IsThisTheRandomNumberPlusX=%IsThisTheRandomNumber%+1
set /a IsThisTheRandomNumber=%IsThisTheRandomNumberPlusX%

goto JumpSearchIsNumberEqual


:NumberFoundForJump
echo The Number is %IsThisTheRandomNumber%

cmd /c %*

set end=%time%
set options="tokens=1-4 delims=:.,"

::Breakes the start and end time into hours, minutes, seconds, miliseconds
for /f %options% %%a in ("%start%") do set start_h=%%a&set /a start_m=100%%b %% 100&set /a start_s=100%%c %% 100&set /a start_ms=100%%d %% 100
for /f %options% %%a in ("%end%") do set end_h=%%a&set /a end_m=100%%b %% 100&set /a end_s=100%%c %% 100&set /a end_ms=100%%d %% 100

::The end time is subtracted with the start time
set /a hours=%end_h%-%start_h%
set /a mins=%end_m%-%start_m%
set /a secs=%end_s%-%start_s%
set /a ms=%end_ms%-%start_ms%
if %ms% lss 0 set /a secs = %secs% - 1 & set /a ms = 100%ms%
if %secs% lss 0 set /a mins = %mins% - 1 & set /a secs = 60%secs%
if %mins% lss 0 set /a hours = %hours% - 1 & set /a mins = 60%mins%
if %hours% lss 0 set /a hours = 24%hours%
if 1%ms% lss 100 set ms=0%ms%

set /a totalsecs = %hours%*3600 + %mins%*60 + %secs%
echo It took Jump Search %hours%:%mins%:%secs%.%ms% (%totalsecs%.%ms%s total) to find the number.
set /a AllJumpTimesSecs=%AllJumpTimesSecs% +  %totalsecs%
set /a AllJumpTimesMS=%AllJumpTimesMS% +  %ms%

::-------------------------------------------------------------------------------------------Binary Search------------------------------------------------------------
set start=%time%

set /a RangeTop=%HighestNumber%



:TopOfBinarySearch

if %HighestNumber%==%RandomNumber% goto NumberFoundButTop

set /a RangeTopPlusBottom=%RangeTop%+%RangeBottom%
set /a RangeMiddle=%RangeTopPlusBottom%/2

if %RangeMiddle%==%RandomNumber% goto NumberFoundForBinary
if %RangeMiddle% gtr %RandomNumber% goto BinaryRnLSSMiddle
if %RangeMiddle% lss %RandomNumber% goto BinaryRnGTRMiddle

goto TopOfBinarySearch

:BinaryRnGTRMiddle
set /a RangeBottom=%RangeMiddle%
goto TopOfBinarySearch

:BinaryRnLSSMiddle
set /a RangeTop=%RangeMiddle%
goto TopOfBinarySearch



:NumberFoundForBinary
echo The Number is %RangeMiddle%
goto StopwatchEndForBinary

:NumberFoundButTop
echo The Number is %HighestNumber%

:StopwatchEndForBinary
cmd /c %*

set end=%time%
set options="tokens=1-4 delims=:.,"

::Breakes the start and end time into hours, minutes, seconds, miliseconds
for /f %options% %%a in ("%start%") do set start_h=%%a&set /a start_m=100%%b %% 100&set /a start_s=100%%c %% 100&set /a start_ms=100%%d %% 100
for /f %options% %%a in ("%end%") do set end_h=%%a&set /a end_m=100%%b %% 100&set /a end_s=100%%c %% 100&set /a end_ms=100%%d %% 100

::The end time is subtracted with the start time
set /a hours=%end_h%-%start_h%
set /a mins=%end_m%-%start_m%
set /a secs=%end_s%-%start_s%
set /a ms=%end_ms%-%start_ms%
if %ms% lss 0 set /a secs = %secs% - 1 & set /a ms = 100%ms%
if %secs% lss 0 set /a mins = %mins% - 1 & set /a secs = 60%secs%
if %mins% lss 0 set /a hours = %hours% - 1 & set /a mins = 60%mins%
if %hours% lss 0 set /a hours = 24%hours%
if 1%ms% lss 100 set ms=0%ms%

set /a totalsecs = %hours%*3600 + %mins%*60 + %secs%
echo It took Binary Search %hours%:%mins%:%secs%.%ms% (%totalsecs%.%ms%s total) to complete find the number.
set /a AllBinaryTimesSecs=%AllBinaryTimesSecs% +  %totalsecs%
set /a AllBinaryTimesMS=%AllBinaryTimesMS% +  %ms%

::---------------------------------------------------------------------Fibonacci Search--------------------------------------------------------------------------------------
set start=%time%

set /a IsThisTheRandomNumber=1
set /a FibonacciRandomNumber= %RandomNumber%
set /a FibonacciFullNumber= 0

:TopOfFibonacciSearch
set /a FibonacciNumberOne=0
set /a FibonacciNumberTwo=1
set /a FibonacciNumberThree=1
if %FibonacciRandomNumber%==%FibonacciNumberOne% goto NumberFoundButStarter

goto BridgeOverFibacci

:FibonacciRnGTRFibonacciNumberThree
set /a FibonacciNumberSave=%FibonacciNumberThree%
set /a FibonacciNumberOne=%FibonacciNumberTwo%
set /a FibonacciNumberTwo=%FibonacciNumberThree%


:BridgeOverFibacci
set /a FibonacciNumberThree= %FibonacciNumberOne% + %FibonacciNumberTwo%
if %FibonacciNumberThree%==%FibonacciRandomNumber% goto NumberFoundForFibonacci

if %FibonacciNumberThree% gtr %FibonacciRandomNumber% goto FibonacciRnLssFibonacciNumberThree

if %FibonacciNumberThree% lss %FibonacciRandomNumber% goto FibonacciRnGTRFibonacciNumberThree


:FibonacciRnLssFibonacciNumberThree
set /a FibonacciFullNumber= %FibonacciNumberSave%+%FibonacciFullNumber%

set /a FibonacciRandomNumber= %FibonacciRandomNumber%-%FibonacciNumberSave%
goto TopOfFibonacciSearch



:NumberFoundForFibonacci
set /a IsThisTheRandomNumber= %FibonacciNumberThree% + %FibonacciFullNumber%
echo The Number is %IsThisTheRandomNumber%
goto StopwatchEndForFibonacci

:NumberFoundButStarter
set /a IsThisTheRandomNumber= %FibonacciNumberThree% + %FibonacciFullNumber%
echo The Number is %IsThisTheRandomNumber%

:StopwatchEndForFibonacci
cmd /c %*

set end=%time%
set options="tokens=1-4 delims=:.,"

::Breakes the start and end time into hours, minutes, seconds, miliseconds
for /f %options% %%a in ("%start%") do set start_h=%%a&set /a start_m=100%%b %% 100&set /a start_s=100%%c %% 100&set /a start_ms=100%%d %% 100
for /f %options% %%a in ("%end%") do set end_h=%%a&set /a end_m=100%%b %% 100&set /a end_s=100%%c %% 100&set /a end_ms=100%%d %% 100

::The end time is subtracted with the start time
set /a hours=%end_h%-%start_h%
set /a mins=%end_m%-%start_m%
set /a secs=%end_s%-%start_s%
set /a ms=%end_ms%-%start_ms%
if %ms% lss 0 set /a secs = %secs% - 1 & set /a ms = 100%ms%
if %secs% lss 0 set /a mins = %mins% - 1 & set /a secs = 60%secs%
if %mins% lss 0 set /a hours = %hours% - 1 & set /a mins = 60%mins%
if %hours% lss 0 set /a hours = 24%hours%
if 1%ms% lss 100 set ms=0%ms%

set /a totalsecs = %hours%*3600 + %mins%*60 + %secs%
echo It took Fibonacci Search %hours%:%mins%:%secs%.%ms% (%totalsecs%.%ms%s total) to find the number.
set /a AllFibonacciTimesSecs=%AllFibonacciTimesSecs% +  %totalsecs%
set /a AllFibonacciTimesMS=%AllFibonacciTimesMS% +  %ms%

if %CurrentNumberOfLoops%==%OverallNumberOfLoops% goto EndOfCode
goto LoopAllAlgorithms

:EndOfCode
echo Overall loops %OverallNumberOfLoops%

echo Seconds Linear %AllLinearTimesSecs% >> SearchAlgorithmsTimesRange10000.txt
echo Seconds Jump %AllJumpTimesSecs% >> SearchAlgorithmsTimesRange10000.txt
echo Seconds Binary %AllBinaryTimesSecs% >> SearchAlgorithmsTimesRange10000.txt
echo Seconds Fibonacci %AllFibonacciTimesSecs% >> SearchAlgorithmsTimesRange10000.txt

echo ms Linear %AllLinearTimesMS% >> SearchAlgorithmsTimesRange10000.txt
echo ms Jump %AllJumpTimesMS% >> SearchAlgorithmsTimesRange10000.txt
echo ms Binary %AllBinaryTimesMS% >> SearchAlgorithmsTimesRange10000.txt
echo mc Fibonacci %AllFibonacciTimesMS% >> SearchAlgorithmsTimesRange10000.txt

echo Seconds Linear %AllLinearTimesSecs%
echo Seconds Jump %AllJumpTimesSecs%
echo Seconds Binary %AllBinaryTimesSecs%
echo Seconds Fibonacci %AllFibonacciTimesSecs%

echo ms Linear %AllLinearTimesMS%
echo ms Jump %AllJumpTimesMS%
echo ms Binary %AllBinaryTimesMS%
echo mc Fibonacci %AllFibonacciTimesMS%
pause