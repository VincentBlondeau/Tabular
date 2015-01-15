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
	data ifNil: [ ^ nil ].
	self type = 'str'
		ifTrue: [ ^ data ].
	self type = 's'
		ifTrue: [ ^ (self stringAt: data) asString ].
	self style isDate
		ifTrue: [ ^ Date fromExcelDays: data asString ].
	self type ifNil: [ ^ data asString ]
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
	self style: (aXMLElement attributeAt: 's').
	self type: (aXMLElement attributeAt: 't' ifAbsent: [ nil ]).
	self data: ((aXMLElement elementAt: 'v') ifNotNil: [ :e | e firstNode ]).
	self formula: ((aXMLElement elementAt: 'f') ifNotNil: [ :e | e firstNode ])
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
	^ self styleAt: style 
]

{ #category : #'accessing - attributes' }
TabularCell >> style: anObject [
	style := anObject
]

{ #category : #accessing }
TabularCell >> styleAt: aString [
	aString ifEmpty: [ ^ TabularStyle newFrom: self workbook ].
	^ self workbook styles at: aString
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
