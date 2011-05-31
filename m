Message-ID: <4DE4F490.6030609@...515...>
Date: Tue, 31 May 2011 17:00:48 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <20110531132435.GZ8496@...1296...>
In-Reply-To: <20110531132435.GZ8496@...1296...>
Subject: Re: [Openvpn-devel] Patch for socket.c / add_in6_addr() on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> Hi,
>
> attached you'll find another patch that is needed to make OpenVPN compile
> on Windows.  After quite some consideration I have decided to change
> the implementation for all platforms, as doing this with #ifdef WIN32
> would be messy at best.
>
> What the function in question does is "add a 32 bit offset to an IPv6
> address" - needed for server IP address calculation and for client pool
> assignment.  The old implementation did so in rounds of 32 bit, but the
> windows declaration of "struct in6_addr" has no 32bit-accessor in the
> underlying union...  windows has 8 and 16 bit, solaris has 8 and 32 bit,
> etc., so the only thing available everywhere is "8 bit".
>
> The addition stuff is a bit tricky as you need to be able to handle=20
> overflows (what's 0x2 + 0xffffffff in 32bit-math?) - but I've actually
> tested this for the relevant overflow candidates on Linux/i386 and
> NetBSD/Sparc64 (different word size, different endianness), and also ran=
=20
> random additions on 3 different implementations and compared the results=
=20
> (same!).  So I'm sure it works :-)
>
> The new function takes about 1.5-1.8x more time, that is, 70usec vs. 40us=
ec
> on my Atom 330 - and it's only called once per client connect on the
> server.  I'm willing to accept the slowness here to make the code easier
> to read, and more portable.
>
> Samuli has confirmed that it fixes this particular compilation problem
> on Windows :-)
>
> gert
>=20=20=20
As far Visual Studio 2008 compatibility is concerned, I give this patch
an ACK. Also, the approach chosen here sounds reasonable.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


