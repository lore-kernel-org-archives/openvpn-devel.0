MIME-Version: 1.0
In-Reply-To: <6577A8C6073C4955870B08F7CB09B9FD@...576...>
References: <2ece24860905270336r54fb6cb9hfa1578e611d97fb3@...278...>
	<6577A8C6073C4955870B08F7CB09B9FD@...576...>
Date: Thu, 28 May 2009 08:56:22 +0200
Message-ID: <2ece24860905272356l5234c224mcbd4b7c01553a983@...278...>
From: jonathan openvpn <jonathan.openvpn@...277...>
Content-Type: multipart/alternative; boundary=000e0cd1574431911c046af375cf
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

--000e0cd1574431911c046af375cf
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello.

First of all, thank you for the quick response.

We have other applications running on the Windows CE distribution and the
linker option "MACHINE" is set to "THUMB".
We are using a custom developed board, and we develop our applications
through Visual Studio 2005.

We only need to stablish a connection to a VPN server without need of a GUI,
all configuration must be transparent to the user. Therefore I think we only
need the openvpn executable and TAP_CE driver. If i'm not wrong, the
ovpncmgr module is to provide a GUI for the openVPN client. Is that correct?

When no dll is provided, and I try to debug the application from Visual
Studio connected to the device, i get the message: "An error occurred that
usually indicates a corrupt installation (code 0x8007007e). If the problem
persists, repair your Visual Studio installation via 'Add or Remove
Programs' in control Panel"
Some webs refer to that error like some archives are missing. When I put the
dlls you have listed below, the error changes to: "openvpn is not a valid
WindowsCE application". I suspect that some of the dll may not be correct
for my platform. Could it be the source of my problem?

I have not been able to find the cellcore.dll for our platform. Does it mean
we cannot use the connection manager functionality? I have read in some
forums that this functionality is not present on Windows CE...

Sorry for my ignorance, I am pretty new on Windows CE.

Your help is so much appreciated. Thank you very much.

Jonathan.


2009/5/27 dave <dev@...575...>

>  That message usually means the binary is hosed, and I believe missing
> dlls give a different message.
> Are you sure Thumb is correct for your platform?  Are you using a consumer
> device like a pocket pc phone, etc, or is it a custom board?
>
> I ask that because the existing code does use some functionality peculiar
> to the pocket pc (phone) that is not generally available on other platforms,
> yet the SDKs ofen include the headers and import libs, allowing you to
> successfully compile, but then you can't run it on the target device.
>
> When you say 'client application' are you meaning just the gui, or the
> whole entire set of programs (i.e., the TAP driver, the openvpn executable,
> and the gui).
>
> You can use DUMPBIN to find the dlls from the exe, and also inspect the
> header to see the cpu configuration.  Here is a short list, if it helps:
>
> openvpn:
> *  coredll.dll
> *  w2s.dll
> *  iphlpapi.dll
> *  wininet.dll
> *  ole32.dll
> *  cellcore.dll
>
> tap-ce:
> *  ndis.dll
> *  coredll.dll
>
> ovpncmgr:
> *  iphlpapi.dll
> *  toolhelp.dll
> *  cellcore.dll
> *  ole32.dll
> *  mfcce300.dll
> *  coredll.dll
> *  winsock.dll
>
> Your build may (will) differ depending on your platform, because your
> platform builder may have put some of these features in different dlls.
> That list was for PocketPC.
>
> Now, the cellcore.dll, you may not have on other platforms.  It is needed
> for supporting Windows Connectin Manager, and you can surgically cut out
> that functionality if your platform doesn't have it.  Most of the rest is
> fairly standard.
>
> Before doing surgery, you may wish to re-check your assumptions.  Also, if
> you wish to zip up your problem binaries and send them to me directly, I
> will do a quick inspection for you.
>
> -dave
>
>  -----Original Message-----
> *From:* jonathan openvpn [mailto:jonathan.openvpn@...277...]
> *Sent:* Wednesday, May 27, 2009 5:36 AM
> *To:* openvpn-devel@lists.sourceforge.net
> *Subject:* [Openvpn-devel] CE port needed DLLs
>
> Hello.
>
> I'm triying to execute a Windows CE 5.0 porting of openvpn client
> application. I've been successful on compiling it but when i try to execute
> i receive the message: "openvpn is not a valid WindowsCE application".
>
> I am compiling to ARM-Thumb architecture. I suspect there is a problem with
> needed DLLs.
>
> Could anyone tell me wich DLLs are needed and where could i get them?
>
> Thank you very much.
>
>

--000e0cd1574431911c046af375cf
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello.<br><br>First of all, thank you for the quick response.<br><br>We hav=
e other applications running on the Windows CE distribution and the linker =
option &quot;MACHINE&quot; is set to &quot;THUMB&quot;.<br>We are using a c=
ustom developed board, and we develop our applications through Visual Studi=
o 2005.<br>
<br>We only need to stablish a connection to a VPN server without need of a=
 GUI, all configuration must be transparent to the user. Therefore I think =
