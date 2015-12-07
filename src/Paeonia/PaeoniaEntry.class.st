Class {
	#name : #PaeoniaEntry,
	#superclass : #PaeoniaObject,
	#instVars : [
		'article',
		'price',
		'amount'
	],
	#category : #'Paeonia-Model'
}

{ #category : #accessing }
PaeoniaEntry >> amount [
	^ amount
]

{ #category : #accessing }
PaeoniaEntry >> amount: anObject [
	amount := anObject
]

{ #category : #accessing }
PaeoniaEntry >> article [
	^ article
]

{ #category : #accessing }
PaeoniaEntry >> article: anObject [
	article := anObject
]

{ #category : #accessing }
PaeoniaEntry >> price [
	^ price
]

{ #category : #accessing }
PaeoniaEntry >> price: anObject [
	price := anObject
]
