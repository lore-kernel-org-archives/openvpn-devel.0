Date: Sun, 18 Dec 2016 22:26:59 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161218212659.GY78624@...1296...>
References: <1482079255-15159-1-git-send-email-steffan@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qkWs0iooC3sIAMHP"
Content-Disposition: inline
In-Reply-To: <1482079255-15159-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Use SHA256 for the internal digest,
 instead of MD5
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--qkWs0iooC3sIAMHP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Dec 18, 2016 at 05:40:55PM +0100, Steffan Karger wrote:
> Our internal options digest uses MD5 hashes to store the state, instead of
> storing the full options string.  There's nothing wrong with that, but it
> would still be better to use SHA256 because:
>  * That makes it easier to make OpenVPN "FIPS-compliant" (forbids MD5)
>  * We don't have to explain anymore that MD5 is fine too
>=20
> The slightly less bytes for the digest (16 instead of 32) and operations
> per connection setup are not worth sticking to MD5.

I can't find very clear information on "which versions of OpenSSL do
support sha256", but since we have a trac ticket about our windows
builds having issues with sha256 certificates we might take this
opportunity to revisit minimum OpenSSL versions supported in master
from now on...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--qkWs0iooC3sIAMHP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYVv8iAAoJEB2Cnv7KVigScosL/j+ZITFRyars5Anu2MxhZRsi
KJBnYC916cn0NbkLavZydy+95rH8oLU5aT7u6uPuAIA5WJeTyeo6pWogYO/QpODk
oUSeL/vvDp7OOmcFwYxNxR6itwwx6MP11MXzBR3kb9rp47NmuZdXFCgmnS1tG0oF
CQGP2R3bJchd+XKChHcB4Q43y/V7LWYFPyUEtnkpDHUyB7IdkyJpWHB1uMGIrLtq
XYpY0SDkj3sI1FU1k22zvORgFthCicT9JdXOtRmGmx+bIGKbP0F3rvhG+bFnyiST
JXYpXKC4Nq9fxylRMjUZk6YoMXfqTM3VdrwVMME84nHJfhbKqHIWvsON8ZMgANzW
XP6f8k4GqUCWCdQRgfo36qtZwQsIyKBQd0c9pqqXjeqBThWkuIszT6AZSISzNULA
PuZlOObLpRoqVEHOzyKCDA35d7/1rhd6IPut7g2ci/rOFff4aq20Y+y4s1bnELAB
/eTZjNcdNC7bVQ9o3YAh7rAdF56z0XiMkBt+79IC+w==
=NyZq
-----END PGP SIGNATURE-----

--qkWs0iooC3sIAMHP--

