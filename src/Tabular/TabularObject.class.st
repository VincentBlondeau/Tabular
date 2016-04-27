"
I am TabularObject, the root class of objects which model a workbook 

Responsibility:

TabularObject is the abstract superclass of all Tabular models.

Example:

Sample code showing how to open one of the workbooks used in the test suite is provided in ConfigurationOfTabular class>>catalogKeyClassesAndExample.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	attributes:		<Object>
	workbook:		<Object>


Implementation Points:

Tabular currently supports two document formats, XLSX and ODS, the internal representation of these two formats is quite different.  This has been accomodated by splitting the relevant models in to format specific versions.


Diagram see: http://www.gliffy.com/go/publish/6148167

Standard:
 http://standards.iso.org/ittf/PubliclyAvailableStandards/c061750_ISO_IEC_29500-1_2012.zip

See also

http://www.ecma-international.org/news/TC45_current_work/TC45_available_docs.htm

Other links:

http://davidgohel.github.io/ReporteRs/FlexTable.html for ideas 

http://epplus.codeplex.com/

http://stackoverflow.com/questions/151005/create-excel-xls-and-xlsx-file-from-c-sharp


"
Class {
	#name : #TabularObject,
	#superclass : #Object,
	#instVars : [
		'attributes',
		'workbook'
	],
	#category : 'Tabular-Model'
}

{ #category : #'as yet unclassified' }
TabularObject class >> newFrom: aTabularWorkbook [
	^ self new
		workbook: aTabularWorkbook;
		yourself
]

{ #category : #'accessing - attributes' }
TabularObject >> attributeAt: aKeySymbol [
	^attributes at: aKeySymbol ifAbsent: nil. "Better default values management needed"
]

{ #category : #'accessing - attributes' }
TabularObject >> attributeAt: aKeySymbol put: value [
	attributes at: aKeySymbol put: value
]

{ #category : #'xlsx specific' }
TabularObject >> extractFromXml: aXmlElement [
	self subclassResponsibility 
]

{ #category : #initialization }
TabularObject >> initialize [
	super initialize.
	attributes := Dictionary new.
]

{ #category : #testing }
TabularObject >> isTabularCell [
	^false.
]

{ #category : #testing }
TabularObject >> isTabularWorksheet [
	^false.
]

{ #category : #'xlsx specific' }
TabularObject >> rID: aString [
	self attributeAt: #rID put: aString
]

{ #category : #'xlsx specific' }
TabularObject >> stringTable [
	^ workbook stringTable 
]

{ #category : #accessing }
TabularObject >> workbook [
	^ workbook 
]

{ #category : #accessing }
TabularObject >> workbook: aTabularWorkbook [
	workbook := aTabularWorkbook 
]
