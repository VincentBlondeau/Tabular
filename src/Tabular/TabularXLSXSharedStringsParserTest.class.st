Class {
	#name : #TabularXLSXSharedStringsParserTest,
	#superclass : #TestCase,
	#instVars : [
		'xmlString'
	],
	#category : #'Tabular-Tests'
}

{ #category : #setUp }
TabularXLSXSharedStringsParserTest >> setUp [

xmlString := '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<sst xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" count="10" uniqueCount="6"><si><t>aaa</t></si><si><t>bbb</t></si><si><t>ccc</t></si><si><t>Berne</t></si><si><t>Lille</t></si><si><t>Москва</t></si></sst>'.

]

{ #category : #tests }
TabularXLSXSharedStringsParserTest >> testParsingResult [
|  obj |
obj := TabularXLSXSharedStringsParser 	parse: xmlString.
self assert: obj first  equals: 'aaa'.
self assert: obj second equals: 'bbb'.
self assert: obj third equals: 'ccc'.
self assert: obj fourth equals: 'Berne'.
self assert: obj fifth equals: 'Lille'.
self assert: obj sixth equals: 'Москва'.
]
