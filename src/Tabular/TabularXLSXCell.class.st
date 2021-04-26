"
See TabularCell for description and responsibilities.

Standard:

p. 1600
18.3.1.4 Cell

Example
<row r=""1"" spans=""1:1"">
<c r=""A1"" t=""inlineStr"">
<is><t>This is inline string example</t></is>
</c>
</row>

s attribute is style index,
t attribute is cell data type; values are on p. 2444, 18.18.11

b boolean
d date
e error
inlineStr (inline string)
n number
s shared string
str (formula string)

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
	#name : #TabularXLSXCell,
	#superclass : #TabularCell,
	#instVars : [
		'style',
		'type',
		'formula'
	],
	#category : #'Tabular-Model'
}

{ #category : #'accessing - attributes' }
TabularXLSXCell >> colspan [
	^ self attributeAt: #colspan
]

{ #category : #'accessing - attributes' }
TabularXLSXCell >> colspan: anObject [
	^ self attributeAt: #colspan put: anObject
]

{ #category : #'accessing - attributes' }
TabularXLSXCell >> formula [
	"not in attributes for performance issues"

	^ formula
]

{ #category : #'accessing - attributes' }
TabularXLSXCell >> formula: anObject [
	"not in attributes for performance issues"

	formula := anObject
]

{ #category : #testing }
TabularXLSXCell >> hasSharableString [
	"strings can be shared when they have not been computed by a formula"
	^data isString and: [ formula isNil ]
]

{ #category : #'accessing - attributes' }
TabularXLSXCell >> rowspan [
	^ self attributeAt: #rowspan
]

{ #category : #'accessing - attributes' }
TabularXLSXCell >> rowspan: anObject [
	^ self attributeAt: #rowspan put: anObject
]

{ #category : #accessing }
TabularXLSXCell >> stringAt: aXMLString [
	^ self stringTable at: aXMLString asString asInteger
]

{ #category : #'accessing - attributes' }
TabularXLSXCell >> style [
	^ style 
]

{ #category : #'accessing - attributes' }
TabularXLSXCell >> style: anObject [
	style := anObject
]

{ #category : #'accessing - attributes' }
TabularXLSXCell >> type [
	^ type
]

{ #category : #'accessing - attributes' }
TabularXLSXCell >> type: anObject [
	"not in attributes for performance issues"

	type := anObject
]
