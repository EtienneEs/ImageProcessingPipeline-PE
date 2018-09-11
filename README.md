# PE-workflow
This repository will contain all the scripts i use to process images from PE-Spinning Disk.

1. Acquisition of the Images with PE-Spinning disk
2. Transfer of the files to a remote Drive
3. Copy the data to the remote drive of VAMP (Virtual Analysis And Data Management Platform)
4. Convert the .mvd files to ics/ids files with Fiji using the script: batch-convert_and_auto-copy.py
5. Deconvolution of the files with Huygens Remote Manager [Huygens Remote Manager](https://svi.nl/FrontPage)
6. Transfer of the deconvolved data back to the VAMP
7. Generation of split-view movies using the script: ....
