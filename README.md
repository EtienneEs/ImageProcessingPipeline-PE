# Analysing Transcellular Lumen formation in the zebrafish vasculature

This project is a step by step guide to analyse transcellular lumen formation
in the zebrafish vasculature. The first part describes the experimental setup,
followed by a in detail description of the image processing pipeline.
[This is the link text](#headin)

1. [Background: Experimental procedure](#Background)
2. [Image processing pipeline](#ImageProcessing)
    1. [File conversion](#Conversion)
    2. [Deconvolution](#Deconvolution)
    3. [Split movies and first analysis: the MPS-movie-maker](#MPS)
3. [Step by Step guide for coworkers](#StepByStep)


## Experimental procedure <a name="Background"></a>
_Day0_: Adult zebrafish ([_Danio rerio_][w1]) are set up for mating in 1l cages. Day1: In the next morning the eggs are collected with a sieve with a sieve and cleaned with E3. For transient expression of a construct or generation of a transgenic line the embryos are injected immediately at 1-cell stage. After one to two hours, only fertilised eggs are selected and distributed into petri dishes with blue egg water (E3 supplemented with Methylene blue). Six hours later the plates are controlled for dead embryos. If the plate contains less than five dead eggs: the dead embryos were removed, otherwise only healthy embryos are transferred to a plate with fresh blue egg water. _Day1_: At around 24hpf the embryos are transferred to E3 with 1x PTU. In order to analyse lumen invagination and lumen fusion at more decent working hours (not 23:00), the development of the embryos was accelerated by incubation at 32°C and imaged around 33-35hpf or slowed down by incubation at 25°C and further imaged around 46-60hpf(_Day2_). (Note: Injected embryos showed a higher lethality when incubated at higher temperatures, therefore injected embryos were preferentially incubated at lower temperatures.) In order to analyse transcellular lumen formation in high spatial and temporal resolution the PerkinElmer Spinning disk “UltraviewVox” microscope was used.

![timeline_microscopy.png][p1]

## Image processing pipeline <a name="ImageProcessing"></a>

Overview of the image processing pipeline:  
![Visualization of Image Processing Pipeline][p2]


### File conversion: Batch converter and autocopy <a name="Conversion"></a>

Image files acquired with the PerkinElmer Spinning disk “UltraviewVox” are saved in the .mvd file format. In order to extract and convert this file format into a more compatible file format the [batch converter script][1] has been written. It is written in the macro language of [ImageJ][w2]. The code of this script is partially based on code written by Kai Schleicher. It converts one or multiple image datasets in a chosen folder location. It further allows to specify the input file format (.mvd2, .lif, .sid, .czi), which is only limited by the file formats supported by [Bioformats plugin][w3]. Further it allows to specify an outfile type, a destination location and an “autocopy” option. The script will convert the input files into the specified file format and save the Image data in a subfolder. If the option “autocopy” is activated, the files are further copied to the specified destination folder (e.g. a remote drive like the R-drive of the Huygens deconvolution server).

Optional: If you want to automatically shut down the PC or logout of the server (like [VAMP, Virtual Analysis And Data Management Platform][w4]) you can run the python script [automated_shutdown.py][2]. It will repeatedly check if the [batch converter script][1] has finished and saved a python_log file. Once the file is detected [automated_shutdown.py][2] will shutdown the working station.

Summary:
- [batch converter script][1]:
 Converts any input file format supported by [Bioformats plugin][w3].
- [automated_shutdown.py][2]: will shutdown the working station once batch converter script finished.

### Deconvolution <a name="Deconvolution"></a>
For Images and Hyperstacks acquired with PerkinElmer Spinning disk “UltraviewVox” microscope it is essential to deconvolve them prior to analysis.
Deconvolution was performed with [Huygens Remote Manager][w5] with the following settings:  [Deconvolution_Settings][3].

Optional: [batch-rename.py][4]:  
Convertion and deconvolution of the files leads to a rather long filename. For convenience i wrote this small [batch-rename.py][4] script. It will delete the Foldername of the container file and delete the job-id? generated by the Huygens Remote Manager.

### Split movies and first analysis: the MPS-movie-maker <a name="MPS"></a>
The resulting image data is further processed and analysed with the Split movie batch script. The script allows choosing a source directory, containing the image data and a destination directory. Further it allows to choose the file input format(e.g. ics). For each file, with the correct file ending, a maximum projection is generated and a composite movie together with inverted greyscale single channel movies are combined with each other. The resulting movie is saved as .avi file and optionally the resulting image file can be saved additionally. The operator can choose if the files are processed:
- __automatically__: Brightness and Contrast ist set with automatic thresholds or
- __semi-manually__, allowing individual cropping of the data and manuel setting of Brightness and Contrast.

The combined, final movie will contain a time stamp and scale bar.

Picture of final movie file:
![Example picture of MPS script Result][p3]


Link to an example result of MPSmovieMaker:  
[Result of MPSmovieMaker (.avi file)][m1]

----
----

## Step by Step guide for coworkers: <a name="StepByStep"></a>

1. Acquisition of the Images with PE-Spinning disk
2. Transfer of the files to the remote drive (M-drive)
3. (Copy the data to the remote drive of VAMP (Virtual Analysis And Data Management Platform))
4. Convert the .mvd files to ics/ids files with [Fiji][w2] using the scripts:
    1. [batch-convert_and_auto-copy.ijm][1]
    2. (optional) automatically shutdown PC after the files have been converted [automated_shutdown.py][2]
5. Deconvolution of the files with [Huygens Remote Manager][w5] using the settings noted in [Deconvolution_Settings][3]
6. Transfer of the deconvolved data back to the VAMP
7. Run [batch-rename.py](../blob/master/batch-rename.py) script to remove the folder name and the (job?)number, added by the Huygens serves.  
8. Analyse the processed data, for example with: [MPSmovieMaker][5]

[w1]: https://en.wikipedia.org/wiki/Zebrafish
[w2]: https://imagej.net/Welcome
[w3]: https://imagej.net/Bio-Formats
[w4]: https://www.biozentrum.unibas.ch/de/abteilungen/research-it/tools-and-services/vamp-virtual-analysis-and-data-management-platform/
[w5]: https://svi.nl/FrontPage


[p1]: ../master/timeline_microscopy.png
[p2]: ../master/timeline_image_processing.png
[p3]: ../master/picture_of_MPSmovieMaker_result.png

[m1]: ../master/MPS_example.avi

[1]: ../master/batch-convert_and_auto-copy.ijm
[2]: ../master/automated_shutdown.py
[3]: ../master/Deconvolution_Settings.md
[4]: ../master/batch-rename.py
[5]: https://github.com/EtienneEs/Fiji-macros/blob/master/18_07_28_r3d-batchprocessing_green_magenta_new.ijm
