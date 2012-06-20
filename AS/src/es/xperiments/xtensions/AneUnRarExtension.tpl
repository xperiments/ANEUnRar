<extension xmlns="http://ns.adobe.com/air/extension/3.2">
	<id>es.xperiments.xtensions.AneUnRar</id>
	<versionNumber>@majorVersion@.@minorVersion@.@buildNumber@</versionNumber>
		<platforms> 
			<platform name="iPhone-ARM">
				<applicationDeployment>
					<nativeLibrary>libAneUnRar.a</nativeLibrary>
					<initializer>AneUnRarExtensionInitializer</initializer>
					<finalizer>AneUnRarExtensionFinalizer</finalizer>
				</applicationDeployment>
			</platform>
	</platforms>
</extension>
			