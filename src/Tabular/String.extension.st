Extension { #name : #String }

{ #category : #'*Tabular' }
String >> asPoint [
	"'A1' asPoint -> 1 @ 1
	'B3' asPoint -> 2 @ 3"

	| decomp |
	decomp := self stemAndNumericSuffix.
	^ decomp first base26AsInteger @ decomp second
]

{ #category : #'*Tabular' }
String >> base26AsInteger [
	^ (self capitalized asOrderedCollection reverse
		withIndexCollect: [ :letter :index | (letter asInteger - $A asciiValue + 1) * (26 raisedTo: index - 1) ]) sum
]
