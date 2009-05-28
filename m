From: "dave" <dev@...575...>
Date: Thu, 28 May 2009 09:57:12 -0500
Message-ID: <CD36606441FC4A1FA4BA09920D4D9032@...576...>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0018_01C9DF7A.AFBA34F0"
In-Reply-To: <2ece24860905280729s28ef4b56p2da1142fced29ed1@...278...>
Subject: Re: [Openvpn-devel] CE port needed DLLs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: 'jonathan openvpn' <jonathan.openvpn@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_0018_01C9DF7A.AFBA34F0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

hahah, yes an x86 binary would indeed cause problems.
cellcore.dll is indeed available on ce5, and ce4.x as well.  Its not
part of the OS, but rather part of the PPC/PPCphone/smartphone platforms
(and you dont' have the source to it from platform builder).
It has to do with functionality intended for phone operations (hence the
name) but it also provides the 'Windows Connection Manager', which is
intended to 'simplify' netwroroking by automatically connecting and
disconnecting stuff.  It causes me much heartache and sorry because it
likes to terminate the network link used fo rthe tunnel when the TAP
gets connected, thinking that TAP is a 'cheaper' connection than the
underlying link.  It doesn't know that TAP is dependent on the
underlying link, so I have to do some hackery to keep the underlying
link open.
 
Regarding 'conventional' networking, this just means making connections
not-through-connection-manager, and doesn't mean you need to do any
special research.  I just made that term up to distinguish from using
connection manager to establish connections.  You can just establish
your wireless link in whatever way is normal, and carry on like you
would in a desktop scenario.
 
Winintet.dll is used for some of the httpproxy support, and you may be
able to conditionally compile that support out to remove that dependency
if you want.
 
You should be on your way.

-----Original Message-----
From: jonathan openvpn [mailto:jonathan.openvpn@...277...] 
Sent: Thursday, May 28, 2009 9:30 AM
To: dave
Cc: openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] CE port needed DLLs


Hi Dave.

This morning I've been able to solve the error and began to debug the
application. There were two reasons for my problem:

 - the wininet.dll file i had was compiled for x86 platform. I've found
a thumb file version in internet. 
 - I have removed the code related to the connection manager (files
openvpn.c and wince_portstuff.c) and the cellcore.lib link reference. 

Also, in internet i have found that cellcore.dll is available in Windows
Mobile and Windows Embedded CE 6.0 but not in Windows CE 5.0
At this point, as you have said, i will need to do networking "in the
more conventional way", in spite of i don't know what it means yet, and
how to do it...

To sum up, my problem was i didn't have the correct platform libraries,
plus a big piece of ignorance...

Can you give me a link or reference to somewhere I could get information
about possibilities to solve my networking needs without the connection
manager?

Thank you very much for your help. It has been very useful. Probably
i'll come back soon with some new questions and doubts. I hope some day
i'll be able to solve someone questions too...

Best regards,

Jonathan.



2009/5/28 dave <dev@...575...>


Sure, you're welcome.  Thumb should not fundamentally be a problem
provided the platform and tools support it, and it sounds like in your
case it does.
 
Your assumptions about what you need are correct, I believe (i.e., you
don't need the gui).  You may want to inspect the code, however, because
there are routines for installing and loading the TAP driver that may be
of interest.  They are in taputil.h,.c
 
cellcore.dll is used to provide the Windows Connection Manager stuff,
and in openvpn.exe this in openvpn.c, around line 203, and around line
284.  I should have conditional-compiled that as an option, but I
didn't.  Similarly the support routines are in wince_portstuff.c at line
1631 through the end, and they can go, too (actually if you remove those
first and compile, the compile should fail and you can find if there was
anything I missed, but that should be it).
 
Generic CE platforms don't use the Windows Connection Manager and do
networking in the more conventional way, so you can probable do without
it, and remove the cellcore.lib from your link step.
 
Assuming your error message really means 'missing dlls' instead of
'invalid binary' then you should be better off.
 
Again, if you want to send me your compiled binary, I can inspect it
more closely if that is useful.
 
-Dave


-----Original Message-----
From: jonathan openvpn [mailto:jonathan.openvpn@...277...] 

Sent: Thursday, May 28, 2009 1:56 AM
To: dave
Cc: openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] CE port needed DLLs


