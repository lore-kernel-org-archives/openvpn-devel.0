Date: Sun, 14 Feb 2021 15:50:23 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20210214145023.GU976@...1296...>
References: <ca157141-dc88-8017-0e6e-3ace055bc36e@...2181...>
 <20210125124330.30046-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="sy0qu8fn1MHxO37T"
Content-Disposition: inline
In-Reply-To: <20210125124330.30046-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2] Allow running a default
 configuration with TLS libraries without BF-CBC
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--sy0qu8fn1MHxO37T
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jan 25, 2021 at 01:43:30PM +0100, Arne Schwabe wrote:
> Modern TLS libraries might drop Blowfish by default or distributions
> might disable Blowfish in OpenSSL/mbed TLS. We still signal OCC
> options with BF-CBC compatible strings. To avoid requiring BF-CBC
> for this, special this one usage of BF-CBC enough to avoid a hard
> requirement on Blowfish in the default configuration.

I was about to merge this, based on Antonio's ACK, but this part of
the code confuses me:

> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index b81137cf..d52057cc 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -3836,18 +3856,32 @@ options_string(const struct options *o,
>                 + (TLS_SERVER =3D=3D true)
>                 <=3D 1);
>=20=20
> -        init_key_type(&kt, o->ciphername, o->authname, o->keysize, true,
> -                      false);
> +        /* Skip resolving BF-CBC to allow SSL libraries without BF-CBC
> +         * to work here in the default configuration */
> +        const char *ciphername =3D o->ciphername;
> +        int keysize;
> +
> +        if (strcmp(o->ciphername, "BF-CBC") =3D=3D 0) {
> +            init_key_type(&kt, "none", o->authname, o->keysize, true,
> +                          false);
> +            ciphername =3D cipher_kt_name(kt.cipher);
> +            keysize =3D 128;
> +        }
> +        else
> +        {
> +            init_key_type(&kt, o->ciphername, o->authname, o->keysize, t=
rue,
> +                          false);
> +            keysize =3D kt.cipher_length * 8;
> +        }
>          /* Only announce the cipher to our peer if we are willing to
>           * support it */
> -        const char *ciphername =3D cipher_kt_name(kt.cipher);

So the old code always sends "cipher_kt_name(kt.cipher)".

The new code adds a special case handling for "BF-CBC", calling
init_key_type(none), but then does the "cipher_kt_name()" only for
the "BF-CBC/none" case, no more for the "all other ciphers".

This looks like the wrong way around - shouldn't it do the

> +            ciphername =3D cipher_kt_name(kt.cipher);

for the "not BF-CBC" case, and "ciphername =3D o->cipher" for "only BF-CBC"?


Call me confused...

As a side note, it seems to fail two of my t_client test cases,=20
namely "talking to a 2.3 server with --cipher BF-CBC" and "talking to=20
a 2.4 server with --ncp-disable", so maybe that code needs some more=20
discussion.  I have not investigated more into these failures, first=20
want to understand what the code tries to do.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--sy0qu8fn1MHxO37T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgKTitAAoJEB2Cnv7KVigSKDAL/13xmo8bP4zzfKvvK5iz27LQ
JfYZ98/tqEJcsJ7v/exlB7+Ru/cvnxD5StDMU8aAaZIOpmrYTkWIjKEWrQrEEjeb
e2zAGIMPM4DQtdVBL9MPKf3TNM0APiLNhUiHGLbL0ia4KIOHsHHtb4sRCsXUQEVp
Tc5e+xXIkHPyRkHmB7WpJcA9E+j4NoxPNOBk0OFMGOvHAPDEz40aXoyIbenkvrqX
Qu8pz6qbywSRkkh3Gkx7VFVlqPZpoR5/fvihe/NdJ3sa4yJQ/dC8jsezKP59j1oF
aCJFMb+S8TbPtDMk3i2A5Jp24hcH3tGjS0cMbCY8CJWP296yiBhPlr8BGktSW7Up
JQl7Iy1cvveZSv2KKu+RmiySx55dwfaeUZx/ajnXG9NoIPAPkxPv1IczvUWm/QZz
v0lKFl4+ak/bO+gmnrQK/Q0gfkuaFelGDVT8ME+YBz0HGdCAJ2FyNeaAGMyYh53S
NzdSxEJuV7nkyN0gbkXuA6CzKppKc2Knfaeg7tcLFg==
=LOKW
-----END PGP SIGNATURE-----

--sy0qu8fn1MHxO37T--

