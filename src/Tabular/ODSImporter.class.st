Class {
	#name : #ODSImporter,
	#superclass : #XMLZipImporter,
	#category : #'Tabular-Importers'
}

{ #category : #extracting }
ODSImporter >> extractWorksheets [
	"comment stating purpose of message"

	| dom content |
	content := archive memberNamed: 'content.xml'.
	"dom := XMLDOMParser parse: content contentStream."
	workbook := ODSContentParser parse: content contentStream.

]

{ #category : #importing }
ODSImporter >> import: aStream [
	"comment stating purpose of message"

	super import: aStream.
	self extractWorksheets.
	^ workbook
]
