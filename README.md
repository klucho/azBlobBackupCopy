# Azure Blob Backup
Copies all contents of a given directory to an azure blob.
It is needed to complete all the secrets in all files to complete.
It is assumed that you have a working encfs configuration file. 

## Config files

| File | Description |
| :-- | :--|
| encfs6.xml | EncFs configuration file. |
| encfsPwd.txt | File containing EncFs password. |
| config.yml | blobfuse2 configuration file. |

## Parameters

| Volume      | Description |
| :----------- | :----------- |
| Origin      | Path to the directory to backup |
| Config      | Path to the container Config directory. |
