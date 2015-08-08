Class {
	#name : #ConfigurationOfTabular,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfTabular
}

{ #category : #'development support' }
ConfigurationOfTabular class >> DevelopmentSupport [

"See the methods in the 'development support' category on the class-side of MetacelloBaseConfiguration. Decide what development support methods you would like to use and copy them the the class-side of your configuration."
	<apiDocumentation>

]

{ #category : #private }
ConfigurationOfTabular class >> baseConfigurationClassIfAbsent: aBlock [

	^Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #MetacelloBaseConfiguration ifAbsent: aBlock ].

]

{ #category : #catalog }
ConfigurationOfTabular class >> catalogChangeLog [
	"Returns a paragraph describing the most important changes in the configuration class."

	^ 'Not released yet!'"
	- Version number - Date - topics
[[[
	ConfigurationOfXXX project version: ''xx'' ) load					
]]]"

]

{ #category : #catalog }
ConfigurationOfTabular class >> catalogContactInfo [
	"Returns a paragraph describing contact information such as email, mailing lists and website."

	^ 'Tabular is an amazing project . You can get in contact with our great Tabular programmers at assargaddon@gmail.com and vincent.blondeau@polytech-lille.net'
]

{ #category : #catalog }
ConfigurationOfTabular class >> catalogDescription [
	"Returns a paragraph describing the project"

	^ 'Tabular is an importer/exporter of Microsoft Office and OpenOffice (to be implemented) documents. For now, it handles only the Excel importing but it can be enhanced to import any file based on the Office Open XML format.'
]

{ #category : #catalog }
ConfigurationOfTabular class >> catalogKeyClassesAndExample [
	"Returns a paragraph or more describing the key classes of your project. You can use Pillar/Pier syntax to layout out the text i.e., ==Code== and - for bullet."

	^ 'Tabular is composed of one cool key class named ==TabularXLSXImporter==. There is also ==TabularExperimenting==
- ==TabularXLSXImporter== is responsible for the import of XLSX files. Just do ==TabularXLSXImporter fromFileNamed: <your file>== to import your file. 
- ==TabularExperimenting== is responsible for creating XLSX file from the model'
]

{ #category : #catalog }
ConfigurationOfTabular class >> catalogKeywords [
	"Returns an array of symbols"

	^ #(#XLSX #Excel #Importer #SAXHandler #'Office OpenXML' #Office)
]

{ #category : #private }
ConfigurationOfTabular class >> ensureMetacello [

	(self baseConfigurationClassIfAbsent: []) ensureMetacello
]

{ #category : #private }
ConfigurationOfTabular class >> ensureMetacelloBaseConfiguration [

	Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			| repository version |
			repository := MCHttpRepository location: 'http://seaside.gemstone.com/ss/metacello' user: '' password: ''.
			repository
				versionReaderForFileNamed: 'Metacello-Base-DaleHenrichs.2.mcz'
				do: [ :reader | 
					version := reader version.
					version load.
					version workingCopy repositoryGroup addRepository: repository ] ]
]

{ #category : #'metacello tool support' }
ConfigurationOfTabular class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfTabular class >> load [
	"Load the #stable version defined for this platform. The #stable version is the version that is recommended to be used on this platform."

	"self load"

	<apiDocumentation>
	^(self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfTabular class >> loadBleedingEdge [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfTabular class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfTabular class >> project [

	^self new project
]

{ #category : #'development support' }
ConfigurationOfTabular class >> validate [
	"Check the configuration for Errors, Critical Warnings, and Warnings (see class comment for MetacelloMCVersionValidator for more information). 
	Errors identify specification issues that will result in unexpected behaviour when you load the configuration. 
	Critical Warnings identify specification issues that may result in unexpected behavior when you load the configuration.
	Warnings identify specification issues that are technically correct, but are worth take a look at."

	"self validate"

	<apiDocumentation>
	self ensureMetacello.
	^ ((Smalltalk at: #MetacelloToolBox) validateConfiguration: self debug: #() recurse: false) explore
]

{ #category : #baselines }
ConfigurationOfTabular >> baseline01: spec [
	<version: '0.1-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://ss3.gemstone.com/ss/Tabular'.
		spec package: 'Tabular'.
		spec group: 'Core' with: #('Tabular' ). ].

]

{ #category : #baselines }
ConfigurationOfTabular >> baseline02: spec [
	<version: '0.2-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://ss3.gemstone.com/ss/Tabular'.
		spec 
			project: 'XMLWriter' with: [
				spec
					className: #ConfigurationOfXMLWriter;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/PharoExtras/XMLWriter/main/' ];
			project: 'XMLParser' with: [
				spec
					className: #ConfigurationOfXMLParser;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/PharoExtras/XMLParser/main/' ].
		spec package: 'Tabular' with: [
				spec requires: #('XMLWriter' 'XMLParser' ). ].
		spec group: 'Core' with: #('Tabular' ). ].

]

{ #category : #accessing }
ConfigurationOfTabular >> customProjectAttributes [
	 "Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttrributes"

	^ #().
]

{ #category : #'symbolic versions' }
ConfigurationOfTabular >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '0.2-baseline'.

]

{ #category : #accessing }
ConfigurationOfTabular >> project [

	^ project ifNil: [ 
		"Bootstrap Metacello if it is not already loaded"
		(self class baseConfigurationClassIfAbsent: []) ensureMetacello.
		"Construct Metacello project"
		project := MetacelloMCProject new projectAttributes: self customProjectAttributes. 
		(Smalltalk at: #MetacelloVersionConstructor) on: self project: project.
		project loadType: #linear. "change to #atomic if desired"
		project ]
]

{ #category : #'symbolic versions' }
ConfigurationOfTabular >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'common' version: '0.2'.

]

{ #category : #versions }
ConfigurationOfTabular >> version01: spec [
	<version: '0.1' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.1'.
		spec author: 'VincentBlondeau'.
		spec timestamp: '12/11/2014 11:00'.
		spec package: 'Tabular' with: 'Tabular-MYI.7'. ].

]

{ #category : #versions }
ConfigurationOfTabular >> version02: spec [
	<version: '0.2' imports: #('0.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.2'.
		spec author: 'VincentBlondeau'.
		spec timestamp: '8/8/2015 11:34'.
		spec 
			project: 'XMLWriter' with: '2.6.2';
			project: 'XMLParser' with: '2.4.4'.
		spec package: 'Tabular' with: 'Tabular-HannesHirzel.28'. ].

]
