Class {
	#name : #TabularODSCell,
	#superclass : #TabularCell,
	#category : #'Tabular-Model'
}

{ #category : #'private - converting' }
TabularODSCell >> convertData [
	"Convert the receivers data based on the type"

	"type is one of string, float, percentage, currency, date, time.
	See: http://books.evc-cit.info/odbook/ch05.html"

	| conversionMethod |
	self type = 'string'
		ifTrue: [ ^ self ].
	conversionMethod := ('convertTo' , self type capitalized) asSymbol.
	self perform: conversionMethod
]

{ #category : #'private - converting' }
TabularODSCell >> convertToCurrency [

	^self 
]

{ #category : #'private - converting' }
TabularODSCell >> convertToDate [

	| source |

	data := nil.	
	source := self attributeAt: #'office:date-value'.
	(source matchesRegex: '\d\d\d\d-\d\d-\d\d') ifTrue:
		[data := (DateParser readingFrom: source readStream pattern: 'yyyy-mm-dd') parse].
	(source matchesRegex: '\d\d\d\d-\d\d-\d\dT\d\d\:\d\d\:\d\d') ifTrue:
		[data := DateAndTime readFromString: source].
	data ifNil: [ self error: 'Unknown date / time format: ', source ]
]

{ #category : #'private - converting' }
TabularODSCell >> convertToFloat [
	"ODS spreasheets only have a single numerical type: float.
	Convert to the natural type (int, float, etc.)"
	data := NumberParser parse: self rawValue.
]

{ #category : #'private - converting' }
TabularODSCell >> convertToPercentage [

	^self. 
]

{ #category : #'private - converting' }
TabularODSCell >> convertToTime [

	| source re |
	
	source := self attributeAt: #'office:time-value'.
	re := 'PT([0-9][0-9])H([0-9][0-9])M([0-9][0-9])S' asRegex.
	re matches: source.
	data := Time hour: (re subexpression: 2) asInteger 
				minute: (re subexpression: 3) asInteger 
				second: (re subexpression: 4) asInteger.
]

{ #category : #accessing }
TabularODSCell >> data: anObject [

	data := anObject.
	self type isNotNil ifTrue: [ self convertData ]
]

{ #category : #'accessing - attributes' }
TabularODSCell >> formula [

	^self attributeAt: #'table:formula'
]

{ #category : #accessing }
TabularODSCell >> rawValue [

	^attributes at: #'office:value'
]

{ #category : #accessing }
TabularODSCell >> style [

	| styleName |
	
	styleName := self attributeAt: #'table:style-name'.
	styleName ifNil: [ ^nil ].
	^workbook styles at: styleName.
]

{ #category : #accessing }
TabularODSCell >> type [

	^self attributeAt: #'office:value-type'.
]
