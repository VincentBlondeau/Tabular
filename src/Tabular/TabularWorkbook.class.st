"
I am a TabularWorkbook the model for a spreadsheet file.

TabularWorkbook example1

For the Responsibility part: Three sentences about my main responsibility, what I'm doing, what services do I offer.

For the Collaborators Part: 
I keep one or more Worksheets


Public API and Key Messages

- message one   
- message two 
- what is the way to create instances is a plus.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #TabularWorkbook,
	#superclass : #TabularObject,
	#instVars : [
		'worksheets',
		'styles',
		'strings'
	],
	#category : 'Tabular-Model'
}

{ #category : #'instance creation' }
TabularWorkbook class >> example1 [
	| workbook sheet |
	workbook := TabularWorkbook withSheets: 1.
	workbook filename: 'Test.xlsx'.
	sheet := workbook worksheets first.
	sheet
		at: 1 @ 1 putData: '-';
		at: 2 @ 1 putData: 'colspan test ...........';
		at: 1 @ 2 putData: 'rowspan test';
		at: 2 @ 2 putData: 777.77.
	(sheet cells at: 2 @ 1) colspan: 3.
	(sheet cells at: 1 @ 2) rowspan: 3.
	sheet  at: 4 @ 3 putData: 'Jurij -- Юрий'.
	
	^ workbook
]

{ #category : #'instance creation' }
TabularWorkbook class >> newFrom: aTabularWorkbook [
	^ self shouldNotImplement
]

{ #category : #'instance creation' }
TabularWorkbook class >> withSheets: n [
| res |
	res:=self new.
	n timesRepeat: [ res addNewWorksheet].
	^res.
]

{ #category : #adding }
TabularWorkbook >> addNewWorksheet [

	| newWorksheet |
	
	newWorksheet := TabularWorksheet new.
	newWorksheet workbook: self.
	"Maybe worksheet name generation should be here"
	worksheets add: newWorksheet.
	
]

{ #category : #adding }
TabularWorkbook >> addSheet: aTabularWorksheet [ 
	worksheets add: aTabularWorksheet 
]

{ #category : #finding }
TabularWorkbook >> containsWorksheetNamed: aString [
	self worksheetNamed: aString ifNone: [ ^ false ].
	^ true
]

{ #category : #'accessing - attributes' }
TabularWorkbook >> filename [
	^ self attributeAt: #filename
]

{ #category : #'accessing - attributes' }
TabularWorkbook >> filename: anObject [
	^ self attributeAt: #filename put: anObject 
]

{ #category : #initialization }
TabularWorkbook >> initialize [
	super initialize.
	worksheets := OrderedCollection new
]

{ #category : #accessing }
TabularWorkbook >> stringTable [
	^ strings
]

{ #category : #accessing }
TabularWorkbook >> stringTable: aTabularSharedStrings [ 
	strings := aTabularSharedStrings 
]

{ #category : #accessing }
TabularWorkbook >> styleNamed: aString [

	^styles at: aString
]

{ #category : #accessing }
TabularWorkbook >> styles [
	^ styles 
]

{ #category : #accessing }
TabularWorkbook >> styles: aTabularStyleContainer [
	styles := aTabularStyleContainer 
]

{ #category : #finding }
TabularWorkbook >> worksheetNamed: aString [ 
	^ self worksheets detect: [ :aSheet | aSheet name = aString ] 
]

{ #category : #finding }
TabularWorkbook >> worksheetNamed: aString ifNone: aBlock [
	^ self worksheets detect: [ :aSheet | aSheet name = aString ] ifNone: aBlock
]

{ #category : #accessing }
TabularWorkbook >> worksheets [
	^worksheets
]
