Class {
	#name : #TanderComponent,
	#superclass : #WAComponent,
	#instVars : [
		'errors'
	],
	#category : #'Paeonia-Components'
}

{ #category : #rendering }
TanderComponent >> back [
	self answer
]

{ #category : #rendering }
TanderComponent >> renderBackOn: aRenderer [
	aRenderer submitButton
		callback: [ self back ];
		with: 'Назад'
]

{ #category : #rendering }
TanderComponent >> renderContentOn: aRenderer [
	aRenderer unorderedList
		class: 'errors';
		list: errors.
]

{ #category : #rendering }
TanderComponent >> renderErrorsOn: aRenderer [
	aRenderer unorderedList
		class: 'errors';
		list: errors.
]

{ #category : #rendering }
TanderComponent >> renderNextOn: aRenderer [
	aRenderer submitButton
		callback: [ self next ];
		with: 'Далее'
]

{ #category : #rendering }
TanderComponent >> renderRedoOn: aRenderer [
	aRenderer button
		callback: [ self redo ];
		with: 'Ещё раз'.
		
]

{ #category : #hooks }
TanderComponent >> style [
^'
	ul.errors { color: red}

'
]
