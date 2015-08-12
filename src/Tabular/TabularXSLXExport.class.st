"
I am TabularXSLXExport and exports worksheets to Excel XSLX file format.

NEXT STEPS:

1. Make workbook export functional. Currently only the first sheet is exported.
2. Add more test cases and examples.
3. Create a class TabularDOCXExport as a copy of this class and make it work.


LIMITATIONS:

see example2




"
Class {
	#name : #TabularXSLXExport,
	#superclass : #TabularExport,
	#instVars : [
		'zip',
		'writer'
	],
	#category : #'Tabular-Exporters'
}

{ #category : #examples }
TabularXSLXExport class >> example1 [

    self workbook: (TabularWorkbook example1) fileName: 'TabularTest1.xlsx'
]

{ #category : #examples }
TabularXSLXExport class >> example2 [
"round trip"
 | workbook |

self halt. "does not work yet"
self workbook: (TabularWorkbook example1) fileName: 'TabularTest2Export.xlsx'.

workbook := XLSXImporter import: (FileLocator home / 'TabularTest2Export.xlsx') asFileReference.

self workbook: (TabularWorkbook example1) fileName: 'TabularTest2ExportAndReimported.xlsx'.
]

{ #category : #examples }
TabularXSLXExport class >> example3 [

    | file workbook |
	file := TabularResources testExcelFile3WithAlignment readStream.
	workbook := XLSXImporter import: file.

    self workbook: workbook fileName: 'TabularTest2WithAlingment.xlsx'

"merged cells are not properly rendered; alingment is not rendered"
]

{ #category : #files }
TabularXSLXExport >> content_types_xml [
^'<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
  <Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>
  <Override PartName="/workbook.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml"/>
  <Override PartName="/worksheet.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml"/>
</Types>'.
]

{ #category : #files }
TabularXSLXExport >> generate [
	zip:= ZipArchive new.
	zip addString: self workbook_xml as: 'workbook.xml'.
	zip addString: self worksheet_xml as: 'worksheet.xml'.
	zip addString: self content_types_xml as: '[Content_Types].xml'.
	zip addString: self rels as: '_rels/.rels'.
	zip addString: self workbook_xml_rels as: '_rels/workbook.xml.rels'.
	zip writeToFileNamed: (FileLocator home / workbook filename).
	
]

{ #category : #rendering }
TabularXSLXExport >> mergeCells [
|res|
	res := Dictionary new.
	sheet cells keysAndValuesDo:[:coord :cell|
		(cell colspan notNil | cell rowspan notNil) ifTrue:[ |offset|
			offset := (cell colspan ifNil:[0]) @ (cell rowspan ifNil:[0]). "Should upgrade it with Protected Arithmetic"
			res at: coord put: (coord + offset).
		].
	].
	^res.
]

{ #category : #files }
TabularXSLXExport >> rels [
^'<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="workbook.xml"/>
</Relationships>'.
]

{ #category : #rendering }
TabularXSLXExport >> renderCell: coord [
	| cell |
	cell := sheet cells at: coord.
	^ cell data isNumber
		ifTrue: [ self renderCellWithNumber: coord ]
		ifFalse: [ 
			(cell data isKindOf: Date)
				ifTrue: [ self renderCellWithDate: coord ]
				ifFalse: [ self renderCellWithString: coord ] ]
]

{ #category : #rendering }
TabularXSLXExport >> renderCellWithDate: coord [
	writer tag
		name: 'c';
		attributeAt: 'r' put: (self cellName: coord);
		attributeAt: 't' put: 'inlineStr';
		with:[ writer tag: 'is' with: [ writer tag: 't' with: ((sheet cells at: coord) data ddmmyyyy)]]
]

{ #category : #rendering }
TabularXSLXExport >> renderCellWithNumber:  coord [
	writer tag
		name: 'c';
		attributeAt: 'r' put: (self cellName: coord);
		attributeAt: 't' put: 'n';
		with:[ writer tag: 'v' with: ((sheet cells at: coord) data asString)]
]

{ #category : #rendering }
TabularXSLXExport >> renderCellWithString: coord [

	writer tag
		name: 'c';
		attributeAt: 'r' put: (self cellName: coord);
		attributeAt: 't' put: 'inlineStr';
		with:[ writer tag: 'is' with: [ writer tag: 't' with: ((sheet cells at: coord) data asString)]]
]

{ #category : #rendering }
TabularXSLXExport >> renderMergeCells [
	self mergeCells ifNotEmptyDo: [ : mergeCells |
		writer tag: 'mergeCells' with:[
			mergeCells keysAndValuesDo: [:topleft :bottomright|
				writer tag
					name: 'mergeCell';
					attributeAt: 'ref' put: ((self cellName: topleft),':', (self cellName: bottomright)).
			]
		]
	 ]

]

{ #category : #rendering }
TabularXSLXExport >> renderRow: rowN [
	| keys |
	keys := (sheet cells keys 
	select: [ :coord | coord y = rowN ]) 
	sort: [ :coord1 :coord2 | coord1 x < coord2 x ].	
		
	"cells must be sorted by column in the file"
	keys do: [ :coord | self renderCell: coord ]
]

{ #category : #rendering }
TabularXSLXExport >> renderRows [
	sheet rows do:[:rowN|
		writer tag
			name: 'row';
			attributeAt: 'r' put: rowN asString;
			with:[ self renderRow: rowN]
	] 
]

{ #category : #rendering }
TabularXSLXExport >> renderWorksheet [
	writer tag
		name: 'worksheet';
		attributeAt: 'xmlns' put: 'http://schemas.openxmlformats.org/spreadsheetml/2006/main';
		attributeAt: 'xmlns:r' put: 'http://schemas.openxmlformats.org/officeDocument/2006/relationships';
		with: [ 
					writer tag: 'sheetData' with: [ self renderRows ].
					self renderMergeCells ]
]

{ #category : #files }
TabularXSLXExport >> workbook_xml [
^'<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships">
  <sheets>
    <sheet name="Page 1" sheetId="1" r:id="rId1"/>
  </sheets>
</workbook>'.
]

{ #category : #files }
TabularXSLXExport >> workbook_xml_rels [
^'<?xml version="1.0" encoding="UTF-8" standalone="yes"?>

<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">

  <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheet.xml"/>

</Relationships>'.
]

{ #category : #files }
TabularXSLXExport >> worksheet_xml [
	writer := XMLWriter new.
	writer xml standalone: true.
	self renderWorksheet.
	^ writer write contents convertToEncoding: 'utf-8'
]
