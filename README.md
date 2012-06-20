AneUnRar Adobe AIR Native UnRAR iOS wrapper 
===========================================
A simple wrapper to the Cooliris UnRAR iOS class interface. 

AneUnRar is copyright 2012 Pedro Casaubon. and available under Apache 2.0 license. See the [LICENSE]() file in the project for more information.

IMPORTANT: AneUnRar includes some other open-source projects and such projects remain under their own license.

[Cooliris UnRAR lib](http://code.google.com/p/cooliris-toolkit/)
[Original UnRAR 3.9.10 source code](http://www.rarlab.com/rar_add.htm)

Methods
----------------
 * [openFile](#openfile) 
 * [getReady](#getready)
 * [isSupported](#issupported) 
 * [extractFileAsync](#extractfileasync)
 * [extractFileSync](#extractfilesync)
 * [extractRarAsync](#extractrarasync)
 * [extractRarSync](#extractrarsync)
 * [getFilesAsync](#getfilesasync)
 * [getFilesSync](#getfilessync)
 * [dispose](#dispose)


 <a id="openFile"></a>
 ### openFile         
        /**
         * Open the RAR file to process
         * @param rarFile:String
         * @param skipInvisibleFiles:Boolean
         * @return void
         */
        public function openFile( rarFile:File , skipInvisibleFiles:Boolean = false ):Boolean

 <a id="getReady"></a>
 ### getReady 
        /**
         * Gets the instance status semaphore.
         * If status is false, some process is executing in the background.
         * You can call only one command at time.
         * To process commands in parallel create new AneUnRar instances.
         * @return Boolean
         */                 
        public function getReady( ):Boolean
                 

 <a id="isSupported"></a>
 ### isSupported 
        /**
         * Check if the extension is supported
         * @return Boolean
         */
        public static function isSupported():Boolean
        {
            return _isSupported;
        }

 <a id="extractFileAsync"></a>
 ### extractFileAsync     
        /**
         * Asynchronously Extracts a unique file from the compressed RAR
         * 
         * @param fileName:String Path from the file to extract
         * @param outputFileName:String Path to the destination file to extract
         * @return void
         */
        public function extractFileAsync( fileName:String, outputFile:File ):Boolean

 <a id="extractFileSync"></a>
 ### extractFileSync           
        /**
         * Synchronously Extracts one file from RAR to disk Synchronous
         * 
         * @param fileName:String
         * @param outputFileName:String
         * @return Boolean
         */
        public function extractFileSync( fileName:String, outputFile:File ):Boolean

 <a id="extractRarAsync"></a>
 ### extractRarAsync         
        /**
         * Asynchronously Extracts the RAR file to dir  
         * 
         * @param outputDir:String
         * @return void
         */
        public function extractRarAsync( outputDir:File ):Boolean

 <a id="extractRarSync"></a>
 ### extractRarSync 
        /**
         * Synchronously Extracts the RAR file to dir 
         * 
         * @param outputDir:String
         * @return Boolean
         */
        public function extractRarSync( outputDir:File ):Boolean

 <a id="getFilesAsync"></a>
 ### getFilesAsync         
        /**
         * Gets a single file from rar and extracts it Asynchronously
         * @return void
         */
        public function getFilesAsync( ):Boolean

 <a id="getFilesSync"></a>
 ### getFilesSync         
        /**
         * Gets a single file from rar and extracts it Synchronously
         * @return Array
         */
        public function getFilesSync( ):Array

 <a id="dispose"></a>
 ### dispose         
        /**
         * Disposes the AneUnRar extension
         */
        public function dispose():void


