'''
This script has been written to work together with the
"batch_convert_auto-copy" script. It checks wether the
fiji jython macro has produced a text file after it finished to shutdown
the computer / log out of the server. How to use it:
1. Start in Fiji the Macro "batch_converter_X_to_Y_and_automated_log_off"
2. start this programm in the command line.
    a. this programm will delete any logfiles from previous runs
    b. will continuously check if a new log file has been generated
        (when the fiji macro is finished)
    c. once the fiji macro is finished, it will generate a text file and this
        will allow the automated_log_off script to shutdown the PC
This little script has been written by Etienne Schmelzer.
'''


import os
import time
log_path = "V:\python_log.txt"

if os.path.isfile(log_path):
    os.remove(log_path)

while not os.path.isfile(log_path):
    print("File does not exist:  " + time.strftime("%H:%M:%S"))
    time.sleep(300)
print("File exists")
os.system("shutdown -l")
