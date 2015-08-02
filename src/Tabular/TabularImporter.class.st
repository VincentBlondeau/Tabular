Class {
	#name : #TabularImporter,
	#superclass : #Object,
	#instVars : [
		'workbook',
		'parameters'
	],
	#category : #'Tabular-Importers'
}

{ #category : #'as yet unclassified' }
TabularImporter class >> fromFileNamed: aString [
	^self fromStream: aString asFileReference binaryReadStream
]

{ #category : #'as yet unclassified' }
TabularImporter class >> fromStream: aStream [
	self shouldBeImplemented
]

{ #category : #importing }
TabularImporter >> import: aStream [
	^workbook.
]

{ #category : #'as yet unclassified' }
TabularImporter >> initialize [
	workbook := TabularWorkbook new.
	parameters := Dictionary new.
]
