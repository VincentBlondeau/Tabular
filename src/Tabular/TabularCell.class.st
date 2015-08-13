"
I am TabularCell and the represent a cell in a Worksheet.

Responsibility:
I keep the value and type of a cell, the dimension and the formatting attributes.


For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- what is the way to create instances is a plus.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
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
TabularCell >> extractDataFromXml: aXMLElement [

	self data: (
		(self type = 's')
			ifTrue: [ (self stringAt: ((aXMLElement elementAt: 'v') ifNotNil: [ :e | e firstNode ifNotNil: [ :s | s asString ] ])) asString ]
			ifFalse: [((aXMLElement elementAt: 'v') ifNotNil: [ :e | e firstNode ifNotNil: [ :s | s asString ] ])]
	).

]

{ #category : #conversion }
TabularCell >> extractFromXml: aXMLElement [

	self style: (aXMLElement attributeAt: 's') asString.
	self type: ((aXMLElement attributeAt: 't') asString ifEmpty: [ nil ]).
     self extractDataFromXml: aXMLElement.
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
