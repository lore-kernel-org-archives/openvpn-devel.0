From: "Dave" <dev@...575...>
Subject: RE: [Openvpn-devel] OpenVPN for PocketPC
Message-ID: <000d01c651e6$80e420c0$1601a8c0@...576...>
MIME-Version: 1.0
In-Reply-To: <44282E12.6050109@...41...>
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
Date: Mon Mar 27 13:37:10 2006
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: 'James Yonan' <jim@...41...>
Cc: 'Iftikhar Qureshi' <iftikharqureshi@...109...>, openvpn-devel@lists.sourceforge.net

> -----Original Message-----
> From: James Yonan [mailto:jim@...41...]=20

...

> > etc.  I believe the object spaces have been unified, and I know you=20
> > can take a socket and pass it to, say WaitForSingleObject=20
> and have it=20
> > work.
> They sort of did that with WSAEventSelect -- if there was a way that=20
> WSAEventSelect could be used on the TAP device handle (as well as the=20
> network socket), then that would be another route towards moving away=20
> from overlapped I/O.

Upon thinking about your suggestion, I think there are some problems:

*  SOCKETs that go to select() can be signalled in three different ways:
read data available, ready to accept writes, and error (more for
WSAEventSelect).  Windows handles are either signalled or non-signalled, so
there isn't that breakdown.  I think this is internal architecture to
Winsock and I don't know if it could be replicated into other systems.  An
interesting research project, though.

I also noticed that sockets are not handles in CE, so the likelihood of
select ever accepting HANDLEs directly is slim to none.  There might be some
funky wrapper that could be made, though again there would be research to do
on that.

> > the existing event architecture as-is, and I just had to make some=20
> > specialized versions of tun_finalize, queue_read, open, close, etc.
> How did you deal with getting socket.c off of overlapped I/O=20
> (or did you=20
> figure out a way that PocketPC can do overlapped I/O?).

The latter, mostly.  It was a happy confluence of events that:
*  Winsock implementations are required to support overlapped IO, at least
through the WSA- functions,
*  you happily were already using the WSA- functions for the waits and get
results,
*  the WSAEvent in CE is really a native event, and the WSAOVERLAPPED is
defined the same as OVERLAPPED

So it all fell into place.  I had to modify tun to call my emulated
overlapped io api, but this wound up being fairly a fairly surgical (i.e.
not gross) change.

> > I didn't bother
> > doing the same with writes since they always completed immediately=20
> > anyway once handing off to NDIS.
> I would worry about assuming this unless the API guarantees it.  I've=20
> seen a few cases in the overall development of OpenVPN where assuming=20
> that writes always complete immediately (even when totally=20
> supported by=20
> observed behavior) introduced subtle bugs.

I'm curious if you can expound.  Subtlety is not a virtue in bugs!  I was
going by my interpretation of the existing driver code.  It seemed to me it
went like:

1)  IRP_MJ_CREATE comes in
2)  packet is handed off to NDIS via NdisMEthIndicateReceive and finished
via NdisMEthIndicateReceiveComplete
3)  the IoCompleteRequest() finished the IRP under all code paths
immediately

So it seemed that really it was always completing immediately.  And even if
it wasn't, since the next time usermode queues a write it waits for the
first to complete (via finalize) so it didn't seem to be a big loss to leave
that call synchronous.  NDIS sends the packet up the stack asynchronously
already.

> It's probably not essential to support control-c/keyboard=20
> signaling --=20
> this feature is used mostly by developers who run OpenVPN in console=20
> mode.  Real-world usage of OpenVPN usually involves running=20

Ah!  So I'm the only one to bear the burden!  Well, good to know that -- I
hadn't delved that far into the openvpn architecture.  Actually, the
management interface sounds like it will make the future task of packaging
up a PPC-relevant UI much more easy than I expected, so that's good news
indeed.

> The driver has quite a bit of instrumentation code to help debug/test=20
> the DHCP handshake.

Yes, now I must figure out how to interpret it.  Care to take a look at the
output from the driver and/or openvpn?  You might can tell me immediately
what it means where it might take me days to figure it out.  I'll stick an
excerpt at the bottom of this message.

> Nobind is quite an important option, so I'm surprised that CE=20
> wouldn't=20
> support it.  If it's really not supported on UDP sockets, it might be=20
> possible to simulate nobind by binding to a dynamic port number (from=20
> 49152 through 65535) and if the bind fails, retry the next=20
> higher value.

