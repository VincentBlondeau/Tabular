Class {
	#name : #TabularDateTest,
	#superclass : #TestCase,
	#category : #'Tabular-Tests'
}

{ #category : #tests }
TabularDateTest >> testFromExcelDays [
	"https://support.microsoft.com/en-us/office/date-systems-in-excel-e7fe7167-48a9-4b96-bb53-5612a800b487"

	self assert: (Date fromExcelDay: 39448) yyyymmdd equals: (Date fromString: '01/01/2008') yyyymmdd.
	self assert: (Date fromExcelDay: 40729) yyyymmdd equals: (Date fromString: '07/05/2011') yyyymmdd.
	self assert: (Date fromExcelDay: 35981) yyyymmdd equals: (Date fromString: '07/05/1998') yyyymmdd.
	
	self assert: (Date fromExcelDay: 0) isNil.
]
