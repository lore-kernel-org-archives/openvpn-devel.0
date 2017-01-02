Date: Mon, 2 Jan 2017 15:55:43 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170102145543.GM78624@...1296...>
References: <f49ae3c3-70c8-3169-4776-a7b89b7e8799@...2101...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cCEKa9UdY3MtHM1R"
Content-Disposition: inline
In-Reply-To: <f49ae3c3-70c8-3169-4776-a7b89b7e8799@...2101...>
Subject: Re: [Openvpn-devel] Crash in options.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gisle Vanem <gvanem@...2101...>
Cc: OpenVPN-dev <openvpn-devel@lists.sourceforge.net>

--cCEKa9UdY3MtHM1R
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jan 02, 2017 at 03:28:58PM +0100, Gisle Vanem wrote:
> Just as an experiment, I compiled openvpn.exe using MinGW w/o
> 'ENABLE_CRYPTO' defined. Duh, you think. What would be the benefit of
> that? I ask myself the same. This code (at line 4079):
>=20
> #else  /* ifdef ENABLE_CRYPTO */
>     fprintf(fp, usage_message,
>             title_string,
>             o.ce.connect_retry_seconds,
>             o.ce.local_port, o.ce.remote_port,
>             TUN_MTU_DEFAULT, TAP_MTU_EXTRA_DEFAULT,
>             o.verbosity);
> #endif
>=20
> uses a 'title_string[]' as format with no parameters specified and
> thus crashes as expected. So is all code outside '!defined(ENABLE_CRYPTO)'
> really dead code or what?

Actually, "usage_message" is the format string here...=20=20

There might still be bugs here, though - as in: someone adapted the=20
"#ifdef ENABLE_CRYPTO" part of the usage_message and forgot to change
arguments in the the #else case.   While we do test builds with
--disable-crypto, I'm not sure anyone has run "openvpn --help" with
such a build in the last 5 years...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--cCEKa9UdY3MtHM1R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYamnvAAoJEB2Cnv7KVigShkUL/19tU+fmGnDMEr17sA7/VG7s
DthiI/MZU4gd6nVzgD5kDxBzbp+p5wsVA8A8doiuAJY+3pSYjwnw0XCOnxgZID/u
KR10UrjGT4SgQYae7oTkG7HIK6UfVL8wvh5DllBgWRXP5th9ijaaERIBETPLetyu
SBIDYcuxtDRXp7DIl4dPeE1L290BO+5mkhE7QQ92uwocumR4knoTFCFmGwuWcPyp
+xZQTktJnK5L2k2O2DMt7CpIZV7i0D3xpPx9+W1vMlJKnKjPo1VsyRlh349Z6+Z3
4Dz71Gvhu1EY3Ew5C6mby6OxP+hcuTK9nK9mMKL7L3HHN6IpCkD/6voQ4d97f1aM
Zn3vXmsPkpIIVe4FfpUnygF4LK2NovN6JbEwG0OZMMq8F7AJno6yVjgGqOsjgAPB
T7BoJKln9skANwXj8ako1l2Z/VNgdk05m+FJHYrp4pKrknsIuAWRMadYZ0yGYv8N
Ma2rFklXTnrbEjhSDshqwLFZyKpirV+AgH6LtM01cQ==
=M27f
-----END PGP SIGNATURE-----

--cCEKa9UdY3MtHM1R--

