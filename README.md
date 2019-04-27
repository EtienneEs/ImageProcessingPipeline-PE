# PE-workflow
This repository will contain all the scripts I use to process Hyperstack images
from PE-Spinning Disk.

![Visualization of Image Processing Pipeline][1]

1. Acquisition of the Images with PE-Spinning disk
2. Transfer of the files to a remote Drive
3. Copy the data to the remote drive of VAMP (Virtual Analysis And Data Management Platform)
4. Convert the .mvd files to ics/ids files with Fiji using the scripts:
    1. [batch-convert_and_auto-copy.ijm](../blob/master/batch-convert_and_auto-copy.ijm)
    2. (optional) automatically shutdown PC after the files have been converted [automated_shutdown.py](../blob/master/automated_shutdown.py)
5. Deconvolution of the files with [Huygens Remote Manager](https://svi.nl/FrontPage) using the settings noted in [Deconvolution_Settings](../blob/master/Deconvolution_Settings.md)
6. Transfer of the deconvolved data back to the VAMP
7. Run [batch-rename.py](../blob/master/batch-rename.py) script to remove the folder name and the (job?)number, added by the Huygens serves.  
8. Now you can start to analyse your Data. One option is to generate a Maximum projection of the stack, show the merged channels and the single channels next to each other and combine them in a movie. If you want to do this automatically or semi automatically check out my Fiji-macros repository: [Fiji-macros/18_07_28_r3d-batchprocessing_green_magenta_new.ijm](https://github.com/EtienneEs/Fiji-macros/blob/master/18_07_28_r3d-batchprocessing_green_magenta_new.ijm)

[1]: ../master/timeline_image_processing.png  
