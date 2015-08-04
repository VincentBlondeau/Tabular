Class {
	#name : #XMLZipImporter,
	#superclass : #TabularImporter,
	#instVars : [
		'archive',
		'xmlDOMs'
	],
	#category : #'Tabular-Importers'
}

{ #category : #importing }
XMLZipImporter >> import: aStream [
	archive := ZipArchive new readFrom: aStream.
	^super import: aStream.

]
