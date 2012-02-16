Date: Thu, 16 Feb 2012 19:29:09 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120216182908.GM7024@...1296...>
References: <1329413441-22538-1-git-send-email-heiko.hund@...1489...>
	<1329413441-22538-4-git-send-email-heiko.hund@...1489...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hdW7zL/qDS6RXdAL"
Content-Disposition: inline
In-Reply-To: <1329413441-22538-4-git-send-email-heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [PATCH 3/4] use the underscore version of stat
	on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

--hdW7zL/qDS6RXdAL
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Feb 16, 2012 at 06:30:40PM +0100, Heiko Hund wrote:
> MSVC does not know wstat(). Instead _wstat() must be used here.
> Unfortunately _wstat() takes a 'struct _stat'. A type 'stat_t' is
> introduced to handle this situation in a portable way.

Semi-ACK.=20=20

In general, ACK, though it might be a bit easier to understand the code=20
if there were an explantory comment at the typedef, and the type would be=20
called "openvpn_stat_t" or such - so that when referenced in pf.c, it's=20
clear that this is not something "from the build environment" but "local".

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--hdW7zL/qDS6RXdAL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTz1K9KkuBuNlUUl1AQJW4AP9GHBoZss1B1DUutoPMnwexPPU8bZSX7V2
ZI8KB0wJFt9gP97+Hu+fCODLlwkQZBR+cjipaLnGj1e8/pILvuUlzTSUay6UuWZ1
MA/XZCR3ngvDC++XIGl6GD5a8KMbWJzp3K74O4vl30OOfcEpt9PiXolnDEirB4aU
K6+5i4oi/Bk=
=kuLi
-----END PGP SIGNATURE-----

--hdW7zL/qDS6RXdAL--

