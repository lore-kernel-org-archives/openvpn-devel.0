Date: Tue, 21 Jul 2020 18:39:06 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200721163906.GE1431@...1296...>
References: <20200717160231.12042-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="jegqYwEjryNOq2+v"
Content-Disposition: inline
In-Reply-To: <20200717160231.12042-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] t_net.sh: drop hard dependency on
 t_client.rc
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

--jegqYwEjryNOq2+v
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jul 17, 2020 at 06:02:31PM +0200, Antonio Quartulli wrote:
> Right now t_net.sh depends on t_client.rc in order to source the
> RUN_SUDO variable only.

I was about to merge this ("nice and easy") but I think it's just
complicated.

> diff --git a/tests/t_net.sh b/tests/t_net.sh
> index c67c3df2..63732db9 100755
> --- a/tests/t_net.sh
> +++ b/tests/t_net.sh
> @@ -77,9 +77,7 @@ if [ -r "${top_builddir}"/t_client.rc ]; then
>  elif [ -r "${srcdir}"/t_client.rc ]; then
>      . "${srcdir}"/t_client.rc
>  else
> -    echo "$0: cannot find 't_client.rc' in build dir ('${top_builddir}')=
" >&2
> -    echo "$0: or source directory ('${srcdir}'). SKIPPING TEST." >&2
> -    exit 77
> +    RUN_SUDO=3D"${RUN_SUDO:-sudo}"
>  fi

Leave off the whole else clause.

>  if [ ! -x "$openvpn" ]; then
> @@ -117,8 +115,7 @@ else
>=20=20
>      if [ -z "$RUN_SUDO" ]
>      then
> -        echo "$0: this test must run be as root, or RUN_SUDO=3D... " >&2
> -        echo "      must be set correctly in 't_client.rc'. SKIP." >&2
> +        echo "$0: using t_client.rc, but RUN_SUDO=3D... is not defined c=
orrectly. SKIP. " >&2
>          exit 77

In here, print & set

      if [ -z "$RUN_SUDO" ]
      then
 +        echo "$0: no RUN_SUDO=3D... in t_client.rc or environment, defaul=
ting to 'sudo'." >&2
 +        echo "      if that does not work, set RUN_SUDO=3D correctly for =
your system." >&2
 +        RUN_SUDO=3Dsudo"
      fi

done - less code, message conveyed if needed.
=20=20
gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--jegqYwEjryNOq2+v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfFxopAAoJEB2Cnv7KVigSFLIL/RRI/EjcskIJjjwMswaSH3cg
XEjAqBMuqoNaWIfw+EAn+JoSrC+sss0U+hLF7wwFA/Th+CN1rllXc86Tx7alNxMa
iGJ7WmG1wjYsrj94UjRY+nb4fZ2Z7OehnqbpJ6RwYyqqcMF0E3XPl/+lHtDwsz5Z
L6Ih/cgFHILQuY0XpHAAta0eWNLx+qjvGDXpky6hDH3zjwqCxIF/rFzdqRQKgGKr
K4yPKk1G6XTHmgOXB9Tc0SwYuE2i+NSEsDckYoeEStHdHupOdfuagbCgpbwEW1ja
glqXZkuWW087VXtDHlH1hdvd2fRCZcuFue9weONYL2PdJkNEip3+brivOGh9KFO2
siIiIrZGZNGzYf1JiM72aK0TyVaQ/UzoqCsTeEeSL7nXnxeP8di4F+hGGVfJkH7R
dVx5caYOf3ahAVl5Ju9lG2rxambLBTqFmODRp1mY9x4d8irptWtdE1KPWrgmELL0
iogF6Mr6J+0z686J8PkrCQn9BKr+vUprxPVQvf0xww==
=aTr3
-----END PGP SIGNATURE-----

--jegqYwEjryNOq2+v--

