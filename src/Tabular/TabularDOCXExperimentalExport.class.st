"
I am TabularDOCXExperimentalExport and export a TabularWorkbook to a DOCX file.


For the Class part:  State the name of the class with one line description: For example, I'm xxx the root of the hierarchy of visitor objects.

For the Responsibility part: Three sentences about my main responsibility, what I'm doing, what services do I offer.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- what is the way to create instances is a plus.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	zip:		<Object>


    Implementation Points


DOCX files are zip files but instead of a *.zip extension there is a *.DOCX extension.

Basic code to create a zip file.
zip:= ZipArchive new. 
zip addString: 'hallo' as: 'theFile.txt'.
zip writeToFileNamed: (FileLocator temp / 'myfile.zip') .


"
Class {
	#name : #TabularDOCXExperimentalExport,
	#superclass : #TabularExport,
	#instVars : [
		'zip'
	],
	#category : #'Tabular-Exporters'
}

{ #category : #'as yet unclassified' }
TabularDOCXExperimentalExport >> generate [

"use the workbook instance variable and the zip instance variable to populate the archive."

self halt.
]
