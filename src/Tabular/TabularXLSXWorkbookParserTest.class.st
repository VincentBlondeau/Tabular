Class {
	#name : #TabularXLSXWorkbookParserTest,
	#superclass : #TestCase,
	#instVars : [
		'xmlStringWorkbookWith2Worksheets',
		'xmlStringWorkbookWith2WorksheetsB'
	],
	#category : #'Tabular-Tests'
}

{ #category : #setUp }
TabularXLSXWorkbookParserTest >> setUp [

xmlStringWorkbookWith2WorksheetsB := '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"><fileVersion appName="Calc"/><workbookPr backupFile="false" showObjects="all" date1904="false"/><workbookProtection/>

<sheets>
<sheet name="SheetA" sheetId="1" state="visible" r:id="rId2"/>
<sheet name="SheetB" sheetId="2" state="visible" r:id="rId3"/>
</sheets>

<calcPr iterateCount="100" refMode="A1" iterate="false" iterateDelta="0.001"/></workbook>'.



xmlStringWorkbookWith2Worksheets := '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"><fileVersion appName="Calc"/><workbookPr backupFile="false" showObjects="all" date1904="false"/><workbookProtection/><bookViews><workbookView showHorizontalScroll="true" showVerticalScroll="true" showSheetTabs="true" xWindow="0" yWindow="0" windowWidth="16384" windowHeight="8192" tabRatio="236" firstSheet="0" activeTab="0"/></bookViews><sheets><sheet name="SheetA" sheetId="1" state="visible" r:id="rId2"/><sheet name="SheetB" sheetId="2" state="visible" r:id="rId3"/></sheets><calcPr iterateCount="100" refMode="A1" iterate="false" iterateDelta="0.001"/></workbook>'
]

{ #category : #tests }
TabularXLSXWorkbookParserTest >> testParsingResult [
|  xmlString result |

xmlString := '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"><fileVersion appName="Calc"/><workbookPr backupFile="false" showObjects="all" date1904="false"/>

<sheets>
<sheet name="Sheet1" sheetId="1" state="visible" r:id="rId2"/>
</sheets>

</workbook>'.

result := TabularXLSXWorkbookParser 	parse: xmlString.
self assert: (result isKindOf: StandardOrderedDictionary).
self assert: (result at: 'rId2')	 equals: 'Sheet1'.

]

{ #category : #tests }
TabularXLSXWorkbookParserTest >> testParsingWorkbookWithTwoWorksheets [
|  result |
result := TabularXLSXWorkbookParser 	parse: xmlStringWorkbookWith2Worksheets.

self assert: (result isKindOf: StandardOrderedDictionary).
self assert: (result at: 'rId2')	 equals: 'SheetA'.
self assert: (result at: 'rId3')	 equals: 'SheetB'.
]

{ #category : #tests }
TabularXLSXWorkbookParserTest >> testParsingWorkbookWithTwoWorksheetsB [
|  result |
result := TabularXLSXWorkbookParser 	parse: xmlStringWorkbookWith2WorksheetsB.

self assert: (result isKindOf: StandardOrderedDictionary).
self assert: (result at: 'rId2')	 equals: 'SheetA'.
self assert: (result at: 'rId3')	 equals: 'SheetB'.
]
