Class {
	#name : #RRIssuer,
	#superclass : #SPClassifier,
	#category : #'ReRating-Model'
}

{ #category : #'as yet unclassified' }
RRIssuer class >> descriptionComment [

]

{ #category : #'as yet unclassified' }
RRIssuer class >> descriptionContainer [
	^(super descriptionContainer)
		label: 'Серт. центры';
		yourself.  
]
