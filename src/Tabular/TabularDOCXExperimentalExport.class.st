"
I am TabularDOCXExperimentalExport and export a TabularWorkbook to a DOCX file.

Responsibility part:  I only export one worksheet (table) at the moment.

THIS IS A DEMO CLASS which shows how a DOCX file is constructed from the parts.  Besides that NO FUNCTION.


TabularDOCXExperimentalExport3 uses an imported template and only generates document.xml.

Later as more parametrization will come in parts from here will be moved to TabularDOCXExperimentalExport3 thus removing parts from there.


Collaborators Part:  I use TabularWorksheetWriterWordML to help generating the code for the document.xml file contained in the DOCX archive.


Public API and Key Messages

- #export: aWorkbook fileName: aString.

Example: #example1
  
Internal Representation and Key Implementation Points.

    Instance Variables
	zip:		<Object>


    Implementation Points


DOCX files are zip files but instead of a *.zip extension there is a *.DOCX extension.

Basic code to create a zip file.
zip:= ZipArchive new. 
zip addString: 'hallo' as: 'theFile.txt'.
zip writeToFileNamed: (FileLocator temp / 'myfile.zip') .


"
Class {
	#name : #TabularDOCXExperimentalExport,
	#superclass : #TabularExport,
	#category : #'Tabular-Exporters'
}

