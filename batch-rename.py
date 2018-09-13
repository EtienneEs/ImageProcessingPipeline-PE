import os
import glob
from tkinter import filedialog as fd
#from sys import argv
#script, path = argv
# insert the path below!


#path = "V:/deconvolved/"
path = fd.askdirectory()
os.chdir(path)

print(os.getcwd())
# excluding directories inside of the directory
lista= [file for file in glob.glob('*') if not os.path.isdir(file)]
print(lista[1])
# the deconvolution with the HRM servers add (job?)numbers in the back: 18_07_06_*GFP*_*mCherry*_-_18_07_06_*GFP*_*mCherry*_6_5b98b010b9912_hrm.r3d

deconvolved = raw_input("Were the files deconvolved by an HRM server, which adds numbers in the back ? insert 'yes' \n  >")
#deconvolved = "yes"
print("The files will be renamed now")
for f in lista:
    name, file_extension = f.split(".")
    if str(deconvolved) == "yes":
        name = name[0:(len(name)-18)]
    if "_-_" in name:
        folder_name, name = name.split('_-_')
    final_name = name + "." + file_extension
    print(final_name)
    os.rename(f, final_name)
print("All files have been renamed")
