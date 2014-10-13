"
A TabularExperimenting is xxxxxxxxx.

"
Class {
	#name : #TabularExperimenting,
	#superclass : #Object,
	#instVars : [
		'workbook',
		'zip',
		'sheet'
	],
	#category : #'Tabular-Exporters'
}

{ #category : #'as yet unclassified' }
TabularExperimenting class >> createZip:filename content: aByteArray [
	|z|
	z:= ZipArchive new.
	z addString: aByteArray as: 'test.txt'.
	z addString: aByteArray as: '/dir/again.txt'.		
	z writeToFileNamed: filename.
	
]

{ #category : #'as yet unclassified' }
TabularExperimenting class >> test [
|text|
	text := WriteStream on: ''.
	text
		nextPutAll: 'This is a demo text to test ZIP posibilities of Pharo';
		cr;cr;
		nextPutAll: 'А теперь и с русскими буквами!';
		yourself.
	
	self createZip: 'helloWorld.zip' content: (text contents convertToEncoding: 'utf-8')
]

{ #category : #files }
TabularExperimenting >> cellName: coord [
	^((self columnName: coord x), (coord y asString))
]

{ #category : #files }
TabularExperimenting >> columnName: n [
	(n <= 26) ifTrue: [^(Character value: 64 + n) asString].
	
	^(self columnName: ((n-1) quo: 26)), (self columnName: ((n-1) rem: 26) +1 )
]

{ #category : #files }
TabularExperimenting >> content_types_xml [
^'<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
  <Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>
  <Override PartName="/workbook.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml"/>
  <Override PartName="/worksheet.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml"/>
</Types>'.
]

{ #category : #'as yet unclassified' }
TabularExperimenting >> generateXLSX [
	zip:= ZipArchive new.
	zip addString: self workbook_xml as: 'workbook.xml'.
	zip addString: self worksheet_xml as: 'worksheet.xml'.
	zip addString: self content_types_xml as: '[Content_Types].xml'.
	zip addString: self rels as: '_rels/.rels'.
	zip addString: self workbook_xml_rels as: '_rels/workbook.xml.rels'.
	zip writeToFileNamed: ((OSEnvironment default at: 'HOME') asPath / workbook filename).
	
]

{ #category : #initialization }
TabularExperimenting >> initialize [
	workbook := TabularWorkbook withSheets: 1.
	workbook filename: 'Test.xlsx'.
	
	sheet := workbook worksheets first.

	sheet
		at: 1@1 putData: '-';
		at: 2@1 putData: 'colspan test';
		at: 1@2 putData: 'rowspan test';
		at: 2@2 putData: 777.77.

	(sheet cells at: 2@1) colspan: 3.
	(sheet cells at: 1@2) rowspan: 3.
]

{ #category : #files }
TabularExperimenting >> mergeCells [
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
TabularExperimenting >> rels [
^'<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="workbook.xml"/>
</Relationships>'.
]

{ #category : #files }
TabularExperimenting >> renderMergeCellsOn: writer [
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

{ #category : #files }
TabularExperimenting >> renderNumberCell: cell coord: coord on: writer [
	writer tag
		name: 'c';
		attributeAt: 'r' put: (self cellName: coord);
		attributeAt: 't' put: 'n';
		with:[ writer tag: 'v' with: (cell data asString)]
]

{ #category : #files }
TabularExperimenting >> renderRow: rowN on: writer [
|keys|
	keys := (sheet cells keys select:[:coord| coord y = rowN]) sort: [:coord1 :coord2| coord1 x < coord2 x].
	"cells must be sorted by column in the file"
	keys do:[:coord||cell| 
		cell := sheet cells at: coord.
		cell data isNumber
			ifTrue: [ self renderNumberCell: cell coord: coord on: writer ]
			ifFalse: [ self renderStringCell: cell coord: coord on: writer ].
	]
]

{ #category : #files }
TabularExperimenting >> renderRowsOn: writer [
	sheet rows do:[:rowN|
		writer tag
			name: 'row';
			attributeAt: 'r' put: rowN asString;
			with:[ self renderRow: rowN on: writer]
	] 
]

{ #category : #files }
TabularExperimenting >> renderStringCell: cell coord: coord on: writer [
	writer tag
		name: 'c';
		attributeAt: 'r' put: (self cellName: coord);
		attributeAt: 't' put: 'inlineStr';
		with:[ writer tag: 'is' with: [ writer tag: 't' with: (cell data asString)]]
]

{ #category : #files }
TabularExperimenting >> workbook_xml [
^'<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships">
  <sheets>
    <sheet name="Brian" sheetId="1" r:id="rId1"/>
  </sheets>
</workbook>'.
]

{ #category : #files }
TabularExperimenting >> workbook_xml_rels [
^'<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheet.xml"/>
</Relationships>'.
]

{ #category : #files }
TabularExperimenting >> worksheet_xml [
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
TabularExperimenting >> worksheet_xml_old [
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
