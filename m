References: <20190225183531.27399-1-stefan.strogin@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <1572e620-4a2d-d840-060b-a1ecbdd224eb@...1227...>
Date: Mon, 4 Mar 2019 10:41:05 +0100
MIME-Version: 1.0
In-Reply-To: <20190225183531.27399-1-stefan.strogin@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tTBrBxD6rAX503dJu4aElShyJkltP6e8A"
Subject: Re: [Openvpn-devel] [PATCH v2] Use correct ifdefs for LibreSSL
 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Stefan Strogin <stefan.strogin@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tTBrBxD6rAX503dJu4aElShyJkltP6e8A
Content-Type: multipart/mixed; boundary="wLwGi0zlmWi0dNhP67CmoAruiq6KkK0DN";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Stefan Strogin <stefan.strogin@...277...>
Cc: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <1572e620-4a2d-d840-060b-a1ecbdd224eb@...1227...>
Subject: Re: [PATCH v2] Use correct ifdefs for LibreSSL support
References: <20190225183531.27399-1-stefan.strogin@...277...>
In-Reply-To: <20190225183531.27399-1-stefan.strogin@...277...>

--wLwGi0zlmWi0dNhP67CmoAruiq6KkK0DN
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 25.02.19 um 19:35 schrieb Stefan Strogin:
> - TLS 1.3 is not ready yet in LibreSSL. Also there is a theoretical
> possibility of OpenSSL >=3D1.1.1 built without TLS 1.3 support.
> - EC_KEY_METHOD API and SSL_get1_supported_ciphers are added into LibreSSL
> master (not yet released in 2.9.0).
> - Some methods that are available since LibreSSL 2.7.0 were thrown away
> in ssl_openssl.c regardless of LibreSSL version. Use them with newer Libr=
eSSL.
>=20

Acked-By: Arne Schwabe <arne@...1227...>

Looks good so far. I am struggling to find a security/release policy how
long LibreSSL SSL versions are still supported. I would be nice to have
some idea when we can remove the LibreSSL 2.7.0 defines.

Arne


--wLwGi0zlmWi0dNhP67CmoAruiq6KkK0DN--

--tTBrBxD6rAX503dJu4aElShyJkltP6e8A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlx88rEACgkQFRhsZwKx
RFRaPA/5AY9EdwbY5FLvt4ISw/ehoAqZus+Ua4VT0NTyeDq9lq1+tesKndXnd7MU
PROiA3Ql0VFouslVwwyEdjQ64mHTogaP2TZ3epUA7T2/FQ6nv3EHBQCCTPspKaPW
dS47jiZyq7+2OOI33yNljX4ZELDiZ4WNAincvjv54ioRny2+2U5XQtnIi9gyI1yD
Xd+NjdxeVyPYDIQJQ31hA9daGp/pn5wGs/+BzWHfTZFnSghhs+BmoYY9SLzRHHyO
A5fIg8iM+ZiSeCYKwtTTWVNlCQBuB5pJ1itSpkHW+toig2eK5UrUJiqo/WpF2KtW
KMbvvqQBPDEkJjiaWspwySCCiJW621XBO6eoCBQKiy1aDxE3xZ2bKDL+P5vCr1kV
nf/aWfm4os3y1sWWUi+RWpdknE6ie9qRo6H+mc9xCOmcMSe7RS1d59VMt1aHKvDh
6qyMjy9QKUsdHcupbYLMnzJWrU6S/T84eg2CnOFLphEBrzCtBVvVLqA1s8DG3GMI
YcuXX9/KLv6ioKPBiLXG84Ro5LpzhZFuRUVUR2cfTuoL7O0TmrheiFWjnfJScI4e
XiK5WxdKcITQBCiDeCnEn5IT1P5u4LZbXNA1aQgbWqIBqeH9iw+Jw66UBCjkMqRy
CJsRG4grAIYgVEJBEFUJxjl41hfV8o7hXLlWVtb+7uynzIg2TZc=
=KBFt
-----END PGP SIGNATURE-----

--tTBrBxD6rAX503dJu4aElShyJkltP6e8A--

