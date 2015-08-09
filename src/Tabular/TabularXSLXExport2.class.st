"
I am TabularXSLXExport2 an experimental class which exports worksheets to Excel XSLX file format.

NEXT STEP:

Refactor TabularXSLXExport2 

Keep the working TabularXSLXExport1 as reference in the image until TabularXSLXExport2 is fine.

Usage: 


TabularXSLXExport2 on: aWorkbook.

TabularXSLXExport2 on: TabularWorkbook example1



Note: I need to be refactored.
"
Class {
	#name : #TabularXSLXExport2,
	#superclass : #TabularExport,
	#instVars : [
		'zip',
		'writer'
	],
	#category : #'Tabular-Exporters'
}

{ #category : #examples }
TabularXSLXExport2 class >> example1b [

    self workbook: (TabularWorkbook example1) fileName: 'Test1b.xlsx'
]

{ #category : #examples }
TabularXSLXExport2 class >> example2 [

	| aStream |
	self halt.
	"please complete"
	self export: (TabularWorkbook example1) stream: aStream.
]

{ #category : #files }
TabularXSLXExport2 >> content_types_xml [
^'<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
  <Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>
  <Override PartName="/workbook.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml"/>
  <Override PartName="/worksheet.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml"/>
</Types>'.
]

{ #category : #generating }
TabularXSLXExport2 >> generate [
	zip:= ZipArchive new.
	zip addString: self workbook_xml as: 'workbook.xml'.
	zip addString: (self worksheet_xml convertToEncoding: 'utf-8') as: 'worksheet.xml'.
	zip addString: self content_types_xml as: '[Content_Types].xml'.
	zip addString: self rels as: '_rels/.rels'.
	zip addString: self workbook_xml_rels as: '_rels/workbook.xml.rels'.
	zip writeToFileNamed: ((OSEnvironment default at: 'HOME') asPath / workbook filename).
	
]

{ #category : #generating }
TabularXSLXExport2 >> generateXLSX: aWorkbook to: aStream [
	workbook := aWorkbook.
	sheet := workbook worksheets first.
	^self generateXLSXto: aStream.
]

{ #category : #generating }
TabularXSLXExport2 >> generateXLSXto: aStream [
	zip:= ZipArchive new.
	zip addString: self workbook_xml as: 'workbook.xml'.
	zip addString: (self worksheet_xml convertToEncoding: 'utf-8') as: 'worksheet.xml'.
	zip addString: self content_types_xml as: '[Content_Types].xml'.
	zip addString: self rels as: '_rels/.rels'.
	zip addString: self workbook_xml_rels as: '_rels/workbook.xml.rels'.
	zip writeTo: aStream.
	
]

{ #category : #generating }
TabularXSLXExport2 >> mergeCells [
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
TabularXSLXExport2 >> rels [
^'<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="workbook.xml"/>
</Relationships>'.
]

{ #category : #rendering }
TabularXSLXExport2 >> renderDataCell: cell coord: coord on: writer [
	writer tag
		name: 'c';
		attributeAt: 'r' put: (self cellName: coord);
		attributeAt: 't' put: 'inlineStr';
		with:[ writer tag: 'is' with: [ writer tag: 't' with: (cell data ddmmyyyy)]]
]

{ #category : #rendering }
TabularXSLXExport2 >> renderMergeCellsOn: writer [
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
TabularXSLXExport2 >> renderNumberCell: cell coord: coord on: writer [
	writer tag
		name: 'c';
		attributeAt: 'r' put: (self cellName: coord);
		attributeAt: 't' put: 'n';
		with:[ writer tag: 'v' with: (cell data asString)]
]

{ #category : #rendering }
TabularXSLXExport2 >> renderRow: rowN on: writer [
|keys|
	keys := (sheet cells keys select:[:coord| coord y = rowN]) sort: [:coord1 :coord2| coord1 x < coord2 x].
	"cells must be sorted by column in the file"
	keys do:[:coord||cell| 
		cell := sheet cells at: coord.
		cell data isNumber
			ifTrue: [ self renderNumberCell: cell coord: coord on: writer ]
			ifFalse: [ 
				(cell data isKindOf: Date)
					ifTrue: [self renderDataCell: cell coord: coord on: writer ]
					ifFalse:  [self renderStringCell: cell coord: coord on: writer ]
				].
	]
]

{ #category : #rendering }
TabularXSLXExport2 >> renderRowsOn: writer [
	sheet rows do:[:rowN|
		writer tag
			name: 'row';
			attributeAt: 'r' put: rowN asString;
			with:[ self renderRow: rowN on: writer]
	] 
]

{ #category : #rendering }
TabularXSLXExport2 >> renderStringCell: cell coord: coord on: writer [
	writer tag
		name: 'c';
		attributeAt: 'r' put: (self cellName: coord);
		attributeAt: 't' put: 'inlineStr';
		with:[ writer tag: 'is' with: [ writer tag: 't' with: (cell data asString)]]
]

{ #category : #files }
TabularXSLXExport2 >> workbook_xml [
^'<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships">
  <sheets>
    <sheet name="Page 1" sheetId="1" r:id="rId1"/>
  </sheets>
</workbook>'.
]

{ #category : #files }
TabularXSLXExport2 >> workbook_xml_rels [
^'<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheet.xml"/>
</Relationships>'.
]

{ #category : #files }
TabularXSLXExport2 >> worksheet_xml [
|writer|


	writer := XMLWriter new.
	writer xml standalone: true.
	
	writer tag
		name: 'worksheet';
		attributeAt: 'xmlns' put: 'http://schemas.openxmlformats.org/spreadsheetml/2006/main';
		attributeAt: 'xmlns:r' put: 'http://schemas.openxmlformats.org/officeDocument/2006/relationships';
		with:[
			writer tag: 'sheetData' with: [ self renderRowsOn: writer ].
			self renderMergeCellsOn: writer.
		].
	^writer write contents.
]

{ #category : #files }
TabularXSLXExport2 >> worksheet_xml_old [
^'<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships">
  <sheetData>
    <row>
      <c t="inlineStr">
        <is>
          <t>Sub Total</t>
        </is>
      </c>
      <c t="inlineStr">
        <is>
          <t>Tax</t>
        </is>
      </c>
      <c t="inlineStr">
        <is>
          <t>Total</t>
        </is>
      </c>
    </row>
    <row>
      <c>
        <v>14.95</v>
      </c>
    </row>
    <row>
      <c>
        <v>19.95</v>
      </c>
    </row>
    <row>
      <c>
        <v>4.95</v>
      </c>
    </row>
  </sheetData>
</worksheet>'.
]
