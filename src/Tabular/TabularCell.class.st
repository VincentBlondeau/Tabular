Class {
	#name : #TabularCell,
	#superclass : #TabularObject,
	#instVars : [
		'data',
		'style'
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
	self type = 'str'
		ifTrue: [ ^ data ].
	self type = 's'
		ifTrue: [ ^ (self stringAt: data) asString ].
	self type ifNil: [ ^ data ]
]

{ #category : #accessing }
TabularCell >> data: anObject [
	data := anObject
]

{ #category : #'as yet unclassified' }
TabularCell >> dataIfNotNil [
	^ self data ifNil: [ self error: 'The accessed data is nil!' ]
]

{ #category : #'as yet unclassified' }
TabularCell >> extractFromXml: aXMLElement [
	self style: (aXMLElement attributeAt: 's').
	self type: (aXMLElement attributeAt: 't' ifAbsent: [ nil ]).
	self data: ((aXMLElement elementAt: 'v') ifNotNil: [ :e | e firstNode ]).
	self formula: ((aXMLElement elementAt: 'f') ifNotNil: [ :e | e firstNode ])
]

{ #category : #'accessing - attributes' }
TabularCell >> formula [
	^ self attributeAt: #formula
]

{ #category : #'accessing - attributes' }
TabularCell >> formula: anObject [
	^ self attributeAt: #formula put: anObject
]

{ #category : #'as yet unclassified' }
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
	^ self attributeAt: #type
]

{ #category : #'accessing - attributes' }
TabularCell >> type: anObject [
	^ self attributeAt: #type put: anObject
]
