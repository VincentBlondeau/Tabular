Class {
	#name : #BaselineOfTabular,
	#superclass : #BaselineOf,
	#category : #BaselineOfTabular
}

{ #category : #baselines }
BaselineOfTabular >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				project: 'XMLWriter'
					with: [ spec
						className: #ConfigurationOfXMLWriter;
						versionString: #stable;
						repository: 'http://smalltalkhub.com/mc/PharoExtras/XMLWriter/main/' ];
				project: 'XMLParser'
					with: [ spec
						className: #ConfigurationOfXMLParser;
						versionString: #stable;
						repository: 'http://smalltalkhub.com/mc/PharoExtras/XMLParser/main/' ].
			spec package: 'Tabular' with: [ spec requires: #('XMLWriter' 'XMLParser') ].
			spec group: 'Core' with: #('Tabular') ]
]
