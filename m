Date: Mon, 25 May 2020 08:04:15 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200525060415.GY1431@...1296...>
References: <20200524203322.15885-1-James.Bottomley@...2316...>
 <20200524203322.15885-3-James.Bottomley@...2316...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ncBgPXMfjU2hwCiX"
Content-Disposition: inline
In-Reply-To: <20200524203322.15885-3-James.Bottomley@...2316...>
Subject: Re: [Openvpn-devel] [PATCH v5 2/2] Add unit tests for engine keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Bottomley <James.Bottomley@...2317...>
Cc: openvpn-devel@lists.sourceforge.net

--ncBgPXMfjU2hwCiX
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I see the granularity of your patch set as "not right":

On Sun, May 24, 2020 at 01:33:22PM -0700, James Bottomley wrote:
> Testing engines is problematic, so one of the prerequisites built for
> the tests is a simple openssl engine that reads a non-standard PEM
> guarded key.  The test is simply can we run a client/server
> configuration with the usual sample key replaced by an engine key.
> The trivial engine prints out some operations and we check for these
> in the log to make sure the engine was used to load the key and that
> it correctly got the password.

This patch says "add unit tests", but it contains changes to configure.ac
and OpenVPN code

>  configure.ac                                  |   5 +
>  src/openvpn/crypto_openssl.c                  |   1 +

These two hunks should go to the first patch.

Every patch should be fully testable on its own - so if I apply only
the first hunk, I should be able to use and test engine keys, without
having to apply the "add a unit test" patch set.

> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
> index a7569623..34637ebf 100644
> --- a/src/openvpn/crypto_openssl.c
> +++ b/src/openvpn/crypto_openssl.c
> @@ -92,6 +92,7 @@ setup_engine(const char *engine)
>  {
>      ENGINE *e =3D NULL;
>=20=20
> +    OPENSSL_config(NULL);
>      ENGINE_load_builtin_engines();
>=20=20
>      if (engine)

For that change, I wonder what side effects it might have on existing
setups.  Arne, can you help?  Is this "safe"?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--ncBgPXMfjU2hwCiX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJey1/fAAoJEB2Cnv7KVigS2coMAJ4V/ezKs0L69YN0/DDrl799
XpolZwpH8TiRQJPmZDSV4qnkkO2Sk6Mn1970e6RlzIlm5hLbu6iTLlpf0MvZ7XsW
21G1r+mQgKQgObqeDLBeby8kP81TXU4k6e2ADzvNNHYow5dmKOKvfe0kZ09BgpYo
UeSVBn43x+rNJYzC+u+hU2DjUw1iMMjBFy91iR2K8B3eBBM4HlTM7AWRb1ySx/0w
klswAgkSJJoZ1O0kbN2sphi8SDDjR0AALHDfNf1lhEv0Og2UvRar5+WDrtR/qMsL
ZJKLL4dnUhy/5bOatNv1UGFEBJMcOuw96ht3VG2NaGBqi4NOGIHVe9FhYgMFlIXo
vnXwGPYrQSNGLw498L9SPwtPqC6JgnpKftXDRjSnh1CUMy3yEk1oHD41B2fUX970
crRIhFSVmEc4D4MiVtcIlV8o5541srZ2xpQGuzUWPjzzyMStxjZ1M/sOlqNgPJLZ
jVcYrPjQAFdFLyjIDrI98keceh/NSxXzzDBPnHXjbQ==
=xVob
-----END PGP SIGNATURE-----

--ncBgPXMfjU2hwCiX--

