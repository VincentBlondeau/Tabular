Class {
	#name : #XMLZipImporter,
	#superclass : #TabularImporter,
	#instVars : [
		'archive',
		'xmlDOMs'
	],
	#category : #'Tabular-Importers'
}

{ #category : #extracting }
XMLZipImporter >> DOMfor: aPathString [
	^xmlDOMs
		at: aPathString
		ifAbsentPut:[XMLDOMParser parse: (archive memberNamed: aPathString) contentStream].
]

{ #category : #importing }
XMLZipImporter >> import: aStream [
	archive := ZipArchive new readFrom: aStream.
	^workbook
]

{ #category : #'as yet unclassified' }
XMLZipImporter >> initialize [
	super initialize.
	xmlDOMs := Dictionary new.
]
