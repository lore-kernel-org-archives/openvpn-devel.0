Date: Mon, 2 Aug 2021 17:30:43 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YQgPowECDDVqaCKy@...1296...>
References: <20210802115521.699150-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="I4RUKU7soNUpj5+L"
Content-Disposition: inline
In-Reply-To: <20210802115521.699150-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2] Modernise OpenVPN defaults and
 introduce '--compat-mode'
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

--I4RUKU7soNUpj5+L
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Aug 02, 2021 at 01:55:21PM +0200, Arne Schwabe wrote:
> +static void
> +options_set_backwards_compatible_options(struct options *o)
> +{
> +    /* TLS min version is not set */
> +    if ((o->ssl_flags & SSLF_TLS_VERSION_MIN_MASK) =3D=3D 0)
> +    {
> +        if (!need_compatibility(o, 203070))
[..]

> +    else if (streq(p[0], "compat-mode") && p[1] && !p[3])
> +    {
> +        unsigned int major, minor, patch;
> +        if (!(sscanf(p[1], "%u.%u.%u", &major, &minor, &patch) =3D=3D 3))
> +        {
> +            msg(msglevel, "cannot parse version number for -compat-mode:=
 %s", p[1]);
> +            goto err;
> +        }
> +
> +        options->backwards_compatible =3D major * 10000 + minor * 100 + =
patch;
> +    }

I think the math is wrong here.

If I try this out with "9.9.9", I arrive at 9*10000+9*100+9 =3D 90909, which
is way below "203070".  So whatever you specify here will always cause
"enable backwards compat before 2.3.7".

Thus, NAK on v2...

gert



--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--I4RUKU7soNUpj5+L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhCA+iAAoJEB2Cnv7KVigSkFwMAKkgB3IYrBiu0fd0XVGX8cS+
PLZLgBcVwOl1lgnILctI25DfJYpWlJP2IaXmWDe/wUvbP+Kw3Q0Jwi8DrVQOyLGh
ooR4IXqubaLmd+G7n0hMAlwt4bTv2lvWbTiapfsX5Nf6MAA5Rl745jEKubDZRZ7I
Gfm0/I82rgciqJ/32agR1YLTY/8R/ENL77Rlz3dMdd4MxTGQ4RCqVlaXGgD6va7T
fpOIo708AaOl4YFRfe0K2kPDMpvXnnwD33LongDozn+y0Aijx7co6ZBq+hlNyLql
AUgNyN03h8epKtHkVWbEBXZMqpqjfJRsjDBVsbef/Jkj9H4HXhBogamlp19SY6GC
zUsfX5+xnB9lAXiy7hetGL6Fotz+d5EMJ8AntLYVwoaXQwVQVjU6RNXktZ9cDw+B
J7K1BcRaU7wWCA8q3ER8Y/8JaO1a3yYBfOEvU4jIio+T/1qFJ7XSbZqV7C7zB4+I
CpwvCMeamEFIMF1MClsi9OhfCnkacqD/ssHXlbDvmg==
=dgaN
-----END PGP SIGNATURE-----

--I4RUKU7soNUpj5+L--

