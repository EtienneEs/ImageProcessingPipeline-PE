# PE-workflow
This repository will contain all the scripts i use to process images from PE-Spinning Disk.

1. Acquisition of the Images with PE-Spinning disk
2. Transfer of the files to a remote Drive
3. Copy the data to the remote drive of VAMP (Virtual Analysis And Data Management Platform)
4. Convert the .mvd files to ics/ids files with Fiji using the scripts:
    1. [batch-convert_and_auto-copy.ijm](../blob/master/batch-convert_and_auto-copy.ijm)
    2. (optional) automatically shutdown PC after the files have been converted [automated_shutdown.py](../blob/master/automated_shutdown.py)
5. Deconvolution of the files with [Huygens Remote Manager](https://svi.nl/FrontPage) using the settings noted in [Deconvolution_Settings](../blob/master/Deconvolution_Settings.md)
6. Transfer of the deconvolved data back to the VAMP
7. Run [batch-rename.py](../blob/master/batch-rename.py) script to remove the folder name and the (job?)number, added by the Huygens serves.  
8. Generation of split-view movies using the script: ....
