Class {
	#name : #PaeoniaObject,
	#superclass : #Object,
	#instVars : [
		'unrecognized'
	],
	#category : #'Paeonia-Model'
}

{ #category : #accessing }
PaeoniaObject >> unrecognized [
	^ unrecognized
]

{ #category : #accessing }
PaeoniaObject >> unrecognized: anObject [
	unrecognized := anObject
]
