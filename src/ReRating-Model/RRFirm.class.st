Class {
	#name : #RRFirm,
	#superclass : #SPClassifier,
	#instVars : [
		'region',
		'address',
		'phone',
		'email',
		'website'
	],
	#category : #'ReRating-Model'
}

{ #category : #'as yet unclassified' }
RRFirm class >> descriptionAddress [
	^(SPMemoDescription new)
		accessorAndName: #address;
		priority: 90;
		label: 'Адрес фирмы';
		yourself.  
]

{ #category : #'as yet unclassified' }
RRFirm class >> descriptionContainer [
	^(super descriptionContainer)
		label: 'Фирмы';
		addListFields: #(region);
		table:'firms';
		yourself.  
]

{ #category : #'as yet unclassified' }
RRFirm class >> descriptionEmail [
	^(SPStringDescription new)
		accessorAndName: #email;
		priority: 40;
		label: 'Email';
		yourself.  
]

{ #category : #'as yet unclassified' }
RRFirm class >> descriptionPhone [
	^(SPStringDescription new)
		accessorAndName: #phone;
		priority: 30;
		label: 'Телефон';
		yourself.  
]

{ #category : #'as yet unclassified' }
RRFirm class >> descriptionRegion [
	^(SPClassifierDescription new)
		classifier: RRRegion;
		accessorAndName: #region;
		priority: 70;
		label: 'Регион';
		fastSearchDBAccessBlock: [:firm| firm region title];
		yourself.  
]

{ #category : #'as yet unclassified' }
RRFirm class >> descriptionTitle [
	^(super descriptionTitle)
		fieldWidth: 300;  
		yourself.  
]

{ #category : #'as yet unclassified' }
RRFirm class >> descriptionWebsite [
	^(SPStringDescription new)
		accessorAndName: #website;
		priority: 50;
		label: 'Сайт фирмы';
		fieldWidth: 250;
		yourself.
]

{ #category : #accessing }
RRFirm >> address [
	^ address
]

{ #category : #accessing }
RRFirm >> address: anObject [
	address := anObject
]

{ #category : #accessing }
RRFirm >> email [
	^ email
]

{ #category : #accessing }
RRFirm >> email: anObject [
	email := anObject
]

{ #category : #accessing }
RRFirm >> phone [
	^ phone
]

{ #category : #accessing }
RRFirm >> phone: anObject [
	phone := anObject
]

{ #category : #accessing }
RRFirm >> region [
	^ region
]

{ #category : #accessing }
RRFirm >> region: anObject [
	region := anObject
]

{ #category : #accessing }
RRFirm >> website [
	^ website
]

{ #category : #accessing }
RRFirm >> website: anObject [
	website := anObject
]
