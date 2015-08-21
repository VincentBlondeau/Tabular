"
I am TabularXSLXExport and export worksheets to Excel XSLX file format.

NEXT STEPS:

1. Add styles to export

2. Generalize worksheets export mechanism. Use rIds in the
    worksheet objects.

3. Create a class TabularDOCXExport as a copy of this class and make it work.


LIMITATIONS:

- Currently only the first three worksheets are exported.

Reference:

http://officeopenxml.com/anatomyofOOXML-xlsx.php

Content Types

Every package must have a [Content_Types].xml, found at the root of the package. This file contains a list of all of the content types of the parts in the package. Every part and its type must be listed in [Content_Types].xml. The following is a content type for the main content part:

<Override PartName=""/xl/workbook.xml"" ContentType=""application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml""/>

It's important to keep this in mind when adding new parts to the package.



Relationships

Every package contains a relationships part that defines the relationships between the other parts and to resources outside of the package. This separates the relationships from content and makes it easy to change relationships without changing the sources that reference targets.
package relationships part

For an OOXML package, there is always a relationships part (.rels) within the _rels folder that identifies the starting parts of the package, or the package relationships. For example, the following defines the identity of the start part for the content:

<Relationship Id=""rId1"" Type=""http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument"" Target=""xl/workbook.xml""/>.

There are also typically relationships within .rels for app.xml and core.xml.

In addition to the relationships part for the package, each part that is the source of one or more relationships will have its own relationships part. Each such relationship part is found within a _rels sub-folder of the part and is named by appending '.rels' to the name of the part.

Typically the main content part (workbook.xml) has its own relationships part (workbook.xml.rels). It will contain relationships to the other parts of the content, such as sheet1.xml, sharedStrings.xml, styles.xml, theme1,xml, as well as the URIs for external links. 


