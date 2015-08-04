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
	workbook := TabularWorkbook new.
	^workbook.
]

{ #category : #'as yet unclassified' }
TabularImporter >> initialize [
	parameters := Dictionary new.
]
