-- Author: Yazir, for: mtakp.pl
-- If you want to use that code, atleast give credits.

local articles = {
	["[PL] Reklama"] = "articles/reklama.txt",
	["[PL] Biznesy klanowe"] = "articles/biznesy.txt",
	["[PL] Jak zacząć, wstęp, poradnik"] = "articles/jakzaczac.txt",
	["[PL] Organizacja: Policja"] = "articles/mechanika-policji.txt",
	["[PL] Regulamin"] = "articles/regulamin.txt",
	["[PL] Event: Totem"] = "articles/event-totem.txt",
	["[PL] Sposoby zarobku"] = "articles/sposoby-zarobku.txt",
}

addEventHandler("onClientResourceStart", resourceRoot,
function()
    windowHelp = guiCreateWindow(0.17, 0.12, 0.66, 0.77, "[KP] Help panel", true)
    guiWindowSetSizable(windowHelp, false)
    guiSetAlpha(windowHelp, 1.00)
    memoContent = guiCreateMemo(0.25, 0.09, 0.74, 0.88, "", true, windowHelp)
    guiSetAlpha(memoContent, 0.9)
    guiMemoSetReadOnly(memoContent, true)
    gridlistArticle = guiCreateGridList(0.01, 0.09, 0.24, 0.88, true, windowHelp)
    guiGridListAddColumn(gridlistArticle, "Article", 0.9)
    editSearch = guiCreateEdit(0.01, 0.04, 0.23, 0.04, "", true, windowHelp)
    guiSetVisible( windowHelp, false )

    addEventHandler( "onClientGUIClick", windowHelp, 
	function ( )
		setElementData( localPlayer, "guiCloseBlock", false )
		if source == gridlistArticle then
			local sel = guiGridListGetSelectedItem( gridlistArticle )
			if sel > -1 then
				local file = fileOpen( articles[guiGridListGetItemData( gridlistArticle, sel, 1 )], true )
				if file then
					local text = fileRead( file, fileGetSize( file ) )
					guiSetText( memoContent, text:gsub( "\t", "   " ) )
					fileClose( file )
				end
			end
		elseif source == editSearch then
			setElementData( localPlayer, "guiCloseBlock", true )
		end
	end )

	addEventHandler( "onClientGUIChanged", editSearch, 
	function ( )
		refreshList( )
	end )
end )

addCommandHandler( "kphelp", 
function ( )
	if not guiGetVisible( windowHelp ) then
		showHelpWindow( true )
	else
		showHelpWindow( false )
	end
end )

bindKey( "F1", "down", function (  ) executeCommandHandler( "kphelp" ) end )


function showHelpWindow( bool )
	if bool then
		refreshList( )
		showCursor( true, true )
		guiSetVisible( windowHelp, true )
	else
		showCursor( false )
		guiSetVisible( windowHelp, false )
	end
end
addEvent( "onCloseAllWindows" )
addEventHandler( "onCloseAllWindows", root, showHelpWindow )


function refreshList( )
	guiGridListClear( gridlistArticle )
	local editText = guiGetText( editSearch )
	for k,v in pairs( articles ) do
		if k:lower():find( editText:lower() ) then
			local row = guiGridListAddRow( gridlistArticle, k )
			guiGridListSetItemData( gridlistArticle, row, 1, k )
			--outputChatBox( v )
		end
	end
end