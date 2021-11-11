Date: Thu, 11 Nov 2021 22:08:51 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YY2GYxV5lT8xVoF8@...1296...>
References: <20210520151148.2565578-7-arne@...1227...>
 <20211111192051.3706965-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="WfMobFV7e2tJUFZe"
Content-Disposition: inline
In-Reply-To: <20211111192051.3706965-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v5] [OSSL 3.0] Allow loading of non
 default providers
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

--WfMobFV7e2tJUFZe
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Nov 11, 2021 at 08:20:51PM +0100, Arne Schwabe wrote:
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index b5d65d293..b1f9473dc 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -8157,6 +8158,13 @@ add_option(struct options *options,
>              options->engine =3D "auto";
>          }
>      }
> +    else if (streq(p[0], "providers") && p[1])
> +    {
> +        for (size_t j =3D 1; j < MAX_PARMS && p[j] !=3D NULL;j++)
> +        {
> +            options->providers.names[j] =3D p[j];
> +        }
> +    }
>  #endif /* ENABLE_CRYPTO_MBEDTLS */

This seems to be in an #ifndef ENABLE_CRYPTO_MBEDTLS block, which
means an mbedTLS build won't understand the option "--providers"
(but --help shows it, and there's a "mbed TLS provider functionality=20
is not available" patch in crypto_mbedtls.c...)

Sounds somewhat unintentional?

(I'm primarily complaining because my server side testbed strongly
dislikes options that are necessary for particular builds, but
break on other builds... :-) )

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--WfMobFV7e2tJUFZe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhjYZjAAoJEB2Cnv7KVigSxpcL/23NUX2NSRZxRnyB+MMWpeFY
nRjzyVefDnIWbkF0dAn8gsaWfqYRigjbWKyz5/u1wmkBIGHrYfw+umYG7Jkdzdx0
XO91yfkKMevvdQc1KRm+nalfIZKNiTWGzxLUoWF3MpEph5q/bWV9+r9mlUqTshoa
WLSY831RsEVxwLxx07uitnuk+RPHMkDQwiHJzdwRqMi3HtaTH/l7ofbd4zAs4NLY
fJRE7eHjcOs9XzgcziKOHXJ6tkdehwYYB28/CUEujEDJPeLmyVrAAJWCChTqnHze
pvg+68SF3QpWuCqRTVrsrXPzySnXaowE566bLxcBIcp5+Zc+oISHWC5FLrO+voYM
vv/wn93kqmFGdLi8jDJfIWEHdhLQnSV91oxhpo33ZfDwczjjb0hv8DKHG/j2pql6
rK9qXVkrkhERnfHMxz2YmyYke/bTSp+dvYzJNtSHeg7jVCBWY0izgdlA3Emgb2ba
nte/VvFc/fgOaCD4nh3PdhKV80a/tUcACiIS7cjUMA==
=jfuV
-----END PGP SIGNATURE-----

--WfMobFV7e2tJUFZe--

