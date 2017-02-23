Date: Thu, 23 Feb 2017 10:23:14 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170223092314.GR93896@...1296...>
References: <cover.1487368114.git.logout@...260...>
	<a77187a66affdba318ef70e0e218b69cdad509d1.1487368114.git.logout@...260...>
	<20170223080347.GA56089@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlZi+g8Ywt2nzGP6"
Content-Disposition: inline
In-Reply-To: <20170223080347.GA56089@...1296...>
Subject: Re: [Openvpn-devel] [RFC PATCH v1 01/15] OpenSSL: don't use direct
 access to the internal of SSL_CTX
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: logout@...260...
Cc: openvpn-devel@lists.sourceforge.net

--HlZi+g8Ywt2nzGP6
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Feb 23, 2017 at 09:03:47AM +0100, Gert Doering wrote:
> This patch brings two problems outside the "OpenSSL functionality"=20
> part.
>=20
>  - openssl_compat.h is not included in the built tarballs, so mingw builds
>    fail (and "builds for anyone building from tarballs" would break) ->
>    findable by running "make distcheck"

This has been fixed & pushed (so we can build windows snapshots again).

>  - configure.ac does something to CentOS 6 / RHEL 6 which makes configure
>    explode:
>=20
> ...
> checking for linux/if_tun.h... yes
> checking tap-windows.h usability... no
> checking tap-windows.h presence... no
> checking for tap-windows.h... no
> checking whether TUNSETPERSIST is declared... yes
> checking for setcon in -lselinux... yes
> checking for pam_start in -lpam... yes
> checking for PKCS11_HELPER... no
> ./configure: line 21440: syntax error near unexpected token `fi'
> ./configure: line 21440: `fi'

This still needs investigation.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--HlZi+g8Ywt2nzGP6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYrqoBAAoJEB2Cnv7KVigSGOUL/iH5lml+UKoOmtElIm1MSb0N
jpbS9Fh53+WedT1F0ZXGr+2hgD5G8ru9EOfSCcYfttmvEpXVuuK/PNYd1tOUTpX/
obEZuHskW5ri8Ocid9A2L2YSJmUf7ClUdqwd3S7dR00LLupqWp3JLid2Gb0OiCZS
0sORDcD/0c4isX2KQmSGMlbyJumFEXBUQ3iPEn6tx/xs4wW+KMbdU1Aqkl2A/p+4
O8gDdChBIQlSgVvbLxtNhtp0yxL6gYeet3U9dhuZf/QX1WF0kufhS4yV35kA6qrW
M7ZW5zMSvO7r5HwSIVwckO0N7YG6aPMiky8yNYkatrZg50agD9NmHoQTA5PQSBm2
1Yj38KDu4Uo8Qoa10i+GCoiIIlx1gPGSxj/w5tcEMtZeG8Yhq5TBljaQDGue3FiW
AimrE9h+RDJKKQnopatgoCTRRSBY4sObi8bGgcbRveMnL+zEtcgCWU/Rca/xfA++
RXL1GEw1apru+q0u6oQsbLdoDjWYV1VaLzbKFAl5dA==
=Qkga
-----END PGP SIGNATURE-----

--HlZi+g8Ywt2nzGP6--

