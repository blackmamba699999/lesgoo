READ ME


AFMtoFrictionV:

change the directory name

Takes .txt data from the AFM and saves it as an array of information containing line number, time, friction in volts, and standard deviation.
Input: 1-infinity(?) .txt files
Output: Single text file with 4 columns

All files you analyze must be in the same directory as the matlab code.

Make sure the directory matches the where the matlab file is located and set the starting and ending columns you want analyzed
at line 130, 131, 137, and 138, as "MinX" and "MaxX"

You can uncomment the plot function (line 110-120) to see the friction loops and where to trim the data, but commenting this out when you are
running the code will make it go much faster.

comment out input 128-129

enter same min and max X in line 137-138, uncomment it and comment out 135-136

if you have multiple files, run the code with lines 110-120 uncommented and then fine x min and max values, then comment it out 

FrictionVtoMu

Takes .txt. data from AFMtoFrictionV and calculates the coefficient of friction based on load, force constants, and deflection sensitivities.
Graphs the result and also saves all data into a 5 column matrix that can be pasted into spreadsheets or Origin.
Input: Text file from AFMtoFrictionV, deflection sensitivities, force constants, and load