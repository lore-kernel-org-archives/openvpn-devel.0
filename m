Message-Id: <494BCA08020000BC00074BD7@...1170...>
Date: Fri, 19 Dec 2008 16:21:28 +0100
From: "Svein Hansen" <Svein.Hansen@...1133...>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="=__Part391136E8.0__="
Subject: Re: [Openvpn-devel] Building a Windows installer.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part391136E8.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


>>> Den 19. desember 2008 kl. 15:27, i meldingen
<494BAF50.5000306@...1172...>,
skrev "Dennis P. Nikolaenko" <dennis@...1172...>:
> Svein Hansen wrote:
>>   
>>>>> Den 19. desember 2008 kl. 14:36, i meldingen
>>>>>         
>> <494BA351.8060303@...1172...>,
>> skrev "Dennis P. Nikolaenko" <dennis@...1172...>:
>>   
>>> Svein Hansen wrote:
>>>     
>>>>    DetailPrint "We are running on a 64-bit system."
>>>> +
>>>> +  SetRegView 64
>>>> +  WriteRegStr HKLM "Software\Microsoft\Windows 
>>>> NT\CurrentVersion\AppCompatFlags\Layers" 
>>>> "$INSTDIR\bin\openvpn-gui-1.0.3.exe" "RUNASADMIN"
>>>> +  SetRegView 32
>>>>
>>>>    SetOutPath "$INSTDIR\bin"
>>>>
>>>> @@ -442,6 +446,8 @@
>>>> tap-32bit:
>>>>
>>>>    DetailPrint "We are running on a 32-bit system."
>>>> +  WriteRegStr HKLM "Software\Microsoft\Windows 
>>>> NT\CurrentVersion\AppCompatFlags\Layers" 
>>>> "$INSTDIR\bin\openvpn-gui-1.0.3.exe" "RUNASADMIN"
>>>> +
>>>>
>>>>    SetOutPath "$INSTDIR\bin"
>>>>    File "${GEN}\tapinstall\i386\tapinstall.exe"
>>>>
>>>> This is maybe not the best way to do it...but it works..
>>>>       
>>> IMO a better option would be to include a manifest instead of
>>>     
>> polluting 
>>   
>>> application compatibility database in registry.
>>> --
>>> Dennis
>>>     
>>
>> I have tried to add a manifest, but that creates a new issue about
>> signing.
>> (I'm clearly not an expert on manifests...)
>>
>> * openvpn-gui-1.0.3.exe.manifest:
>> Executable: openvpn-gui-1.0.3.exe 
>> Manifest:openvpn-gui-1.0.3.exe.manifest
>> openvpn-gui manifest file:
>> <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
>> <assembly xmlns="urn:schemas-microsoft-com:asm.v1"
>> manifestVersion="1.0"> 
>>   <trustInfo xmlns="urn:schemas-microsoft-com:asm.v2">
>>     <security>
>>       <requestedPrivileges>
>>         <requestedExecutionLevel
>>           level="requireAdministrator"
>>           uiAccess="false"/>
>>         </requestedPrivileges>
>>        </security>
>>   </trustInfo>
>> </assembly>
>>
>> Then: 
>> C:\manifest>mt.exe -manifest openvpn-gui-1.0.3.exe.manifest
>> -outputresource:openvpn-gui-1.0.3.exe
>> Microsoft (R) Manifest Tool version 5.2.3790.2075
>> Copyright (c) Microsoft Corporation 2005.
>>
>> Now openvpn-gui-1.0.3.exe is elevated to "requireAdministrator".
>>
>> But, when starting the GUI I get:
>> An unidentified program wants access to your computer 
>> Unidentified Publisher
>> -> Cancel
>> -> Allow
> You should get the same (orange color) error, when building the
binary 
> yourself, unless you take it from the official distribution and you
seem 
> to have taken it from there...
> If you sign the binary with a code signing certificate which is is in

> turn signed by a trusted root CA, you would get a "good" UAC prompt
for 
> a signed application. You have to buy a code signing certificate from
a 
> preinstalled CA or install self-generated CA on all you client
machines.
>  From a signing point view, yes app compat solution is better as it
does 
> not require any additional "acrobatics". Just ensure that app compat

> entry is removed when OpenVPN GUI is uninstalled.
> --
> Dennis

Thanks for the enlightenment :-)

Maybe this is something for the OpenVPN developers to dive into?
There must be several sysadmins that would like to see this included in
the 
official distribution. Or?

One vote from me..

Svein Hansen


