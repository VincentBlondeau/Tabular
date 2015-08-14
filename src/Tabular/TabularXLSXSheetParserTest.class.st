"
A XLSXSheetParserTest is a test class for testing the behavior of XLSXSheetParser
"
Class {
	#name : #TabularXLSXSheetParserTest,
	#superclass : #TestCase,
	#instVars : [
		'xmlString',
		'xmlString2'
	],
	#category : #'Tabular-Tests'
}

{ #category : #setUp }
TabularXLSXSheetParserTest >> setUp [

self setUpXmlString1.
self setUpXmlString2
]

{ #category : #setUp }
TabularXLSXSheetParserTest >> setUpXmlString1 [

xmlString := '<?xml version="1.0" standalone="yes"?>
<worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships">
<sheetData>
<row r="1">
<c r="A1" t="n"><v>11</v></c>
<c r="B1" t="n"><v>21</v></c>
<c r="C1" t="n"><v>31</v></c>
</row>
</sheetData>
</worksheet>
'.

]

{ #category : #setUp }
TabularXLSXSheetParserTest >> setUpXmlString2 [

xmlString2 := '<?xml version="1.0" standalone="yes"?>
<worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships">
<sheetData>

<row r="1">
<c r="A1" t="inlineStr">
<is><t>abcdefghijklmnopqrstuvwxyz 1234567890</t></is>
</c>
</row>

</sheetData>
</worksheet>'.

]

{ #category : #tests }
TabularXLSXSheetParserTest >> testCellType [
|  worksheet |
worksheet := TabularXLSXSheetParser	
	               parse: xmlString.

self assert: (worksheet cellAt: 'A1' asPoint)	 type equals: 'n'.  "number"
	

]

{ #category : #tests }
TabularXLSXSheetParserTest >> testParsingResult [
|  worksheet |
worksheet := TabularXLSXSheetParser	parse: xmlString.
self assert: (worksheet cellAt: 'A1' asPoint)	 data equals: 11.
self assert: (worksheet at: 'B1' asPoint)	 data equals: 21.
self assert: (worksheet at: 3@1)	 data equals: 31.
	

]

{ #category : #tests }
TabularXLSXSheetParserTest >> testParsingResult2 [
|  worksheet |
worksheet := TabularXLSXSheetParser	parse: xmlString2.
	
self assert: ((worksheet cellAt: 'A1' asPoint) data isKindOf: String).
self assert: (worksheet cellAt: 'A1' asPoint) data equals: 'abcdefghijklmnopqrstuvwxyz 1234567890'



	

]
