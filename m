MIME-Version: 1.0
In-Reply-To: <1DEBAC6728FF4F9E8B743981F029E1BC@...576...>
References: <2ece24860905272356l5234c224mcbd4b7c01553a983@...278...>
	<1DEBAC6728FF4F9E8B743981F029E1BC@...576...>
Date: Thu, 28 May 2009 16:29:31 +0200
Message-ID: <2ece24860905280729s28ef4b56p2da1142fced29ed1@...278...>
From: jonathan openvpn <jonathan.openvpn@...277...>
Content-Type: multipart/alternative; boundary=001636ed6a11c0b8fb046af9c9dd
Subject: Re: [Openvpn-devel] CE port needed DLLs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: dave <dev@...575...>
Cc: openvpn-devel@lists.sourceforge.net

--001636ed6a11c0b8fb046af9c9dd
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Dave.

This morning I've been able to solve the error and began to debug the
application. There were two reasons for my problem:

 - the wininet.dll file i had was compiled for x86 platform. I've found a
thumb file version in internet.
 - I have removed the code related to the connection manager (files
openvpn.c and wince_portstuff.c) and the cellcore.lib link reference.

Also, in internet i have found that cellcore.dll is available in Windows
Mobile and Windows Embedded CE 6.0 but not in Windows CE 5.0
At this point, as you have said, i will need to do networking "in the more
conventional way", in spite of i don't know what it means yet, and how to do
it...

To sum up, my problem was i didn't have the correct platform libraries, plus
a big piece of ignorance...

Can you give me a link or reference to somewhere I could get information
about possibilities to solve my networking needs without the connection
manager?

Thank you very much for your help. It has been very useful. Probably i'll
come back soon with some new questions and doubts. I hope some day i'll be
able to solve someone questions too...

Best regards,

Jonathan.


2009/5/28 dave <dev@...575...>

