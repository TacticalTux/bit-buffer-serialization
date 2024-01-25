This module is a bit-buffer serialization system written for a personal project of mine that I am releasing publicly.

There are only three functions provided by the module:
```
Serialize({Instance, Instance, Instance}): DataString
Deserialize(DataString or BitBuffer): {Instance, Instance, Instance}
GetEpochNumberFromData(DataString): {BufferEpoch, Buffer}
```

Serialize and Deserialize are self explanatory, and take the data given and perform the inverse of each other. GetEpochNumberFromData is a way to get the Epoch number, which can be used to determine which version of this module to use incase if there are multiple versions of data present. It also returns the Buffer, which can be directly passed to the Deserialize function in place of the data string to prevent the string from having to be decoded from Base91 twice.

Base91 encoding is used as it is the highest base that is datastore compatible, along with waits being implemented at certain parts of the code in order to prevent threads from yielding when deserializing multiple millions of instances.

Example of a game that uses this (full map saving system):
https://www.roblox.com/games/6685286210/Baseplate

Utilizes rstk's BitBuffer module:
https://github.com/rstk/BitBuffer