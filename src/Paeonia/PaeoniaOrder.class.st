Class {
	#name : #PaeoniaOrder,
	#superclass : #PaeoniaObject,
	#instVars : [
		'customer',
		'desc',
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
PaeoniaOrder >> desc [
	^ desc
]

{ #category : #accessing }
PaeoniaOrder >> desc: anObject [
	desc := anObject
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

{ #category : #accessing }
PaeoniaOrder >> shop [
	^ shop
]

{ #category : #accessing }
PaeoniaOrder >> shop: anObject [
	shop := anObject
]
