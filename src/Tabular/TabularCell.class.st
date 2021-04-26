"
I  represent a single cell in a Worksheet.

Responsibility:
I provide access to the value, formula, style and formatting information.  The encoding of this information follows the format used by the document type, i.e. XLSX or ODS.

"
Class {
	#name : #TabularCell,
	#superclass : #TabularObject,
	#instVars : [
		'data'
	],
	#category : #'Tabular-Model'
}

{ #category : #accessing }
TabularCell >> data [
	^data
]

{ #category : #accessing }
TabularCell >> data: anObject [
	data := anObject
]

{ #category : #accessing }
TabularCell >> dataIfNotNil [
	^ self data ifNil: [ NotFound signal: 'The accessed data is nil!' ]
]

{ #category : #'accessing - attributes' }
TabularCell >> formula [

	self subclassResponsibility.
]

{ #category : #testing }
TabularCell >> isTabularCell [
	^ true
]

{ #category : #printing }
TabularCell >> printOn: stream [
	super printOn: stream.
	stream << '(' << self data asString <<')'.
]

{ #category : #'accessing - attributes' }
TabularCell >> style [

	self subclassResponsibility.
]

{ #category : #accessing }
TabularCell >> value [

	^self data.
]
