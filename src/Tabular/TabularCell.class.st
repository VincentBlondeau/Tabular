"
I am TabularCell and the represent a cell in a Worksheet.

Responsibility:
I keep the value and type of a cell, the dimension and the formatting attributes.

"
Class {
	#name : #TabularCell,
	#superclass : #TabularObject,
	#instVars : [
		'data'
	],
	#category : 'Tabular-Model'
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
