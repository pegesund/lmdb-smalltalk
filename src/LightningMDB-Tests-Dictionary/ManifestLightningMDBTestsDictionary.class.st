"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestLightningMDBTestsDictionary',
	#superclass : 'PackageManifest',
	#category : 'LightningMDB-Tests-Dictionary-Manifest',
	#package : 'LightningMDB-Tests-Dictionary',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestLightningMDBTestsDictionary class >> ruleCascadedNextPutAllsRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#MDBSortedDictionaryPerformaceTests #testSerialization #false)) #'2024-09-04T13:51:22.971591+02:00') )
]

{ #category : 'code-critics' }
ManifestLightningMDBTestsDictionary class >> ruleStringConcatenationRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGClassDefinition #(#MDBSortedDictionaryTest)) #'2024-09-04T13:36:20.34012+02:00') )
]

{ #category : 'code-critics' }
ManifestLightningMDBTestsDictionary class >> ruleTempsReadBeforeWrittenRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#MDBSortedDictionaryPerformaceTests #testSerialization #false)) #'2024-09-04T13:51:46.330257+02:00') )
]
