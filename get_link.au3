#include<_HttpRequest.au3>
#include<File.au3>
$link = 'http://cafef.vn/co-dong-lon-star-invest-kien-nghi-bo-sung-nhieu-van-de-vao-chuong-trinh-dhdcd-cua-vinaconex-20190628093348921.chn'

Func laynoidungcafef($linktrangbao)
$data=_HttpRequest(2,$linktrangbao,'','','','Connection: keep-alive|Upgrade-Insecure-Requests: 1')
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
EndFunc


Func getlinkcafef($linkcafef)
$data=_HttpRequest(2,$linkcafef,'','','','Connection: keep-alive|Upgrade-Insecure-Requests: 1')

$sodong = _FileCountLines(@ScriptDir&'\linkvao.txt')
for $i = 1  to 50 Step 1
	$tach=StringRegExp($data,'href="(.*?).chn',3)
	$tach[0] = $tach[0] & '.chn'
	$data = StringReplace($data,$tach[0],'')

	if StringLeft($tach[0],4) <> 'http' Then
		$tach[0] = 'http://cafef.vn' & $tach[0]
	EndIf

	$giong=0
	for $k=1 to $sodong Step 1
		If $tach[0] = FileReadLine(@ScriptDir&'\linkvao.txt',$k) Then
			$giong = 1
		EndIf
	Next
	If $giong = 0 Then
		FileWriteLine(@ScriptDir&'\linkvao.txt',$tach[0])
	EndIf
Next
;ShellExecute(@ScriptDir&'\linkvao.txt')
EndFunc


$khoidau = 'http://cafef.vn/'
getlinkcafef($khoidau)
for $e = 1 to 10 Step 1
	for $f = 1 to _FileCountLines(@ScriptDir&'\linkvao.txt') step 1
		$linkchay = FileReadLine(@ScriptDir&'\linkvao.txt',$f)
		getlinkcafef($linkchay)
	Next
Next

ShellExecute(@ScriptDir&'\linkvao.txt')