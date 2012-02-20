Date: Mon, 20 Feb 2012 21:39:13 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120220203913.GU7024@...1296...>
References: <CAOazyz08kLGKyq-Wcd1KTQ9akdQCAYPP9b1aMVne-b9TArMKDQ@...278...>
	<1329749121-24501-1-git-send-email-alon.barlev@...277...>
	<4F426F81.6040201@...1114...>
	<CAOazyz1DhzxPf3GS1dqhYKXSkL5NeSDy03z340VYibKWBKxPRQ@...278...>
	<CAOazyz1uZY2Entpuq4tn0DdBbQEZk32iugtmbttOkCrdbjK7Jw@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4fNq9Po2wJlmxAaR"
Content-Disposition: inline
In-Reply-To: <CAOazyz1uZY2Entpuq4tn0DdBbQEZk32iugtmbttOkCrdbjK7Jw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] windows: do not use X_OK as it is
	unsupported
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

--4fNq9Po2wJlmxAaR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Feb 20, 2012 at 09:47:25PM +0200, Alon Bar-Lev wrote:
> Another option is to use X_OK and declare a macro
> PLATFORM_MASK_MODE(m)... whatever you think more readable.

This is something I would like better, as it localizes the change to
one place.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--4fNq9Po2wJlmxAaR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT0KvcakuBuNlUUl1AQJc/AP+Ol5UFkHdX52JuJfRVssjArWh/oyHfOty
v6UyMUGPqZUpgVkXLJ0cmWKzGIdSHOJEnQTueL5qUAs9d8hp52kzAHLK1WKgS+s9
oLf254shoOrn7rbwcrsa7XODDLfY28vXmG4fQm2rsuxr3/7IKZV7+lutBedqOFMg
kV+HD0OsKk8=
=4Ph6
-----END PGP SIGNATURE-----

--4fNq9Po2wJlmxAaR--

