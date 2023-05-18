Date: Thu, 18 May 2023 09:09:44 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <ZGXPOEHPiim-dguK@...1296...>
References: <20230517200143.216-1-chipitsine@...277...>
 <a362a6e5-c80b-1473-d503-4e51befd22ee@...2181...>
 <f1428331-1d68-aafc-ba18-e7ce96ba363c@...68...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="7PJKGLlCn9Yv2jbV"
Content-Disposition: inline
In-Reply-To: <f1428331-1d68-aafc-ba18-e7ce96ba363c@...68...>
Subject: Re: [Openvpn-devel] [PATCH] src/openvpn/dco_freebsd.c: handle
 malloc failure
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Matthias Andree <matthias.andree@...68...>
Cc: openvpn-devel@lists.sourceforge.net

--7PJKGLlCn9Yv2jbV
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, May 18, 2023 at 09:00:26AM +0200, Matthias Andree wrote:
> That, and constants usually go on the left-hand side of comparison so
> the compiler flags the accidental if (foo =3D NULL) even if it does not
> produce "add a pair of parentheses if you really mean to use an
> assignment as if() expression" like warnings. You can't if (NULL =3D foo)=
...

This is actually not OpenVPN style today (it's "syzzer style" so we find
it in a few crypto modules).

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--7PJKGLlCn9Yv2jbV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJkZc84AAoJEB2Cnv7KVigSz/EL/3zRn0tG7NnfJvW00e7rX16L
6OITKtgWrT3STUKd9ljs2JQnaxXL8ocXt8Am3NNdS/WrwvEEZnJgRSUDexdsz/rt
KCZom68Dz3RC4YgBFOHi4KvDBxrIcsVTR+Lsehtflu+eT1VOa98YewPr92hyZQAP
Nexd0lX6i2rm/zG9R25FCmrdjWIzBAC3Gh8OVwLnC58Ldz5EnpB5xmCeSrN2TRar
ZJBL1ukTYZGHcEgC9UVQ9glxH/IGXOwg2bPk+0dSteIiclXj6DAMEqvqWL1z89n/
I1BxF7l1k+33Ak5KPQXunTVp38Dnct2Em9eD0/D5dZwc1vGm8oLt7+mrVlUPVJHx
ashoSsNrqCKGDGRvv2bJ6LfNAajptbN+4GosAcdZTLulVx+TU22SxZFIOQis7GrV
UUvv9T8luKHzsW83BLZgCdcAskOvVmBHsES5Ycboc0C6Yw1iPoaOH0dZNE8dJZ3x
2ssgNG4ibTwXsF1nPsWU2sVE4kQqloL14LTrEHnsXA==
=WIvd
-----END PGP SIGNATURE-----

--7PJKGLlCn9Yv2jbV--

