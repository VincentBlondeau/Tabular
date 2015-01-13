Extension { #name : #Date }

{ #category : #'*Tabular' }
Date class >> fromExcelDays: dayCount [ 
	"Days since 1 January 1900"

	^ self julianDayNumber: SqueakEpoch + dayCount - 366 "It is supposed by excel that 1900 is a leap year...."
]
