Class {
	#name : #TabularCell,
	#superclass : #TabularObject,
	#instVars : [
		'data',
		'style',
		'type',
		'formula'
	],
	#category : #'Tabular-Model'
}

{ #category : #'accessing - attributes' }
TabularCell >> colspan [
	^ self attributeAt: #colspan
]

{ #category : #'accessing - attributes' }
TabularCell >> colspan: anObject [
	^ self attributeAt: #colspan put: anObject
]

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

{ #category : #conversion }
TabularCell >> extractFromXml: aXMLElement [
	self style: (aXMLElement attributeAt: 's') asString.
	self type: ((aXMLElement attributeAt: 't') asString ifEmpty: [ nil ]).
	self data: (
		(self type = 's')
			ifTrue: [ (self stringAt: ((aXMLElement elementAt: 'v') ifNotNil: [ :e | e firstNode ifNotNil: [ :s | s asString ] ])) asString ]
			ifFalse: [((aXMLElement elementAt: 'v') ifNotNil: [ :e | e firstNode ifNotNil: [ :s | s asString ] ])]
	).
	self formula: ((aXMLElement elementAt: 'f') ifNotNil: [ :e | e firstNode asString ])
]

{ #category : #'accessing - attributes' }
TabularCell >> formula [
	"not in attributes for performance issues"

	^ formula
]

{ #category : #'accessing - attributes' }
TabularCell >> formula: anObject [
	"not in attributes for performance issues"

	formula := anObject
]

{ #category : #testing }
TabularCell >> isTabularCell [
	^ true
]

{ #category : #printing }
TabularCell >> printOn: stream [
	"super printOn: stream."
	stream << self data asString.
]

{ #category : #'accessing - attributes' }
TabularCell >> rowspan [
	^ self attributeAt: #rowspan
]

{ #category : #'accessing - attributes' }
TabularCell >> rowspan: anObject [
	^ self attributeAt: #rowspan put: anObject
]

{ #category : #accessing }
TabularCell >> stringAt: aXMLString [
	^ self stringTable at: aXMLString asString asInteger
]

{ #category : #'accessing - attributes' }
TabularCell >> style [
	^ style 
]

{ #category : #'accessing - attributes' }
TabularCell >> style: anObject [
	style := anObject
]

{ #category : #'accessing - attributes' }
TabularCell >> type [
	^ type
]

{ #category : #'accessing - attributes' }
TabularCell >> type: anObject [
	"not in attributes for performance issues"

	type := anObject
]