we only need the openvpn executable and TAP_CE driver. If i&#39;m not wrong=
, the ovpncmgr module is to provide a GUI for the openVPN client. Is that c=
orrect?<br>
<br>When no dll is provided, and I try to debug the application from Visual=
 Studio connected to the device, i get the message: &quot;An error occurred=
 that usually indicates a corrupt installation (code 0x8007007e). If the pr=
oblem persists, repair your Visual Studio installation via &#39;Add or Remo=
ve Programs&#39; in control Panel&quot;<br>
Some webs refer to that error like some archives are missing. When I put th=
e dlls you have listed below, the error changes to: &quot;openvpn is not a =
valid WindowsCE application&quot;. I suspect that some of the dll may not b=
e correct for my platform. Could it be the source of my problem?<br>
<br>I have not been able to find the cellcore.dll for our platform. Does it=
 mean we cannot use the connection manager functionality? I have read in so=
me forums that this functionality is not present on Windows CE...<br><br>
Sorry for my ignorance, I am pretty new on Windows CE.<br><br>Your help is =
so much appreciated. Thank you very much.<br><br>Jonathan.<br><br><br><div =
class=3D"gmail_quote">2009/5/27 dave <span dir=3D"ltr">&lt;<a href=3D"mailt=
o:dev@...575...">dev@...575...</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">





<div>
<div>
<div><span><font color=3D"#0000ff" size=3D"2" face=3D"Arial">That=20
message usually means the binary is hosed, and I believe missing dlls give =
a=20
different message.</font></span></div>
<div><span><font color=3D"#0000ff" size=3D"2" face=3D"Arial">Are=20
you sure Thumb is correct for your platform?=A0 Are you using a consumer=20
device like a pocket pc phone, etc, or is it a custom board?</font></span><=
/div>
<div><span><font color=3D"#0000ff" size=3D"2" face=3D"Arial"></font></span>=
=A0</div>
<div><span><font color=3D"#0000ff" size=3D"2" face=3D"Arial">I ask=20
that because the existing code does use some functionality peculiar to the=
=20
pocket pc (phone) that is not generally available on other platforms, yet t=
he=20
SDKs ofen include the headers and import libs, allowing you to successfully=
=20
compile, but then you can&#39;t run it on the target device.</font></span><=
/div>
<div><span><font color=3D"#0000ff" size=3D"2" face=3D"Arial"></font></span>=
=A0</div>
<div><span><font color=3D"#0000ff" size=3D"2" face=3D"Arial">When=20
you say &#39;client application&#39; are you meaning just the gui, or the w=
hole entire=20
set of programs (i.e., the TAP driver, the openvpn executable, and the=20
gui).</font></span></div>
<div><span><font color=3D"#0000ff" size=3D"2" face=3D"Arial"></font></span>=
=A0</div>
<div><span><font color=3D"#0000ff" size=3D"2" face=3D"Arial">You=20
can use DUMPBIN to find the dlls from the exe, and also inspect the header =
to=20
see the cpu configuration.=A0 Here is a short list, if it=20
helps:</font></span></div>
<div><span><font color=3D"#0000ff" size=3D"2" face=3D"Arial"></font></span>=
=A0</div>
<div><span><font color=3D"#0000ff" size=3D"2" face=3D"Arial">openvpn:</font=
></span></div>
<div><span><font color=3D"#0000ff" size=3D"2" face=3D"Arial">*=A0 coredll.d=
ll</font></span></div>
<div><span><font color=3D"#0000ff" size=3D"2" face=3D"Arial">*=A0 w2s.dll</=
font></span></div>
<div><span><font color=3D"#0000ff" size=3D"2" face=3D"Arial">*=A0 iphlpapi.=
dll</font></span></div>
<div><span><font color=3D"#0000ff" size=3D"2" face=3D"Arial">*=A0 wininet.d=
ll</font></span></div>
<div><span><font color=3D"#0000ff" size=3D"2" face=3D"Arial">*=A0 ole32.dll=
</font></span></div>
<div><span><font color=3D"#0000ff" size=3D"2" face=3D"Arial">*=A0 cellcore.=
dll</font></span></div>
<div><font face=3D"Tahoma"><font size=3D"2"><span><font color=3D"#0000ff" f=
ace=3D"Arial"></font></span></font></font>=A0</div>
<div><font size=3D"+0"><font color=3D"#0000ff" size=3D"2" face=3D"Arial"><s=
pan>tap-ce:</span></font></font></div>
<div><font size=3D"+0"><font color=3D"#0000ff" size=3D"2" face=3D"Arial"><s=
pan>*=A0 ndis.dll</span></font></font></div>
<div><font size=3D"+0"><font color=3D"#0000ff" size=3D"2" face=3D"Arial"><s=
pan>*=A0 coredll.dll</span></font></font></div>
<div><font size=3D"+0"><font color=3D"#0000ff" size=3D"2" face=3D"Arial"><s=
pan></span></font></font>=A0</div>
<div><font size=3D"+0"><font color=3D"#0000ff" size=3D"2" face=3D"Arial"><s=
pan>ovpncmgr:</span></font></font></div>
<div><font size=3D"+0"><font color=3D"#0000ff" size=3D"2" face=3D"Arial"><s=
pan>*=A0 iphlpapi.dll</span></font></font></div>
<div><font size=3D"+0"><font color=3D"#0000ff" size=3D"2" face=3D"Arial"><s=
pan>*=A0 toolhelp.dll</span></font></font></div>
<div><font size=3D"+0"><font color=3D"#0000ff" size=3D"2" face=3D"Arial"><s=
pan>*=A0 cellcore.dll</span></font></font></div>
<div><font size=3D"+0"><font color=3D"#0000ff" size=3D"2" face=3D"Arial"><s=
pan>*=A0 ole32.dll</span></font></font></div>
<div><font size=3D"+0"><font color=3D"#0000ff" size=3D"2" face=3D"Arial"><s=
pan>*=A0 mfcce300.dll</span></font></font></div>
<div><font size=3D"+0"><font color=3D"#0000ff" size=3D"2" face=3D"Arial"><s=
pan>*=A0 coredll.dll</span></font></font></div>
<div><font size=3D"+0"><font color=3D"#0000ff" size=3D"2" face=3D"Arial"><s=
pan>*=A0 winsock.dll</span></font></font></div>
<div><font face=3D"Tahoma"><font color=3D"#0000ff" size=3D"2" face=3D"Arial=
"><span></span></font></font>=A0</div>
<div><font face=3D"Tahoma"><font color=3D"#0000ff" size=3D"2" face=3D"Arial=
"><span>Your build may (will) differ depending on your=20
platform, because your platform builder may have put some of these features=
 in=20
