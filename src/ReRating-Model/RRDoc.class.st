Class {
	#name : #RRDoc,
	#superclass : #SPTablePart,
	#instVars : [
		'num',
		'issuer',
		'validFrom',
		'validTo'
	],
	#category : #'ReRating-Model'
}

{ #category : #'as yet unclassified' }
RRDoc class >> descriptionComment [

]

{ #category : #'as yet unclassified' }
RRDoc class >> descriptionContainer [
	^(super descriptionContainer)
		label: 'Сертификаты';
		yourself.  
]

{ #category : #'as yet unclassified' }
RRDoc class >> descriptionIssuer [
	^(SPClassifierDescription new)
		classifier: RRIssuer;
		accessorAndName: #issuer;
		priority: 30;
		label: 'Выдан';
		yourself.  
]

{ #category : #'as yet unclassified' }
RRDoc class >> descriptionNum [
	^(SPStringDescription new)
		accessorAndName: #num;
		priority: 20;
		label: 'Рег. номер';
		fieldWidth: 300;
		yourself.  
]

{ #category : #'as yet unclassified' }
RRDoc class >> descriptionValidFrom [
	^(SPDateDescription new)
		accessorAndName: #validFrom;
		priority: 40;
		label: 'Действителен с';
		yourself.  
]

{ #category : #'as yet unclassified' }
RRDoc class >> descriptionValidTo [
	^(SPDateDescription new)
		accessorAndName: #validTo;
		priority: 50;
		label: 'по';
		yourself.  
]

{ #category : #accessing }
RRDoc >> issuer [
	^ issuer
]

{ #category : #accessing }
RRDoc >> issuer: anObject [
	issuer := anObject
]

{ #category : #accessing }
RRDoc >> num [
	^ num
]

{ #category : #accessing }
RRDoc >> num: anObject [
	num := anObject
]

{ #category : #accessing }
RRDoc >> validFrom [
	^ validFrom
]

{ #category : #accessing }
RRDoc >> validFrom: anObject [
	validFrom := anObject
]

{ #category : #accessing }
RRDoc >> validTo [
	^ validTo
]

{ #category : #accessing }
RRDoc >> validTo: anObject [
	validTo := anObject
]
