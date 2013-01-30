Date: Wed, 30 Jan 2013 14:17:05 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20130130131705.GV22465@...1296...>
References: <20130130130717.GB19096@...1805...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UxEh+DSO2GFtiULE"
Content-Disposition: inline
In-Reply-To: <20130130130717.GB19096@...1805...>
Subject: Re: [Openvpn-devel] [PATCH] x509 validity for tls-verify
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Emmanuel Dreyfus <manu@...1031...>
Cc: openvpn-devel@lists.sourceforge.net

--UxEh+DSO2GFtiULE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jan 30, 2013 at 01:07:17PM +0000, Emmanuel Dreyfus wrote:
> +++ src/openvpn/ssl_verify_polarssl.c	2013-01-30 09:37:42.000000000 +0100
> @@ -140,8 +140,21 @@
>=20=20
>    return buf;
>  }
>=20=20
> +char *
> +x509_get_validity_notBefore (openvpn_x509_cert_t *cert, struct gc_arena =
*gc)
> +{
> +  return NULL;
> +}

Can this not be done with PolarSSL, or did you not investigate?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--UxEh+DSO2GFtiULE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUQkdUakuBuNlUUl1AQJDCwP+MQz6lZv7RSSZLUKb9KPRd2vE0xJVTdmF
79cFqmzz7teYXXNhiCl7dpAXmZD+kOsQtLgbzH4ephHdH2FFu+9trV6PCOtnYhiw
LueaJyI68/qofLkuBXMcW5qCT6BPOwX9a4ial3CThczb56pL2FWA0bX9dO2kqH+v
x3KxAqCgWJk=
=DSTB
-----END PGP SIGNATURE-----

--UxEh+DSO2GFtiULE--

