Class {
	#name : #TabularWorkbook,
	#superclass : #TabularObject,
	#instVars : [
		'worksheets',
		'styles'
	],
	#category : #'Tabular-Model'
}

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

{ #category : #'accessing - attributes' }
TabularWorkbook >> filename [
	^self attributeAt: #filename
]

{ #category : #'accessing - attributes' }
TabularWorkbook >> filename: anObject [
	^self attributeAt: #filename put: anObject 
]

{ #category : #initialization }
TabularWorkbook >> initialize [
	worksheets := OrderedCollection new.
	super initialize.
]

{ #category : #accessing }
TabularWorkbook >> worksheets [
	^worksheets
]