>  Sure, you're welcome.  Thumb should not fundamentally be a problem
> provided the platform and tools support it, and it sounds like in your case
> it does.
>
> Your assumptions about what you need are correct, I believe (i.e., you
> don't need the gui).  You may want to inspect the code, however, because
> there are routines for installing and loading the TAP driver that may be of
> interest.  They are in taputil.h,.c
>
> cellcore.dll is used to provide the Windows Connection Manager stuff, and
> in openvpn.exe this in openvpn.c, around line 203, and around line 284.  I
> should have conditional-compiled that as an option, but I didn't.  Similarly
> the support routines are in wince_portstuff.c at line 1631 through the end,
> and they can go, too (actually if you remove those first and compile, the
> compile should fail and you can find if there was anything I missed, but
> that should be it).
>
> Generic CE platforms don't use the Windows Connection Manager and do
> networking in the more conventional way, so you can probable do without it,
> and remove the cellcore.lib from your link step.
>
> Assuming your error message really means 'missing dlls' instead of 'invalid
> binary' then you should be better off.
>
> Again, if you want to send me your compiled binary, I can inspect it more
> closely if that is useful.
>
> -Dave
>
>  -----Original Message-----
> *From:* jonathan openvpn [mailto:jonathan.openvpn@...277...]
> *Sent:* Thursday, May 28, 2009 1:56 AM
> *To:* dave
> *Cc:* openvpn-devel@lists.sourceforge.net
> *Subject:* Re: [Openvpn-devel] CE port needed DLLs
>
> Hello.
>
> First of all, thank you for the quick response.
>
> We have other applications running on the Windows CE distribution and the
> linker option "MACHINE" is set to "THUMB".
> We are using a custom developed board, and we develop our applications
> through Visual Studio 2005.
>
> We only need to stablish a connection to a VPN server without need of a
> GUI, all configuration must be transparent to the user. Therefore I think we
> only need the openvpn executable and TAP_CE driver. If i'm not wrong, the
> ovpncmgr module is to provide a GUI for the openVPN client. Is that correct?
>
> When no dll is provided, and I try to debug the application from Visual
> Studio connected to the device, i get the message: "An error occurred that
> usually indicates a corrupt installation (code 0x8007007e). If the problem
> persists, repair your Visual Studio installation via 'Add or Remove
> Programs' in control Panel"
> Some webs refer to that error like some archives are missing. When I put
> the dlls you have listed below, the error changes to: "openvpn is not a
> valid WindowsCE application". I suspect that some of the dll may not be
> correct for my platform. Could it be the source of my problem?
>
> I have not been able to find the cellcore.dll for our platform. Does it
> mean we cannot use the connection manager functionality? I have read in some
> forums that this functionality is not present on Windows CE...
>
> Sorry for my ignorance, I am pretty new on Windows CE.
>
> Your help is so much appreciated. Thank you very much.
>
> Jonathan.
>
>
> 2009/5/27 dave <dev@...575...>
>
>>  That message usually means the binary is hosed, and I believe missing
>> dlls give a different message.
>> Are you sure Thumb is correct for your platform?  Are you using a consumer
>> device like a pocket pc phone, etc, or is it a custom board?
>>
>> I ask that because the existing code does use some functionality peculiar
>> to the pocket pc (phone) that is not generally available on other platforms,
>> yet the SDKs ofen include the headers and import libs, allowing you to
>> successfully compile, but then you can't run it on the target device.
>>
>> When you say 'client application' are you meaning just the gui, or the
>> whole entire set of programs (i.e., the TAP driver, the openvpn executable,
>> and the gui).
>>
>> You can use DUMPBIN to find the dlls from the exe, and also inspect the
>> header to see the cpu configuration.  Here is a short list, if it helps:
>>
>> openvpn:
>> *  coredll.dll
>> *  w2s.dll
>> *  iphlpapi.dll
>> *  wininet.dll
>> *  ole32.dll
>> *  cellcore.dll
>>
>> tap-ce:
>> *  ndis.dll
>> *  coredll.dll
>>
>> ovpncmgr:
>> *  iphlpapi.dll
>> *  toolhelp.dll
>> *  cellcore.dll
>> *  ole32.dll
>> *  mfcce300.dll
>> *  coredll.dll
>> *  winsock.dll
>>
>> Your build may (will) differ depending on your platform, because your
>> platform builder may have put some of these features in different dlls.
>> That list was for PocketPC.
>>
>> Now, the cellcore.dll, you may not have on other platforms.  It is needed
>> for supporting Windows Connectin Manager, and you can surgically cut out
>> that functionality if your platform doesn't have it.  Most of the rest is
>> fairly standard.
>>
>> Before doing surgery, you may wish to re-check your assumptions.  Also, if
>> you wish to zip up your problem binaries and send them to me directly, I
>> will do a quick inspection for you.
>>
>> -dave
>>
>>  -----Original Message-----
>> *From:* jonathan openvpn [mailto:jonathan.openvpn@...277...]
>> *Sent:* Wednesday, May 27, 2009 5:36 AM
>> *To:* openvpn-devel@lists.sourceforge.net
>> *Subject:* [Openvpn-devel] CE port needed DLLs
>>
>> Hello.
>>
>> I'm triying to execute a Windows CE 5.0 porting of openvpn client
>> application. I've been successful on compiling it but when i try to execute
>> i receive the message: "openvpn is not a valid WindowsCE application".
>>
>> I am compiling to ARM-Thumb architecture. I suspect there is a problem
>> with needed DLLs.
>>
>> Could anyone tell me wich DLLs are needed and where could i get them?
>>
>> Thank you very much.
>>
>>
>

--001636ed6a11c0b8fb046af9c9dd
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Dave.<br><br>This morning I&#39;ve been able to solve the error and bega=
n to debug the application. There were two reasons for my problem:<br><br>=
=A0- the wininet.dll file i had was compiled for x86 platform. I&#39;ve fou=
nd a thumb file version in internet. <br>
=A0- I have removed the code related to the connection manager (files openv=
pn.c and wince_portstuff.c) and the cellcore.lib link reference. <br><br>Al=
so, in internet i have found that cellcore.dll is available in Windows Mobi=
le and Windows Embedded CE 6.0 but not in Windows CE 5.0<br>
At this point, as you have said, i will need to do networking &quot;in the =
more conventional way&quot;, in spite of i don&#39;t know what it means yet=
, and how to do it...<br><br>To sum up, my problem was i didn&#39;t have th=
e correct platform libraries, plus a big piece of ignorance...<br>
<br>Can you give me a link or reference to somewhere I could get informatio=
n about possibilities to solve my networking needs without the connection m=
anager?<br><br>Thank you very much for your help. It has been very useful. =
Probably i&#39;ll come back soon with some new questions and doubts. I hope=
 some day i&#39;ll be able to solve someone questions too...<br>
<br>Best regards,<br><br>Jonathan.<br><br><br><div class=3D"gmail_quote">20=
09/5/28 dave <span dir=3D"ltr">&lt;<a href=3D"mailto:dev@...575...">dev@...493...=
575...</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"border-=
left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left=
: 1ex;">






<div>
<div><font color=3D"#0000ff" size=3D"2" face=3D"Arial"><span>Sure,=20
you&#39;re welcome.=A0 Thumb should not fundamentally be a problem provided=
 the=20
platform and tools support it, and it sounds like in your case it=20
does.</span></font></div>
<div><font color=3D"#0000ff" size=3D"2" face=3D"Arial"><span></span></font>=
=A0</div>
<div><font color=3D"#0000ff" size=3D"2" face=3D"Arial"><span>Your=20
assumptions about what you need are correct, I believe (i.e., you don&#39;t=
 need the=20
gui).=A0 You may want to inspect the code, however, because there are=20
routines for installing and loading the TAP driver that may be of=20
interest.=A0 They are in taputil.h,.c</span></font></div>
<div><font color=3D"#0000ff" size=3D"2" face=3D"Arial"><span></span></font>=
=A0</div>
<div><font color=3D"#0000ff" size=3D"2" face=3D"Arial"><span>cellcore.dll i=
s used to provide the Windows Connection=20
Manager stuff, and in openvpn.exe this in openvpn.c, around line 203, and a=
round=20
line 284.=A0 I should have conditional-compiled that as an option, but=A0I=
=20
didn&#39;t.=A0 Similarly the support routines are in wince_portstuff.c at l=
ine=20
1631 through the end, and they can go, too (actually if you remove those fi=
rst=20
and compile, the compile should fail and you can find if there was anything=
 I=20
missed, but that should be it).</span></font></div>
<div><font color=3D"#0000ff" size=3D"2" face=3D"Arial"><span></span></font>=
=A0</div>
<div><font color=3D"#0000ff" size=3D"2" face=3D"Arial"><span>Generic CE pla=
tforms don&#39;t use the Windows Connection=20
Manager and do networking in the more conventional way, so you can probable=
 do=20
without it, and remove the cellcore.lib from your link step.</span></font><=
/div>
<div><font color=3D"#0000ff" size=3D"2" face=3D"Arial"><span></span></font>=
=A0</div>
<div><font color=3D"#0000ff" size=3D"2" face=3D"Arial"><span>Assuming your =
error message really means &#39;missing dlls&#39;=20
instead of &#39;invalid binary&#39; then you should be better off.</span></=
font></div>
<div><font color=3D"#0000ff" size=3D"2" face=3D"Arial"><span></span></font>=
=A0</div>
<div><font color=3D"#0000ff" size=3D"2" face=3D"Arial"><span>Again,=20
if you want to send me your compiled binary, I can inspect it more closely =
if=20
that is useful.</span></font></div>
<div><font color=3D"#0000ff" size=3D"2" face=3D"Arial"><span></span></font>=
=A0</div>
<div><font color=3D"#0000ff" size=3D"2" face=3D"Arial"><span>-Dave</span></=
font></div>
<blockquote style=3D"border-left: 2px solid rgb(0, 0, 255); padding-left: 5=
px; margin-left: 5px; margin-right: 0px;">
  <div></div>
  <div dir=3D"ltr" align=3D"left" lang=3D"en-us"><font size=3D"2" face=3D"T=
ahoma"><div class=3D"im">-----Original Message-----<br><b>From:</b> jonatha=
n openvpn=20
  [mailto:<a href=3D"mailto:jonathan.openvpn@...277..." target=3D"_blank">j=
onathan.openvpn@...277...</a>] <br></div><div><div></div><div class=3D"h5">=
<b>Sent:</b> Thursday, May 28, 2009=20
  1:56 AM<br><b>To:</b> dave<br><b>Cc:</b>=20
  <a href=3D"mailto:openvpn-devel@lists.sourceforge.net" target=3D"_blank">=
openvpn-devel@lists.sourceforge.net</a><br><b>Subject:</b> Re: [Openvpn-dev=
el] CE=20
  port needed DLLs<br><br></div></div></font></div><div><div></div><div cla=
ss=3D"h5">Hello.<br><br>First of all, thank you for=20
  the quick response.<br><br>We have other applications running on the Wind=
ows=20
  CE distribution and the linker option &quot;MACHINE&quot; is set to &quot=
;THUMB&quot;.<br>We are=20
  using a custom developed board, and we develop our applications through V=
isual=20
  Studio 2005.<br><br>We only need to stablish a connection to a VPN server=
=20
  without need of a GUI, all configuration must be transparent to the user.=
=20
  Therefore I think we only need the openvpn executable and TAP_CE driver. =
If=20
  i&#39;m not wrong, the ovpncmgr module is to provide a GUI for the openVP=
N client.=20
  Is that correct?<br><br>When no dll is provided, and I try to debug the=20
  application from Visual Studio connected to the device, i get the message=
: &quot;An=20
  error occurred that usually indicates a corrupt installation (code=20
  0x8007007e). If the problem persists, repair your Visual Studio installat=
ion=20
  via &#39;Add or Remove Programs&#39; in control Panel&quot;<br>Some webs =
refer to that=20
  error like some archives are missing. When I put the dlls you have listed=
=20
  below, the error changes to: &quot;openvpn is not a valid WindowsCE appli=
cation&quot;. I=20
  suspect that some of the dll may not be correct for my platform. Could it=
 be=20
  the source of my problem?<br><br>I have not been able to find the cellcor=
e.dll=20
  for our platform. Does it mean we cannot use the connection manager=20
  functionality? I have read in some forums that this functionality is not=
=20
  present on Windows CE...<br><br>Sorry for my ignorance, I am pretty new o=
n=20
  Windows CE.<br><br>Your help is so much appreciated. Thank you very=20
  much.<br><br>Jonathan.<br><br><br>
  <div class=3D"gmail_quote">2009/5/27 dave <span dir=3D"ltr">&lt;<a href=
=3D"mailto:dev@...575..." target=3D"_blank">dev@...575...</a>&gt;</span><br>
  <blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204=
, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
    <div>
    <div>
    <div><span><font color=3D"#0000ff" size=3D"2" face=3D"Arial">That messa=
ge usually means=20
    the binary is hosed, and I believe missing dlls give a different=20
    message.</font></span></div>
    <div><span><font color=3D"#0000ff" size=3D"2" face=3D"Arial">Are you su=
re Thumb is=20
    correct for your platform?=A0 Are you using a consumer device like a=20
    pocket pc phone, etc, or is it a custom board?</font></span></div>
    <div><span><font color=3D"#0000ff" size=3D"2" face=3D"Arial"></font></s=
pan>=A0</div>
    <div><span><font color=3D"#0000ff" size=3D"2" face=3D"Arial">I ask that=
 because the=20
    existing code does use some functionality peculiar to the pocket pc (ph=
one)=20
    that is not generally available on other platforms, yet the SDKs ofen=20
    include the headers and import libs, allowing you to successfully compi=
le,=20
    but then you can&#39;t run it on the target device.</font></span></div>
    <div><span><font color=3D"#0000ff" size=3D"2" face=3D"Arial"></font></s=
pan>=A0</div>
    <div><span><font color=3D"#0000ff" size=3D"2" face=3D"Arial">When you s=
ay &#39;client=20
    application&#39; are you meaning just the gui, or the whole entire set =
of=20
    programs (i.e., the TAP driver, the openvpn executable, and the=20
    gui).</font></span></div>
    <div><span><font color=3D"#0000ff" size=3D"2" face=3D"Arial"></font></s=
pan>=A0</div>
    <div><span><font color=3D"#0000ff" size=3D"2" face=3D"Arial">You can us=
e DUMPBIN to find=20
    the dlls from the exe, and also inspect the header to see the cpu=20
    configuration.=A0 Here is a short list, if it helps:</font></span></div>
    <div><span><font color=3D"#0000ff" size=3D"2" face=3D"Arial"></font></s=
pan>=A0</div>
    <div><span><font color=3D"#0000ff" size=3D"2" face=3D"Arial">openvpn:</=
font></span></div>
    <div><span><font color=3D"#0000ff" size=3D"2" face=3D"Arial">*=A0=20
    coredll.dll</font></span></div>
    <div><span><font color=3D"#0000ff" size=3D"2" face=3D"Arial">*=A0=20
    w2s.dll</font></span></div>
    <div><span><font color=3D"#0000ff" size=3D"2" face=3D"Arial">*=A0=20
    iphlpapi.dll</font></span></div>
    <div><span><font color=3D"#0000ff" size=3D"2" face=3D"Arial">*=A0=20
    wininet.dll</font></span></div>
    <div><span><font color=3D"#0000ff" size=3D"2" face=3D"Arial">*=A0=20
    ole32.dll</font></span></div>
    <div><span><font color=3D"#0000ff" size=3D"2" face=3D"Arial">*=A0=20
    cellcore.dll</font></span></div>
    <div><font face=3D"Tahoma"><font size=3D"2"><span><font color=3D"#0000f=
f" face=3D"Arial"></font></span></font></font>=A0</div>
    <div><font size=3D"+0"><font color=3D"#0000ff" size=3D"2" face=3D"Arial=
"><span>tap-ce:</span></font></font></div>
    <div><font size=3D"+0"><font color=3D"#0000ff" size=3D"2" face=3D"Arial=
"><span>*=A0=20
    ndis.dll</span></font></font></div>
    <div><font size=3D"+0"><font color=3D"#0000ff" size=3D"2" face=3D"Arial=
"><span>*=A0=20
    coredll.dll</span></font></font></div>
    <div><font size=3D"+0"><font color=3D"#0000ff" size=3D"2" face=3D"Arial=
"><span></span></font></font>=A0</div>
    <div><font size=3D"+0"><font color=3D"#0000ff" size=3D"2" face=3D"Arial=
"><span>ovpncmgr:</span></font></font></div>
    <div><font size=3D"+0"><font color=3D"#0000ff" size=3D"2" face=3D"Arial=
"><span>*=A0=20
    iphlpapi.dll</span></font></font></div>
    <div><font size=3D"+0"><font color=3D"#0000ff" size=3D"2" face=3D"Arial=
"><span>*=A0=20
    toolhelp.dll</span></font></font></div>
    <div><font size=3D"+0"><font color=3D"#0000ff" size=3D"2" face=3D"Arial=
"><span>*=A0=20
    cellcore.dll</span></font></font></div>
    <div><font size=3D"+0"><font color=3D"#0000ff" size=3D"2" face=3D"Arial=
"><span>*=A0=20
    ole32.dll</span></font></font></div>
    <div><font size=3D"+0"><font color=3D"#0000ff" size=3D"2" face=3D"Arial=
"><span>*=A0=20
    mfcce300.dll</span></font></font></div>
    <div><font size=3D"+0"><font color=3D"#0000ff" size=3D"2" face=3D"Arial=
"><span>*=A0=20
    coredll.dll</span></font></font></div>
    <div><font size=3D"+0"><font color=3D"#0000ff" size=3D"2" face=3D"Arial=
"><span>*=A0=20
    winsock.dll</span></font></font></div>
    <div><font face=3D"Tahoma"><font color=3D"#0000ff" size=3D"2" face=3D"A=
rial"><span></span></font></font>=A0</div>
    <div><font face=3D"Tahoma"><font color=3D"#0000ff" size=3D"2" face=3D"A=
rial"><span>Your=20
    build may (will) differ depending on your platform, because your platfo=
rm=20
    builder may have put some of these features in different dlls.=A0 That=
=20
    list was for PocketPC.</span></font></font></div>
    <div><font face=3D"Tahoma"><font color=3D"#0000ff" size=3D"2" face=3D"A=
rial"><span></span></font></font>=A0</div>
    <div><font face=3D"Tahoma"><font color=3D"#0000ff" size=3D"2" face=3D"A=
rial"><span>Now, the=20
    cellcore.dll, you may not have on other platforms.=A0 It is needed for=
=20
    supporting Windows Connectin Manager, and you can surgically cut out th=
at=20
    functionality if your platform doesn&#39;t have it.=A0 Most of the rest=
 is=20
    fairly standard.</span></font></font></div>
    <div><font face=3D"Tahoma"><font color=3D"#0000ff" size=3D"2" face=3D"A=
rial"><span></span></font></font>=A0</div>
    <div><font face=3D"Tahoma"><font color=3D"#0000ff" size=3D"2" face=3D"A=
rial"><span>Before=20
    doing surgery, you may wish to re-check your assumptions.=A0 Also, if y=
ou=20
    wish to zip up your problem binaries and send them to me directly, I wi=
ll do=20
    a quick inspection for you.</span></font></font></div>
    <div><font face=3D"Tahoma"><font color=3D"#0000ff" size=3D"2" face=3D"A=
rial"><span></span></font></font>=A0</div><font color=3D"#888888">
    <div><font face=3D"Tahoma"><font color=3D"#0000ff" size=3D"2" face=3D"A=
rial"><span>-dave</span></font></font></div></font></div>
    <div>
    <div></div>
    <div>
    <blockquote style=3D"border-left: 2px solid rgb(0, 0, 255); padding-lef=
t: 5px; margin-left: 5px; margin-right: 0px;">
      <div></div>
      <div dir=3D"ltr" align=3D"left" lang=3D"en-us"><font size=3D"2" face=
=3D"Tahoma">-----Original=20
      Message-----<br><b>From:</b> jonathan openvpn [mailto:<a href=3D"mail=
to:jonathan.openvpn@...277..." target=3D"_blank">jonathan.openvpn@...277...=
</a>] <br><b>Sent:</b> Wednesday,=20
      May 27, 2009 5:36 AM<br><b>To:</b> <a href=3D"mailto:openvpn-devel@...1224...=
sts.sourceforge.net" target=3D"_blank">openvpn-devel@lists.sourceforge.net<=
/a><br><b>Subject:</b>=20
      [Openvpn-devel] CE port needed DLLs<br><br></font></div>Hello.<br><br=
>I&#39;m=20
      triying to execute a Windows CE 5.0 porting of openvpn client applica=
tion.=20
      I&#39;ve been successful on compiling it but when i try to execute i =
receive=20
      the message: &quot;openvpn is not a valid WindowsCE application&quot;=
.<br><br>I am=20
      compiling to ARM-Thumb architecture. I suspect there is a problem wit=
h=20
      needed DLLs.<br><br>Could anyone tell me wich DLLs are needed and whe=
re=20
      could i get them?<br><br>Thank you very=20
    much.<br></blockquote></div></div></div></blockquote></div><br></div></=
div></blockquote></div>
</blockquote></div><br>

--001636ed6a11c0b8fb046af9c9dd--

