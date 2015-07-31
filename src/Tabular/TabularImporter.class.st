Class {
	#name : #TabularImporter,
	#superclass : #Object,
	#instVars : [
		'archive',
		'workbook',
		'sharedStrings',
		'sheetsToExtract'
	],
	#category : #'Tabular-Importers'
}

{ #category : #importing }
TabularImporter class >> import: aStream [
	^ self new import: aStream

	
]

{ #category : #importing }
TabularImporter class >> import: aFileReferenceOrAStream onlySheetsNamed: aCollection [
	^ self new import: aFileReferenceOrAStream onlySheetsNamed: aCollection
]

{ #category : #extracting }
TabularImporter >> extractSharedStrings [
	| strings |
	strings := XMLDOMParser
		parse: (((archive memberNamed: 'xl/sharedStrings.xml') "contentStreamFromEncoding: 'utf8'") contents asString convertFromEncoding: 'utf-8').
	workbook
		stringTable:
			((TabularSharedStrings newFrom: workbook)
				extractFromXml: strings;
				yourself)
]

{ #category : #importing }
TabularImporter >> extractStyles [
	| styles |
	styles := XMLDOMParser
		parse: ((archive memberNamed: 'xl/styles.xml') contentStreamFromEncoding: 'utf8') contents asString.
	workbook
		styles:
			((TabularStylesContainer newFrom: workbook)
				extractFromXml: styles;
				yourself)
]

{ #category : #extracting }
TabularImporter >> extractWorkbook [
	| workbookXML |
	workbookXML := XMLDOMParser
		parse: ((archive memberNamed: 'xl/workbook.xml') contentStreamFromEncoding: 'utf8') contents asString.
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
TabularImporter >> extractWorksheets [
	| xmlSheet |
	workbook worksheets
		do: [ :aSheet | 
			(sheetsToExtract isNil or: [ sheetsToExtract includes: aSheet name ])
				ifTrue: [ 
					xmlSheet := XMLDOMParser
						parse:
							((archive memberNamed: (self getPathForSheet: aSheet rID)) contentStreamFromEncoding: 'utf8') contents asString.
					aSheet extractContentsFromXml: xmlSheet ] ]
]

{ #category : #extracting }
TabularImporter >> getPathForSheet: rID [
	| relation |
	relation:=((XMLDOMParser parse:(
		(archive memberNamed: 'xl/_rels/workbook.xml.rels') contentStreamFromEncoding: 'utf8'
	)) findElementNamed: 'Relationships')
			elementsDetect: [:rel| (rel attributeAt: 'Id') = ('rId', rID)]
			ifNone: [^'xl/worksheets/sheet' , rID , '.xml'].
	^'xl/',(relation attributeAt: 'Target').
	
]

{ #category : #importing }
TabularImporter >> import: aStream [
	archive := ZipArchive new readFrom: aStream.
	workbook := TabularWorkbook new filename: 'import'.
	self extractWorkbook.
	self extractSharedStrings.
	self extractStyles.
	self extractWorksheets.
	^ workbook
]

{ #category : #importing }
TabularImporter >> import: aFileReference onlySheetsNamed: aCollection [


	sheetsToExtract := aCollection.
	^ self import: aFileReference
]
