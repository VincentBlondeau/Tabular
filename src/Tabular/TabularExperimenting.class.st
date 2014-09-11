Class {
	#name : #TabularExperimenting,
	#superclass : #Object,
	#category : #Tabular
}

{ #category : #'as yet unclassified' }
TabularExperimenting class >> createZip:filename content: aTextFileString [
	|z|
	z:= ZipArchive new.
	z addString: aTextFileString as: 'test.txt'.
	z addString: aTextFileString as: '/dir/again.txt'.		
	z writeToFileNamed: filename.
	
]

{ #category : #'as yet unclassified' }
TabularExperimenting class >> test [
|text|
	text := WriteStream on: ''.
	text
		nextPutAll: 'This is a demo text to test ZIP posibilities of Pharo';
		cr;cr;
		"nextPutAll: 'А теперь и с русскими буквами!';"
		yourself.
	
	self createZip: 'helloWorld.zip' content: text contents
]
