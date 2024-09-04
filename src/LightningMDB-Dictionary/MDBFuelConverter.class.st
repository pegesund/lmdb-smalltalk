Class {
	#name : 'MDBFuelConverter',
	#superclass : 'MDBObjectConverter',
	#instVars : [
		'serializer',
		'materializer'
	],
	#category : 'LightningMDB-Dictionary',
	#package : 'LightningMDB-Dictionary'
}

{ #category : 'converting' }
MDBFuelConverter >> deserialize: aValueData [

	| buf |
	
	buf := self getBuffer: aValueData mvSize.
	aValueData copyDataTo: buf.
	^(FLMaterializer materializeFrom: buf readStream) 
]

{ #category : 'accessing' }
MDBFuelConverter >> materializer [

	^ materializer ifNil: [ materializer := FLMaterializer new ]
]

{ #category : 'accessing' }
MDBFuelConverter >> materializer: aFuelMaterializer [

	materializer := aFuelMaterializer
]

{ #category : 'converting' }
MDBFuelConverter >> serialize: anObject [ 

	^ByteArray streamContents: [ :stream |
		FLSerializer serialize: anObject on: stream ]
]

{ #category : 'accessing' }
MDBFuelConverter >> serializer [

	^ serializer ifNil: [ serializer := FLSerializer new ]
]

{ #category : 'accessing' }
MDBFuelConverter >> serializer: aFuelSerializer [

	serializer := aFuelSerializer
]
