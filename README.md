# Armada campaign tool

This is a minute maid tool that work with the Corelian conflict manager.
https://community.fantasyflightgames.com/topic/243667-corellian-conflict-manager-70-google-spreadsheet/

This tools can print a text version of all fleets (with scarred ships and repair costs).
It also help to print the "bill" of repairs.

## Caution

This tool is not meant to be used "out of the box". You will have a lot of work to adapt it to your campaign.

Also I'm french, so a lot of strings are in french untranslated. I don't plan to change this, but if other people are interested
I can work on a better version. Just ask :)

## Anyway

If you still want to use this tool, you have to create an account on google spreadsheets (see : https://developers.google.com/sheets/api/quickstart/ruby)
Put the credential.json file in the run directory and then you can start.

From the run directory you have to launch
```
ruby update_data.rb     # retrieve the data from the spreadsheet
ruby process_data.rb    # work on the data so that they are more usefull
```

Then you can use
```
ruby print_fleets.rb    # print fleets lists
ruby process_data.rb    # print repair bill
```

**Remember you will have to adapt the code to your campaign. Nothing will work automatically.**