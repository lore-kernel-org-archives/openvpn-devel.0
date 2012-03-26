Date: Mon, 26 Mar 2012 20:11:19 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120326181118.GY1359@...1296...>
References: <20120326161943.GW1359@...1296...>
	<CAOazyz0Tbdn8+W9g1UmtLzGmbHbGNagRsN6KVZnVvqr_c2Hm6g@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CjJSuxoe2P5GDFE9"
Content-Disposition: inline
In-Reply-To: <CAOazyz0Tbdn8+W9g1UmtLzGmbHbGNagRsN6KVZnVvqr_c2Hm6g@...278...>
Subject: Re: [Openvpn-devel] build failure on OpenBSD
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--CjJSuxoe2P5GDFE9
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Mar 26, 2012 at 07:58:02PM +0200, Alon Bar-Lev wrote:
> The problem is the use of the TARGET_XXXX not the use of HAVE.
> As I wrote before next stage is to get rid of the syshead.h and its compl=
exity.
> There is no sense to check for platform, just if header exists.

Check for header is too fragile, obviously - it checks for header, but
fails, because header needs other headers.

We need the TARGET_XXX stuff anyway, because tun.c and route.c need
them - stuff like "how is the /bin/route syntax for IPv6 on xxxBSD"
can not be detected by configure.=20=20

So I'm much more in favour of actually keeping what we have: knowledge
about every platform.  We *know* which headers are there on FreeBSD,
NetBSD, OpenBSD - and the way OpenVPN needs to tie into the system=20
for ifconfig and route means "porting to a yet-unknown operating system
by just running 'configure ; make' is a pipe dream, no more".

This might work for stuff that's sufficiently far away from the system
innards, and using pkg-config libraries for the nitty gritty details,
but it won't for OpenVPN.=20=20

> In the mean time please try the following[1] patch.
>=20
> Alon
>=20
> [1] https://github.com/alonbl/openvpn/commit/b0f45ae19909b33723faebe7f8fb=
003f82900ff4

That patch makes configure detect <netinet/in.h> (as such: thanks, it
helps), but it makes configure even more complicated, which means=20
"config.log is even longer and harder to read".

<rant>
All this crap in configure really needs to go away...

checking stdio.h usability... yes
checking stdio.h presence... yes
checking for stdio.h... yes
...
checking errno.h usability... yes
checking errno.h presence... yes
checking for errno.h... yes
...
checking whether SIGHUP is declared... yes
checking whether SIGINT is declared... yes
checking whether SIGUSR1 is declared... yes
checking whether SIGUSR2 is declared... yes
checking whether SIGTERM is declared... yes
...
checking for socket... yes
checking for recv... yes
checking for recvfrom... yes
checking for send... yes
checking for sendto... yes
checking for listen... yes
checking for accept... yes
checking for connect... yes
checking for bind... yes
checking for select... yes
checking for gethostbyname... yes

... all of these are on any operating that has any chance of running
OpenVPN.  So testing for it is a pure waste of code lines and cpu=20
cycles.
</rant>

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--CjJSuxoe2P5GDFE9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT3CxRqkuBuNlUUl1AQIeswP/fa0iRCmJh5CtkSefypkfZkEXgM2pSpVi
vUBBPSJMbz6l9CRzk5crhA7lzSX4x+J3mVvEuMfFxsk2IIKUH+p19aEGsOy8Vvm0
4kxG/z+ucEfGhqDYPW3h3eSh+/GuTL0j3Ty13HaHtEa37Fjo9pPoPtlZMLUlt7X1
UswBd+NFGDw=
=iZbS
-----END PGP SIGNATURE-----

--CjJSuxoe2P5GDFE9--

