Class {
	#name : #TabularWorkbook,
	#superclass : #TabularObject,
	#instVars : [
		'worksheets',
		'styles',
		'strings'
	],
	#category : #'Tabular-Model'
}

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

{ #category : #'as yet unclassified' }
TabularWorkbook >> addNewWorksheet [
	worksheets add: TabularWorksheet new. "Maybe worksheet name generation should be here"
]

{ #category : #adding }
TabularWorkbook >> addSheet: aTabularWorksheet [ 
	worksheets add: aTabularWorksheet 
]

{ #category : #'accessing - attributes' }
TabularWorkbook >> filename [
	^ self attributeAt: #filename
]

{ #category : #'accessing - attributes' }
TabularWorkbook >> filename: anObject [
	^ self attributeAt: #filename put: anObject 
]

{ #category : #finding }
TabularWorkbook >> findWorksheetNamed: aString [ 
	^ self worksheets detect: [ :aSheet | aSheet name = aString ] 
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
TabularWorkbook >> worksheets [
	^worksheets
]
