Class {
	#name : #PaeoniaOrder,
	#superclass : #PaeoniaObject,
	#instVars : [
		'shop',
		'entries'
	],
	#category : #'Paeonia-Model'
}

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

{ #category : #accessing }
PaeoniaOrder >> shop [
	^ shop
]

{ #category : #accessing }
PaeoniaOrder >> shop: anObject [
	shop := anObject
]
