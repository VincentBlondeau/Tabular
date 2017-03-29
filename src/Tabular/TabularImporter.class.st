"
I am TabularImporter the root of a hierarchy which imports Office files.

LATER:
Subclasses HTMLImporter and ODSImporter will be added.

Public API and Key Messages

- import: aStream  (a Stream of a flat file)
- message two 
- what is the way to create instances is a plus.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	parameters:		<Object>
	workbook:		<Object>


    Implementation Points
"
Class {
	#name : #TabularImporter,
	#superclass : #Object,
	#instVars : [
		'workbook',
		'parameters'
	],
	#category : #'Tabular-Importers'
}

{ #category : #'instance creation' }
TabularImporter class >> fromFileNamed: aString [
	^self fromStream: aString asFileReference binaryReadStream
]

{ #category : #'instance creation' }
TabularImporter class >> fromStream: aStream [
	^self new import: aStream.
]

{ #category : #importing }
TabularImporter >> import: aStream [
	workbook := TabularWorkbook new.
	^workbook.
]

{ #category : #'as yet unclassified' }
TabularImporter >> initialize [
	parameters := Dictionary new.
]
