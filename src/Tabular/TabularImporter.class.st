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
		parse: ((archive memberNamed: 'xl/sharedStrings.xml') contentStreamFromEncoding: 'utf8') contents asString.
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
	"For now we suppose that the Sheet has the same number that the rId. So if the rId is 2, the sheet will be worksheets/sheet2.xml"

	| xmlSheet |
	workbook worksheets
		do: [ :aSheet | 
			(sheetsToExtract isNil or: [ sheetsToExtract includes: aSheet name ])
				ifTrue: [ 
					xmlSheet := XMLDOMParser
						parse:
							((archive memberNamed: 'xl/worksheets/sheet' , aSheet rID , '.xml') contentStreamFromEncoding: 'utf8') contents asString.
					aSheet extractContentsFromXml: xmlSheet ] ]
]

{ #category : #importing }
TabularImporter >> import: aStream [
	archive := ZipArchive new readFrom: aStream.
	workbook := TabularWorkbook new filename: 'import'.
	self extractWorkbook.
	self extractWorksheets.
	self extractSharedStrings.
	self extractStyles.
	^ workbook
]

{ #category : #importing }
TabularImporter >> import: aFileReference onlySheetsNamed: aCollection [


	sheetsToExtract := aCollection.
	^ self import: aFileReference
]
