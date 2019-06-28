#include<_HttpRequest.au3>
#include<File.au3>
;$link = 'http://cafef.vn/co-dong-lon-star-invest-kien-nghi-bo-sung-nhieu-van-de-vao-chuong-trinh-dhdcd-cua-vinaconex-20190628093348921.chn'

Func laynoidungcafef($linktrangbao)
If StringLen($linktrangbao) > 53 Then
$data=_HttpRequest(2,$linktrangbao,'','','','Connection: keep-alive|Upgrade-Insecure-Requests: 1')
	If StringRegExp($data,'<p>(.*?)</div>',1) <> False Then
		$tach=StringRegExp($data,'<p>(.*?)</div>',1)
		$content = $tach[0]
		While 1
			If StringRegExp($content,'<(.*?)>',1) = False Then
				ExitLoop
			EndIf
			$kiemtra = StringRegExp($content,'<(.*?)>',1)
			$content = StringReplace($content,$kiemtra[0],'')
			$content = StringReplace($content,'<>','')
			if StringInStr($content,'<') = 0 Then
				ExitLoop
			EndIf
		WEnd
		FileWriteLine(@ScriptDir&'\noidungbao.txt',$content)
	EndIf
EndIf
EndFunc


for $so = 1 to _FileCountLines(@ScriptDir&'\linkvao.txt') step 1
	$laylink = FileReadLine(@ScriptDir&'\linkvao.txt',$so)
	laynoidungcafef($laylink)
Next
ShellExecute(@ScriptDir&'\noidungbao.txt')