Hello.

First of all, thank you for the quick response.

We have other applications running on the Windows CE distribution and
the linker option "MACHINE" is set to "THUMB".
We are using a custom developed board, and we develop our applications
through Visual Studio 2005.

We only need to stablish a connection to a VPN server without need of a
GUI, all configuration must be transparent to the user. Therefore I
think we only need the openvpn executable and TAP_CE driver. If i'm not
wrong, the ovpncmgr module is to provide a GUI for the openVPN client.
Is that correct?

When no dll is provided, and I try to debug the application from Visual
Studio connected to the device, i get the message: "An error occurred
that usually indicates a corrupt installation (code 0x8007007e). If the
problem persists, repair your Visual Studio installation via 'Add or
Remove Programs' in control Panel"
Some webs refer to that error like some archives are missing. When I put
the dlls you have listed below, the error changes to: "openvpn is not a
valid WindowsCE application". I suspect that some of the dll may not be
correct for my platform. Could it be the source of my problem?

I have not been able to find the cellcore.dll for our platform. Does it
mean we cannot use the connection manager functionality? I have read in
some forums that this functionality is not present on Windows CE...

Sorry for my ignorance, I am pretty new on Windows CE.

Your help is so much appreciated. Thank you very much.

Jonathan.



2009/5/27 dave <dev@...575...>


That message usually means the binary is hosed, and I believe missing
dlls give a different message.
Are you sure Thumb is correct for your platform?  Are you using a
consumer device like a pocket pc phone, etc, or is it a custom board?
 
I ask that because the existing code does use some functionality
peculiar to the pocket pc (phone) that is not generally available on
other platforms, yet the SDKs ofen include the headers and import libs,
allowing you to successfully compile, but then you can't run it on the
target device.
 
When you say 'client application' are you meaning just the gui, or the
whole entire set of programs (i.e., the TAP driver, the openvpn
executable, and the gui).
 
You can use DUMPBIN to find the dlls from the exe, and also inspect the
header to see the cpu configuration.  Here is a short list, if it helps:
 
openvpn:
*  coredll.dll
*  w2s.dll
*  iphlpapi.dll
*  wininet.dll
*  ole32.dll
*  cellcore.dll
 
tap-ce:
*  ndis.dll
*  coredll.dll
 
ovpncmgr:
*  iphlpapi.dll
*  toolhelp.dll
*  cellcore.dll
*  ole32.dll
*  mfcce300.dll
*  coredll.dll
*  winsock.dll
 
Your build may (will) differ depending on your platform, because your
platform builder may have put some of these features in different dlls.
That list was for PocketPC.
 
Now, the cellcore.dll, you may not have on other platforms.  It is
needed for supporting Windows Connectin Manager, and you can surgically
cut out that functionality if your platform doesn't have it.  Most of
the rest is fairly standard.
 
Before doing surgery, you may wish to re-check your assumptions.  Also,
if you wish to zip up your problem binaries and send them to me
directly, I will do a quick inspection for you.
 

-dave

-----Original Message-----
From: jonathan openvpn [mailto:jonathan.openvpn@...277...] 
Sent: Wednesday, May 27, 2009 5:36 AM
To: openvpn-devel@lists.sourceforge.net
Subject: [Openvpn-devel] CE port needed DLLs


Hello.

I'm triying to execute a Windows CE 5.0 porting of openvpn client
application. I've been successful on compiling it but when i try to
execute i receive the message: "openvpn is not a valid WindowsCE
application".

I am compiling to ARM-Thumb architecture. I suspect there is a problem
with needed DLLs.

Could anyone tell me wich DLLs are needed and where could i get them?

Thank you very much.





------=_NextPart_000_0018_01C9DF7A.AFBA34F0
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii">
<TITLE>Message</TITLE>