--=__Part391136E8.0__=
Content-Type: text/html; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Content-Description: HTML

<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dutf-8">
<META content=3D"MSHTML 6.00.6000.16735" name=3DGENERATOR></HEAD>
<BODY style=3D"MARGIN: 4px 4px 1px; FONT: 10pt Tahoma"><SPAN style=3D"FONT:=
 10pt Segoe UI; COLOR: #000000"><BR>&gt;&gt;&gt; Den 19. desember 2008 kl. =
15:27, i meldingen &lt;</SPAN><SPAN style=3D"FONT: 10pt Segoe UI; COLOR: #f=
f0000; TEXT-DECORATION: underline"><A href=3D"mailto:494BAF50.5000306@...1173...=
72...">494BAF50.5000306@...1172...</A></SPAN><SPAN style=3D"FONT: 10pt Sego=
e UI; COLOR: #000000">&gt;,<BR>skrev "Dennis P. Nikolaenko" &lt;</SPAN><SPA=
N style=3D"FONT: 10pt Segoe UI; COLOR: #ff0000; TEXT-DECORATION: underline"=
><A href=3D"mailto:dennis@...1172...">dennis@...1172...</A></SPAN><SPAN sty=
le=3D"FONT: 10pt Segoe UI; COLOR: #000000">&gt;:<BR>&gt; Svein Hansen wrote=
:<BR>&gt;&gt;&nbsp;&nbsp; <BR>&gt;&gt;&gt;&gt;&gt; Den 19. desember 2008 kl=
. 14:36, i meldingen<BR>&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; <BR>&gt;&gt; &lt;</SPAN><SPAN style=3D"FONT: 10pt Segoe U=
I; COLOR: #ff0000; TEXT-DECORATION: underline"><A href=3D"mailto:494BA351.8=
060303@...1172...">494BA351.8060303@...1172...</A></SPAN><SPAN style=3D"FON=
T: 10pt Segoe UI; COLOR: #000000">&gt;,<BR>&gt;&gt; skrev "Dennis P. Nikola=
enko" &lt;</SPAN><SPAN style=3D"FONT: 10pt Segoe UI; COLOR: #ff0000; TEXT-D=
ECORATION: underline"><A href=3D"mailto:dennis@...1172...">dennis@...1174...=
.</A></SPAN><SPAN style=3D"FONT: 10pt Segoe UI; COLOR: #000000">&gt;:<BR>&g=
t;&gt;&nbsp;&nbsp; <BR>&gt;&gt;&gt; Svein Hansen wrote:<BR>&gt;&gt;&gt;&nbs=
p;&nbsp;&nbsp;&nbsp; <BR>&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; DetailPrint "We=
 are running on a 64-bit system."<BR>&gt;&gt;&gt;&gt; +<BR>&gt;&gt;&gt;&gt;=
 +&nbsp; SetRegView 64<BR>&gt;&gt;&gt;&gt; +&nbsp; WriteRegStr HKLM "Softwa=
re\Microsoft\Windows <BR>&gt;&gt;&gt;&gt; NT\CurrentVersion\AppCompatFlags\=
Layers" <BR>&gt;&gt;&gt;&gt; "$INSTDIR\bin\openvpn-gui-1.0.3.exe" "RUNASADM=
IN"<BR>&gt;&gt;&gt;&gt; +&nbsp; SetRegView 32<BR>&gt;&gt;&gt;&gt;<BR>&gt;&g=
t;&gt;&gt;&nbsp;&nbsp;&nbsp; SetOutPath "$INSTDIR\bin"<BR>&gt;&gt;&gt;&gt;<=
BR>&gt;&gt;&gt;&gt; @@ -442,6 +446,8 @@<BR>&gt;&gt;&gt;&gt; tap-32bit:<BR>&=
gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; DetailPrint "We are r=
unning on a 32-bit system."<BR>&gt;&gt;&gt;&gt; +&nbsp; WriteRegStr HKLM "S=
oftware\Microsoft\Windows <BR>&gt;&gt;&gt;&gt; NT\CurrentVersion\AppCompatF=
lags\Layers" <BR>&gt;&gt;&gt;&gt; "$INSTDIR\bin\openvpn-gui-1.0.3.exe" "RUN=
ASADMIN"<BR>&gt;&gt;&gt;&gt; +<BR>&gt;&gt;&gt;&gt;<BR>&gt;&gt;&gt;&gt;&nbsp=
;&nbsp;&nbsp; SetOutPath "$INSTDIR\bin"<BR>&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbs=
p; File "${GEN}\tapinstall\i386\tapinstall.exe"<BR>&gt;&gt;&gt;&gt;<BR>&gt;=
&gt;&gt;&gt; This is maybe not the best way to do it...but it works..<BR>&g=
t;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>&gt;&gt;&gt; IMO a b=
etter option would be to include a manifest instead of<BR>&gt;&gt;&gt;&nbsp=
;&nbsp;&nbsp;&nbsp; <BR>&gt;&gt; polluting <BR>&gt;&gt;&nbsp;&nbsp; <BR>&gt=
;&gt;&gt; application compatibility database in registry.<BR>&gt;&gt;&gt; -=
-<BR>&gt;&gt;&gt; Dennis<BR>&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; <BR>&gt;&g=
t;<BR>&gt;&gt; I have tried to add a manifest, but that creates a new issue=
 about<BR>&gt;&gt; signing.<BR>&gt;&gt; (I'm clearly not an expert on manif=
ests...)<BR>&gt;&gt;<BR>&gt;&gt; * openvpn-gui-1.0.3.exe.manifest:<BR>&gt;&=
gt; Executable: openvpn-gui-1.0.3.exe <BR>&gt;&gt; Manifest:openvpn-gui-1.0=
.3.exe.manifest<BR>&gt;&gt; openvpn-gui manifest file:<BR>&gt;&gt; &lt;?xml=
 version=3D"1.0" encoding=3D"UTF-8" standalone=3D"yes"?&gt;<BR>&gt;&gt; &lt=
