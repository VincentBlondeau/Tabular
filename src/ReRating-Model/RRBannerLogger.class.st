Class {
	#name : #RRBannerLogger,
	#superclass : #Object,
	#instVars : [
		'clicksFile',
		'session'
	],
	#category : #'ReRating-Seaside-Banner'
}

{ #category : #'as yet unclassified' }
RRBannerLogger class >> session: aSPSession [
	^self new
		session: aSPSession;
		yourself.
]

{ #category : #'as yet unclassified' }
RRBannerLogger >> clickTo: agent [
| click |
	click := RRBannerClick new.
	click
		agent: agent;
		rating: agent rating;
		yourself.
	session glorpSession inUnitOfWorkDo: [session glorpSession register: click]. 
		
]

{ #category : #accessing }
RRBannerLogger >> session: anObject [
	session := anObject
]
