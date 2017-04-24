Date: Mon, 24 Apr 2017 22:57:38 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170424205738.GM30424@...1296...>
References: <20170413172609.29093-1-davids@...515...>
	<20170424143910.20118-1-davids@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IfZ+tgy+ooJOsAAy"
Content-Disposition: inline
In-Reply-To: <20170424143910.20118-1-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH v5] Fix broken ./configure on systems
 without openssl.pc
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--IfZ+tgy+ooJOsAAy
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Apr 24, 2017 at 04:39:10PM +0200, David Sommerseth wrote:
> This patch have been tested on Scientic Linux 7.3 (RHEL clone) and
> FreeBSD 10.3-RELEASE-p11.
>
> v5 - Remove the right OPENSSL_LIBS and preserve the old one
>    - In PKG_CHECK_MODULES(), check for openssl instead of libssl
>      + libcrypto
>    - Fix tab/space issues once again
[..]

This looks good for me.

FreeBSD 10.3, no pkg-config               -> works
Gentoo, pkg-config                        -> works
FreeBSD 7.3, no pkg-config, openssl 0.9.8 -> fails (as it should)

   checking for OPENSSL... no
   checking additionally if OpenSSL is available and version >=3D 1.0.1... =
configure: error: OpenSSL version too old

NetBSD 7.0.1, pkg-config, openssl 1.0.1t  -> works
OpenBSD 6.0, pkg-config, LibreSSL 2.4.2 (OPENSSL_VERSION_NUMBER 0x20000000L)
                                          -> works


I'd like to see a review from Steffan whether we've anything left that
I didn't see in my setups (I run without setting env vars, with openssl
installed "in the default places"), but for my machines, this is good to=20
go (=3DACK).

[I'll have to go and upgrade a number of the older buildslaves, as some
of these do have 0.9.8<x> installed - so expect some errors when pushing,
but this is understood and inveitable]

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--IfZ+tgy+ooJOsAAy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJY/mbBAAoJEB2Cnv7KVigS9PgL/ihfZynXVPDClzGqUkgpm8Kz
DmbxGcLi5y/sLtSbnj07rJy88VfI7a5aMv+eBs3WxEmbXKdiGFrq/TmDADdDovmZ
1UwcsivbVE0o/NBOa99v5GAxn/bj+fru0tfkFs+VWiAkBhLo81+O28QY79Lcr8ih
tkPccTZR8FyU6AXD0qM5KOOv9s7jSebG1aEeJZtxrHZOFhUA5mWT3MfTAb/3p2Sc
NRDd3O5plOM8XkykuSOCsjWfL9VXIflxDyoxW7onlmEz+/3Bsheg/HFVO3T39Dd+
BSOdleiBCDNPv++/XUHMsZ58wuUzTVHG8mcO/jzVFyM3D64eSZit9qHEcp1uSB5w
r1OdX1k3JcgpkQcay0WXNGsSRwYN4y8Tlv5477aLsH+LVji64807QgNhKqmRb8Zb
xNhp5DaEtVFh9EwQvpdJR4WT9mKLa0dl0/k2vk95R+DCf1OZVfroIY9pG7CQu4ud
eEPhiSQaXcteBX3XO58m5dPqgsq//eouvB72yGXiQw==
=182D
-----END PGP SIGNATURE-----

--IfZ+tgy+ooJOsAAy--

