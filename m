Date: Fri, 5 Oct 2018 14:51:53 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20181005125153.GM962@...1296...>
References: <20181005123938.25649-1-steffan@...1856...>
 <CAFHpkQEKOeNJGRccLTRTN0UoszmJtypx8=uR8oNq6aXU_gjc=g@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="CQL2Jiu9fsaVZZPj"
Content-Disposition: inline
In-Reply-To: <CAFHpkQEKOeNJGRccLTRTN0UoszmJtypx8=uR8oNq6aXU_gjc=g@...278...>
Subject: Re: [Openvpn-devel] [PATCH] travis: add OpenSSL 1.1 Windows build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ???????? ?????????????? <chipitsine@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--CQL2Jiu9fsaVZZPj
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Oct 05, 2018 at 05:49:17PM +0500, ???????? ?????????????? wrote:
> openssl versions were aligned to those used in "openvpn-build" repo, i.e.
> the same version were used as in installer creation.
> not sure why do we want to have big matrix for cross builds.
>=20
> but I do not mind, the more tests the better :)

With the cryptoapi code, we have code paths now that are "only windows"
and "care needs to be taken for openssl 1.0 <-> 1.1" (RSA_meth_set_sign()).

That's the new thing...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--CQL2Jiu9fsaVZZPj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbt15oAAoJEB2Cnv7KVigSsIYL/0YxPQOOdwABPHGwU5SgZHnn
ZqO8s1oYbsq5gj43DwkusK+pH0CYkPgyJesKQtKJfXW2BV6YD9FF6rx3BT2QVHa3
+g3+A62Wvk7w/Mzg4n/SM5AuBru/uphQpgbAGR0ZGH+OdbnXL7IX8y1ION8Ewitc
k2h6MvOpJcR9d0yY5QbOLUwy1CR1Oks+GMDrBfH5ov5T1SEzJWJtgwhoaXS/JHV0
D7oKAC/kyPgx0ppxxpbDvyRTLYejirlpDrgpdUj4o9+BA6blIROruf3G2qOwmhXo
UTQ6GWB7dJ3jmzKlDkV27CdBA5aVdLt6Qd3ZFWfJf5dF/jnyPAwEf18WJzVZg4pH
z8GCcqQ2WieCqKYGbYVU1ylstOGNqelTy+XS35XTE4D7/YSWD2BjnfBtjtPgSp5G
5wJqB61nBZa8cNBQCqEmVq5f0md9k8vNm1Rh4+LZfZXqu6w3IGwlRtofu5yi1ePr
hjbXOafYt6fiBm09m+R8bVPUZwffZwRVmm0y4WuGcw==
=m+2R
-----END PGP SIGNATURE-----

--CQL2Jiu9fsaVZZPj--