What clued me in was the docs for WSARecv which explicitly stated that the
socket must be bound, so I suppose that technically it shouldn't work on NT
either, but just does as a 'gift'.  Again, I should be able to emulate the
behavior somewhat by binding a port of 0, though for some reason this
chooses between 1024 and 5000, as opposed to the high ones.  The
try-and-repeat you suggest should also work.


> > Iftikhar:  I updated the source and also I fixed the problem I=20
> > mentioned previously about the driver not handling the=20
> power-off state=20
> > correctly; you can power on and off to heart's content.
> >=20=20=20
> Is this fix relevant to the 2000/XP version of the driver as=20
> well?  If=20
> so, would you mind posting a patch that only addresses this fix?

It's not relevant.  The stream driver part for CE has some additional power
management stuff.  My doing debug file io at that time is apparently uncool.
I removed that and all worked again.  The NDIS power management behaves fine
as-is.


> Okay, a couple questions for you:
>=20
> The 2000/XP version of the driver uses the OemWin2k.inf file and=20
> tapinstall.exe (basically a clone of devcon.exe from the DDK)=20
> to install=20
> and configure the TAP device nodes.  What is the PocketPC way=20
> of doing this?

Pretty easy:  registry keys are set up.  If one wishes you can then load the
driver immediately with an ioctl you send to NDIS, or you can soft-reset
(sortof like 'restart windows') and it will be loaded automatically.

For testing, I made a little app that adds/removes the keys and
loads/unloads the driver.  In a release situation this can be handled in the
CAB file, and/or little app like the tapinstall.exe you mention.

> 2000/XP provides the netsh utility for programmatically configuring=20
> network devices.  Does PocketPC have any equivalent utility/API?

Yes and no.  I'm not familiar with netsh, but understand it to have been
created because it is fancier than the sundry other tools and more amenable
to scripting.  There is not an equivalent to this for CE.  Now, the stuff
like ping, route, ipconfig, etc., do exist.  They don't ship with PPC
because it doesn't have a console out-of-box anyway.  They are findable on
the internet and I have a set which I am using now.  Actually I think
Microsoft releases the source available -- they're pretty much all a UI to
the IpHelper functions.  Which, since you already have those calls in
openvpn, it might obviate the necessity for an end user to worry about them.

-Dave


PS Oh, regarding output from my DHCP, this is what my windows box says
during the last phase of negotiation:

Sun Mar 26 17:36:30 2006 us=3D885461 TAP-WIN32 device [OpenVPN] opened:
\\.\Global\{0B8E84A0-84E7-46DB-BEE7-C4B0166791E9}.tap
Sun Mar 26 17:36:30 2006 us=3D885495 TAP-Win32 Driver Version 8.1=20
Sun Mar 26 17:36:30 2006 us=3D885512 TAP-Win32 MTU=3D1500
Sun Mar 26 17:36:30 2006 us=3D885537 Notified TAP-Win32 driver to set a DHCP
IP/netmask of 10.8.0.50/255.255.255.0 on interface
{0B8E84A0-84E7-46DB-BEE7-C4B0166791E9} [DHCP-serv: 10.8.0.0, lease-time:
31536000]
Sun Mar 26 17:36:30 2006 us=3D892848 Successful ARP Flush on interface [5]
{0B8E84A0-84E7-46DB-BEE7-C4B0166791E9}
Sun Mar 26 17:36:30 2006 us=3D901492 TEST ROUTES: 0/0 succeeded len=3D-1 re=
t=3D0
a=3D0 u/d=3Ddown
Sun Mar 26 17:36:30 2006 us=3D901537 Route: Waiting for TUN/TAP interface to
come up...
Sun Mar 26 17:36:32 2006 us=3D65631 TEST ROUTES: 0/0 succeeded len=3D-1 ret=
=3D0
a=3D0 u/d=3Ddown
Sun Mar 26 17:36:32 2006 us=3D65678 Route: Waiting for TUN/TAP interface to
come up...
Sun Mar 26 17:36:33 2006 us=3D434239 TEST ROUTES: 0/0 succeeded len=3D-1 re=
t=3D1
a=3D0 u/d=3Dup
Sun Mar 26 17:36:33 2006 us=3D434277 Initialization Sequence Completed


And this is what the similar section on the pocket pc says:

