Class {
	#name : #XLSXImporter,
	#superclass : #XMLZipImporter,
	#instVars : [
		'sharedStrings',
		'sheetsToExtract'
	],
	#category : #'Tabular-Importers'
}

{ #category : #importing }
XLSXImporter class >> import: aStream [
	^ self new import: aStream

	
]

{ #category : #importing }
XLSXImporter class >> import: aFileReferenceOrAStream onlySheetsNamed: aCollection [
	^ self new import: aFileReferenceOrAStream onlySheetsNamed: aCollection
]

{ #category : #extracting }
XLSXImporter >> extractSharedStrings [
	| strings |
	strings := self DOMfor: 'xl/sharedStrings.xml'.
	workbook
		stringTable:
			((TabularSharedStrings newFrom: workbook)
				extractFromXml: strings;
				yourself)
]

{ #category : #importing }
XLSXImporter >> extractStyles [
	| styles |
	styles := self DOMfor: 'xl/styles.xml'.
	workbook
		styles:
			((TabularStylesContainer newFrom: workbook)
				extractFromXml: styles;
				yourself)
]

{ #category : #extracting }
XLSXImporter >> extractWorkbook [
	| workbookXML |
	workbookXML := self DOMfor: 'xl/workbook.xml'.
	workbookXML
		allElementsNamed: 'sheet'
		do: [ :aXmlSheet | 
			workbook
				addSheet:
					((TabularWorksheet newFrom: workbook)
						extractFromXml: aXmlSheet;
						yourself) ]
]

{ #category : #extracting }
XLSXImporter >> extractWorksheets [
	| xmlSheet |
	workbook worksheets
		do: [ :aSheet | 
			(sheetsToExtract isNil or: [sheetsToExtract includes: aSheet name])
				ifTrue: [ 
					xmlSheet := 	self DOMfor: (self getPathForSheet: aSheet rID).
					aSheet extractContentsFromXml: xmlSheet.
				]
		]
]

{ #category : #extracting }
XLSXImporter >> getPathForSheet: rID [
	| relation |
	relation:=((self DOMfor: 'xl/_rels/workbook.xml.rels')
		findElementNamed: 'Relationships')
			elementsDetect: [:rel| (rel attributeAt: 'Id') = ('rId', rID)]
			ifNone: [^'xl/worksheets/sheet' , rID , '.xml'].
	^'xl/',(relation attributeAt: 'Target').
	
]

{ #category : #'as yet unclassified' }
XLSXImporter >> import: aStream [
	archive := ZipArchive new readFrom: aStream.
	workbook := TabularWorkbook new filename: 'import'.
	self extractWorkbook.
	self extractSharedStrings.
	self extractStyles.
	self extractWorksheets.
	^ workbook
]

{ #category : #importing }
XLSXImporter >> import: aFileReference onlySheetsNamed: aCollection [


	sheetsToExtract := aCollection.
	^ self import: aFileReference
]
