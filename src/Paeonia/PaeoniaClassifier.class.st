Class {
	#name : #PaeoniaClassifier,
	#superclass : #Object,
	#instVars : [
		'desc',
		'guid'
	],
	#category : #'Paeonia-Model'
}

{ #category : #'instance creation' }
PaeoniaClassifier class >> guid: guid desc: desc [
	^(self new)
		guid: guid;
		desc: desc;
		yourself.
]

{ #category : #accessing }
PaeoniaClassifier >> desc [
	^ desc
]

{ #category : #accessing }
PaeoniaClassifier >> desc: anObject [
	desc := anObject asString withBlanksCondensed
]

{ #category : #accessing }
PaeoniaClassifier >> guid [
	^ guid
]

{ #category : #accessing }
PaeoniaClassifier >> guid: anObject [
	guid := anObject asString withBlanksCondensed
]

{ #category : #'as yet unclassified' }
PaeoniaClassifier >> printOn: aStream [
	aStream << desc << ' {' << guid<<$).
]
