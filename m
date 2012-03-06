Message-ID: <4F560B5F.5030204@...1114...>
Date: Tue, 06 Mar 2012 14:04:31 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
	<1330546342-17794-10-git-send-email-alon.barlev@...277...>
	<4F55E72D.2010306@...515...>
	<CAOazyz1j=gYO__gyeck89kGnJ+BmCHW=qmX8MF3KV9gBJF3k2Q@...278...>
In-Reply-To: <CAOazyz1j=gYO__gyeck89kGnJ+BmCHW=qmX8MF3KV9gBJF3k2Q@...278...>
Subject: Re: [Openvpn-devel] [PATCH 09/52] cleanup: memcmp.c: remove unused
 source
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, "Openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 06/03/12 12:13, Alon Bar-Lev wrote:
> Not exactly. This file is needed for VERY old libc implementations. I
> don't think these exists anymore in supported configurations. If we
> find memcmp() is missing, we add it properly to compat.

Agreed, and I also ACKed this one in the first round.  This is basically
dead code in the vast majority of platforms.  Bear in mind that OpenVPN
was released about a decade ago,  "a few" things have changed since then ;-)

This patch goes in.


kind regards,

David Sommerseth


> 2012/3/6 Samuli Sepp=C3=A4nen <samuli@...515...>:
>>=20
>>> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...> ---=20
>>> configure.ac |    3 --- memcmp.c     |   43
>>> ------------------------------------------- 2 files changed, 0
>>> insertions(+), 46 deletions(-) delete mode 100644 memcmp.c
[..snip..]
>>=20
>> My C-fu is fairly low, but this still seems to make sense as there's
>> no memcmp.h. The memcmp function calls in other source files seem to
>> use memcmp function stored elsewhere (gcc[1], libc[2], etc.).
>>=20
>> ACK.
>>=20
>> -- Samuli Sepp=C3=A4nen Community Manager OpenVPN Technologies, Inc
>>=20
>> irc freenode net: mattock
>>=20
>>=20
>> [1] <http://justin.harmonize.fm/index.php/2009/05/exploring-memcmp>=20
>> [2]=20
>> <http://www.slac.stanford.edu/comp/unix/package/rtems/doc/html/libc/libc=
.info.memcmp.html>
>
>>=20
> -------------------------------------------------------------------------=
-----
>
>=20
Keep Your Developer Skills Current with LearnDevNow!
> The most comprehensive online learning library for Microsoft
> developers is just $99.99! Visual Studio, SharePoint, SQL - plus
> HTML5, CSS3, MVC3, Metro Style Apps, more. Free future releases when
> you subscribe now! http://p.sf.net/sfu/learndevnow-d2d=20
> _______________________________________________ Openvpn-devel mailing
> list Openvpn-devel@lists.sourceforge.net=20
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9WC1sACgkQDC186MBRfrpwggCfahRiNIZZrCssyxWqOgCJPi+c
r0gAoJeO5E5MqyggxsCPNSDXPy9SC6eU
=3DEm9/
-----END PGP SIGNATURE-----

