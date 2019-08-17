Date: Sat, 17 Aug 2019 08:48:36 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190817064836.GS1349@...1296...>
References: <20190816204945.7937-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="YrQNB5Deg1WGKZi3"
Content-Disposition: inline
In-Reply-To: <20190816204945.7937-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] mbedtls: fix segfault by calling
 mbedtls_cipher_free() in cipher_ctx_free()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--YrQNB5Deg1WGKZi3
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Aug 16, 2019 at 10:49:45PM +0200, Antonio Quartulli wrote:
> Commit ("openssl: Fix compilation without deprecated OpenSSL 1.1 APIs")
> has removed the cipher_ctx_cleanup() API, as it is not anymore required
> to be a distinct call. However, while doing so it also touched the
> mbedtls backend in a wrong way causing a systematic segfault upon connect=
ion.
>=20
> Basically mbedtls_cipher_free(ctx) was moved from the defunct cipher_ctx_=
cleanup()
> to md_ctx_free(), while it was supposed to go into cipher_ctx_free().
> This was clearly wrong as also the type of the ctx variable was not
> correct anymore.
>=20
> Fix this mistake by actually moving mbedtls_cipher_free(ctx) to
> cipher_ctx_free().

This looks reasonable, the explanation makes sense and it pacifies
buildbot (gave this a test run on all the bots, and we're back to
"t_client test 1 fails on ubuntu+fedora29", and no more crashes).

So I'm good with it, though I'd welcome a confirmation from Arne
or Steffan.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--YrQNB5Deg1WGKZi3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJdV6NEAAoJEB2Cnv7KVigSJHUL/1T2rwma0cRFP0TPbaAiqpbS
v/9/7MVtD5GyxkDiRZwGC7mbGrTuAWdkKoJ2QAPmhVPPSoN95Bjx0LGe3EAAvYJ7
4Az2qchzELI4tpkq7YgkYslD7n22vjje2euqBQMi0sFHnvCCP5d2CqEjnYed5GQF
8Zj+qpxwgia0YDgsGRrh9ns48hE7khsQ9LgNpN715D0tAbWKHGRS3JOhxe/tmfDg
eReco2PEocoD9Vn9bQvQzRLkGzI0fmYzZz0Nz3KtQa83wFa+xKrV5tl57/f/6flR
/Gp+7uUGTlYTj8vUWC9lDTupaLAPSiujbFoORcsK+IaHrcaDbHeaDMN+XXmNh0jU
VNBosEaRD2+j/g4JC2PvKaIGQgPjX37U/P12gpAplAaH5wjbnrxZ+YkuHthkOp4v
4mXstRWHXFDPo5hdjwatK7px/ZMlGRNTr+T/B99xl2NPZowFklAtuOqFHwMYxEHu
AHeU8eUA/y1QffV36w8dGsRBpFVi21xDCeMZ2c78Pw==
=dbB/
-----END PGP SIGNATURE-----

--YrQNB5Deg1WGKZi3--

