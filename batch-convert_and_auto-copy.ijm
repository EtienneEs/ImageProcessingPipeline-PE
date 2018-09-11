// @File(label="source directory",style="directory") dir1
// @String(label="open only files of type",choices={".mvd2",".lif",".sld",".czi"}) infiletype
// @String(label="save as file type",choices={"ICS-1","ICS-2","OME-TIFF", "CellH5"}) outfiletype
// @String(label="Do you want to copy the files automatically to R ?", choices= {"Yes", "No"}) autocopy

// -------------------------------------------------------------------------------
// This is a batch converter to convert between Bio-formats supported file formats.
// It has been written by Kai Schleicher and has been slightly modified by Etienne Schmelzer.
// The Modifications are: Once the the files are converted, they are copied to the
// remote drive of the Huygens deconvolution servers(dir3). Once all the files are copied,
// a text file will be generated(logfile), which can be recognized by the python script
// "automated_shutdown.py", which will then shutdown the computer.
// -------------------------------------------------------------------------------

dir2 = dir1 + File.separator + "ics_ids"
dir3 = "R:\src"

File.makeDirectory(dir2);

logfile= "V:/Python_Log.txt"

if (File.exists(logfile) == 1) {
	File.delete("V:/Python_Log.txt");
}

// check user selection and translate into proper file endings
if (outfiletype == "ICS-1") {
    tgt_suffix = ".ids";
} else if (outfiletype == "ICS-2") {
    tgt_suffix = ".ics";
} else if (outfiletype == "OME-TIFF") {
    tgt_suffix = ".ome.tif";
} else if (outfiletype == "CellH5") {
    tgt_suffix = ".ch5";
}

list = getFileList(dir1);

setBatchMode(true);

for (i=0; i<list.length; i++) {
    // only open an image with the requested extension:
    if(endsWith(list[i], infiletype)){

        incoming = dir1+File.separator+list[i];

        //open the image at position i as a hyperstack using the bio-formats
        //opens all images of a container file (e.g. *.lif, *.sld)
       	run("Bio-Formats Importer", "open=[" + incoming + "] color_mode=Default open_all_series view=Hyperstack stack_order=XYCZT use_virtual_stack");

    	// get image IDs of all open images:
    	all = newArray(nImages);

    	for (k=0; k < nImages; k++) {
            selectImage(k+1);
            all[k] = getImageID;
            title = getTitle();
            title = replace(title,infiletype,"");
            title = replace(title," ","_");
            print("saving file..."+ title);
            outFile = dir2 +File.separator+ title + tgt_suffix;
    		run("Bio-Formats Exporter", "save=[" + outFile + "]");
            print("Done");
    	}

        run("Close All");  // close all images to free the memory
    }
}

print(" ");
print("All done");



if (autocopy == "Yes") {
	print("Start copying,....");
	slist = getFileList(dir2);
	print(slist.length);
	for (i=0; i<slist.length; i++){
		sourcetobecopied = dir2+File.separator+slist[i];
		destinationtobecopied = dir3+File.separator+slist[i];
		//print(sourcetobecopied);
		if (File.exists(destinationtobecopied) == 0) {
			print("Copying Element: " + i+1 + " of " + slist.length);
			//print(destinationtobecopied);
			File.copy(sourcetobecopied, destinationtobecopied);
			print("Copying next element");

		} else {
			print("Element " + i+1 + " does already exist. Copying next Element");
		}


	}
	print("All files have been copied");
	selectWindow("Log");
	saveAs("Text", logfile);

}
