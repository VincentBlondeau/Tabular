Class {
	#name : #PaeoniaOrder,
	#superclass : #PaeoniaObject,
	#instVars : [
		'customerDesc',
		'customer',
		'entries'
	],
	#category : #'Paeonia-Model'
}

{ #category : #accessing }
PaeoniaOrder >> customer [
	^ customer
]

{ #category : #accessing }
PaeoniaOrder >> customer: anObject [
	customer := anObject
]

{ #category : #accessing }
PaeoniaOrder >> customerDesc [
	^ customerDesc
]

{ #category : #accessing }
PaeoniaOrder >> customerDesc: anObject [
	customerDesc := anObject asString withBlanksCondensed
]

{ #category : #accessing }
PaeoniaOrder >> entries [
	^ entries
]

{ #category : #accessing }
PaeoniaOrder >> entries: anObject [
	entries := anObject
]

{ #category : #'as yet unclassified' }
PaeoniaOrder >> initialize [
	entries := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
PaeoniaOrder >> unrecognized [
	^customer isNil
]
