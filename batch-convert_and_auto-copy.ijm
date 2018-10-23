// @File(label="source directory",style="directory") dir0
// @String(label="Is the data in subfolders?", choices= {"Yes", "No"}) subfolder
// @String(label="open only files of type",choices={".mvd2",".lif",".sld",".czi"}) infiletype
// @String(label="save as file type",choices={"ICS-1","ICS-2","OME-TIFF", "CellH5"}) outfiletype
// @String(label="Do you want to copy the files automatically to R ?", choices= {"Yes", "No"}) autocopy


// -------------------------------------------------------------------------------
// This is a batch converter to convert between Bio-formats supported file formats.
// If your data is stored in subfolders -> "Yes" for the subfolders.
// The Modifications are: Once the the files are converted, they are copied to the
// remote drive of the Huygens deconvolution servers(dir3). Once all the files are copied,
// a text file will be generated(logfile), which can be recognized by the python script
// "automated_shutdown.py", which will then shutdown the computer.
// -------------------------------------------------------------------------------

setBatchMode(true);
dir3 = "R:\src"

// This paragraph checks, if a logfile already exists and deletes it
logfile= "V:/Python_Log.txt"
if (File.exists(logfile) == 1) {
	File.delete("V:/Python_Log.txt");
};

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


function getTimestamp() {
// generates a Timestamp, no arguments needed
	MonthNames = newArray("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec");
	DayNames = newArray("Sun", "Mon","Tue","Wed","Thu","Fri","Sat");
	getDateAndTime(year, month, dayOfWeek, dayOfMonth, hour, minute, second, msec);
	TimeString ="Date: "+DayNames[dayOfWeek]+" ";
	if (dayOfMonth<10) {TimeString = TimeString+"0";}
	TimeString = TimeString+dayOfMonth+"-"+MonthNames[month]+"-"+year+" Time: ";
	if (hour<10) {TimeString = TimeString+"0";}
	TimeString = TimeString+hour+":";
	if (minute<10) {TimeString = TimeString+"0";}
	TimeString = TimeString+minute+":";
	if (second<10) {TimeString = TimeString+"0";}
	TimeString = TimeString+second;
	//print(TimeString);
	return TimeString;
}




function converter(infiletype, outfiletype, dir1, dir2) {
// converts the files with the ending "infiletype" to the desired "outfiletype"
// dir1 is the directory for the incoming files
// dir2 is the targetdirectory
	list = getFileList(dir1);

	for (i=0; i<list.length; i++) {
	    // only open an image with the requested extension:
	    if(endsWith(list[i], infiletype)){
	    	print("Processing: " + list[i]);

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
	            //break
	    	}

	        run("Close All");  // close all images to free the memory
	    }
	}

	print(" ");
	print("All done");
};


function autotransfer(dir2, dir3) {
// copies all the files from folder dir2 to folder dir3
	slist = getFileList(dir2);
	tfolder = replace(dir2, '/', File.separator);
	print("copying folder " + tfolder );
	for (i=0; i<slist.length; i++){
		sourcetobecopied = dir2+File.separator+slist[i];
		destinationtobecopied = dir3+File.separator+slist[i];
		//print(sourcetobecopied);
		if (File.exists(destinationtobecopied) == 0) {
			print("Copying Element: " + i + " of " + slist.length);
			//print(destinationtobecopied);
			File.copy(sourcetobecopied, destinationtobecopied);
			print("Copying next element");

		} else {
			print("Element " + i + " does already exist. Copying next Element");
		}


	}

};

print("The script has been started at: " + getTimestamp());
if (subfolder == "Yes") {
	list = getFileList(dir0);
	for (i=0; i<list.length; i++) {
		dir1 = dir0 + File.separator + list[i];
		dir2 = dir1 + "ics_ids";
		if (File.exists(dir2) == 0) {
			File.makeDirectory(dir2);
		}

		converter(infiletype, outfiletype, dir1, dir2);
		if (autocopy == "Yes") {
			autotransfer(dir2, dir3);
		};
	};
}


if (subfolder == "No") {
	dir1 = dir0;
	dir2 = dir1 + File.separator + "ics_ids";
	if (File.exists(dir2) == 0) {
		File.makeDirectory(dir2);
	};
	converter(infiletype, outfiletype, dir1, dir2);
	if (autocopy == "Yes") {
		autotransfer(dir2, dir3);
	};
}
// finalising the log and saving a txt file
// this txt file will fullfill the condition to autologout for the external python script
print("All files have been copied");
print("The script finished at: " + getTimestamp());
selectWindow("Log");
saveAs("Text", logfile);
