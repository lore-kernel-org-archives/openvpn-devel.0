From: "Dave" <dev@...575...>
Subject: RE: [Openvpn-devel] OpenVPN for PocketPC
Message-ID: <000001c651c9$5e17eb20$1601a8c0@...576...>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0001_01C65197.137D7B20"
In-Reply-To: <20060327165648.99695.qmail@...593...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Mon Mar 27 11:08:04 2006
To: 'Iftikhar Qureshi' <iftikharqureshi@...109...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_0001_01C65197.137D7B20
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Forgot completely about the rtti lib.  Sorry about that.  Strictly it's not
needed I don't think, but I have a tendency to use exceptions so I usually
put it in without thinking about it.
=20
The installation of the driver works like this:
=20
*  Stick it in \Windows
This is the conventional location for such files.  CE doesn't have a
configurable 'PATH' per se, but that directory is implictly used for module
lookup.
*  Create the required NDIS keys.  You can do that with the TapTester via
the button labelled 'SetupNDISKeys', and you just have to do it once.
Eventually, when everything is working, I intend to make a .cab installer
which will do the registry setup.
=20
That the basic installation and will make available a device called TAP1:
which is the tap driver.  The driver will automatically be loaded upon
bootup via soft reset.  Also, you can cause it to be loaded immediately
(without soft reset) with the TAP tester button labelled 'RegisterAdapter'
=20
=20
How to remove:
=20
*  mostly for dev, you can unload the driver immediately via the TapTester
button labelled 'DeregisterAdapter'.  This is  useful for dev/testing
because you can't install a newly built driver if one is already loaded.
*  more important:  since the system will load the driver automatically when
you soft reset, it is important to use the 'DeleteNDISKeys' button if you
don't want that to happen.  When the keys are deleted, then the system will
not know about the driver and not load it.
=20
=20
Quick check that it is loaded:
=20
1)  There is a button labelled 'SqooshIt' (sorry for the silly name), that
will list all loaded NDIS adapters, you will see the TAP driver if it is
loaded.
2)  You can drill down through the standard network settings and you will
see an adapter named:
'TAP1: Virtual Ethernet Device' listed along with all the other adapters on
your device.  I can't tell you how to get there because they move this
around, but on my PPC2003 device, it can be accessed from the network icon
at the top of the screen:  settings, advanced, network card, network
adapters; and then there is a listbox with the names in it.
=20
=20
This should be a drop kick, but I am interested if there is any lock-down
for unsigned drivers on PPC-Phone Edition which is what your PPC-6700 is
running I think.  I'm interested in SmartPhone, too, but I don't know anyone
with one of those devices to try it out on.  Maybe you have a friend?
=20
=20
Notes on current status:
=20
1  currently, I have hacked forward.c to have the following commented out
around line 1215:
  if (flags & IOW_WAIT_SIGNAL)
    wait_signal (c->c2.event_set, (void*)&err_shift);

the consequence is that you don't have a means (like ctrl-c) to stop the
openvpn app.  I have to do this for the moment until I can figure out
either: a way to get a real event handle for the console, or a different
mechanism altogether to provide the signals thus emulated.  So you can
terminate it from the control panel, or if you use something like 'magic
button' the X button will really close the app (instead of 'smart minimize',
which really just hides it behind the desktop).
=20
2  You must not use the 'nobind' option in the client config.
=20
3  I haven't figured out why my dhcp is not configuring correctly, however I
have had luck with the 'ip-win32 ipapi' 'ifconfig l rp' options.
=20
4  I am a configuration newby to openvpn, and I know my test setup is not
correctly configured.  I am using a windows client as my control during
experiments.  It's not working correctly either, so I know I have something
wrong -- don't know what yet.
=20
FWIW, my client config contains:
=20
#begin
client
=20
dev tap
dev-node TAP1:
=20
proto udp
=20
remote 192.168.1.10 1194
#don't like this but work-around until I fix/emulate nobind
local 192.168.1.129
=20
#dhcp not working for some reason, this gets past that
ip-win32 ipapi
#interestingly, I still get a 10.8.0.51 address on the TAP, which is from
the DHCP pool!  curious....
ifconfig 10.8.0.40 255.255.255.0

#openssl stuff
ca "\\ca.crt"
cert "\\ipaq4150.crt"
key "\\ipaq4150.key"
=20
comp-lzo
=20
verb 5
#end
=20
though don't take this as a reccomendation, just as a reference point as to
where I am now.
=20
=20
FWIW:  you may wish to download nettools_arm_setup.exe from somewhere which
will give you the usual network tools like route, ipconfig, netstat, et al.
=20
-Dave
=20
=20

-----Original Message-----
From: openvpn-devel-admin@lists.sourceforge.net
[mailto:openvpn-devel-admin@lists.sourceforge.net] On Behalf Of Iftikhar
Qureshi
Sent: Monday, March 27, 2006 10:57 AM
To: Dave
Cc: openvpn-devel@lists.sourceforge.net
Subject: RE: [Openvpn-devel] OpenVPN for PocketPC


