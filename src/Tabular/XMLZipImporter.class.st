"
I am XMLZipImporter and import Office files which are packed in zip files.

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
	archive:		<Object>
	xmlDOMs:		<Object>


    Implementation Points
"
Class {
	#name : #XMLZipImporter,
	#superclass : #TabularImporter,
	#instVars : [
		'archive',
		'xmlDOMs'
	],
	#category : 'Tabular-Importers'
}

{ #category : #importing }
XMLZipImporter >> import: aStream [
	archive := ZipArchive new readFrom: aStream.
	^super import: aStream.

]
