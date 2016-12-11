Class {
	#name : #ReRatingGeneral,
	#superclass : #SPMainApplication,
	#category : #'ReRating-Seaside'
}

{ #category : #'as yet unclassified' }
ReRatingGeneral class >> menu [
	^{
	RRAgent .
	RRFirm .
	RRRegion.
	RRIssuer.
	RRQualification.
	'Типы' -> {
		RREstateType.
		RROperationType.
	}.
	RRBannerClick.
	}
]
