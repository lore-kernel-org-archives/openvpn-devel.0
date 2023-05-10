Date: Wed, 10 May 2023 13:57:00 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <ZFuGjLXBS9MTpVdl@...1296...>
References: <20230510112236.248026-1-frank@...2641...>
 <20230510112236.248026-3-frank@...2641...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Zu68dvB+HksJL87/"
Content-Disposition: inline
In-Reply-To: <20230510112236.248026-3-frank@...2641...>
Subject: Re: [Openvpn-devel] [PATCH 2/3] Change type of frame.mss_fix to
 uint16_t
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

--Zu68dvB+HksJL87/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, May 10, 2023 at 01:22:35PM +0200, Frank Lichtenheld wrote:
>                  }
> -                mssval =3D (opt[2]<<8)+opt[3];
> +                mssval =3D opt[2] << 8;
> +                mssval +=3D opt[3];

Is this an intentional change, or just a side effect of "something
intermediate"?

> @@ -7260,6 +7260,7 @@ add_option(struct options *options,
>              /* value specified, assume encapsulation is not
>               * included unless "mtu" follows later */
>              options->ce.mssfix =3D positive_atoi(p[1]);
> +            ASSERT(options->ce.mssfix <=3D UINT16_MAX);
>              options->ce.mssfix_encap =3D false;
>              options->ce.mssfix_default =3D false;

This part of the patch is making me unhappy, thus, NAK.  We do have
a way to signal option errors, and ASSERT() is not...  your code
would make a client ASSERT() if a server pushes "mssfix 70000".

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Zu68dvB+HksJL87/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJkW4aLAAoJEB2Cnv7KVigSbUQMAImjkQiUbhbGHGqOF4KKXgiW
K3DX2yXovG1/mFiPV/b5v93pBybyvO/bGyREY8YU4dVKdWEzuTMijA5XO+Wetkkg
Ta9fCKLBMg0guVhuu56tn/LIiVjbk/fSd8S82iy/XFP/InLzMhstlsTPCOr7qyPi
B/PILF7C7Cy8ZaT/37DD29bnNJWhydvzhan8uOXczllBjmuUy2LzQxK48TQHvnCt
HzT4/jCjC5dME5VwVcNszXNIO0BBGEYT0pOKiZWW/gjyC0xL5GzdEFz/PEADApSS
dezmSMhVWvtgmmjPaLlUYHT99q0fUT9quUhCX6ZMpBA3GyHVPXgAu6LwK2d77VgR
1CrQle/Eu5/ejLUPkOblGVmGVzUlkJRySwsTZ96myV+qwGfK8kQaxIx+GGr1XROs
4phQq9BXBfPTZFR1SDZT/BJh68VzTXQlSGBurWPd+k4roEQnG05UGXxFfwp/8vUL
IigPWE+Iy59YgWBdj8yT09kjv2jJR/Xe0sMBV3MSHA==
=ZUG8
-----END PGP SIGNATURE-----

--Zu68dvB+HksJL87/--