;assembly xmlns=3D"urn:schemas-microsoft-com:asm.v1"<BR>&gt;&gt; manifestVe=
rsion=3D"1.0"&gt; <BR>&gt;&gt;&nbsp;&nbsp; &lt;trustInfo xmlns=3D"urn:schem=
as-microsoft-com:asm.v2"&gt;<BR>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; &lt;securi=
ty&gt;<BR>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;requestedPrivile=
ges&gt;<BR>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;req=
uestedExecutionLevel<BR>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; level=3D"requireAdministrator"<BR>&gt;&gt;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uiAccess=3D"false"/&gt;<BR>&g=
t;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;/requestedPrivil=
eges&gt;<BR>&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;/securit=
y&gt;<BR>&gt;&gt;&nbsp;&nbsp; &lt;/trustInfo&gt;<BR>&gt;&gt; &lt;/assembly&=
gt;<BR>&gt;&gt;<BR>&gt;&gt; Then: <BR>&gt;&gt; C:\manifest&gt;mt.exe -manif=
est openvpn-gui-1.0.3.exe.manifest<BR>&gt;&gt; -outputresource:openvpn-gui-=
1.0.3.exe<BR>&gt;&gt; Microsoft (R) Manifest Tool version 5.2.3790.2075<BR>=
&gt;&gt; Copyright (c) Microsoft Corporation 2005.<BR>&gt;&gt;<BR>&gt;&gt; =
Now openvpn-gui-1.0.3.exe is elevated to "requireAdministrator".<BR>&gt;&gt=
;<BR>&gt;&gt; But, when starting the GUI I get:<BR>&gt;&gt; An unidentified=
 program wants access to your computer <BR>&gt;&gt; Unidentified Publisher<=
BR>&gt;&gt; -&gt; Cancel<BR>&gt;&gt; -&gt; Allow<BR>&gt; You should get the=
 same (orange color) error, when building the binary <BR>&gt; yourself, unl=
ess you take it from the official distribution and you seem <BR>&gt; to hav=
e taken it from there...<BR>&gt; If you sign the binary with a code signing=
 certificate which is is in <BR>&gt; turn signed by a trusted root CA, you =
would get a "good" UAC prompt for <BR>&gt; a signed application. You have t=
o buy a code signing certificate from a <BR>&gt; preinstalled CA or install=
 self-generated CA on all you client machines.<BR>&gt;&nbsp; From a signing=
 point view, yes app compat solution is better as it does <BR>&gt; not requ=
ire any additional "acrobatics". Just ensure that app compat <BR>&gt; entry=
 is removed when OpenVPN GUI is uninstalled.<BR>&gt; --<BR>&gt; Dennis<BR><=
BR>Thanks for the enlightenment :-)<BR><BR>Maybe this is something for the =
OpenVPN developers to dive into?<BR>There must be several sysadmins that wo=
uld like to see this included in the <BR>official distribution. Or?<BR><BR>=
One vote from me..<BR><BR>Svein Hansen<BR><BR></SPAN></BODY></HTML>

--=__Part391136E8.0__=--

