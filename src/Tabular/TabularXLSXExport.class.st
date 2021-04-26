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
	#name : #TabularXLSXExport,
	#superclass : #TabularExport,
	#instVars : [
		'sharedStrings',
		'totalSharedStrings'
	],
	#category : #'Tabular-Exporters'
}

{ #category : #examples }
TabularXLSXExport class >> example1 [

    self workbook: (TabularWorkbook example1) fileName: 'TabularTest1.xlsx'
]

{ #category : #examples }
TabularXLSXExport class >> example2 [
"round trip"
 | workbook |

self halt. "does not work yet"
self workbook: (TabularWorkbook example1) fileName: 'TabularTest2Export.xlsx'.

workbook := XLSXImporter import: (FileLocator home / 'TabularTest2Export.xlsx') asFileReference.

self workbook: (TabularWorkbook example1) fileName: 'TabularTest2ExportAndReimported.xlsx'.
]

{ #category : #examples }
TabularXLSXExport class >> example3 [

    | file workbook |
	file := TabularResources testExcelFile3WithAlignment readStream.
	workbook := XLSXImporter import: file.

    self workbook: workbook fileName: 'TabularTest2WithAlingment.xlsx'

"merged cells are not properly rendered; alingment is not rendered"
]

{ #category : #files }
TabularXLSXExport >> content_types_xml [
	" [Content_Types].xml file, this describes the location of the major files in the archive and the standards to which it itself adheres and the content types of those files. 
"

	| w |
	w := self newXMLWriterForRels.
	(w tag: 'Types')
		xmlns: 'http://schemas.openxmlformats.org/package/2006/content-types';
		with: [ w
				tag: 'Override'
				attributes:
					{(#PartName -> '/_rels/.rels').
					(#ContentType -> 'application/vnd.openxmlformats-package.relationships+xml')}.
			w
				tag: 'Override'
				attributes:
					{(#PartName -> '/docProps/app.xml').
					(#ContentType -> 'application/vnd.openxmlformats-officedocument.extended-properties+xml')}.
			w
				tag: 'Override'
				attributes:
					{(#PartName -> '/docProps/core.xml').
					(#ContentType -> 'application/vnd.openxmlformats-package.core-properties+xml')}.
			w
				tag: 'Override'
				attributes:
					{(#PartName -> '/xl/_rels/workbook.xml.rels').
					(#ContentType -> 'application/vnd.openxmlformats-package.relationships+xml')}.
			w
				tag: 'Override'
				attributes:
					{(#PartName -> '/xl/sharedStrings.xml').
					(#ContentType -> 'application/vnd.openxmlformats-officedocument.spreadsheetml.sharedStrings+xml')}.
			w
				tag: 'Override'
				attributes:
					{(#PartName -> '/xl/styles.xml').
					(#ContentType -> 'application/vnd.openxmlformats-officedocument.spreadsheetml.styles+xml')}.
			w
				tag: 'Override'
				attributes:
					{(#PartName -> '/xl/workbook.xml').
					(#ContentType -> 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml')}.
			1 to: workbook worksheets size do: [ :index | 
				w
					tag: 'Override'
					attributes:
						{(#PartName -> ('/xl/worksheets/sheet' , index printString , '.xml')).
						(#ContentType -> 'application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml')} ] ].
	^w contents
]

{ #category : #initialize }
TabularXLSXExport >> countSharedStrings [
	"To write the shared string table, we need it (naturally) and we need the total number of cells containing shared strings."
	sharedStrings := OrderedCollection new.
	totalSharedStrings := 0.
	workbook worksheets
		do: [ :sheet | 
			sheet
				cellsDo: [ :cell | 
					cell hasSharableString
						ifTrue: [ totalSharedStrings := totalSharedStrings + 1.
							(sharedStrings includes: cell data)
								ifFalse: [ sharedStrings add: cell data ] ] ] ]
]

{ #category : #files }
TabularXLSXExport >> docPropsApp_xml [
	| w |
	w := self newXMLWriter.
	(w tag: 'Properties')
		xmlns: 'http://schemas.openxmlformats.org/officeDocument/2006/extended-properties';
		xmlnsAt: #vt put: 'http://schemas.openxmlformats.org/officeDocument/2006/docPropsVTypes';
		with: [
			w tag: 'TotalTime' with: '0'.	"Tabular workbooks don't have a total editing time attribute yet"
			w tag: 'Application' with: 'Pharo Tabular Export'].
	^w contents
]

{ #category : #files }
TabularXLSXExport >> docPropsCore_xml [
	| w |
	w := self newXMLWriter.
	(w tag: 'cp:coreProperties')
		xmlnsAt: 'cp'
			put: 'http://schemas.openxmlformats.org/package/2006/metadata/core-properties';
		xmlnsAt: 'dc' put: 'http://purl.org/dc/elements/1.1/';
		xmlnsAt: 'dcterms' put: 'http://purl.org/dc/terms/';
		xmlnsAt: 'dcmitype' put: 'http://purl.org/dc/dcmitype/';
		xmlnsAt: 'xsi' put: 'http://www.w3.org/2001/XMLSchema-instance';
		with: [ w
				tag: 'dcterms:created'
				attributes: {(#xsi:type -> 'dcterms:W3CDTF')}
				with: DateAndTime now asString.
			w tag: 'dc:creator' with: 'Tabular'.
			w tag: 'dc:language' with: 'en-GB'.
			w tag: 'cp:revision' with: '1' ].
	^ w contents
]

{ #category : #files }
TabularXLSXExport >> generate [
	
	zip addString: self content_types_xml as: '[Content_Types].xml'.
	zip addString: self rels as: '_rels/.rels'.

	zip addString: self docPropsApp_xml as: 'docProps/app.xml'.
	zip addString: self docPropsCore_xml as: 'docProps/core.xml'.

    "Everything outside the xl/ folder is just meta data"
	self countSharedStrings.
	zip addString: self sharedStrings_xml  as: 'xl/sharedStrings.xml'.
	zip addString: self styles_xml as: 'xl/styles.xml'.
	zip addString: self workbook_xml as: 'xl/workbook.xml'.
	zip addString: self workbook_xml_rels as: 'xl/_rels/workbook.xml.rels'.
	workbook worksheets
		doWithIndex: [ :worksheet :index | 
			zip
				addString: (TabularWorksheetWriterXL for: worksheet)
				as: 'xl/worksheets/sheet' , index printString , '.xml' ].
	
	self writeZip.
]

{ #category : #initialize }
TabularXLSXExport >> initialize [
	zip := ZipArchive new
]

{ #category : #files }
TabularXLSXExport >> newXMLWriter [
	"create a new XML writer that emits the proper XML declaration and pretty-prints output."
	| w |
	w := XMLWriter new enablePrettyPrinting.
	w xml encoding: 'UTF-8'; standalone: true.
	^w
]

{ #category : #files }
TabularXLSXExport >> newXMLWriterForRels [
	"create a new XML writer that emits the proper XML declaration (without standalone attribute) and pretty-prints output."
	| w |
	w := XMLWriter new enablePrettyPrinting.
	w xml encoding: 'UTF-8'.
	^w
]

{ #category : #files }
TabularXLSXExport >> rels [
	"self basicNew rels"

	^ self
		relsFor:
			{('xl/workbook.xml' -> 'http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument').
			('docProps/core.xml'
				-> 'http://schemas.openxmlformats.org/package/2006/relationships/metadata/core-properties').
			('docProps/app.xml'
				-> 'http://schemas.openxmlformats.org/officeDocument/2006/relationships/extended-properties')}
]

{ #category : #files }
TabularXLSXExport >> relsFor: associations [
	"create the relationships XML for the given associations which map member names within XLSX file to their types"
	| w n |
	w := self newXMLWriterForRels.
	(w tag: 'Relationships')
		xmlns: 'http://schemas.openxmlformats.org/package/2006/relationships';
		with: [
			n := 1.
			associations do: [ :assoc |
				 (w tag: 'Relationship')
				attributes:
					{(#Id -> ('rId', n printString)).
					(#Type -> assoc value).
					(#Target -> assoc key)}.
					n := n+1]].
	^ w contents
]

{ #category : #files }
TabularXLSXExport >> sharedStrings_xml [
	"we don't maintain the string table within the workbook during processing, but build it only for writing"
	| w |
	w := self newXMLWriter.
	(w tag: 'sst')
		xmlns: 'http://schemas.openxmlformats.org/spreadsheetml/2006/main';
		attributes: { #count -> totalSharedStrings printString. #uniqueCount -> sharedStrings size printString };
		with: [
			sharedStrings do: [ :each |
				w tag: 'si' with: [ 
					w tag: 't' attributes: {  #xml:space -> 'preserve' } with: each ] ]
			].
	^w contents
]

{ #category : #'files-styles-xml' }
TabularXLSXExport >> stylesBordersOn: w [
	w
		tag: 'borders'
		attributes: {(#count -> '1')}
		with: [ w
				tag: 'border'
				attributes:
					{(#diagonalUp -> 'false').
					(#diagonalDown -> 'false')}
				with: [ w
						tag: 'left';
						tag: 'right';
						tag: 'top';
						tag: 'bottom';
						tag: 'diagonal' ] ]
]

{ #category : #'files-styles-xml' }
TabularXLSXExport >> stylesCellStyleXfsOn: w [
	w
		tag: 'cellStyleXfs'
		attributes: {(#count -> '20')}
		with: [ w
				tag: 'xf'
				attributes:
					{(#numFmtId -> '164').
					(#fontId -> '0').
					(#fillId -> '0').
					(#borderId -> '0').
					(#applyFont -> 'true').
					(#applyBorder -> 'true').
					(#applyAlignment -> 'true').
					(#applyProtection -> 'true')}
				with: [ w
						tag: 'alignment'
						attributes:
							{(#horizontal -> 'general').
							(#vertical -> 'bottom').
							(#textRotation -> '0').
							(#wrapText -> 'false').
							(#indent -> '0').
							(#shrinkToFit -> 'false')}.
					w
						tag: 'protection'
						attributes:
							{(#locked -> 'true').
							(#hidden -> 'false')} ].
			#(#(0 1) #(0 1) #(0 2) #(0 2) #(0 0) #(0 0) #(0 0) #(0 0) #(0 0) #(0 0) #(0 0) #(0 0) #(0 0) #(0 0) #(43 1) #(41 1) #(44 1) #(42 1) #(9 1))
				do: [ :pair | 
					w
						tag: 'xf'
						attributes:
							{(#numFmtId -> pair first printString).
							(#fontId -> pair last printString).
							(#fillId -> '0').
							(#borderId -> '0').
							(#applyFont -> 'true').
							(#applyBorder -> 'true').
							(#applyAlignment -> 'true').
							(#applyProtection -> 'true')} ] ]
]

{ #category : #'files-styles-xml' }
TabularXLSXExport >> stylesCellStylesOn: w [
	w
		tag: 'cellStyles'
		attributes: {(#count -> '6')}
		with:
			[ #(
				#('Normal' 0 0)
				#('Comma' 15 3)
				#('Comma [0]' 16 6)
				#('Currency' 17 4)
				#('Currency [0]' 18 7)
				#('Percent' 19 5))
				do: [ :triple | 
					w
						tag: 'cellStyle'
						attributes:
							{(#name -> triple first).
							(#xfId -> triple second printString).
							(#builtinId -> triple third printString).
							(#customBuiltin -> 'false')} ] ]
]

{ #category : #'files-styles-xml' }
TabularXLSXExport >> stylesCellXfsOn: w [
	w
		tag: 'cellXfs'
		attributes: {(#count -> '1')}
		with: [ w
				tag: 'xf'
				attributes:
					{(#numFmtId -> '164').
					(#fontId -> '0').
					(#fillId -> '0').
					(#borderId -> '0').
					(#applyFont -> 'false').
					(#applyBorder -> 'false').
					(#applyAlignment -> 'false').
					(#applyProtection -> 'false')}
				with: [ w
						tag: 'alignment'
						attributes:
							{(#horizontal -> 'general').
							(#vertical -> 'bottom').
							(#textRotation -> '0').
							(#wrapText -> 'false').
							(#indent -> '0').
							(#shrinkToFit -> 'false')}.
					w
						tag: 'protection'
						attributes:
							{(#locked -> 'true').
							(#hidden -> 'false')} ] ]
]

{ #category : #'files-styles-xml' }
TabularXLSXExport >> stylesFillsOn: w [
	w
		tag: 'fills'
		attributes: {(#count -> '2')}
		with: [
			w tag: 'fill' with: [ w tag: 'patternFill' attributes: {(#patternType -> 'none')} ].
			w tag: 'fill' with: [ w tag: 'patternFill' attributes: {(#patternType -> 'gray125')} ] ]
]

{ #category : #'files-styles-xml' }
TabularXLSXExport >> stylesFontsOn: w [
	"at the moment, we just write 4 entries, 3 of which are identical."

	w
		tag: 'fonts'
		attributes: {(#count -> '4')}
		with: [ (w tag: 'font')
				with: [ w tag: 'sz' attributes: {(#val -> '10')}.
					w tag: 'name' attributes: {(#val -> 'Arial')}.
					w tag: 'family' attributes: {(#val -> '0')} ].
			3
				timesRepeat: [ (w tag: 'font')
						with: [ w tag: 'sz' attributes: {(#val -> '10')}.
							w tag: 'name' attributes: {(#val -> 'Arial')}.
							w tag: 'family' attributes: {(#val -> '2')} ] ] ]
]

{ #category : #'files-styles-xml' }
TabularXLSXExport >> stylesNumFmtsOn: w [
	w
		tag: 'numFmts'
		attributes: {(#count -> '1')}
		with: [ w
				tag: 'numFmt'
				attributes:
					{(#numFmtId -> '164').
					(#formatCode -> 'GENERAL')} ]
]

{ #category : #'files-styles-xml' }
TabularXLSXExport >> styles_xml [
	"These are the styles as emitted by an empty LibreOffice Calc document (give or take some lower/uppercase differences). For an actually styled sheet, we would need to maintain styles within Tabular which we don't do yet.
	The previous version of this method returned a constant string, which is shorter but less extendable...
	self new styles_xml"
	| w |
	w := self newXMLWriter.
	(w tag: 'Stylesheet')
		xmlns: 'http://schemas.openxmlformats.org/spreadsheetml/2006/main';
		with: [
			self stylesNumFmtsOn: w.
			self stylesFontsOn: w.
			self stylesFillsOn: w.
			self stylesBordersOn: w.
			self stylesCellStyleXfsOn: w.
			self stylesCellXfsOn: w.
			self stylesCellStylesOn: w].
	 ^w contents
]

{ #category : #files }
TabularXLSXExport >> workbook_xml [
	"self new workbook: (TabularWorkbook new addSheet: TabularWorksheet new); workbook_xml"

	| w |
	w := self newXMLWriter.
	(w tag: 'workbook')
		xmlns: 'http://schemas.openxmlformats.org/spreadsheetml/2006/main';
		xmlnsAt: 'r' put: 'http://schemas.openxmlformats.org/officeDocument/2006/relationships';
		with: [ w tag: 'fileVersion' attributes: {(#appName -> 'Tabular')}.
			w
				tag: 'workbookPr'
				attributes:
					{(#backupFile -> 'false').
					(#showObjects -> 'all').
					(#date1904 -> 'false')}.
			w tag: 'workbookProtection'.
			w
				tag: 'calcPr'
				attributes:
					{(#iterateCount -> '100').
					(#refMode -> 'A1').
					(#iterate -> 'false').
					(#iterateDelta -> '0.001')}.
			w
				tag: 'sheets'
				with: [ workbook worksheets
						doWithIndex: [ :each :index | 
							w
								tag: 'sheet'
								attributes:
									{(#name -> each name).
									(#sheetId -> index printString).
									(#state -> 'visible').
									(#r:id -> ('rId' , (index + 2) printString))} ] ] ].
	^w contents
]

{ #category : #files }
TabularXLSXExport >> workbook_xml_rels [
	"self new workbook: (TabularWorkbook new addSheet: TabularWorksheet new); workbook_xml_rels"
	| associations |
	associations := OrderedCollection
		with: 'styles.xml' -> 'http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles'
		with: 'sharedStrings.xml' -> 'http://schemas.openxmlformats.org/officeDocument/2006/relationships/sharedStrings'.
	workbook worksheets
		doWithIndex: [ :worksheet :index | 
			associations
				add:
					('worksheets/sheet' , index printString, '.xml')
						-> 'http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet' ].
	^ self relsFor: associations
]
