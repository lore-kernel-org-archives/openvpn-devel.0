From: "Dave" <dev@...575...>
Subject: RE: [Openvpn-devel] OpenVPN for PocketPC
Message-ID: <000001c65146$e4da2520$1601a8c0@...576...>
MIME-Version: 1.0
In-Reply-To: <44270158.8050206@...41...>
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
Date: Sun Mar 26 18:35:01 2006
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: 'James Yonan' <jim@...41...>
Cc: 'Iftikhar Qureshi' <iftikharqureshi@...109...>, openvpn-devel@lists.sourceforge.net

> -----Original Message-----
> From: James Yonan [mailto:jim@...41...]=20
> Sent: Sunday, March 26, 2006 3:02 PM
> To: Dave
> Cc: 'Iftikhar Qureshi'; openvpn-devel@lists.sourceforge.net
> Subject: Re: [Openvpn-devel] OpenVPN for PocketPC
>=20
>=20
> >
> > *  I discovered yesterday that in the particular case of=20
> winsock, that=20
> > overlapped io support is required, and (supposedly) has been=20
> > implemented in CE and is available via the WSA versions of those=20
> > methods (e.g. WSAGetOverlappedResult).  This is really good news=20
> > because it possibly means that all the socket.c work will=20
> not have to=20
> > be reworked at all.  Hopefully!
> >
> > So I think that only the five various tun_* and *_tun=20
> methods need to=20
> > be implemented to declare this 'feature complete' and then the=20
> > exciting phase of testing/fixing begins.
> >
> >=20=20=20
> The Windows version of OpenVPN currently wants overlapped I/O to be=20
> supported by the OS.  The reason why overlapped I/O was=20
> originally used=20
> (rather than unix-style select or poll) is so that the event=20
> loop could=20
> treat TAP device events the same as network socket events, and handle=20
> network and TAP events within a single event loop.
>=20
> The root of the problem is that Windows supports two incompatible (as=20
> far as I know)  I/O wait event spaces:  there is the SOCKET=20
> type which=20
> can be used as an argument to select() and then there's the HANDLE=20
> (returned by CreateEvent) which is used as an argument to=20
> WaitForSingleObject/WaitForMultipleObjects.  Currently the Windows=20
> version of OpenVPN uses the HANDLE space which unfortunately=20
> makes the=20
> I/O code more complex than would be the case under unix.
>=20
> However if we could figure out a way to allow select() to poll on the=20
> TAP device handle as well as network sockets, then we could=20
> do away with=20
> Windows overlapped I/O -- that would move us into the SOCKET=20
> event space=20
> which is much more reasonable to deal with, and compatible with unix=20
> event I/O semantics (such as select()).
>=20
> James
=20
It's an interesting idea and worth some thought.  The object spaces were
separate for historical reasons (winsock came out when 16-bit was still
quite alive) and hence the duplicated WSAOVERLAPPED, WSAEVENT, etc.  I
believe the object spaces have been unified, and I know you can take a
socket and pass it to, say WaitForSingleObject and have it work.  Perhaps
the converse is true (take a file handle and pass it to select(), or at
least WSASelect()).  This assuming that winsock doesn't strap-on some
private magic to it's socket handles that would be a problem for non-magical
'other' handles.  Also, the driver would have to be coded to signal the
handle appropriately.  I think this is doable in NT, however I'm pretty sure
it would be a challenge for CE because you don't have access to your handle
(so what would one signal).

Agreed it would be tidier to have all the platforms use the simpler select()
mechanism.

Ultimately, yesterday I gave up the ghost on trying to rework the tap
usermode stuff to work in a polling manner, and wound up implementing the
equivalent of overlapped IO using a custom DeviceIoControl() for the
overlapped Read() and for the CancelIo().  This let me reuse all the
existing event architecture as-is, and I just had to make some specialized
versions of tun_finalize, queue_read, open, close, etc.  I didn't bother
doing the same with writes since they always completed immediately anyway
once handing off to NDIS.  Anyway, this re-unified the event model between
the socket stuff and the tap stuff.

Your point is timely, however, because my new challenge is similar (though
different):  the handle returned from GetStdHandle() is _not_ suitable for
synchronization on CE.  The WSAWaitForEvent call barfs with 'invalid
parameter' if it is in the event set.  Eventually I figured out it was the
console handle so at the moment I have that commented-out until I can think
of a suitable solution.  I'll probably have to dig in the PortLib code, but
the console driver itself is not open-source, so it might be a chore
resolving that issue.

With that commented-out, I can't ctrl-c to stop the application, but I can
start to initiate a session with the server.  Now things run happily until I
get to the point where DHCP is happening and then it fails to get an IP
address from the server.  Hopefully something configuration related, but,
well, probably not -- probably a bug I introduced and will have to
find-and-fix (sigh).

Question for you:  I discovered today that 'nobind' can't be used on CE.
The socket has to go through bind() before it can be used in, say WSARecv.
Is there an especial reason why someone would be upset about not having that
option supported?  I haven't tried, but I might be able to emulate it by
binding to ADDR_ANY:0.  Maybe.

Iftikhar:  I updated the source and also I fixed the problem I mentioned
previously about the driver not handling the power-off state correctly; you
can power on and off to heart's content.

-Dave


