"
#articleId and #articleDesc are the ""external"" code and description, respectively. ""External"" means ""from the document"".

#article is a reference to ""internal"" article object, which holds classifier element from 1C database
"
Class {
	#name : #PaeoniaEntry,
	#superclass : #PaeoniaObject,
	#instVars : [
		'articleId',
		'articleDesc',
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
PaeoniaEntry >> articleDesc [
	^ articleDesc
]

{ #category : #accessing }
PaeoniaEntry >> articleDesc: anObject [
	articleDesc := anObject asString withBlanksCondensed
]

{ #category : #accessing }
PaeoniaEntry >> articleId [
	^ articleId
]

{ #category : #accessing }
PaeoniaEntry >> articleId: anObject [
	articleId := anObject asString withBlanksCondensed
]

{ #category : #accessing }
PaeoniaEntry >> price [
	^ price
]

{ #category : #accessing }
PaeoniaEntry >> price: anObject [
	price := anObject
]

{ #category : #'as yet unclassified' }
PaeoniaEntry >> unrecognized [
	^article isNil
]