Mon Mar 27 08:56:29 2006 us=3D47349 TAP-WIN32 device [TAP1:] opened: TAP1:
Mon Mar 27 08:56:29 2006 us=3D48315 TAP-Win32 Driver Version 8.1 (DEBUG)
Mon Mar 27 08:56:29 2006 us=3D48978 TAP-Win32 MTU=3D1500
Mon Mar 27 08:56:29 2006 us=3D49755 Notified TAP-Win32 driver to set a DHCP
IP/netmask of 10.8.0.51/255.255.255.0 on interface TAP1: [DHCP-serv:
10.8.0.0, lease-time: 31536000]
Mon Mar 27 08:56:29 2006 us=3D51431 Successful ARP Flush on interface [1310=
74]
TAP DEVICE 1
Mon Mar 27 08:56:29 2006 us=3D84761 TEST ROUTES: 0/0 succeeded len=3D-1 ret=
=3D0
a=3D0 u/d=3Ddown
Mon Mar 27 08:56:29 2006 us=3D85677 Route: Waiting for TUN/TAP interface to
come up...
(...12 times...)
Mon Mar 27 08:56:58 2006 us=3D389816 Initialization Sequence Completed With
Errors ( see http://openvpn.net/faq.html#dhcpclientserv )


During that activity the driver is spewing out the following debug:


[TAP DEVICE 1] Unhandled OID ffffff
[TAP DEVICE 1] Unhandled OID 20214
[TAP DEVICE 1] Unhandled OID 20215
[TAP DEVICE 1] Unhandled OID 20215
TAP_Open; dwData =3D 0x00036110, dwAccess =3D 0xc0000000, dwShareMode =3D
0x00000000; inst =3D 0x00036110
[TAP DEVICE 1] [TAP] release [8.1] open request (m_TapOpens=3D0)
AdapterTransmit ??? src=3D0:ff:2d:4b:be:28 dest=3D33:33:ff:4b:be:28 proto=
=3D0x86dd
len=3D86
AdapterTransmit ??? src=3D0:ff:2d:4b:be:28 dest=3D33:33:0:0:0:2 proto=3D0x8=
6dd
len=3D62
AdapterTransmit ??? src=3D0:ff:2d:4b:be:28 dest=3D33:33:ff:4b:be:28 proto=
=3D0x86dd
len=3D78
AdapterTransmit ??? src=3D0:ff:2d:4b:be:28 dest=3D33:33:0:0:0:2 proto=3D0x8=
6dd
len=3D70
AdapterTransmit ??? src=3D0:ff:2d:4b:be:28 dest=3D33:33:ff:4b:be:28 proto=
=3D0x86dd
len=3D86
AdapterTransmit ??? src=3D0:ff:2d:4b:be:28 dest=3D33:33:0:0:0:2 proto=3D0x8=
6dd
len=3D70
AdapterTransmit IPv4 UDP[342] BOOTREQUEST DHCPDISCOVER
0.0.0.0:BOOTPC[0:ff:2d:4b:be:28] ->
255.255.255.255:BOOTPS[ff:ff:ff:ff:ff:ff] ch=3D0:ff:2d:4b:be:28 xid=3D0x000=
00ae9
ma=3D0x00000383 id=3D0x4451 ttl=3D128 ic=3D0xf554 [0x0000] uc=3D0x75e6 [0x0=
000/60]
OPT.53.1.1.61.7.1.0.255.45.75.190.40.55.7.1.3.6.15.44.46.47.255.0.0.0.0.0.0.
0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0
DHCPMsg IPv4 UDP[304] BOOTREPLY DHCPOFFER 10.8.0.0:BOOTPS[0:ff:2f:4b:be:28]
-> 255.255.255.255:BOOTPC[ff:ff:ff:ff:ff:ff] yi=3D10.8.0.51 si=3D10.8.0.0
ch=3D0:ff:2d:4b:be:28 xid=3D0x00000ae9 ma=3D0x00000300 ttl=3D16 ic=3D0x9fc4=
 [0x0000]
uc=3D0x311e [0x0000/22]
OPT.53.1.2.54.4.10.8.0.0.51.4.49.0.0.0.1.4.255.255.255.0.255

With the last pair repeated 12 times.

In the short term I modified the client config to use:

ifconfig 10.8.0.40 255.255.255.0
ip-win32 ipapi=20

Which gets me further but I don't really know what I'm doing, I'm just
hacking around.  When those configs are used, I then get the address of
10.8.0.51.  Hmmm.  Shouldn't I have gotten .40?  The .51 what what I
originally was going to be assigned from DHCP!



