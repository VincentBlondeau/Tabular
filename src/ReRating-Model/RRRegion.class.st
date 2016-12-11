Class {
	#name : #RRRegion,
	#superclass : #SPClassifier,
	#category : #'ReRating-Model'
}

{ #category : #'as yet unclassified' }
RRRegion class >> descriptionComment [

]

{ #category : #'as yet unclassified' }
RRRegion class >> descriptionContainer [
	^(super descriptionContainer)
		label: 'Регионы';
		table:'regions';
		yourself.  
]
