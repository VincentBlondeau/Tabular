"
I am ƖXLSXImporter which imports Excel files.

Key message for importing is in TabularCell>>extractFromXml: aXMLElement

The attribute t=""s"" of a cell c seems to indicate that the content has
to be interpreted as a shared string.

The other variant is an inline string

t=""inlineStr""

<row r=""1"">
<c r=""A1"" t=""inlineStr"">
<is><t>abcdefghijklmnopqrstuvwxyz 1234567890</t></is>
</c>




For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- import: aReadStream   
- message two 
- what is the way to create instances is a plus.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	sharedStrings:		<Object>
	sheetsToExtract:		<Object>
	workbookRels:		<Object>


    Implementation Points
"
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

{ #category : #importing }
XLSXImporter >> extractArchive: aStream [
	(ZipArchive isZipArchive: aStream)
		ifTrue: [archive := ZipArchive new readFrom: aStream]
		ifFalse: [  self error: 'XLSX file do not represent valid Zip archive, as it should be' ]. "Maybe you missed it with XLS file?"
	
	
]

{ #category : #extracting }
XLSXImporter >> extractSharedStrings [
      (archive memberNamed: 'xl/sharedStrings.xml') isNil ifTrue: [ ^sharedStrings    := '']
ifFalse: 
	[^sharedStrings := TabularXLSXSharedStringsParser parse: (archive memberNamed: 'xl/sharedStrings.xml') contentStream]
	

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
			aSheet := TabularXLSXSheetParser	parse: ((archive memberNamed: (self getPathForSheet: id)) contentStream).				
			aSheet name: sheetName.
			workbook addSheet: aSheet.
		].
	^workbook worksheets.
]

{ #category : #extracting }
XLSXImporter >> extractWorksheetsList [
| list |
	list:=TabularXLSXWorkbookParser parse: (archive memberNamed: 'xl/workbook.xml') contentStream.
	sheetsToExtract ifNotNil:[list := list associationsSelect: [:assoc| sheetsToExtract includes: assoc value] ].
	^list.

]

{ #category : #extracting }
XLSXImporter >> getPathForSheet: rID [
	^'xl/',(workbookRels at: rID).
	
]

{ #category : #importing }
XLSXImporter >> import: aStream [
	self extractArchive: aStream.
	workbook := TabularWorkbook new.	"self extractStyles."
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
		worksheet cellsDo:[:cell| 
			((cell attributeAt: #xlsx:t) = 's')
				ifTrue:[cell data: (sharedStrings at: (cell data asNumber + 1))] "XLSX uses 0-based arrays"
		]
	]
]
