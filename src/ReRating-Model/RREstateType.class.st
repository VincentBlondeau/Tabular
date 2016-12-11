Class {
	#name : #RREstateType,
	#superclass : #SPClassifier,
	#category : #'ReRating-Model'
}

{ #category : #'as yet unclassified' }
RREstateType class >> descriptionComment [

]

{ #category : #'as yet unclassified' }
RREstateType class >> descriptionContainer [
	^(super descriptionContainer)
		label: 'Типы недвижимости';
		yourself.  
]