<META content=3D"MSHTML 6.00.6000.16825" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D399325014-28052009><FONT face=3DArial color=3D#0000ff si=
ze=3D2>hahah,=20
yes an x86 binary would indeed cause problems.</FONT></SPAN></DIV>
<DIV><SPAN class=3D399325014-28052009><FONT face=3DArial color=3D#0000ff=20
size=3D2>cellcore.dll is indeed available on ce5, and ce4.x as well.&nbsp; =
Its not=20
part of the OS, but rather part of the PPC/PPCphone/smartphone platforms (a=
nd=20
you dont' have the source to it from platform builder).</FONT></SPAN></DIV>
<DIV><SPAN class=3D399325014-28052009><FONT face=3DArial color=3D#0000ff si=
ze=3D2>It has=20
to do with functionality intended for phone operations (hence the name) but=
 it=20
also provides the 'Windows Connection Manager', which is intended to 'simpl=
ify'=20
netwroroking by automatically connecting and disconnecting stuff.&nbsp; It=
=20
causes me much heartache and sorry because it likes to terminate the networ=
k=20
link used fo rthe tunnel when the TAP gets connected, thinking that TAP is =
a=20
'cheaper' connection than the underlying link.&nbsp; It doesn't know that T=
AP is=20
dependent on the underlying link, so I have to do some hackery to keep the=
=20
underlying link open.</FONT></SPAN></DIV>
<DIV><SPAN class=3D399325014-28052009><FONT face=3DArial color=3D#0000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D399325014-28052009><FONT face=3DArial color=3D#0000ff=20
size=3D2>Regarding 'conventional' networking, this just means making connec=
tions=20
not-through-connection-manager, and doesn't mean you need to do any special=
=20
research.&nbsp; I just made that term up&nbsp;to distinguish from using=20
connection manager to establish connections.&nbsp; You can just establish y=
our=20
wireless link in whatever way is normal, and carry on like you would in a=20
desktop scenario.</FONT></SPAN></DIV>
<DIV><SPAN class=3D399325014-28052009><FONT face=3DArial color=3D#0000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D399325014-28052009><FONT face=3DArial color=3D#0000ff=20
size=3D2>Winintet.dll is used for some of the httpproxy support, and you ma=
y be=20
able to conditionally compile that support out to remove that dependency if=
 you=20
want.</FONT></SPAN></DIV>
<DIV><SPAN class=3D399325014-28052009><FONT face=3DArial color=3D#0000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D399325014-28052009><FONT face=3DArial color=3D#0000ff si=
ze=3D2>You=20
should be on your way.</FONT></SPAN></DIV>
<BLOCKQUOTE=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px soli=
d; MARGIN-RIGHT: 0px">
  <DIV></DIV>
  <DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft><FO=
NT=20
  face=3DTahoma size=3D2>-----Original Message-----<BR><B>From:</B> jonatha=
n openvpn=20
  [mailto:jonathan.openvpn@...277...] <BR><B>Sent:</B> Thursday, May 28, 20=
09=20
  9:30 AM<BR><B>To:</B> dave<BR><B>Cc:</B>=20
  openvpn-devel@lists.sourceforge.net<BR><B>Subject:</B> Re: [Openvpn-devel=
] CE=20
  port needed DLLs<BR><BR></FONT></DIV>Hi Dave.<BR><BR>This morning I've be=
en=20
  able to solve the error and began to debug the application. There were tw=
o=20
  reasons for my problem:<BR><BR>&nbsp;- the wininet.dll file i had was com=
piled=20
  for x86 platform. I've found a thumb file version in internet. <BR>&nbsp;=
- I=20
  have removed the code related to the connection manager (files openvpn.c =
and=20
  wince_portstuff.c) and the cellcore.lib link reference. <BR><BR>Also, in=
=20
  internet i have found that cellcore.dll is available in Windows Mobile an=
d=20
  Windows Embedded CE 6.0 but not in Windows CE 5.0<BR>At this point, as yo=
u=20
  have said, i will need to do networking "in the more conventional way", i=
n=20
  spite of i don't know what it means yet, and how to do it...<BR><BR>To su=
m up,=20
  my problem was i didn't have the correct platform libraries, plus a big p=
iece=20
  of ignorance...<BR><BR>Can you give me a link or reference to somewhere I=
=20
  could get information about possibilities to solve my networking needs wi=
thout=20
  the connection manager?<BR><BR>Thank you very much for your help. It has =
been=20
  very useful. Probably i'll come back soon with some new questions and dou=
bts.=20
  I hope some day i'll be able to solve someone questions too...<BR><BR>Bes=
t=20
  regards,<BR><BR>Jonathan.<BR><BR><BR>
  <DIV class=3Dgmail_quote>2009/5/28 dave <SPAN dir=3Dltr>&lt;<A=20
  href=3D"mailto:dev@...575...">dev@...575...</A>&gt;</SPAN><BR>
  <BLOCKQUOTE class=3Dgmail_quote=20
  style=3D"PADDING-LEFT: 1ex; MARGIN: 0pt 0pt 0pt 0.8ex; BORDER-LEFT: rgb(2=
04,204,204) 1px solid">
    <DIV>
    <DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN>Sure, you're wel=
