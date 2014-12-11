Class {
	#name : #TabularImporter,
	#superclass : #Object,
	#instVars : [
		'archive',
		'workbook',
		'sharedStrings'
	],
	#category : #'Tabular-Importers'
}

{ #category : #importing }
TabularImporter class >> import: aPath [
	^ self new import: aPath

	
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
	workbook worksheets do: [ :aSheet |  	
				xmlSheet := XMLDOMParser parse: ((archive memberNamed: 'xl/worksheets/sheet', aSheet rID , '.xml') contentStreamFromEncoding: 'utf8') contents asString.
				aSheet extractContentsFromXml: xmlSheet ]
]

{ #category : #importing }
TabularImporter >> import: aString [
	archive := ZipArchive new readFrom: aString.
	workbook := TabularWorkbook new filename: aString.
	self extractWorkbook.
	self extractWorksheets.
	self extractSharedStrings.
	^ workbook
]