{ #category : #'as yet unclassified' }
TabularDOCXExperimentalExport class >> example1 [

self export: TabularWorkbook new fileName: (FileLocator home / 'test1.docx')
]

{ #category : #'as yet unclassified' }
TabularDOCXExperimentalExport class >> wordMLcloseDocumentTag [

^'</w:body></w:document>'


]

{ #category : #'as yet unclassified' }
TabularDOCXExperimentalExport class >> wordMLopenDocumentTag [

^'<?xml version="1.0" encoding="UTF-8" standalone="yes"?>

<w:document xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:w10="urn:schemas-microsoft-com:office:word" xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing" xmlns:wps="http://schemas.microsoft.com/office/word/2010/wordprocessingShape" xmlns:wpg="http://schemas.microsoft.com/office/word/2010/wordprocessingGroup" 
xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" xmlns:wp14="http://schemas.microsoft.com/office/word/2010/wordprocessingDrawing" xmlns:w14="http://schemas.microsoft.com/office/word/2010/wordml" mc:Ignorable="w14 wp14">

<w:body>
'
]

{ #category : #files }
TabularDOCXExperimentalExport >> app_xml_String [

^'<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Properties xmlns="http://schemas.openxmlformats.org/officeDocument/2006/extended-properties" xmlns:vt="http://schemas.openxmlformats.org/officeDocument/2006/docPropsVTypes"><TotalTime>311</TotalTime><Application>LibreOffice/4.3.5.2$Linux_x86 LibreOffice_project/430m0$Build-2</Application><Paragraphs>13</Paragraphs></Properties>'
]

{ #category : #files }
TabularDOCXExperimentalExport >> contentTypesString [

 ^'<?xml version="1.0" encoding="UTF-8"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">

<Override PartName="/_rels/.rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>

<Override PartName="/word/_rels/document.xml.rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>

<Override PartName="/word/settings.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.settings+xml"/>

<Override PartName="/word/fontTable.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.fontTable+xml"/>

<Override PartName="/word/numbering.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.numbering+xml"/>

<Override PartName="/word/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.styles+xml"/>

<Override PartName="/word/document.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml"/>

<Override PartName="/docProps/app.xml" ContentType="application/vnd.openxmlformats-officedocument.extended-properties+xml"/>

<Override PartName="/docProps/core.xml" ContentType="application/vnd.openxmlformats-package.core-properties+xml"/>
</Types>'.

]

{ #category : #files }
TabularDOCXExperimentalExport >> core_xml_String [

^ '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<cp:coreProperties xmlns:cp="http://schemas.openxmlformats.org/package/2006/metadata/core-properties" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:dcmitype="http://purl.org/dc/dcmitype/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><dcterms:created xsi:type="dcterms:W3CDTF">2015-08-18T09:03:27Z</dcterms:created><dc:creator>user </dc:creator><dc:language>en-GB</dc:language><cp:lastModifiedBy>user </cp:lastModifiedBy><dcterms:modified xsi:type="dcterms:W3CDTF">2015-08-18T09:08:38Z</dcterms:modified><cp:revision>1</cp:revision></cp:coreProperties>'
]

{ #category : #files }
TabularDOCXExperimentalExport >> documentString [

^'<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:document xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:w10="urn:schemas-microsoft-com:office:word" xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing" xmlns:wps="http://schemas.microsoft.com/office/word/2010/wordprocessingShape" xmlns:wpg="http://schemas.microsoft.com/office/word/2010/wordprocessingGroup" xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" xmlns:wp14="http://schemas.microsoft.com/office/word/2010/wordprocessingDrawing" xmlns:w14="http://schemas.microsoft.com/office/word/2010/wordml" mc:Ignorable="w14 wp14"><w:body><w:p><w:pPr><w:pStyle w:val="Heading1"/><w:numPr><w:ilvl w:val="0"/><w:numId w:val="1"/></w:numPr><w:spacing w:before="240" w:after="120"/><w:rPr><w:sz w:val="36"/><w:b/><w:sz w:val="36"/><w:b/><w:szCs w:val="36"/><w:bCs/><w:rFonts w:ascii="Liberation Sans" w:hAnsi="Liberation Sans" w:eastAsia="Droid Sans Fallback" w:cs="FreeSans"/></w:rPr></w:pPr><w:r><w:rPr></w:rPr><w:t>The first tabular table</w:t></w:r><w:r></w:r></w:p><w:tbl><w:tblPr><w:tblW w:w="9638" w:type="dxa"/><w:jc w:val="left"/><w:tblInd w:w="55" w:type="dxa"/><w:tblBorders><w:top w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:left w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:bottom w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:insideH w:val="single" w:sz="2" w:space="0" w:color="000000"/></w:tblBorders><w:tblCellMar><w:top w:w="55" w:type="dxa"/><w:left w:w="54" w:type="dxa"/><w:bottom w:w="55" w:type="dxa"/><w:right w:w="55" w:type="dxa"/></w:tblCellMar></w:tblPr><w:tblGrid><w:gridCol w:w="3212"/><w:gridCol w:w="3213"/><w:gridCol w:w="3213"/></w:tblGrid><w:tr><w:trPr></w:trPr><w:tc><w:tcPr><w:tcW w:w="3212" w:type="dxa"/><w:tcBorders><w:top w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:left w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:bottom w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:insideH w:val="single" w:sz="2" w:space="0" w:color="000000"/></w:tcBorders><w:shd w:fill="auto" w:val="clear"/><w:tcMar><w:left w:w="54" w:type="dxa"/></w:tcMar></w:tcPr><w:p><w:pPr><w:pStyle w:val="TableContents"/><w:rPr></w:rPr></w:pPr><w:r><w:rPr></w:rPr><w:t>Berne</w:t></w:r><w:r></w:r></w:p></w:tc><w:tc><w:tcPr><w:tcW w:w="3213" w:type="dxa"/><w:tcBorders><w:top w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:left w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:bottom w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:insideH w:val="single" w:sz="2" w:space="0" w:color="000000"/></w:tcBorders><w:shd w:fill="auto" w:val="clear"/><w:tcMar><w:left w:w="54" w:type="dxa"/></w:tcMar></w:tcPr><w:p><w:pPr><w:pStyle w:val="TableContents"/><w:rPr></w:rPr></w:pPr><w:r><w:rPr></w:rPr><w:t>Lille</w:t></w:r><w:r></w:r></w:p></w:tc><w:tc><w:tcPr><w:tcW w:w="3213" w:type="dxa"/><w:tcBorders><w:top w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:left w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:bottom w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:right w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:insideH w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:insideV w:val="single" w:sz="2" w:space="0" w:color="000000"/></w:tcBorders><w:shd w:fill="auto" w:val="clear"/><w:tcMar><w:left w:w="54" w:type="dxa"/></w:tcMar></w:tcPr><w:p><w:pPr><w:pStyle w:val="TableContents"/><w:rPr></w:rPr></w:pPr><w:r><w:rPr></w:rPr><w:t>Санкт-Петербург</w:t></w:r><w:r></w:r></w:p></w:tc></w:tr><w:tr><w:trPr></w:trPr><w:tc><w:tcPr><w:tcW w:w="3212" w:type="dxa"/><w:tcBorders><w:left w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:bottom w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:insideH w:val="single" w:sz="2" w:space="0" w:color="000000"/></w:tcBorders><w:shd w:fill="auto" w:val="clear"/><w:tcMar><w:left w:w="54" w:type="dxa"/></w:tcMar></w:tcPr><w:p><w:pPr><w:pStyle w:val="TableContents"/><w:rPr></w:rPr></w:pPr><w:r><w:rPr></w:rPr><w:t>1</w:t></w:r><w:r></w:r></w:p></w:tc><w:tc><w:tcPr><w:tcW w:w="3213" w:type="dxa"/><w:tcBorders><w:left w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:bottom w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:insideH w:val="single" w:sz="2" w:space="0" w:color="000000"/></w:tcBorders><w:shd w:fill="auto" w:val="clear"/><w:tcMar><w:left w:w="54" w:type="dxa"/></w:tcMar></w:tcPr><w:p><w:pPr><w:pStyle w:val="TableContents"/><w:rPr></w:rPr></w:pPr><w:r><w:rPr></w:rPr><w:t>4</w:t></w:r><w:r></w:r></w:p></w:tc><w:tc><w:tcPr><w:tcW w:w="3213" w:type="dxa"/><w:tcBorders><w:left w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:bottom w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:right w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:insideH w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:insideV w:val="single" w:sz="2" w:space="0" w:color="000000"/></w:tcBorders><w:shd w:fill="auto" w:val="clear"/><w:tcMar><w:left w:w="54" w:type="dxa"/></w:tcMar></w:tcPr><w:p><w:pPr><w:pStyle w:val="TableContents"/><w:rPr></w:rPr></w:pPr><w:r><w:rPr></w:rPr><w:t>7</w:t></w:r><w:r></w:r></w:p></w:tc></w:tr><w:tr><w:trPr></w:trPr><w:tc><w:tcPr><w:tcW w:w="3212" w:type="dxa"/><w:tcBorders><w:left w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:bottom w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:insideH w:val="single" w:sz="2" w:space="0" w:color="000000"/></w:tcBorders><w:shd w:fill="auto" w:val="clear"/><w:tcMar><w:left w:w="54" w:type="dxa"/></w:tcMar></w:tcPr><w:p><w:pPr><w:pStyle w:val="TableContents"/><w:rPr></w:rPr></w:pPr><w:r><w:rPr></w:rPr><w:t>2</w:t></w:r><w:r></w:r></w:p></w:tc><w:tc><w:tcPr><w:tcW w:w="3213" w:type="dxa"/><w:tcBorders><w:left w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:bottom w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:insideH w:val="single" w:sz="2" w:space="0" w:color="000000"/></w:tcBorders><w:shd w:fill="auto" w:val="clear"/><w:tcMar><w:left w:w="54" w:type="dxa"/></w:tcMar></w:tcPr><w:p><w:pPr><w:pStyle w:val="TableContents"/><w:rPr></w:rPr></w:pPr><w:r><w:rPr></w:rPr><w:t>5</w:t></w:r><w:r></w:r></w:p></w:tc><w:tc><w:tcPr><w:tcW w:w="3213" w:type="dxa"/><w:tcBorders><w:left w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:bottom w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:right w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:insideH w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:insideV w:val="single" w:sz="2" w:space="0" w:color="000000"/></w:tcBorders><w:shd w:fill="auto" w:val="clear"/><w:tcMar><w:left w:w="54" w:type="dxa"/></w:tcMar></w:tcPr><w:p><w:pPr><w:pStyle w:val="TableContents"/><w:rPr></w:rPr></w:pPr><w:r><w:rPr></w:rPr><w:t>8</w:t></w:r><w:r></w:r></w:p></w:tc></w:tr><w:tr><w:trPr></w:trPr><w:tc><w:tcPr><w:tcW w:w="3212" w:type="dxa"/><w:tcBorders><w:left w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:bottom w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:insideH w:val="single" w:sz="2" w:space="0" w:color="000000"/></w:tcBorders><w:shd w:fill="auto" w:val="clear"/><w:tcMar><w:left w:w="54" w:type="dxa"/></w:tcMar></w:tcPr><w:p><w:pPr><w:pStyle w:val="TableContents"/><w:rPr></w:rPr></w:pPr><w:r><w:rPr></w:rPr><w:t>3</w:t></w:r><w:r></w:r></w:p></w:tc><w:tc><w:tcPr><w:tcW w:w="3213" w:type="dxa"/><w:tcBorders><w:left w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:bottom w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:insideH w:val="single" w:sz="2" w:space="0" w:color="000000"/></w:tcBorders><w:shd w:fill="auto" w:val="clear"/><w:tcMar><w:left w:w="54" w:type="dxa"/></w:tcMar></w:tcPr><w:p><w:pPr><w:pStyle w:val="TableContents"/><w:rPr></w:rPr></w:pPr><w:r><w:rPr></w:rPr><w:t>6</w:t></w:r><w:r></w:r></w:p></w:tc><w:tc><w:tcPr><w:tcW w:w="3213" w:type="dxa"/><w:tcBorders><w:left w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:bottom w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:right w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:insideH w:val="single" w:sz="2" w:space="0" w:color="000000"/><w:insideV w:val="single" w:sz="2" w:space="0" w:color="000000"/></w:tcBorders><w:shd w:fill="auto" w:val="clear"/><w:tcMar><w:left w:w="54" w:type="dxa"/></w:tcMar></w:tcPr><w:p><w:pPr><w:pStyle w:val="TableContents"/><w:rPr></w:rPr></w:pPr><w:r><w:rPr></w:rPr><w:t>9</w:t></w:r><w:r></w:r></w:p></w:tc></w:tr></w:tbl><w:p><w:pPr><w:pStyle w:val="TextBody"/><w:rPr></w:rPr></w:pPr><w:r><w:rPr></w:rPr></w:r><w:r></w:r></w:p><w:p><w:pPr><w:pStyle w:val="TextBody"/><w:rPr></w:rPr></w:pPr><w:r><w:rPr></w:rPr></w:r><w:r></w:r></w:p><w:p><w:pPr><w:pStyle w:val="TextBody"/><w:spacing w:before="0" w:after="140"/><w:rPr></w:rPr></w:pPr><w:r><w:rPr></w:rPr></w:r><w:r></w:r></w:p><w:sectPr><w:type w:val="nextPage"/><w:pgSz w:w="11906" w:h="16838"/><w:pgMar w:left="1134" w:right="1134" w:header="0" w:top="1134" w:footer="0" w:bottom="1134" w:gutter="0"/><w:pgNumType w:fmt="decimal"/><w:formProt w:val="false"/><w:textDirection w:val="lrTb"/></w:sectPr></w:body></w:document>'.




]

{ #category : #files }
TabularDOCXExperimentalExport >> document_xml_rels [

^'<?xml version="1.0" encoding="UTF-8"?>


<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">

<Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Target="styles.xml"/>

<Relationship Id="rId2" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/numbering" Target="numbering.xml"/>

<Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/fontTable" Target="fontTable.xml"/>

<Relationship Id="rId4" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/settings" Target="settings.xml"/>
</Relationships>'.


]

{ #category : #files }
TabularDOCXExperimentalExport >> fontTableString [

^'<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:fonts xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"><w:font w:name="Times New Roman"><w:charset w:val="00"/><w:family w:val="roman"/><w:pitch w:val="variable"/></w:font><w:font w:name="Symbol"><w:charset w:val="02"/><w:family w:val="roman"/><w:pitch w:val="variable"/></w:font><w:font w:name="Arial"><w:charset w:val="00"/><w:family w:val="swiss"/><w:pitch w:val="variable"/></w:font><w:font w:name="Liberation Serif"><w:altName w:val="Times New Roman"/><w:charset w:val="01"/><w:family w:val="roman"/><w:pitch w:val="variable"/></w:font><w:font w:name="Liberation Sans"><w:altName w:val="Arial"/><w:charset w:val="01"/><w:family w:val="swiss"/><w:pitch w:val="variable"/></w:font></w:fonts>'.

]

{ #category : #generating }
TabularDOCXExperimentalExport >> generate [

"use the workbook instance variable and the zip instance variable to populate the archive."

self halt.
zip:= ZipArchive new. 
zip addString: self contentTypesString as: '[Content_Types].xml'.
zip addString: self relsString as: '_rels/.rels'.
zip addString: self app_xml_String as: 'docProps/app.xml'.
zip addString: self core_xml_String as: 'docProps/core.xml'.

zip addString: (self documentString convertToEncoding: 'utf-8')   as: 'word/document.xml'.
zip addString: self stylesString as: 'word/styles.xml'.
zip addString: self settingsString as: 'word/settings.xml'.
zip addString: self numberingString as: 'word/numbering.xml'.
zip addString: self fontTableString as: 'word/fontTable.xml'.
zip addString: self document_xml_rels as: 'word/_rels/document.xml.rels'.
self writeZip

]

{ #category : #files }
TabularDOCXExperimentalExport >> numberingString [

^'<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:numbering xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:v="urn:schemas-microsoft-com:vml"><w:abstractNum w:abstractNumId="1"><w:lvl w:ilvl="0"><w:start w:val="1"/><w:numFmt w:val="none"/><w:suff w:val="nothing"/><w:lvlText w:val=""/><w:lvlJc w:val="left"/><w:pPr><w:tabs><w:tab w:val="num" w:pos="432"/></w:tabs><w:ind w:left="432" w:hanging="432"/></w:pPr></w:lvl><w:lvl w:ilvl="1"><w:start w:val="1"/><w:numFmt w:val="none"/><w:suff w:val="nothing"/><w:lvlText w:val=""/><w:lvlJc w:val="left"/><w:pPr><w:tabs><w:tab w:val="num" w:pos="576"/></w:tabs><w:ind w:left="576" w:hanging="576"/></w:pPr></w:lvl><w:lvl w:ilvl="2"><w:start w:val="1"/><w:numFmt w:val="none"/><w:suff w:val="nothing"/><w:lvlText w:val=""/><w:lvlJc w:val="left"/><w:pPr><w:tabs><w:tab w:val="num" w:pos="720"/></w:tabs><w:ind w:left="720" w:hanging="720"/></w:pPr></w:lvl><w:lvl w:ilvl="3"><w:start w:val="1"/><w:numFmt w:val="none"/><w:suff w:val="nothing"/><w:lvlText w:val=""/><w:lvlJc w:val="left"/><w:pPr><w:tabs><w:tab w:val="num" w:pos="864"/></w:tabs><w:ind w:left="864" w:hanging="864"/></w:pPr></w:lvl><w:lvl w:ilvl="4"><w:start w:val="1"/><w:numFmt w:val="none"/><w:suff w:val="nothing"/><w:lvlText w:val=""/><w:lvlJc w:val="left"/><w:pPr><w:tabs><w:tab w:val="num" w:pos="1008"/></w:tabs><w:ind w:left="1008" w:hanging="1008"/></w:pPr></w:lvl><w:lvl w:ilvl="5"><w:start w:val="1"/><w:numFmt w:val="none"/><w:suff w:val="nothing"/><w:lvlText w:val=""/><w:lvlJc w:val="left"/><w:pPr><w:tabs><w:tab w:val="num" w:pos="1152"/></w:tabs><w:ind w:left="1152" w:hanging="1152"/></w:pPr></w:lvl><w:lvl w:ilvl="6"><w:start w:val="1"/><w:numFmt w:val="none"/><w:suff w:val="nothing"/><w:lvlText w:val=""/><w:lvlJc w:val="left"/><w:pPr><w:tabs><w:tab w:val="num" w:pos="1296"/></w:tabs><w:ind w:left="1296" w:hanging="1296"/></w:pPr></w:lvl><w:lvl w:ilvl="7"><w:start w:val="1"/><w:numFmt w:val="none"/><w:suff w:val="nothing"/><w:lvlText w:val=""/><w:lvlJc w:val="left"/><w:pPr><w:tabs><w:tab w:val="num" w:pos="1440"/></w:tabs><w:ind w:left="1440" w:hanging="1440"/></w:pPr></w:lvl><w:lvl w:ilvl="8"><w:start w:val="1"/><w:numFmt w:val="none"/><w:suff w:val="nothing"/><w:lvlText w:val=""/><w:lvlJc w:val="left"/><w:pPr><w:tabs><w:tab w:val="num" w:pos="1584"/></w:tabs><w:ind w:left="1584" w:hanging="1584"/></w:pPr></w:lvl></w:abstractNum><w:num w:numId="1"><w:abstractNumId w:val="1"/></w:num></w:numbering>'.

]

{ #category : #files }
TabularDOCXExperimentalExport >> relsString [

^'<?xml version="1.0" encoding="UTF-8"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">

<Relationship Id="rId1" Type="http://schemas.openxmlformats.org/package/2006/relationships/metadata/core-properties" Target="docProps/core.xml"/>

<Relationship Id="rId2" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/extended-properties" Target="docProps/app.xml"/>

<Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="word/document.xml"/>
</Relationships>'.


]

{ #category : #files }
TabularDOCXExperimentalExport >> settingsString [

^'<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:settings xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"><w:zoom w:percent="90"/><w:defaultTabStop w:val="709"/></w:settings>'.

]

{ #category : #files }
TabularDOCXExperimentalExport >> stylesString [

^'<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:styles xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:w14="http://schemas.microsoft.com/office/word/2010/wordml" xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" mc:Ignorable="w14"><w:docDefaults><w:rPrDefault><w:rPr><w:rFonts w:ascii="Liberation Serif" w:hAnsi="Liberation Serif" w:eastAsia="Droid Sans Fallback" w:cs="FreeSans"/><w:sz w:val="24"/><w:szCs w:val="24"/><w:lang w:val="en-GB" w:eastAsia="zh-CN" w:bidi="hi-IN"/></w:rPr></w:rPrDefault><w:pPrDefault><w:pPr></w:pPr></w:pPrDefault></w:docDefaults><w:style w:type="paragraph" w:styleId="Normal"><w:name w:val="Normal"/><w:pPr><w:widowControl w:val="false"/><w:suppressAutoHyphens w:val="true"/></w:pPr><w:rPr><w:rFonts w:ascii="Liberation Serif" w:hAnsi="Liberation Serif" w:eastAsia="Droid Sans Fallback" w:cs="FreeSans"/><w:color w:val="auto"/><w:sz w:val="24"/><w:szCs w:val="24"/><w:lang w:val="en-GB" w:eastAsia="zh-CN" w:bidi="hi-IN"/></w:rPr></w:style><w:style w:type="paragraph" w:styleId="Heading1"><w:name w:val="Heading 1"/><w:basedOn w:val="Heading"/><w:next w:val="TextBody"/><w:pPr><w:numPr><w:ilvl w:val="0"/><w:numId w:val="1"/></w:numPr><w:spacing w:before="240" w:after="120"/><w:outlineLvl w:val="0"/><w:outlineLvl w:val="0"/></w:pPr><w:rPr><w:b/><w:bCs/><w:sz w:val="36"/><w:szCs w:val="36"/></w:rPr></w:style><w:style w:type="paragraph" w:styleId="Heading2"><w:name w:val="Heading 2"/><w:basedOn w:val="Heading"/><w:next w:val="TextBody"/><w:pPr><w:numPr><w:ilvl w:val="1"/><w:numId w:val="1"/></w:numPr><w:spacing w:before="200" w:after="120"/><w:outlineLvl w:val="1"/><w:outlineLvl w:val="1"/></w:pPr><w:rPr><w:b/><w:bCs/><w:sz w:val="32"/><w:szCs w:val="32"/></w:rPr></w:style><w:style w:type="paragraph" w:styleId="Heading3"><w:name w:val="Heading 3"/><w:basedOn w:val="Heading"/><w:next w:val="TextBody"/><w:pPr><w:numPr><w:ilvl w:val="2"/><w:numId w:val="1"/></w:numPr><w:spacing w:before="140" w:after="120"/><w:outlineLvl w:val="2"/><w:outlineLvl w:val="2"/></w:pPr><w:rPr><w:b/><w:bCs/><w:color w:val="808080"/><w:sz w:val="28"/><w:szCs w:val="28"/></w:rPr></w:style><w:style w:type="paragraph" w:styleId="Heading"><w:name w:val="Heading"/><w:basedOn w:val="Normal"/><w:next w:val="TextBody"/><w:pPr><w:keepNext/><w:spacing w:before="240" w:after="120"/></w:pPr><w:rPr><w:rFonts w:ascii="Liberation Sans" w:hAnsi="Liberation Sans" w:eastAsia="Droid Sans Fallback" w:cs="FreeSans"/><w:sz w:val="28"/><w:szCs w:val="28"/></w:rPr></w:style><w:style w:type="paragraph" w:styleId="TextBody"><w:name w:val="Text Body"/><w:basedOn w:val="Normal"/><w:pPr><w:spacing w:lineRule="auto" w:line="288" w:before="0" w:after="140"/></w:pPr><w:rPr></w:rPr></w:style><w:style w:type="paragraph" w:styleId="List"><w:name w:val="List"/><w:basedOn w:val="TextBody"/><w:pPr></w:pPr><w:rPr><w:rFonts w:cs="FreeSans"/></w:rPr></w:style><w:style w:type="paragraph" w:styleId="Caption"><w:name w:val="Caption"/><w:basedOn w:val="Normal"/><w:pPr><w:suppressLineNumbers/><w:spacing w:before="120" w:after="120"/></w:pPr><w:rPr><w:rFonts w:cs="FreeSans"/><w:i/><w:iCs/><w:sz w:val="24"/><w:szCs w:val="24"/></w:rPr></w:style><w:style w:type="paragraph" w:styleId="Index"><w:name w:val="Index"/><w:basedOn w:val="Normal"/><w:pPr><w:suppressLineNumbers/></w:pPr><w:rPr><w:rFonts w:cs="FreeSans"/></w:rPr></w:style><w:style w:type="paragraph" w:styleId="Quotations"><w:name w:val="Quotations"/><w:basedOn w:val="Normal"/><w:pPr><w:spacing w:before="0" w:after="283"/><w:ind w:left="567" w:right="567" w:hanging="0"/></w:pPr><w:rPr></w:rPr></w:style><w:style w:type="paragraph" w:styleId="Title"><w:name w:val="Title"/><w:basedOn w:val="Heading"/><w:next w:val="TextBody"/><w:pPr><w:jc w:val="center"/></w:pPr><w:rPr><w:b/><w:bCs/><w:sz w:val="56"/><w:szCs w:val="56"/></w:rPr></w:style><w:style w:type="paragraph" w:styleId="Subtitle"><w:name w:val="Subtitle"/><w:basedOn w:val="Heading"/><w:next w:val="TextBody"/><w:pPr><w:spacing w:before="60" w:after="120"/><w:jc w:val="center"/></w:pPr><w:rPr><w:sz w:val="36"/><w:szCs w:val="36"/></w:rPr></w:style><w:style w:type="paragraph" w:styleId="TableContents"><w:name w:val="Table Contents"/><w:basedOn w:val="Normal"/><w:pPr><w:suppressLineNumbers/></w:pPr><w:rPr></w:rPr></w:style></w:styles>'.

]