come.&nbsp;=20
    Thumb should not fundamentally be a problem provided the platform and t=
ools=20
    support it, and it sounds like in your case it does.</SPAN></FONT></DIV>
    <DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN></SPAN></FONT>&n=
bsp;</DIV>
    <DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN>Your assumptions=
 about what=20
    you need are correct, I believe (i.e., you don't need the gui).&nbsp; Y=
ou=20
    may want to inspect the code, however, because there are routines for=20
    installing and loading the TAP driver that may be of interest.&nbsp; Th=
ey=20
    are in taputil.h,.c</SPAN></FONT></DIV>
    <DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN></SPAN></FONT>&n=
bsp;</DIV>
    <DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN>cellcore.dll is =
used to=20
    provide the Windows Connection Manager stuff, and in openvpn.exe this i=
n=20
    openvpn.c, around line 203, and around line 284.&nbsp; I should have=20
    conditional-compiled that as an option, but&nbsp;I didn't.&nbsp; Simila=
rly=20
    the support routines are in wince_portstuff.c at line 1631 through the =
end,=20
    and they can go, too (actually if you remove those first and compile, t=
he=20
    compile should fail and you can find if there was anything I missed, bu=
t=20
    that should be it).</SPAN></FONT></DIV>
    <DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN></SPAN></FONT>&n=
bsp;</DIV>
    <DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN>Generic CE platf=
orms don't=20
    use the Windows Connection Manager and do networking in the more=20
    conventional way, so you can probable do without it, and remove the=20
    cellcore.lib from your link step.</SPAN></FONT></DIV>
    <DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN></SPAN></FONT>&n=
bsp;</DIV>
    <DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN>Assuming your er=
ror message=20
    really means 'missing dlls' instead of 'invalid binary' then you should=
 be=20
    better off.</SPAN></FONT></DIV>
    <DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN></SPAN></FONT>&n=
bsp;</DIV>
    <DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN>Again, if you wa=
nt to send=20
    me your compiled binary, I can inspect it more closely if that is=20
    useful.</SPAN></FONT></DIV>
    <DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN></SPAN></FONT>&n=
bsp;</DIV>
    <DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN>-Dave</SPAN></FO=
NT></DIV>
    <BLOCKQUOTE=20
    style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: rgb(0,0,255)=
 2px solid; MARGIN-RIGHT: 0px">
      <DIV></DIV>
      <DIV lang=3Den-us dir=3Dltr align=3Dleft><FONT face=3DTahoma size=3D2>
      <DIV class=3Dim>-----Original Message-----<BR><B>From:</B> jonathan o=
penvpn=20
      [mailto:<A href=3D"mailto:jonathan.openvpn@...277..."=20
      target=3D_blank>jonathan.openvpn@...277...</A>] <BR></DIV>
      <DIV>
      <DIV></DIV>
      <DIV class=3Dh5><B>Sent:</B> Thursday, May 28, 2009 1:56 AM<BR><B>To:=
</B>=20
      dave<BR><B>Cc:</B> <A href=3D"mailto:openvpn-devel@...290...=
net"=20
      target=3D_blank>openvpn-devel@lists.sourceforge.net</A><BR><B>Subject=
:</B>=20
      Re: [Openvpn-devel] CE port needed DLLs<BR><BR></DIV></DIV></FONT></D=
IV>
      <DIV>
      <DIV></DIV>
      <DIV class=3Dh5>Hello.<BR><BR>First of all, thank you for the quick=20
      response.<BR><BR>We have other applications running on the Windows CE=
=20
      distribution and the linker option "MACHINE" is set to "THUMB".<BR>We=
 are=20
      using a custom developed board, and we develop our applications throu=
gh=20
      Visual Studio 2005.<BR><BR>We only need to stablish a connection to a=
 VPN=20
      server without need of a GUI, all configuration must be transparent t=
o the=20
      user. Therefore I think we only need the openvpn executable and TAP_C=
E=20
      driver. If i'm not wrong, the ovpncmgr module is to provide a GUI for=
 the=20
      openVPN client. Is that correct?<BR><BR>When no dll is provided, and =
I try=20
      to debug the application from Visual Studio connected to the device, =
i get=20
      the message: "An error occurred that usually indicates a corrupt=20
      installation (code 0x8007007e). If the problem persists, repair your=
=20
      Visual Studio installation via 'Add or Remove Programs' in control=20
      Panel"<BR>Some webs refer to that error like some archives are missin=
g.=20
      When I put the dlls you have listed below, the error changes to: "ope=
nvpn=20
      is not a valid WindowsCE application". I suspect that some of the dll=
 may=20
      not be correct for my platform. Could it be the source of my=20
      problem?<BR><BR>I have not been able to find the cellcore.dll for our=
=20
      platform. Does it mean we cannot use the connection manager functiona=
lity?=20
      I have read in some forums that this functionality is not present on=
=20
      Windows CE...<BR><BR>Sorry for my ignorance, I am pretty new on Windo=
ws=20
      CE.<BR><BR>Your help is so much appreciated. Thank you very=20
      much.<BR><BR>Jonathan.<BR><BR><BR>
      <DIV class=3Dgmail_quote>2009/5/27 dave <SPAN dir=3Dltr>&lt;<A=20
      href=3D"mailto:dev@...575..."=20
      target=3D_blank>dev@...575...</A>&gt;</SPAN><BR>
      <BLOCKQUOTE class=3Dgmail_quote=20
      style=3D"PADDING-LEFT: 1ex; MARGIN: 0pt 0pt 0pt 0.8ex; BORDER-LEFT: r=
gb(204,204,204) 1px solid">
        <DIV>
        <DIV>
        <DIV><SPAN><FONT face=3DArial color=3D#0000ff size=3D2>That message=
 usually=20
        means the binary is hosed, and I believe missing dlls give a differ=
ent=20
        message.</FONT></SPAN></DIV>
        <DIV><SPAN><FONT face=3DArial color=3D#0000ff size=3D2>Are you sure=
 Thumb is=20
        correct for your platform?&nbsp; Are you using a consumer device li=
ke a=20
        pocket pc phone, etc, or is it a custom board?</FONT></SPAN></DIV>
        <DIV><SPAN><FONT face=3DArial color=3D#0000ff=20
        size=3D2></FONT></SPAN>&nbsp;</DIV>
        <DIV><SPAN><FONT face=3DArial color=3D#0000ff size=3D2>I ask that b=
ecause the=20
        existing code does use some functionality peculiar to the pocket pc=
=20
        (phone) that is not generally available on other platforms, yet the=
 SDKs=20
        ofen include the headers and import libs, allowing you to successfu=
lly=20
        compile, but then you can't run it on the target=20
        device.</FONT></SPAN></DIV>
        <DIV><SPAN><FONT face=3DArial color=3D#0000ff=20
        size=3D2></FONT></SPAN>&nbsp;</DIV>
        <DIV><SPAN><FONT face=3DArial color=3D#0000ff size=3D2>When you say=
 'client=20
        application' are you meaning just the gui, or the whole entire set =
of=20
        programs (i.e., the TAP driver, the openvpn executable, and the=20
        gui).</FONT></SPAN></DIV>
        <DIV><SPAN><FONT face=3DArial color=3D#0000ff=20
        size=3D2></FONT></SPAN>&nbsp;</DIV>
        <DIV><SPAN><FONT face=3DArial color=3D#0000ff size=3D2>You can use =
DUMPBIN to=20
        find the dlls from the exe, and also inspect the header to see the =
cpu=20
        configuration.&nbsp; Here is a short list, if it=20
        helps:</FONT></SPAN></DIV>
        <DIV><SPAN><FONT face=3DArial color=3D#0000ff=20
        size=3D2></FONT></SPAN>&nbsp;</DIV>
        <DIV><SPAN><FONT face=3DArial color=3D#0000ff=20
        size=3D2>openvpn:</FONT></SPAN></DIV>
        <DIV><SPAN><FONT face=3DArial color=3D#0000ff size=3D2>*&nbsp;=20
        coredll.dll</FONT></SPAN></DIV>
        <DIV><SPAN><FONT face=3DArial color=3D#0000ff size=3D2>*&nbsp;=20
        w2s.dll</FONT></SPAN></DIV>
        <DIV><SPAN><FONT face=3DArial color=3D#0000ff size=3D2>*&nbsp;=20
        iphlpapi.dll</FONT></SPAN></DIV>
        <DIV><SPAN><FONT face=3DArial color=3D#0000ff size=3D2>*&nbsp;=20
        wininet.dll</FONT></SPAN></DIV>
        <DIV><SPAN><FONT face=3DArial color=3D#0000ff size=3D2>*&nbsp;=20
        ole32.dll</FONT></SPAN></DIV>
        <DIV><SPAN><FONT face=3DArial color=3D#0000ff size=3D2>*&nbsp;=20
        cellcore.dll</FONT></SPAN></DIV>
        <DIV><FONT face=3DTahoma><FONT size=3D2><SPAN><FONT face=3DArial=20
        color=3D#0000ff></FONT></SPAN></FONT></FONT>&nbsp;</DIV>
        <DIV><FONT size=3D+0><FONT face=3DArial color=3D#0000ff=20
        size=3D2><SPAN>tap-ce:</SPAN></FONT></FONT></DIV>
        <DIV><FONT size=3D+0><FONT face=3DArial color=3D#0000ff size=3D2><S=
PAN>*&nbsp;=20
        ndis.dll</SPAN></FONT></FONT></DIV>
        <DIV><FONT size=3D+0><FONT face=3DArial color=3D#0000ff size=3D2><S=
PAN>*&nbsp;=20
        coredll.dll</SPAN></FONT></FONT></DIV>
        <DIV><FONT size=3D+0><FONT face=3DArial color=3D#0000ff=20
        size=3D2><SPAN></SPAN></FONT></FONT>&nbsp;</DIV>
        <DIV><FONT size=3D+0><FONT face=3DArial color=3D#0000ff=20
        size=3D2><SPAN>ovpncmgr:</SPAN></FONT></FONT></DIV>
        <DIV><FONT size=3D+0><FONT face=3DArial color=3D#0000ff size=3D2><S=
PAN>*&nbsp;=20
        iphlpapi.dll</SPAN></FONT></FONT></DIV>
        <DIV><FONT size=3D+0><FONT face=3DArial color=3D#0000ff size=3D2><S=
PAN>*&nbsp;=20
        toolhelp.dll</SPAN></FONT></FONT></DIV>
        <DIV><FONT size=3D+0><FONT face=3DArial color=3D#0000ff size=3D2><S=
PAN>*&nbsp;=20
        cellcore.dll</SPAN></FONT></FONT></DIV>
        <DIV><FONT size=3D+0><FONT face=3DArial color=3D#0000ff size=3D2><S=
PAN>*&nbsp;=20
        ole32.dll</SPAN></FONT></FONT></DIV>
        <DIV><FONT size=3D+0><FONT face=3DArial color=3D#0000ff size=3D2><S=
PAN>*&nbsp;=20
        mfcce300.dll</SPAN></FONT></FONT></DIV>
        <DIV><FONT size=3D+0><FONT face=3DArial color=3D#0000ff size=3D2><S=
PAN>*&nbsp;=20
        coredll.dll</SPAN></FONT></FONT></DIV>
        <DIV><FONT size=3D+0><FONT face=3DArial color=3D#0000ff size=3D2><S=
PAN>*&nbsp;=20
        winsock.dll</SPAN></FONT></FONT></DIV>
        <DIV><FONT face=3DTahoma><FONT face=3DArial color=3D#0000ff=20
        size=3D2><SPAN></SPAN></FONT></FONT>&nbsp;</DIV>
        <DIV><FONT face=3DTahoma><FONT face=3DArial color=3D#0000ff size=3D=
2><SPAN>Your=20
        build may (will) differ depending on your platform, because your=20
        platform builder may have put some of these features in different=20
        dlls.&nbsp; That list was for PocketPC.</SPAN></FONT></FONT></DIV>
        <DIV><FONT face=3DTahoma><FONT face=3DArial color=3D#0000ff=20
        size=3D2><SPAN></SPAN></FONT></FONT>&nbsp;</DIV>
        <DIV><FONT face=3DTahoma><FONT face=3DArial color=3D#0000ff size=3D=
2><SPAN>Now,=20
        the cellcore.dll, you may not have on other platforms.&nbsp; It is=
=20
        needed for supporting Windows Connectin Manager, and you can surgic=
ally=20
        cut out that functionality if your platform doesn't have it.&nbsp; =
Most=20
        of the rest is fairly standard.</SPAN></FONT></FONT></DIV>
        <DIV><FONT face=3DTahoma><FONT face=3DArial color=3D#0000ff=20
        size=3D2><SPAN></SPAN></FONT></FONT>&nbsp;</DIV>
        <DIV><FONT face=3DTahoma><FONT face=3DArial color=3D#0000ff=20
        size=3D2><SPAN>Before doing surgery, you may wish to re-check your=
=20
        assumptions.&nbsp; Also, if you wish to zip up your problem binarie=
s and=20
        send them to me directly, I will do a quick inspection for=20
        you.</SPAN></FONT></FONT></DIV>
        <DIV><FONT face=3DTahoma><FONT face=3DArial color=3D#0000ff=20
        size=3D2><SPAN></SPAN></FONT></FONT>&nbsp;</DIV><FONT color=3D#8888=
88>
        <DIV><FONT face=3DTahoma><FONT face=3DArial color=3D#0000ff=20
        size=3D2><SPAN>-dave</SPAN></FONT></FONT></DIV></FONT></DIV>
        <DIV>
        <DIV></DIV>
        <DIV>
        <BLOCKQUOTE=20
        style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: rgb(0,0,=
255) 2px solid; MARGIN-RIGHT: 0px">
          <DIV></DIV>
          <DIV lang=3Den-us dir=3Dltr align=3Dleft><FONT face=3DTahoma=20
          size=3D2>-----Original Message-----<BR><B>From:</B> jonathan open=
vpn=20
          [mailto:<A href=3D"mailto:jonathan.openvpn@...277..."=20
          target=3D_blank>jonathan.openvpn@...277...</A>] <BR><B>Sent:</B>=
=20
          Wednesday, May 27, 2009 5:36 AM<BR><B>To:</B> <A=20
          href=3D"mailto:openvpn-devel@lists.sourceforge.net"=20
          target=3D_blank>openvpn-devel@lists.sourceforge.net</A><BR><B>Sub=
ject:</B>=20
          [Openvpn-devel] CE port needed=20
          DLLs<BR><BR></FONT></DIV>Hello.<BR><BR>I'm triying to execute a=20
          Windows CE 5.0 porting of openvpn client application. I've been=20
          successful on compiling it but when i try to execute i receive th=
e=20
          message: "openvpn is not a valid WindowsCE application".<BR><BR>I=
 am=20
          compiling to ARM-Thumb architecture. I suspect there is a problem=
 with=20
          needed DLLs.<BR><BR>Could anyone tell me wich DLLs are needed and=
=20
          where could i get them?<BR><BR>Thank you very=20
        much.<BR></BLOCKQUOTE></DIV></DIV></DIV></BLOCKQUOTE></DIV><BR></DI=
V></DIV></BLOCKQUOTE></DIV></BLOCKQUOTE></DIV><BR></BLOCKQUOTE></BODY></HTM=
L>

------=_NextPart_000_0018_01C9DF7A.AFBA34F0--