Dave,

I got updated code and built TAPTester successfully. I had to get RITTI
package for Ccrtrtti.lib.

What is the recommended way of installing tap-ce.dll? ...I just copied it in
the same folder as the TAPTester application which worked.

Salamz,
-IQ

Dave <dev@...575...> wrote:=20

...
Iftikhar: I updated the source and also I fixed the problem I mentioned
previously about the driver not handling the power-off state correctly; you
can power on and off to heart's content.

-Dave



------=_NextPart_000_0001_01C65197.137D7B20
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii">
<TITLE>Message</TITLE>

<META content=3D"MSHTML 6.00.2900.2802" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>Forgot completely about the rtti lib.&nbsp; Sorry about that.&nbsp=
;=20
Strictly it's not needed I don't think, but I have a tendency to use except=
ions=20
so I usually put it in without thinking about it.</FONT></SPAN></DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>The installation of the driver works like this:</FONT></SPAN></DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>*&nbsp; Stick it in \Windows</FONT></SPAN></DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>This is the&nbsp;conventional location for such files.&nbsp; CE do=
esn't=20
have a configurable 'PATH' per se, but that directory is implictly used for=
=20
module lookup.</FONT></SPAN></DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>*&nbsp; Create the required NDIS keys.&nbsp; You can do that with =
the=20
TapTester via the button labelled 'SetupNDISKeys', and you just have to do =
it=20
once.&nbsp; Eventually, when everything is working, I intend to make a .cab=
=20
installer which will do the registry setup.</FONT></SPAN></DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>That the basic installation and will make available a device calle=
d TAP1:=20
which is the tap driver.&nbsp; The driver will automatically be loaded upon=
=20
bootup via soft reset.&nbsp; Also, you can cause it to be loaded immediatel=
y=20
(without soft reset) with the TAP tester button labelled=20
'RegisterAdapter'</FONT></SPAN></DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>How to remove:</FONT></SPAN></DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>*&nbsp; mostly for dev, you can unload the driver immediately via =
the=20
TapTester button labelled 'DeregisterAdapter'.&nbsp; This is&nbsp; useful f=
or=20
dev/testing because you can't install a newly built driver if one is alread=
y=20
loaded.</FONT></SPAN></DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>*&nbsp; more important:&nbsp; since the system will load the drive=
r=20
automatically when you soft reset, it is important to use the 'DeleteNDISKe=
ys'=20
button if you don't want that to happen.&nbsp; When the keys are deleted, t=
hen=20
the system will not know about the driver and not load it.</FONT></SPAN></D=
IV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>Quick check that it is loaded:</FONT></SPAN></DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>1)&nbsp; There is a button labelled 'SqooshIt' (sorry for the sill=
y=20
name), that will list all loaded NDIS adapters, you will see the TAP driver=
 if=20
