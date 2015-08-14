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

" [Content_Types].xml file, this describes the location of the major files in the archive and the standards to which it itself adheres and the content types of those files. 

hard coded at the moment, should be constructed later, I Hannes Hirzel assume.
"

^'<?xml version="1.0" encoding="UTF-8"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">

<Override PartName="/_rels/.rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/><Override PartName="/docProps/app.xml" ContentType="application/vnd.openxmlformats-officedocument.extended-properties+xml"/>

<Override PartName="/docProps/core.xml" ContentType="application/vnd.openxmlformats-package.core-properties+xml"/>

<Override PartName="/xl/_rels/workbook.xml.rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/><Override PartName="/xl/sharedStrings.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sharedStrings+xml"/>

<Override PartName="/xl/worksheets/sheet1.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml"/>

<Override PartName="/xl/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.styles+xml"/><Override PartName="/xl/workbook.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml"/>
</Types>'.
]

{ #category : #files }
TabularXSLXExport >> content_types_xmlOLD [
^'<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
  <Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>
  <Override PartName="/workbook.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml"/>
  <Override PartName="/worksheet.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml"/>
</Types>'.
]

{ #category : #files }
TabularXSLXExport >> docPropsApp_xml [
^'<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Properties xmlns="http://schemas.openxmlformats.org/officeDocument/2006/extended-properties" xmlns:vt="http://schemas.openxmlformats.org/officeDocument/2006/docPropsVTypes">

<TotalTime>125</TotalTime>

<Application>TabularExport </Application>

</Properties>'.
]

{ #category : #'files-docPropsCore' }
TabularXSLXExport >> docPropsCore_xml [
^ self docPropsCore_xml_1,
self docPropsCore_xml_2_creation_date ,
self docPropsCore_xml_3 
]

{ #category : #'files-docPropsCore' }
TabularXSLXExport >> docPropsCore_xml_1 [
^'<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<cp:coreProperties xmlns:cp="http://schemas.openxmlformats.org/package/2006/metadata/core-properties" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:dcmitype="http://purl.org/dc/dcmitype/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">

'.
]

{ #category : #'files-docPropsCore' }
TabularXSLXExport >> docPropsCore_xml_2_creation_date [
^'
<dcterms:created xsi:type="dcterms:W3CDTF">',

DateAndTime now asString,

'</dcterms:created>

<dc:creator>tabular </dc:creator><dc:language>en-GB</dc:language>
'.
]

{ #category : #'files-docPropsCore' }
TabularXSLXExport >> docPropsCore_xml_3 [
^'
<cp:revision>1</cp:revision>

</cp:coreProperties>
'.
]

{ #category : #files }
TabularXSLXExport >> generate [
   
	| fname |
	zip:= ZipArchive new.
	fname := workbook filename.
	zip addString: self content_types_xml as: '[Content_Types].xml'.
	zip addString: self rels as: '_rels/.rels'.

	zip addString: self docPropsApp_xml as: 'docProps/app.xml'.
	zip addString: self docPropsCore_xml as: 'docProps/core.xml'.

    "Everything outside the xl/ folder is just meta data"

	zip addString: self workbook_xml as: 'xl/workbook.xml'.
	zip addString: self sharedStrings_xml  as: 'xl/sharedStrings.xml'.
	zip addString: self styles_xml   as: 'xl/styles.xml'.
	
	zip addString: self worksheet_xml as: 'xl/worksheets/sheet1.xml'.
	zip addString: self workbook_xml_rels as: 'xl/_rels/workbook.xml.rels'.

	zip writeToFileNamed: (FileLocator home / fname ).
	
]

{ #category : #files }
TabularXSLXExport >> generateOLD [
   
	| fname |
	zip:= ZipArchive new.
	fname := workbook filename.
	zip addString: self workbook_xml as: 'workbook.xml'.
	zip addString: self worksheet_xml as: 'worksheet.xml'.
	zip addString: self content_types_xmlOLD as: '[Content_Types].xml'.
	zip addString: self relsOLD as: '_rels/.rels'.
	zip addString: self workbook_xml_rels as: '_rels/workbook.xml.rels'.
	zip writeToFileNamed: (FileLocator home / fname ).
	
]

{ #category : #rendering }
TabularXSLXExport >> mergeCells [
|res|
	res := Dictionary new.
	sheet cellsKeysAndValuesDo: [:coord :cell|
		(cell colspan notNil | cell rowspan notNil) ifTrue:[ |offset|
			offset := (cell colspan ifNil:[0]) @ (cell rowspan ifNil:[0]). "Should upgrade it with Protected Arithmetic"
			res at: coord put: (coord + offset).
		].
	].
	^res.
]

{ #category : #files }
TabularXSLXExport >> rels [
^'<?xml version="1.0" encoding="UTF-8"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">

<Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="xl/workbook.xml"/>

<Relationship Id="rId2" Type="http://schemas.openxmlformats.org/package/2006/relationships/metadata/core-properties" Target="docProps/core.xml"/>


<Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/extended-properties" Target="docProps/app.xml"/>

</Relationships>'.
]

{ #category : #files }
TabularXSLXExport >> relsOLD [
^'<?xml version="1.0" encoding="UTF-8"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">

<Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="xl/workbook.xml"/>

<Relationship Id="rId2" Type="http://schemas.openxmlformats.org/package/2006/relationships/metadata/core-properties" Target="docProps/core.xml"/>


<Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/extended-properties" Target="docProps/app.xml"/>

</Relationships>'.
]

{ #category : #rendering }
TabularXSLXExport >> renderCell: coord [
	| cell |
	cell := sheet cellAt: coord.
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
"do NOT use the construction of a file sharedStrings.xml at the moment; all strings are inlineStr"

	writer tag
		name: 'c';
		attributeAt: 'r' put: (self cellName: coord);
		attributeAt: 't' put: 'inlineStr';
		with:[ writer tag: 'is' with: [ writer tag: 't' with: ((sheet cellAt: coord) data asString)]]
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
	keys := (sheet allCoord
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
TabularXSLXExport >> sharedStrings_xml [
^'<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<sst xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" count="1" uniqueCount="1">
<si><t> </t></si>
</sst>'.
]

{ #category : #files }
TabularXSLXExport >> styles_xml [
^'<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<styleSheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main">
<numFmts count="1">
<numFmt numFmtId="164" formatCode="GENERAL"/></numFmts>
<fonts count="4">

<font><sz val="10"/><name val="Arial"/><family val="2"/></font><font><sz val="10"/><name val="Arial"/><family val="0"/></font>

<font><sz val="10"/><name val="Arial"/><family val="0"/></font><font><sz val="10"/><name val="Arial"/><family val="0"/></font>
</fonts>

<fills count="2"><fill><patternFill patternType="none"/></fill><fill><patternFill patternType="gray125"/></fill></fills><borders count="1"><border diagonalUp="false" diagonalDown="false"><left/><right/><top/><bottom/><diagonal/></border></borders><cellStyleXfs count="20"><xf numFmtId="164" fontId="0" fillId="0" borderId="0" applyFont="true" applyBorder="true" applyAlignment="true" applyProtection="true"><alignment horizontal="general" vertical="bottom" textRotation="0" wrapText="false" indent="0" shrinkToFit="false"/><protection locked="true" hidden="false"/></xf><xf numFmtId="0" fontId="1" fillId="0" borderId="0" applyFont="true" applyBorder="false" applyAlignment="false" applyProtection="false"></xf><xf numFmtId="0" fontId="1" fillId="0" borderId="0" applyFont="true" applyBorder="false" applyAlignment="false" applyProtection="false"></xf><xf numFmtId="0" fontId="2" fillId="0" borderId="0" applyFont="true" applyBorder="false" applyAlignment="false" applyProtection="false"></xf><xf numFmtId="0" fontId="2" fillId="0" borderId="0" applyFont="true" applyBorder="false" applyAlignment="false" applyProtection="false"></xf><xf numFmtId="0" fontId="0" fillId="0" borderId="0" applyFont="true" applyBorder="false" applyAlignment="false" applyProtection="false"></xf><xf numFmtId="0" fontId="0" fillId="0" borderId="0" applyFont="true" applyBorder="false" applyAlignment="false" applyProtection="false"></xf><xf numFmtId="0" fontId="0" fillId="0" borderId="0" applyFont="true" applyBorder="false" applyAlignment="false" applyProtection="false"></xf><xf numFmtId="0" fontId="0" fillId="0" borderId="0" applyFont="true" applyBorder="false" applyAlignment="false" applyProtection="false"></xf><xf numFmtId="0" fontId="0" fillId="0" borderId="0" applyFont="true" applyBorder="false" applyAlignment="false" applyProtection="false"></xf><xf numFmtId="0" fontId="0" fillId="0" borderId="0" applyFont="true" applyBorder="false" applyAlignment="false" applyProtection="false"></xf><xf numFmtId="0" fontId="0" fillId="0" borderId="0" applyFont="true" applyBorder="false" applyAlignment="false" applyProtection="false"></xf><xf numFmtId="0" fontId="0" fillId="0" borderId="0" applyFont="true" applyBorder="false" applyAlignment="false" applyProtection="false"></xf><xf numFmtId="0" fontId="0" fillId="0" borderId="0" applyFont="true" applyBorder="false" applyAlignment="false" applyProtection="false"></xf><xf numFmtId="0" fontId="0" fillId="0" borderId="0" applyFont="true" applyBorder="false" applyAlignment="false" applyProtection="false"></xf><xf numFmtId="43" fontId="1" fillId="0" borderId="0" applyFont="true" applyBorder="false" applyAlignment="false" applyProtection="false"></xf><xf numFmtId="41" fontId="1" fillId="0" borderId="0" applyFont="true" applyBorder="false" applyAlignment="false" applyProtection="false"></xf><xf numFmtId="44" fontId="1" fillId="0" borderId="0" applyFont="true" applyBorder="false" applyAlignment="false" applyProtection="false"></xf><xf numFmtId="42" fontId="1" fillId="0" borderId="0" applyFont="true" applyBorder="false" applyAlignment="false" applyProtection="false"></xf><xf numFmtId="9" fontId="1" fillId="0" borderId="0" applyFont="true" applyBorder="false" applyAlignment="false" applyProtection="false"></xf></cellStyleXfs><cellXfs count="1"><xf numFmtId="164" fontId="0" fillId="0" borderId="0" xfId="0" applyFont="false" applyBorder="false" applyAlignment="false" applyProtection="false"><alignment horizontal="general" vertical="bottom" textRotation="0" wrapText="false" indent="0" shrinkToFit="false"/><protection locked="true" hidden="false"/></xf></cellXfs><cellStyles count="6"><cellStyle name="Normal" xfId="0" builtinId="0" customBuiltin="false"/><cellStyle name="Comma" xfId="15" builtinId="3" customBuiltin="false"/><cellStyle name="Comma [0]" xfId="16" builtinId="6" customBuiltin="false"/><cellStyle name="Currency" xfId="17" builtinId="4" customBuiltin="false"/><cellStyle name="Currency [0]" xfId="18" builtinId="7" customBuiltin="false"/><cellStyle name="Percent" xfId="19" builtinId="5" customBuiltin="false"/></cellStyles></styleSheet>'.
]

{ #category : #files }
TabularXSLXExport >> workbook_xml [
^'<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships">
<fileVersion appName="Calc"/>
<workbookPr backupFile="false" showObjects="all" date1904="false"/>
<workbookProtection/>

<bookViews>
<workbookView showHorizontalScroll="true" showVerticalScroll="true" showSheetTabs="true" xWindow="0" yWindow="0" windowWidth="16384" windowHeight="8192" tabRatio="236" firstSheet="0" activeTab="0"/>
</bookViews>

<sheets>
<sheet name="Sheet1" sheetId="1" state="visible" r:id="rId2"/></sheets>

<calcPr iterateCount="100" refMode="A1" iterate="false" iterateDelta="0.001"/>

</workbook>'.
]

{ #category : #files }
TabularXSLXExport >> workbook_xmlOLD [
^'<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships">
  <sheets>
    <sheet name="Page 1" sheetId="1" r:id="rId1"/>
  </sheets>
</workbook>'.
]

{ #category : #files }
TabularXSLXExport >> workbook_xml_rels [
^'<?xml version="1.0" encoding="UTF-8"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">

<Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Target="styles.xml"/>

<Relationship Id="rId2" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheets/sheet1.xml"/>

<Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/sharedStrings" Target="sharedStrings.xml"/>

</Relationships>'.
]

{ #category : #files }
TabularXSLXExport >> workbook_xml_relsOLD [
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

{ #category : #files }
TabularXSLXExport >> worksheet_xml_example [
	^ '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships">
<sheetPr filterMode="false">
<pageSetUpPr fitToPage="false"/></sheetPr>
<dimension ref="A1:C9"/>
<sheetViews><sheetView windowProtection="false" showFormulas="false" showGridLines="true" showRowColHeaders="true" showZeros="true" rightToLeft="false" tabSelected="true" showOutlineSymbols="true" defaultGridColor="true" view="normal" topLeftCell="A1" colorId="64" zoomScale="100" zoomScaleNormal="100" zoomScalePageLayoutView="100" workbookViewId="0"><selection pane="topLeft" activeCell="C10" activeCellId="0" sqref="C10"/></sheetView></sheetViews><sheetFormatPr defaultRowHeight="12.8"></sheetFormatPr><cols><col collapsed="false" hidden="false" max="1025" min="1" style="0" width="11.5204081632653"/></cols><sheetData><row r="1" customFormat="false" ht="12.8" hidden="false" customHeight="false" outlineLevel="0" collapsed="false"><c r="A1" s="0" t="n"><v>11</v></c><c r="B1" s="0" t="n"><v>21</v></c><c r="C1" s="0" t="n"><v>31</v></c></row><row r="3" customFormat="false" ht="12.8" hidden="false" customHeight="false" outlineLevel="0" collapsed="false"><c r="C3" s="0" t="n"><v>33</v></c></row><row r="4" customFormat="false" ht="12.8" hidden="false" customHeight="false" outlineLevel="0" collapsed="false"><c r="C4" s="0" t="s"><v>0</v></c></row><row r="6" customFormat="false" ht="12.8" hidden="false" customHeight="false" outlineLevel="0" collapsed="false"><c r="C6" s="0" t="n"><v>36</v></c></row><row r="9" customFormat="false" ht="12.8" hidden="false" customHeight="false" outlineLevel="0" collapsed="false"><c r="C9" s="0" t="n"><v>39</v></c></row></sheetData><printOptions headings="false" gridLines="false" gridLinesSet="true" horizontalCentered="false" verticalCentered="false"/><pageMargins left="0.7875" right="0.7875" top="1.05277777777778" bottom="1.05277777777778" header="0.7875" footer="0.7875"/><pageSetup paperSize="9" scale="100" firstPageNumber="1" fitToWidth="1" fitToHeight="1" pageOrder="downThenOver" orientation="portrait" usePrinterDefaults="false" blackAndWhite="false" draft="false" cellComments="none" useFirstPageNumber="true" horizontalDpi="300" verticalDpi="300" copies="1"/><headerFooter differentFirst="false" differentOddEven="false"><oddHeader>&amp;C&amp;&quot;Times New Roman,Regular&quot;&amp;12&amp;A</oddHeader><oddFooter>&amp;C&amp;&quot;Times New Roman,Regular&quot;&amp;12Page &amp;P</oddFooter></headerFooter></worksheet>'
	
]
