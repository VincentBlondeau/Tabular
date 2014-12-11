Extension { #name : #String }

{ #category : #'*Tabular' }
String >> asPoint [
	"'A1' asPoint -> 1 @ 1
	'B3' asPoint -> 2 @ 3"

	^ self onlyLetters base26AsInteger @ self numericSuffix
]

{ #category : #'*Tabular' }
String >> base26AsInteger [
	^ (self capitalized asOrderedCollection reverse
		withIndexCollect: [ :letter :index | (letter asInteger - $A asciiValue + 1) * (26 raisedTo: index - 1) ]) sum
]
