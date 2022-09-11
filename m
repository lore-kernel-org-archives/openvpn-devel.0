Date: Sun, 11 Sep 2022 22:47:49 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yx5JdRcEXh2tTqPE@...1296...>
References: <20220909144546.672-1-lstipakov@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="4k5kf3IWtE6z/se6"
Content-Disposition: inline
In-Reply-To: <20220909144546.672-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Use DCO on Windows by default
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

--4k5kf3IWtE6z/se6
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Sep 09, 2022 at 05:45:46PM +0300, Lev Stipakov wrote:
> +#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32)
>      if (dco_enabled(o))
>      {
> -        dco_check_option(M_USAGE, o);
> -        dco_check_startup_option(M_USAGE, o);
> +        /* check if any option should force disabling DCO */
> +        o->tuntap_options.disable_dco =3D !dco_check_option(D_DCO, o)
> +                                        || !dco_check_startup_option(D_D=
CO, o);
> +    }
> +    else
> +    {
> +        o->tuntap_options.disable_dco =3D true;
> +    }

This is a bit weird.  With the latest change, dco_enabled(o) will
only check tuntap_options.disable_dco - so, if that is false, disable_dco
is already true, so why set it in the "else" branch again?

> +#endif
> +
> +#ifdef _WIN32
> +    if (!o->tuntap_options.disable_dco)

... and why reference the variable directly here, instead of querying
dco_enabled(o)?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--4k5kf3IWtE6z/se6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjHkl1AAoJEB2Cnv7KVigSxcQL/0GjcqmZT5mxK7cyPAXtRg1y
a0w7TzeyRyc6dYuPpKHmKP5EhRqvwLI/OkDmMINmry8764+EM+SGF0Ex9r3ISad7
JEWsIwoorM10tP7PLQxxUu70fDiBILqJhrZQzo3ABId8fobFgtzDwfbUhY6apLq4
SaONNK6grym3+cGiD32AvbFbwYvi532fR1TJdTlUgYD14WEzjEjY0GMg/DsmsncI
F8INLbtMCYEOIcuzQmgns2QJg39Ij/NCY3f5HkQRFCdqZAkHlxUSBQraj8x7JPWb
CmuMj1zYbXIDHH43ylzpcYiOqmOFoV9JIUU6WXuhbUml5Xg/ZrJDSutCK0LBBrsB
ZwxfW0IZG5NfXMEhKiMWVg8haHP9TZqMXij8B+d3uRPHCyPOkHsaX1iPZLHarPRb
p9x5Y2b+EqzSc8x2eWiczsiK4xh7tvcTf0mDCncOSk6tyCVYQkhxjTnoRt3Z1mTm
lzm21cue+sA3tdAmq5VP2900hlJWFLm10kVaZdteVQ==
=yoiu
-----END PGP SIGNATURE-----

--4k5kf3IWtE6z/se6--

