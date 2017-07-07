Date: Fri, 7 Jul 2017 23:11:16 +0200
From: Christian Hesse <list@...1798...>
Message-ID: <20170707231116.2bcf4fdf@...1799...>
In-Reply-To: <20170707195941.61773-1-thomas.veerman@...1862...>
References: <20170707195941.61773-1-thomas.veerman@...1862...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/7UleUaIF5G_T1EEu8GdT1_7";
	protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [PATCH] Fix socks_proxy_port pointing to
 invalid data
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Thomas Veerman via Openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Sig_/7UleUaIF5G_T1EEu8GdT1_7
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Thomas Veerman via Openvpn-devel <openvpn-devel@lists.sourceforge.net> on
Fri, 2017/07/07 21:59:
>          else if (streq(p[1], "SOCKS"))
>          {
>              ce->socks_proxy_server =3D string_alloc(p[2], gc);
> -            ce->socks_proxy_port =3D p[3];
> +            ce->socks_proxy_port =3D string_alloc(p[3], gc);
>              ret =3D true;
>          }
>      }

If we allocate memory here, is it freed later?

A quick look at options.h shows this is (const char *).
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/7UleUaIF5G_T1EEu8GdT1_7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAllf+PQACgkQiUUh18yA
9HYiUQf/Y27fkaXCORd/9yP2oGYmcA3jeQexC5r4S+99l/xPw4oVIbcoi5xyPydV
4ecSAWzA5acy0ZsnQUu5hiSJxlJKKzAmBmGyERZOpZ8QGli3LMq9v+XvrQcIOZsP
p9OsrFqGXXLYZZSSpTBBojoWx595tjbTvK627TkvA7nYUsOSdPNwHUO18yGak37m
HfptMk12flXBJNOsYEVtt3vpwTn2jcrJ5Hzhcg1iaBabrrWS2rsPB7rlpiyvw6T4
1OyHjk4cZ0VZAeij+j4XDg1dOPN17ga/3IkEs6Nb8MJqhGVbw2AYU4BQa17toSmR
MJ1DUBL22/bkgieoAjq9UJb4YoTMUQ==
=+dp3
-----END PGP SIGNATURE-----

--Sig_/7UleUaIF5G_T1EEu8GdT1_7--

