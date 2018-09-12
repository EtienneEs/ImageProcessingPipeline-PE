# Deconvolution Settings


## Images Properties
The images were taken with the [Perkin Elmer Spinning DiskConfocal "Ultra ViewVox"](https://www.biozentrum.unibas.ch/abteilungen/imaging-cre-facility-imcf/microscope-systems/perkinelmer-ultraview-vox/) using a Dual camera setup.
- Objective: HXC PLAN S APO _(63x/1.20, water, Working Distance: 0.22mm)_
- Laserlines:  
  - 488nm _(solid state laser, 50mW)_
  - 561nm _(solid state laser, 50mW)_
- Dichroic:
  - 580 nm edge _(dual band 594/42-730/140; dualband 448/55-523/47)_
- Bandpass Filters:
  - CFP / FarRed Dual-band (_485/60-705/90_)

## Deconvolution Setup
For deconvolution I use the [Huygens Remote Manager](https://svi.nl/FrontPage)
of the University of Basel.

### Image Template (GFP; mCherry)
- number of channels: 2
- PSF: Theoretical
- multipoint confocal (spinning disk)
- NA: 1.2
- excitation (nm):
  - Ch0: 488
  - Ch1: 561
- emission (nm):
  - Ch0: 507
  - Ch1: 610
- objective type: water (1.3381)
- sample medium: water
- pixel size (nm): 106
- z-step (nm): 200
- backprojected pinhole radius (nm):
  - Ch0: 396.83
  - Ch1: 396.83
- pinhole spacing (micron): 4.02

### Restoration Template (GFP; mCherry)
- Classic Maximum Likelihood Estimation
- SNR: _(is kept the same for all picture in order to make comparisons)_
  - Ch0: 10
  - Ch1: 10
- crop surrounding background areas: no
- automatic background estimation
- number of iterations: 100
- quality change 0.01


__Output file format: *r3d*__  
_(the output file format needs to be set to r3d, as ics/ids does not annotate the time to each image-metadata, which is important for automatic time annotation in Omero.)_
