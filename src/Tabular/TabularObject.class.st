"
I am TabularObject, the root object of objects which model a workbook 

Diagram see: http://www.gliffy.com/go/publish/6148167

For the Responsibility part: Three sentences about my main responsibility, what I'm doing, what services do I offer.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- what is the way to create instances is a plus.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	attributes:		<Object>
	workbook:		<Object>


    Implementation Points
"
Class {
	#name : #TabularObject,
	#superclass : #Object,
	#instVars : [
		'attributes',
		'workbook'
	],
	#category : #'Tabular-Model'
}

{ #category : #'as yet unclassified' }
TabularObject class >> newFrom: aTabularWorkbook [
	^ self new
		workbook: aTabularWorkbook;
		yourself
]

{ #category : #'accessing - attributes' }
TabularObject >> attributeAt: aKeySymbol [
	^attributes at: aKeySymbol ifAbsent: nil. "Better default values management needed"
]

{ #category : #'accessing - attributes' }
TabularObject >> attributeAt: aKeySymbol put: value [
	attributes at: aKeySymbol put: value
]

{ #category : #conversion }
TabularObject >> extractFromXml: aXmlElement [
	self subclassResponsibility 
]

{ #category : #initialization }
TabularObject >> initialize [
	super initialize.
	attributes := Dictionary new.
]

{ #category : #testing }
TabularObject >> isTabularCell [
	^false.
]

{ #category : #testing }
TabularObject >> isTabularWorksheet [
	^false.
]

{ #category : #accessing }
TabularObject >> rID: aString [
	self attributeAt: #rID put: aString
]

{ #category : #accessing }
TabularObject >> stringTable [
	^ workbook stringTable 
]

{ #category : #accessing }
TabularObject >> workbook [
	^ workbook 
]

{ #category : #accessing }
TabularObject >> workbook: aTabularWorkbook [
	workbook := aTabularWorkbook 
]
