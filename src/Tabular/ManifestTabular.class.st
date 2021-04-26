"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestTabular,
	#superclass : #PackageManifest,
	#category : #Tabular
}

{ #category : #'meta-data - dependency analyser' }
ManifestTabular class >> manuallyResolvedDependencies [
	^ #(#'Regex-Core')
]