it is loaded.</FONT></SPAN></DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>2)&nbsp; You can drill down through the standard network settings =
and you=20
will see an adapter named:</FONT></SPAN></DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>'TAP1: Virtual Ethernet Device' listed along with all the other ad=
apters=20
on your device.&nbsp; I can't tell you how to get there because they move t=
his=20
around, but on my PPC2003 device, it can be accessed from the network icon =
at=20
the top of the screen: &nbsp;settings, advanced, network card, network adap=
ters;=20
and then there is a listbox with the names in it.</FONT></SPAN></DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>This should be a drop kick, but I am interested if there is any lo=
ck-down=20
for unsigned drivers on PPC-Phone Edition which is what your PPC-6700 is ru=
nning=20
I think.&nbsp; I'm interested in SmartPhone, too, but I don't know anyone w=
ith=20
one of those devices to try it out on.&nbsp; Maybe you have a=20
friend?</FONT></SPAN></DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>Notes on current status:</FONT></SPAN></DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>1&nbsp; currently, I have hacked forward.c to have the following=20
commented out around line 1215:</FONT></SPAN></DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>&nbsp; if (flags &amp; IOW_WAIT_SIGNAL)<BR>&nbsp;&nbsp;&nbsp; wait=
_signal=20
(c-&gt;c2.event_set, (void*)&amp;err_shift);<BR></FONT></SPAN></DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>the consequence is that you don't have a means (like ctrl-c) to st=
op the=20
openvpn app.&nbsp; I have to do this for the moment until I can figure out=
=20
either: a way to get a real event handle for the console, or a different=20
mechanism altogether to provide the signals thus emulated.&nbsp; So you can=
=20
terminate it from the control panel, or if you use something like 'magic bu=
tton'=20
the X button will really close the app (instead of 'smart minimize', which=
=20
really just hides it behind the desktop).</FONT></SPAN></DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>2&nbsp; You must not use the 'nobind' option in the client=20
config.</FONT></SPAN></DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>3&nbsp; I haven't figured out why my dhcp is not configuring corre=
ctly,=20
however I have had luck with </FONT></SPAN><SPAN class=3D789513517-27032006=
><FONT=20
face=3D"Courier New" color=3D#0000ff size=3D2>the 'ip-win32 ipapi' </FONT><=
/SPAN><SPAN=20
class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0000ff size=
=3D2>'ifconfig=20
l rp' options.</FONT></SPAN></DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>4&nbsp; I am a configuration newby to openvpn, and I know my test =
setup=20
is not correctly configured.&nbsp; I am using a windows client as my contro=
l=20
during experiments.&nbsp; It's not working correctly either, so I know I ha=
ve=20
something wrong -- don't know what yet.</FONT></SPAN></DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>FWIW, my client config contains:</FONT></SPAN></DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>#begin</FONT></SPAN></DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>client</FONT></SPAN></DIV>
<DIV><FONT face=3D"Courier New" color=3D#0000ff size=3D2></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>dev tap<BR>dev-node TAP1:</FONT></SPAN></DIV>
<DIV><FONT face=3D"Courier New" color=3D#0000ff size=3D2></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>proto udp</FONT></SPAN></DIV>
<DIV><FONT face=3D"Courier New" color=3D#0000ff size=3D2></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>remote 192.168.1.10 1194</FONT></SPAN></DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>#don't like this but work-around until I fix/emulate nobind<BR>loc=
al=20
192.168.1.129</FONT></SPAN></DIV>
<DIV><FONT face=3D"Courier New" color=3D#0000ff size=3D2></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>#dhcp not working for some reason, this gets past=20
that</FONT></SPAN></DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>ip-win32 ipapi</FONT></SPAN></DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>#interestingly, I still get a 10.8.0.51 address on the TAP, which =
is from=20
the DHCP pool!&nbsp; curious....</FONT></SPAN></DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>ifconfig 10.8.0.40 255.255.255.0<BR></FONT></SPAN></DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>#openssl stuff</DIV></FONT></SPAN><FONT face=3D"Courier New" color=
=3D#0000ff=20
size=3D2></FONT>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>ca "<A href=3D"file://\\ca.crt">\\ca.crt</A>"<BR>cert "<A=20
href=3D"file://\\ipaq4150.crt">\\ipaq4150.crt</A>"<BR>key "<A=20
href=3D"file://\\ipaq4150.key">\\ipaq4150.key</A>"</FONT></SPAN></DIV>
<DIV><FONT face=3D"Courier New" color=3D#0000ff size=3D2></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>comp-lzo</FONT></SPAN></DIV>
<DIV><FONT face=3D"Courier New" color=3D#0000ff size=3D2></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>verb 5<BR>#end</DIV></FONT></SPAN>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>though don't take this as a reccomendation, just as a reference po=
int as=20
to where I am now.</FONT></SPAN></DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>FWIW:&nbsp; you may wish to download nettools_arm_setup.exe from=20
somewhere which will give you the usual network tools like route, ipconfig,=
=20
netstat, et al.</FONT></SPAN></DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>-Dave</FONT></SPAN></DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D789513517-27032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<BLOCKQUOTE=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px soli=
d; MARGIN-RIGHT: 0px">
  <DIV></DIV>
  <DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft><FO=
NT=20
  face=3DTahoma size=3D2>-----Original Message-----<BR><B>From:</B>=20
  openvpn-devel-admin@lists.sourceforge.net=20
  [mailto:openvpn-devel-admin@lists.sourceforge.net] <B>On Behalf Of=20
  </B>Iftikhar Qureshi<BR><B>Sent:</B> Monday, March 27, 2006 10:57=20
  AM<BR><B>To:</B> Dave<BR><B>Cc:</B>=20
  openvpn-devel@lists.sourceforge.net<BR><B>Subject:</B> RE: [Openvpn-devel=
]=20
  OpenVPN for PocketPC<BR><BR></FONT></DIV>Dave,<BR><BR>I got updated code =
and=20
  built TAPTester successfully. I had to get RITTI package for=20
  Ccrtrtti.lib.<BR><BR>What is the recommended way of installing tap-ce.dll=
?=20
  ...I just copied it in the same folder as the TAPTester application which=
=20
  worked.<BR><BR>Salamz,<BR>-IQ<BR><BR><B><I>Dave=20
  &lt;dev@...575...&gt;</I></B> wrote:
  <BLOCKQUOTE class=3Dreplbq=20
  style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: rgb(16,16,255)=
 2px solid">...<BR>Iftikhar:=20
    I updated the source and also I fixed the problem I mentioned<BR>previo=
usly=20
    about the driver not handling the power-off state correctly; you<BR>can=
=20
    power on and off to heart's=20
content.<BR><BR>-Dave</BLOCKQUOTE><BR></BLOCKQUOTE></BODY></HTML>

------=_NextPart_000_0001_01C65197.137D7B20--