different dlls.=A0 That list was for PocketPC.</span></font></font></div>
<div><font face=3D"Tahoma"><font color=3D"#0000ff" size=3D"2" face=3D"Arial=
"><span></span></font></font>=A0</div>
<div><font face=3D"Tahoma"><font color=3D"#0000ff" size=3D"2" face=3D"Arial=
"><span>Now, the cellcore.dll, you may not have on other=20
platforms.=A0 It is needed for supporting Windows Connectin Manager, and yo=
u=20
can surgically cut out that functionality if your platform doesn&#39;t have=
=20
it.=A0 Most of the rest is fairly standard.</span></font></font></div>
<div><font face=3D"Tahoma"><font color=3D"#0000ff" size=3D"2" face=3D"Arial=
"><span></span></font></font>=A0</div>
<div><font face=3D"Tahoma"><font color=3D"#0000ff" size=3D"2" face=3D"Arial=
"><span>Before doing surgery, you may wish to re-check your=20
assumptions.=A0 Also, if you wish to zip up your problem binaries and send=
=20
them to me directly, I will do a quick inspection for=20
you.</span></font></font></div>
<div><font face=3D"Tahoma"><font color=3D"#0000ff" size=3D"2" face=3D"Arial=
"><span></span></font></font>=A0</div><font color=3D"#888888">
<div><font face=3D"Tahoma"><font color=3D"#0000ff" size=3D"2" face=3D"Arial=
"><span>-dave</span></font></font></div></font></div><div><div></div><div c=
lass=3D"h5">
<blockquote style=3D"border-left: 2px solid rgb(0, 0, 255); padding-left: 5=
px; margin-left: 5px; margin-right: 0px;">
  <div></div>
  <div dir=3D"ltr" align=3D"left" lang=3D"en-us"><font size=3D"2" face=3D"T=
ahoma">-----Original Message-----<br><b>From:</b> jonathan openvpn=20
  [mailto:<a href=3D"mailto:jonathan.openvpn@...277..." target=3D"_blank">j=
onathan.openvpn@...277...</a>] <br><b>Sent:</b> Wednesday, May 27, 2009=20
  5:36 AM<br><b>To:</b> <a href=3D"mailto:openvpn-devel@...1223...=
et" target=3D"_blank">openvpn-devel@lists.sourceforge.net</a><br><b>Subject=
:</b>=20
  [Openvpn-devel] CE port needed DLLs<br><br></font></div>Hello.<br><br>I&#=
39;m=20
  triying to execute a Windows CE 5.0 porting of openvpn client application=
.=20
  I&#39;ve been successful on compiling it but when i try to execute i rece=
ive the=20
  message: &quot;openvpn is not a valid WindowsCE application&quot;.<br><br=
>I am compiling=20
  to ARM-Thumb architecture. I suspect there is a problem with needed=20
  DLLs.<br><br>Could anyone tell me wich DLLs are needed and where could i =
get=20
  them?<br><br>Thank you very much.<br></blockquote></div></div></div>
</blockquote></div><br>

--000e0cd1574431911c046af375cf--

