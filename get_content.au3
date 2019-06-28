#include<_HttpRequest.au3>
#include<File.au3>
;$link = 'http://cafef.vn/co-dong-lon-star-invest-kien-nghi-bo-sung-nhieu-van-de-vao-chuong-trinh-dhdcd-cua-vinaconex-20190628093348921.chn'
$dem = 0
Func laynoidungcafef($linktrangbao)
If StringLen($linktrangbao) > 60 Then
$data=_HttpRequest(2,$linktrangbao,'','','','Connection: keep-alive|Upgrade-Insecure-Requests: 1')
	If StringRegExp($data,'<p>(.*?)</div>',1) <> False Then
		$tach=StringRegExp($data,'<p>(.*?)</div>',1)
		$content = $tach[0]
		While 1
			If StringRegExp($content,'<(.*?)>',1) = False Then
				ExitLoop
			EndIf
			$kiemtra = StringRegExp($content,'<(.*?)>',1)
			$xoabo = '<' & $kiemtra[0] & '>'
			$content = StringReplace($content,$xoabo,'')
			if StringInStr($content,'<') = 0 Then
				ExitLoop
			EndIf
		WEnd
		FileWriteLine(@ScriptDir&'\noidungbao.txt',$content)
		$dem +=1
	EndIf
EndIf
EndFunc


for $so = 1 to _FileCountLines(@ScriptDir&'\linkvao.txt') step 1
	$laylink = FileReadLine(@ScriptDir&'\linkvao.txt',$so)
	laynoidungcafef($laylink)
Next
MsgBox(0,0,$dem)
ShellExecute(@ScriptDir&'\noidungbao.txt')