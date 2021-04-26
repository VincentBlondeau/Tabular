"
A XLSXSheetParserTest is a test class for testing the behavior of XLSXSheetParser
"
Class {
	#name : #TabularXLSXSheetParserTest,
	#superclass : #TestCase,
	#instVars : [
		'xmlString',
		'xmlString2',
		'xmlString3'
	],
	#category : #'Tabular-Tests'
}

{ #category : #setUp }
TabularXLSXSheetParserTest >> setUp [

self setUpXmlString1.
self setUpXmlString2.
self setUpXmlString3
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

{ #category : #setUp }
TabularXLSXSheetParserTest >> setUpXmlString3 [

xmlString3 := '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships">

<sheetPr filterMode="false"><pageSetUpPr fitToPage="false"/></sheetPr>

<dimension ref="A1:C2"/>
<sheetViews>
<sheetView windowProtection="false" showFormulas="false" showGridLines="true" showRowColHeaders="true" showZeros="true" rightToLeft="false" tabSelected="true" showOutlineSymbols="true" defaultGridColor="true" view="normal" topLeftCell="A1" colorId="64" zoomScale="100" zoomScaleNormal="100" zoomScalePageLayoutView="100" workbookViewId="0">
<selection pane="topLeft" activeCell="C1" activeCellId="0" sqref="C1"/>
</sheetView>
</sheetViews>

<sheetFormatPr defaultRowHeight="12.8"></sheetFormatPr>

<cols>
<col collapsed="false" hidden="false" max="1" min="1" style="0" width="11.5204081632653"/>
<col collapsed="false" hidden="false" max="2" min="2" style="0" width="20.4132653061224"/>
<col collapsed="false" hidden="false" max="3" min="3" style="0" width="36.0255102040816"/>
<col collapsed="false" hidden="false" max="1025" min="4" style="0" width="11.5204081632653"/>
</cols>

<sheetData>
<row r="1" customFormat="false" ht="12.8" hidden="false" customHeight="false" outlineLevel="0" collapsed="false">
<c r="A1" s="0" t="s"><v>0</v></c>
<c r="B1" s="0" t="s"><v>1</v></c>
<c r="C1" s="0" t="s"><v>2</v></c>
</row>
<row r="2" customFormat="false" ht="12.8" hidden="false" customHeight="false" outlineLevel="0" collapsed="false">
<c r="A2" s="0" t="s"><v>3</v></c>
<c r="B2" s="0" t="s"><v>4</v></c>
<c r="C2" s="0" t="s"><v>5</v></c>
</row>
</sheetData>

<printOptions headings="false" gridLines="false" gridLinesSet="true" horizontalCentered="false" verticalCentered="false"/><pageMargins left="0.7875" right="0.7875" top="1.05277777777778" bottom="1.05277777777778" header="0.7875" footer="0.7875"/><pageSetup paperSize="9" scale="100" firstPageNumber="1" fitToWidth="1" fitToHeight="1" pageOrder="downThenOver" orientation="portrait" usePrinterDefaults="false" blackAndWhite="false" draft="false" cellComments="none" useFirstPageNumber="true" horizontalDpi="300" verticalDpi="300" copies="1"/><headerFooter differentFirst="false" differentOddEven="false"><oddHeader>&amp;C&amp;&quot;Times New Roman,Regular&quot;&amp;12&amp;A</oddHeader><oddFooter>&amp;C&amp;&quot;Times New Roman,Regular&quot;&amp;12Page &amp;P</oddFooter></headerFooter></worksheet>
'.

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

{ #category : #tests }
TabularXLSXSheetParserTest >> testParsingResult3 [
"check for column attributes"

|  worksheet |
worksheet := TabularXLSXSheetParser	parse: xmlString3.
	
self assert: ((worksheet cellAt: 'A1' asPoint) data isKindOf: String).
self assert: (worksheet columnAttributes first at: 'min')  equals: '1'.
self assert: (worksheet columnAttributes first at: 'max')  equals: '1'.
self assert: (worksheet columnAttributes first at: 'width')  equals: '11.5204081632653'.



	

]
