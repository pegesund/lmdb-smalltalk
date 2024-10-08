"
A MDBCursor provides access to MDB_cursor related functionality.
"
Class {
	#name : 'MDBCursor',
	#superclass : 'MDBHandle',
	#category : 'LightningMDB-Core',
	#package : 'LightningMDB-Core'
}

{ #category : 'open' }
MDBCursor class >> open: aMDBTransaction dbi: aMDBDbi [
	
	| instance result |
	
	instance := self new.
	result := self primOpen: aMDBTransaction dbi: aMDBDbi cursor: instance.
	result = 0
		ifFalse: [ self mdbError: result ].

	^instance
]

{ #category : 'ffi-calls' }
MDBCursor class >> primOpen: aMDBTransaction dbi: aMDBDbi cursor: aMDBCursor [
	<primitive: #primitiveNativeCall module: #NativeBoostPlugin error: errorCode>
	
	^ self ffiCall: #( int mdb_cursor_open ( MDBTransaction aMDBTransaction, MDB_dbi aMDBDbi, MDBCursor *aMDBCursor ) ) 
]

{ #category : 'as yet unclassified' }
MDBCursor >> associations [

	| list |
	
	list := OrderedCollection new.
	self keysAndDataDo: [ :keyValue :dataValue |
		list add: keyValue dataAsByteArray -> dataValue dataAsByteArray ].
	
	^list
]

{ #category : 'as yet unclassified' }
MDBCursor >> close [

	self primClose 
]

{ #category : 'as yet unclassified' }
MDBCursor >> getAll: aTwoArgConverterBlock [

	| list |
	
	list := OrderedCollection new.
	self keysAndDataDo: [ :keyValue :dataValue |
		list add: (aTwoArgConverterBlock value: keyValue value: dataValue) ].
	^list
]

{ #category : 'as yet unclassified' }
MDBCursor >> keysAndDataDo: aTwoArgBlock [

	| key data result |
	
	key := MDBValue new.
	data := MDBValue new.
	
	[
		result := self primGet: key data: data operation: MDB_NEXT.
		result = 0
			ifTrue: [ aTwoArgBlock value: key value: data. true ]
			ifFalse: [ false ] ] whileTrue.

	result = MDB_NOTFOUND
		ifFalse: [ self mdbError: result ]
]

{ #category : 'as yet unclassified' }
MDBCursor >> next [

	| key data result |
	
	key := MDBValue new.
	data := MDBValue new.
	
	result := self primGet: key data: data operation: MDB_NEXT.
	result = 0
		ifTrue: [ ^ key -> data ].
	result = MDB_NOTFOUND
		ifTrue: [ ^ nil ].
		
	self mdbError: result
]

{ #category : 'primitives' }
MDBCursor >> primClose [
	
	^ self ffiCall: #( void mdb_cursor_close ( MDBCursor self ) )
]

{ #category : 'primitives' }
MDBCursor >> primGet: aKey data: aValue operation: anOp [
	
	^ self ffiCall: #( int mdb_cursor_get ( MDBCursor self, MDBValue *aKey, MDBValue *aValue, int anOp ) )
]

{ #category : 'as yet unclassified' }
MDBCursor >> set: aKey [

	| key data result |
	
	key := MDBValue allocateFor: aKey.
	data := MDBValue new.
	
	result := self primGet: key data: data operation: MDB_SET.
	key freeData.

	result = 0
		ifFalse: [ self mdbError: result ].
		
	^data
]

{ #category : 'as yet unclassified' }
MDBCursor >> setRange: aKey [

	| key keyBuf data result |
	
	key := MDBValue allocateFor: aKey.
	keyBuf := key mvData.
	
	result := self primGet: key data: (data := MDBValue new) operation: MDB_SET_RANGE.
	keyBuf free.

	result = 0
		ifFalse: [ self mdbError: result ].
		
	^data
]
