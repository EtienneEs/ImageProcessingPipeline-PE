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
        will lead the programm to (optinal) send an email to the User that the
        processing has been finished and shutdown the computer
This little script has been written by Etienne Schmelzer.
Notes: in order to make it work in python 2: raw_input instead of input.
'''


import os
import time
import smtplib

# path to your log script
log_path = "V:\python_log.txt"

automail = "yes"
# enter your gmail address (you might need to activate an "unkown device" on your gemail
# account!! This is your python script)
mailAd = "" # optional (insert gmail adress)
pwd = "" # inserting a password is not recommended
recipient = "" # optional

def get_credentials(mailAd, pwd, recipient):
    # As we do not want to save passwords to github
    # This function checks if there are credentials and if not asks for them
    if mailAd == "":
        mailAd = raw_input("Please insert email address\n>")
    if pwd == "":
        pwd = raw_input("Please enter Password for your email {}:\n>".format(mailAd))
    if recipient == "":
        recipient = raw_input("Please insert receiving email:\n>")
    return(mailAd, pwd, recipient)

def connect_gmail(SSL = "No"):
    # will connect to the gmail server
    if SSL == "yes":

        smtpObj = smtplib.SMTP_SSL('smtp.gmail.com', 465)
        smtpObj.ehlo()
        print("SSL connection established")
        return smtpObj
    else:
        smtpObj = smtplib.SMTP('smtp.gmail.com', 587)
        smtpObj.ehlo()
        smtpObj.starttls()
        return smtpObj

def sendautomail(mailAd, pwd, recipient, msg):
    # connects to the email server, logs in, sends the mail and logs out.
    gmail=connect_gmail()
    gmail.login(mailAd, pwd)
    gmail.sendmail(mailAd, recipient, msg)
    gmail.quit()

if __name__=='__main__':
    # Checks if there is already a logfile and deletes it
    if os.path.isfile(log_path):
        os.remove(log_path)

    if automail == "yes":
        mailAd, pwd, recipient = get_credentials(mailAd, pwd, recipient)

    # Checks in a regular interval if the logfile exists
    while not os.path.isfile(log_path):
        print("File does not exist:  " + time.strftime("%H:%M:%S"))
        time.sleep(300)
    print("File exists")

    if automail == "yes":
    # email is send to the user if activated
        subject = "The Fiji Macro Script has finished"
        body = "A log file has been generated, your Session has been terminated"
        msg = "Subject: {}\n{}".format(subject, body)
        sendautomail(mailAd, pwd, recipient, msg)

    print("System will shutdown")
    time.sleep(50)
    os.system("shutdown -l")
