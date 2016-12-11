Class {
	#name : #RRQualification,
	#superclass : #SPClassifier,
	#category : #'ReRating-Model'
}

{ #category : #'as yet unclassified' }
RRQualification class >> descriptionComment [

]

{ #category : #'as yet unclassified' }
RRQualification class >> descriptionContainer [
	^(super descriptionContainer)
		label: 'Квалификации';
		table:'qualifications';
		yourself.  
]
