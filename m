From: "Dave" <dev@...575...>
Subject: RE: [Openvpn-devel] OpenVPN for PocketPC
Message-ID: <000001c64ebf$5b8fd230$1601a8c0@...576...>
MIME-Version: 1.0
In-Reply-To: <000001c64dbd$0aa26390$1601a8c0@...576...>
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
Date: Thu Mar 23 13:19:06 2006
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: 'Iftikhar Qureshi' <iftikharqureshi@...109...>, openvpn-devel@lists.sourceforge.net

> -----Original Message-----
> From: openvpn-devel-admin@lists.sourceforge.net=20
> [mailto:openvpn-devel-admin@lists.sourceforge.net] On Behalf Of Dave
> Sent: Wednesday, March 22, 2006 8:30 AM
> To: 'Iftikhar Qureshi'; openvpn-devel@lists.sourceforge.net
> Subject: RE: [Openvpn-devel] OpenVPN for PocketPC

Iftikhar;

I updated the source at the web location I previously sent you in case you
want to pick it up.  Here's a brief summary of what I've fixed/extended
since last time:

*  I figured out my dynamic driver load/unload problem; it was a bug I
introduced in one of the ANSI/UNICODE functions that had the effect of
truncating the adapter name stored internally in NDIS.  Curious that it
worked in the emulator anyway...
*  I implemented several of the functions in tun.c (currently residing
wince_tun.c) and sifted away some that were win32-specific ones.
*  I discovered yesterday that in the particular case of winsock, that
overlapped io support is required, and (supposedly) has been implemented in
CE and is available via the WSA versions of those methods (e.g.
WSAGetOverlappedResult).  This is really good news because it possibly means
that all the socket.c work will not have to be reworked at all.  Hopefully!

So I think that only the five various tun_* and *_tun methods need to be
implemented to declare this 'feature complete' and then the exciting phase
of testing/fixing begins.

-Dave