https://msdn.microsoft.com/en-us/library/office/gg278316.aspx
"
Class {
	#name : #TabularXSLXExport,
	#superclass : #TabularExport,
	#instVars : [
		'xmlSheetsForWorkbookXML'
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

{ #category : #'files-content-types' }
TabularXSLXExport >> content_types_xml [

" [Content_Types].xml file, this describes the location of the major files in the archive and the standards to which it itself adheres and the content types of those files. 
hard coded at the moment, should be constructed later.
"

^self content_types_xml_start ,
self content_types_xml_sheets ,
self content_types_xml_end 
]

{ #category : #'files-OLD' }
TabularXSLXExport >> content_types_xmlOLD [
^'<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
  <Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>
  <Override PartName="/workbook.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml"/>
  <Override PartName="/worksheet.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml"/>
</Types>'.
]

{ #category : #'files-content-types' }
TabularXSLXExport >> content_types_xml_end [

" [Content_Types].xml file, this describes the location of the major files in the archive and the standards to which it itself adheres and the content types of those files. 
hard coded at the moment, should be constructed later.
"

^'
<Override PartName="/xl/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.styles+xml"/><Override PartName="/xl/workbook.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml"/>
</Types>'.
]

{ #category : #'files-content-types' }
TabularXSLXExport >> content_types_xml_sheets [

" [Content_Types].xml file, this describes the location of the major files in the archive and the standards to which it itself adheres and the content types of those files. 
hard coded at the moment for two sheets, should be generalized later.
"

| xmlString |
xmlString := '<Override PartName="/xl/worksheets/sheet1.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml"/>
'.

(workbook worksheets size > 1) ifTrue: [ 
xmlString := xmlString, '<Override PartName="/xl/worksheets/sheet2.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml"/>
'].

(workbook worksheets size > 2) ifTrue: [ 
xmlString := xmlString, '<Override PartName="/xl/worksheets/sheet3.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml"/>
'].
	
^xmlString
]

{ #category : #'files-content-types' }
TabularXSLXExport >> content_types_xml_start [

" [Content_Types].xml file, this describes the location of the major files in the archive and the standards to which it itself adheres and the content types of those files. 
hard coded at the moment, should be constructed later.
"

^'<?xml version="1.0" encoding="UTF-8"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">

<Override PartName="/_rels/.rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>

<Override PartName="/docProps/app.xml" ContentType="application/vnd.openxmlformats-officedocument.extended-properties+xml"/>

<Override PartName="/docProps/core.xml" ContentType="application/vnd.openxmlformats-package.core-properties+xml"/>

<Override PartName="/xl/_rels/workbook.xml.rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>

<Override PartName="/xl/sharedStrings.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sharedStrings+xml"/>

'.
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
	
	zip addString: self content_types_xml as: '[Content_Types].xml'.
	zip addString: self rels as: '_rels/.rels'.

	zip addString: self docPropsApp_xml as: 'docProps/app.xml'.
	zip addString: self docPropsCore_xml as: 'docProps/core.xml'.

    "Everything outside the xl/ folder is just meta data"
	zip addString: self sharedStrings_xml  as: 'xl/sharedStrings.xml'.
	zip addString: self styles_xml   as: 'xl/styles.xml'.
	self generateWorksheets.
	zip addString: self workbook_xml as: 'xl/workbook.xml'.
	
	zip addString: self workbook_xml_rels as: 'xl/_rels/workbook.xml.rels'.

	self writeZip.
]

{ #category : #'files-OLD' }
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

{ #category : #files }
TabularXSLXExport >> generateWorksheets [
"LIMITATION: currently only the first worksheet is generated"
	| worksheet |
	
	workbook worksheets isEmpty ifFalse: [ worksheet := workbook worksheets first  ]
									ifTrue: [ worksheet := TabularWorksheet new ] .
									
	zip addString: (TabularWorksheetWriterXL for: worksheet) as: 'xl/worksheets/sheet1.xml'.
	xmlSheetsForWorkbookXML := self workbook_xml_sheetNamed: worksheet name rId: 'rId2'.
	
    (workbook worksheets size > 1) ifTrue: [ 
	 worksheet := workbook worksheets second.
	zip addString: (TabularWorksheetWriterXL for: worksheet) as: 'xl/worksheets/sheet2.xml'.
	xmlSheetsForWorkbookXML := xmlSheetsForWorkbookXML ,
	                           (self workbook_xml_sheetNamed: worksheet name rId: 'rId3').
	].

 (workbook worksheets size > 2) ifTrue: [ 
	 worksheet := workbook worksheets third.
	zip addString: (TabularWorksheetWriterXL for: worksheet) as: 'xl/worksheets/sheet3.xml'.
	xmlSheetsForWorkbookXML := xmlSheetsForWorkbookXML ,
	                           (self workbook_xml_sheetNamed: worksheet name rId: 'rId4').
	]
]

{ #category : #initialize }
TabularXSLXExport >> initialize [

zip:= ZipArchive new.
xmlSheetsForWorkbookXML := ''.
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

{ #category : #'files-OLD' }
TabularXSLXExport >> relsOLD [
^'<?xml version="1.0" encoding="UTF-8"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">

<Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="xl/workbook.xml"/>

<Relationship Id="rId2" Type="http://schemas.openxmlformats.org/package/2006/relationships/metadata/core-properties" Target="docProps/core.xml"/>


<Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/extended-properties" Target="docProps/app.xml"/>

</Relationships>'.
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

{ #category : #'files-workbook-xml' }
TabularXSLXExport >> workbook_xml [

^self workbook_xml_start,
self workbook_xml_sheets,
self workbook_xml_end 
]

{ #category : #'files-OLD' }
TabularXSLXExport >> workbook_xmlOLD [
^'<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships">
  <sheets>
    <sheet name="Page 1" sheetId="1" r:id="rId1"/>
  </sheets>
</workbook>'.
]

{ #category : #'files-workbook-xml' }
TabularXSLXExport >> workbook_xml_end [
^'
<calcPr iterateCount="100" refMode="A1" iterate="false" iterateDelta="0.001"/>
</workbook>'.
]

{ #category : #'files-workbook-xml-rels' }
TabularXSLXExport >> workbook_xml_rels [
	| xml |
	xml := self workbook_xml_rels_part1.

	workbook worksheets size > 2
		ifTrue: [ ^ xml , self workbook_xml_rels_part2_threeWorksheets ].

	workbook worksheets size > 1
		ifTrue: [ ^ xml , self workbook_xml_rels_part2_twoWorksheets ].
		
	^ xml , self workbook_xml_rels_part2_oneWorksheet
]

{ #category : #'files-OLD' }
TabularXSLXExport >> workbook_xml_relsOLD [
^'<?xml version="1.0" encoding="UTF-8" standalone="yes"?>

<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">

  <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheet.xml"/>

</Relationships>'.
]

{ #category : #'files-workbook-xml-rels' }
TabularXSLXExport >> workbook_xml_rels_part1 [
^'<?xml version="1.0" encoding="UTF-8"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">

<Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Target="styles.xml"/>
'.
]

{ #category : #'files-workbook-xml-rels' }
TabularXSLXExport >> workbook_xml_rels_part2_oneWorksheet [
^'
<Relationship Id="rId2" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheets/sheet1.xml"/>

<Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/sharedStrings" Target="sharedStrings.xml"/>

</Relationships>'.
]

{ #category : #'files-workbook-xml-rels' }
TabularXSLXExport >> workbook_xml_rels_part2_threeWorksheets [
^'
<Relationship Id="rId2" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheets/sheet1.xml"/>

<Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheets/sheet2.xml"/>

<Relationship Id="rId4" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheets/sheet3.xml"/>

<Relationship Id="rId5" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/sharedStrings" Target="sharedStrings.xml"/>

</Relationships>'.
]

{ #category : #'files-workbook-xml-rels' }
TabularXSLXExport >> workbook_xml_rels_part2_twoWorksheets [
^'
<Relationship Id="rId2" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheets/sheet1.xml"/>

<Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheets/sheet2.xml"/>

<Relationship Id="rId4" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/sharedStrings" Target="sharedStrings.xml"/>

</Relationships>'.
]

{ #category : #'files-workbook-xml' }
TabularXSLXExport >> workbook_xml_sheetNamed: aString rId: aRidString [

^ ('<sheet name="',
aString,
'" sheetId="1" state="visible" r:id="',
aRidString, 
'"/>
')
]

{ #category : #'files-workbook-xml' }
TabularXSLXExport >> workbook_xml_sheets [

| beginTag endTag  |
beginTag := '<sheets>'.
endTag := '</sheets>'.
^ (beginTag, xmlSheetsForWorkbookXML, endTag)

]

{ #category : #'files-workbook-xml' }
TabularXSLXExport >> workbook_xml_start [
^'<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships">
<fileVersion appName="Tabular"/>
<workbookPr backupFile="false" showObjects="all" date1904="false"/>
<workbookProtection/>
'.
]
