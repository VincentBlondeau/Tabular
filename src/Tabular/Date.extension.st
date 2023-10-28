Extension { #name : #Date }

{ #category : #'*Tabular' }
Date class >> fromExcelDay: aNumber [
	"https://support.microsoft.com/en-us/office/date-systems-in-excel-e7fe7167-48a9-4b96-bb53-5612a800b487
	In the 1900 date system, dates are calculated by using January 1, 1900, as a starting point.
	Suppose to use the 1900 Data System
	"
	
	aNumber <= 0 ifTrue:[^nil].
	^ self julianDayNumber: (SqueakEpoch - 365 - 2 + aNumber)
]
