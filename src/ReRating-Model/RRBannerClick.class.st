Class {
	#name : #RRBannerClick,
	#superclass : #SPDocument,
	#instVars : [
		'agent',
		'rating'
	],
	#category : #'ReRating-Seaside-Banner'
}

{ #category : #'as yet unclassified' }
RRBannerClick class >> descriptionAgent [
	^(SPClassifierDescription new)
		accessorAndName: #agent; 
		label: 'Агент';
		classifier: RRAgent;
		priority: 20;
		fastSearchDBAccessBlock: [:click| click agent title];
		yourself.
]

{ #category : #'as yet unclassified' }
RRBannerClick class >> descriptionAuthor [
]

{ #category : #'as yet unclassified' }
RRBannerClick class >> descriptionComment [
]

{ #category : #'as yet unclassified' }
RRBannerClick class >> descriptionContainer [
	^super descriptionContainer
		table: 'clicks';
		label: 'Клики';
		addListFields: #(agent rating);
		yourself.
]

{ #category : #'as yet unclassified' }
RRBannerClick class >> descriptionRating [
	^(SPNumberDescription new)
		accessorAndName: #rating; 
		label: 'Рейтинг в момент клика';
		priority: 30;
		yourself.
]

{ #category : #accessing }
RRBannerClick >> agent [
	^ agent
]

{ #category : #accessing }
RRBannerClick >> agent: anObject [
	agent := anObject
]

{ #category : #accessing }
RRBannerClick >> rating [
	^ rating
]

{ #category : #accessing }
RRBannerClick >> rating: anObject [
	rating := anObject
]
