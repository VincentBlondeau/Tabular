Class {
	#name : #XLSXImporter,
	#superclass : #XMLZipImporter,
	#instVars : [
		'sharedStrings',
		'workbookRels',
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
	^sharedStrings := XLSXSharedStringsParser parse: (archive memberNamed: 'xl/sharedStrings.xml') contentStream.

]

{ #category : #extracting }
XLSXImporter >> extractStyles [
	self notYetImplemented.
	"| styles |
	styles := self DOMfor: 'xl/styles.xml'.
	workbook
		styles:
			((TabularStylesContainer newFrom: workbook)
				extractFromXml: styles;
				yourself)"
]

{ #category : #extracting }
XLSXImporter >> extractWorkbookRels [
	^workbookRels := XLSXRelsParser parse: (archive memberNamed: 'xl/_rels/workbook.xml.rels') contentStream.
]

{ #category : #extracting }
XLSXImporter >> extractWorksheets [
	self extractWorkbookRels.
	self extractWorksheetsList keysAndValuesDo: [ :id :sheetName | | aSheet |
			aSheet := XLSXSheetParser	parse: ((archive memberNamed: (self getPathForSheet: id)) contentStream).				
			aSheet name: sheetName.
			workbook addSheet: aSheet.
		].
	^workbook worksheets.
]

{ #category : #extracting }
XLSXImporter >> extractWorksheetsList [
| list |
	list:=XLSXWorkbookParser parse: (archive memberNamed: 'xl/workbook.xml') contentStream.
	sheetsToExtract ifNotNil:[list := list associationsSelect: [:assoc| sheetsToExtract includes: assoc value] ].
	^list.

]

{ #category : #extracting }
XLSXImporter >> getPathForSheet: rID [
	^'xl/',(workbookRels at: rID).
	
]

{ #category : #importing }
XLSXImporter >> import: aStream [
	archive := ZipArchive new readFrom: aStream.
	workbook := TabularWorkbook new.
	"self extractStyles."
	self extractSharedStrings.
	self extractWorksheets.

	self resolveSharedStrings.
	^ workbook
]

{ #category : #importing }
XLSXImporter >> import: aFileReference onlySheetsNamed: aCollection [


	sheetsToExtract := aCollection.
	^ self import: aFileReference
]

{ #category : #'as yet unclassified' }
XLSXImporter >> resolveSharedStrings [
"Replace shared strings pointers to real strings"
	workbook worksheets do:[:worksheet|
		worksheet cells do:[:cell| 
			((cell attributeAt: #xlsx:t) = 's')
				ifTrue:[cell data: (sharedStrings at: (cell data asNumber + 1))] "XLSX uses 0-based arrays"
		]
	]
]
