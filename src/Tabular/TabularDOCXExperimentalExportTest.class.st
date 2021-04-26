"
I am TabularDOCXExperimentalExportTest to test the construction of DOCX files which contain tables.

test1 and test2 are demos to show the basics of a ZIP (DOCX) file creation.

This is an attempt to find  out the meaningful number of parts to create a DOCX file.

See TabularDOCXExperimentalExportTest3 for the creation of a complete DOCX file.


UTF8 needs attention.
"
Class {
	#name : #TabularDOCXExperimentalExportTest,
	#superclass : #TestCase,
	#instVars : [
		'fname1',
		'wsheetNumbersInRow1',
		'dir',
		'fname2',
		'fname3',
		'fname4',
		'fname6',
		'document_xml_rels',
		'zip',
		'fname5'
	],
	#category : #'Tabular-Tests'
}

{ #category : #'as yet unclassified' }
TabularDOCXExperimentalExportTest >> setUp [
	wsheetNumbersInRow1 := TabularWorksheet new.
	wsheetNumbersInRow1
		at: 1 @ 1 putData: 11;
		at: 2 @ 1 putData: 21;
		at: 3 @ 1 putData: 31.
		
	  dir := FileLocator temp.  
	"use temporary directory to put the exported test files."

       fname1 := dir / 'TabularDOCX1Exported.zip'. 
       fname2 := dir / 'TabularDOCX2Exported.docx'. 
	fname3 := dir / 'TabularDOCX3Exported.docx'. 
	fname4 := dir / 'TabularDOCX4Exported.docx'. 
	fname5 := dir / 'TabularDOCX5Exported.docx'. 
	

]

{ #category : #'as yet unclassified' }
TabularDOCXExperimentalExportTest >> test1 [
"Basic code to create a zip file."
| theString |
theString := '<?xml version="1.0" encoding="UTF-8"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
<Override PartName="/word/document.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml"/>
</Types>'.

zip:= ZipArchive new. 
zip addString: theString as: '[Content_Types].xml'.
zip writeToFileNamed: fname1 .

]

{ #category : #'as yet unclassified' }
TabularDOCXExperimentalExportTest >> test2 [

"Basic code to create an initial DOCX file. File does not open. It is 'corrupt' "

| theString theContentString |
fname2 ensureDelete.
theString := '<?xml version="1.0" encoding="UTF-8"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
<Override PartName="/word/document.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml"/>
</Types>'.


theContentString :='<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:document xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:w10="urn:schemas-microsoft-com:office:word" xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing" xmlns:wps="http://schemas.microsoft.com/office/word/2010/wordprocessingShape" xmlns:wpg="http://schemas.microsoft.com/office/word/2010/wordprocessingGroup" xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" xmlns:wp14="http://schemas.microsoft.com/office/word/2010/wordprocessingDrawing" xmlns:w14="http://schemas.microsoft.com/office/word/2010/wordml" mc:Ignorable="w14 wp14"><w:body><w:p><w:pPr><w:pStyle w:val="Heading1"/><w:numPr><w:ilvl w:val="0"/><w:numId w:val="1"/></w:numPr><w:spacing w:before="240" w:after="120"/><w:rPr><w:sz w:val="36"/><w:b/><w:sz w:val="36"/><w:b/><w:szCs w:val="36"/><w:bCs/><w:rFonts w:ascii="Liberation Sans" w:hAnsi="Liberation Sans" w:eastAsia="Droid Sans Fallback" w:cs="FreeSans"/></w:rPr></w:pPr><w:r><w:rPr></w:rPr><w:t>My new table</w:t></w:r><w:r></w:r></w:p><w:tbl><w:tblPr><w:tblW w:w="9638" w:type="dxa"/><w:jc w:val="left"/><w:tblInd w:w="55" w:type="dxa"/><w:tblBorders><w:top w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:left w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:bottom w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:insideH w:val="single" w:sz="2" w:space="0" w:color="000000"/></w:tblBorders><w:tblCellMar><w:top w:w="55" w:type="dxa"/><w:left w:w="54" w:type="dxa"/><w:bottom w:w="55" w:type="dxa"/><w:right w:w="55" w:type="dxa"/></w:tblCellMar></w:tblPr><w:tblGrid><w:gridCol w:w="3212"/><w:gridCol w:w="3213"/><w:gridCol w:w="3213"/></w:tblGrid><w:tr><w:trPr></w:trPr><w:tc><w:tcPr><w:tcW w:w="3212" w:type="dxa"/><w:tcBorders><w:top w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:left w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:bottom w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:insideH w:val="single" w:sz="2" w:space="0" w:color="000000"/></w:tcBorders><w:shd w:fill="auto" w:val="clear"/><w:tcMar><w:left w:w="54" w:type="dxa"/></w:tcMar></w:tcPr><w:p><w:pPr><w:pStyle w:val="TableContents"/></w:pPr><w:r><w:rPr></w:rPr></w:r><w:r></w:r></w:p></w:tc><w:tc><w:tcPr><w:tcW w:w="3213" w:type="dxa"/><w:tcBorders><w:top w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:left w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:bottom w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:insideH w:val="single" w:sz="2" w:space="0" w:color="000000"/></w:tcBorders><w:shd w:fill="auto" w:val="clear"/><w:tcMar><w:left w:w="54" w:type="dxa"/></w:tcMar></w:tcPr><w:p><w:pPr><w:pStyle w:val="TableContents"/></w:pPr><w:r><w:rPr></w:rPr></w:r><w:r></w:r></w:p></w:tc><w:tc><w:tcPr><w:tcW w:w="3213" w:type="dxa"/><w:tcBorders><w:top w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:left w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:bottom w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:right w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:insideH w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:insideV w:val="single" w:sz="2" w:space="0" w:color="000000"/></w:tcBorders><w:shd w:fill="auto" w:val="clear"/><w:tcMar><w:left w:w="54" w:type="dxa"/></w:tcMar></w:tcPr><w:p><w:pPr><w:pStyle w:val="TableContents"/></w:pPr><w:r><w:rPr></w:rPr></w:r><w:r></w:r></w:p></w:tc></w:tr><w:tr><w:trPr></w:trPr><w:tc><w:tcPr><w:tcW w:w="3212" w:type="dxa"/><w:tcBorders><w:left w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:bottom w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:insideH w:val="single" w:sz="2" w:space="0" w:color="000000"/></w:tcBorders><w:shd w:fill="auto" w:val="clear"/><w:tcMar><w:left w:w="54" w:type="dxa"/></w:tcMar></w:tcPr><w:p><w:pPr><w:pStyle w:val="TableContents"/></w:pPr><w:r><w:rPr></w:rPr></w:r><w:r></w:r></w:p></w:tc><w:tc><w:tcPr><w:tcW w:w="3213" w:type="dxa"/><w:tcBorders><w:left w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:bottom w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:insideH w:val="single" w:sz="2" w:space="0" w:color="000000"/></w:tcBorders><w:shd w:fill="auto" w:val="clear"/><w:tcMar><w:left w:w="54" w:type="dxa"/></w:tcMar></w:tcPr><w:p><w:pPr><w:pStyle w:val="TableContents"/></w:pPr><w:r><w:rPr></w:rPr></w:r><w:r></w:r></w:p></w:tc><w:tc><w:tcPr><w:tcW w:w="3213" w:type="dxa"/><w:tcBorders><w:left w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:bottom w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:right w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:insideH w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:insideV w:val="single" w:sz="2" w:space="0" w:color="000000"/></w:tcBorders><w:shd w:fill="auto" w:val="clear"/><w:tcMar><w:left w:w="54" w:type="dxa"/></w:tcMar></w:tcPr><w:p><w:pPr><w:pStyle w:val="TableContents"/></w:pPr><w:r><w:rPr></w:rPr></w:r><w:r></w:r></w:p></w:tc></w:tr></w:tbl><w:p><w:pPr><w:pStyle w:val="TextBody"/><w:spacing w:before="0" w:after="140"/><w:rPr></w:rPr></w:pPr><w:r><w:rPr></w:rPr></w:r><w:r></w:r></w:p><w:sectPr><w:type w:val="nextPage"/><w:pgSz w:w="11906" w:h="16838"/><w:pgMar w:left="1134" w:right="1134" w:header="0" w:top="1134" w:footer="0" w:bottom="1134" w:gutter="0"/><w:pgNumType w:fmt="decimal"/><w:formProt w:val="false"/><w:textDirection w:val="lrTb"/></w:sectPr></w:body></w:document>'.

zip:= ZipArchive new. 
zip addString: theString as: '[Content_Types].xml'.
zip addString: theContentString as: 'word/document.xml'.
zip writeToFileNamed: fname2 .
]

{ #category : #'as yet unclassified' }
TabularDOCXExperimentalExportTest >> test3 [
"Basic code to create a DOCX file. It opens but content supplied with document.xml is incomplete"

| theString theContentString theRelsString |
fname3 ensureDelete.
theString := '<?xml version="1.0" encoding="UTF-8"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
<Override PartName="/word/document.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml"/>
</Types>'.


theContentString :='<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:document xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:w10="urn:schemas-microsoft-com:office:word" xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing" xmlns:wps="http://schemas.microsoft.com/office/word/2010/wordprocessingShape" xmlns:wpg="http://schemas.microsoft.com/office/word/2010/wordprocessingGroup" xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" xmlns:wp14="http://schemas.microsoft.com/office/word/2010/wordprocessingDrawing" xmlns:w14="http://schemas.microsoft.com/office/word/2010/wordml" mc:Ignorable="w14 wp14"><w:body><w:p><w:pPr><w:pStyle w:val="Normal"/><w:rPr></w:rPr></w:pPr><w:r><w:rPr></w:rPr><w:t>Hello</w:t></w:r><w:r></w:r></w:p><w:sectPr><w:type w:val="nextPage"/><w:pgSz w:w="11906" w:h="16838"/><w:pgMar w:left="1134" w:right="1134" w:header="0" w:top="1134" w:footer="0" w:bottom="1134" w:gutter="0"/><w:pgNumType w:fmt="decimal"/><w:formProt w:val="false"/><w:textDirection w:val="lrTb"/></w:sectPr></w:body></w:document>'.


theRelsString := '<?xml version="1.0" encoding="UTF-8"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">

<Relationship Id="rId1" Type="http://schemas.openxmlformats.org/package/2006/relationships/metadata/core-properties" Target="docProps/core.xml"/>

<Relationship Id="rId2" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/extended-properties" Target="docProps/app.xml"/>

<Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="word/document.xml"/>
</Relationships>'.

zip:= ZipArchive new. 
zip addString: theString as: '[Content_Types].xml'.
zip addString: (theContentString convertToEncoding: 'utf-8') as: 'word/document.xml'.
zip addString: theRelsString as: '_rels/.rels'.
zip writeToFileNamed: fname3 .
]
