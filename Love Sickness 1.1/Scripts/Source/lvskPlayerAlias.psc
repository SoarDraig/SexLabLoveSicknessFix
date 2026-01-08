Scriptname lvskPlayerAlias extends ReferenceAlias  

lvskMain Property MQ Auto
Actor Property Player Auto

Event OnPlayerLoadGame()
	MQ.Maintenance()
EndEvent