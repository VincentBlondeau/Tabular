Class {
	#name : #TabularObject,
	#superclass : #Object,
	#instVars : [
		'attributes'
	],
	#category : #'Tabular-Model'
}

{ #category : #'accessing - attributes' }
TabularObject >> attributeAt: aKeySymbol [
	^attributes at: aKeySymbol ifAbsent: nil. "Better default values management needed"
]

{ #category : #'accessing - attributes' }
TabularObject >> attributeAt: aKeySymbol put: value [
	attributes at: aKeySymbol put: value
]

{ #category : #initialization }
TabularObject >> initialize [
	super initialize.
	attributes := Dictionary new.
]
