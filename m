Date: Mon, 5 Apr 2021 12:38:56 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210405103856.GO976@...1296...>
References: <20210405080007.1665-1-a@...2181...>
 <20210405080007.1665-3-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="0fC0yQYhV8hAN5cD"
Content-Disposition: inline
In-Reply-To: <20210405080007.1665-3-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 3/3] ssl: remove unneeded if block
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Antonio Quartulli <antonio@...515...>

--0fC0yQYhV8hAN5cD
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Apr 05, 2021 at 10:00:07AM +0200, Antonio Quartulli wrote:
>      /* compute PRF */
> -    if (!ssl_tls1_PRF(BPTR(&seed), BLEN(&seed), secret, secret_len, outp=
ut, output_len))
> -    {
> -        ret =3D false;
> -    }
> +    ret =3D ssl_tls1_PRF(BPTR(&seed), BLEN(&seed), secret, secret_len, o=
utput,
> +                       output_len);

If touching this, I would move the "bool ret" declaration to here as
well.  Doesn't make sense to have a "bool ret =3D true" declaration 15
lines further up if the first use is "assign it a new value", then.

Thus,

+    bool ret =3D ssl_tls1_PRF(BPTR(&seed), BLEN(&seed), secret, secret_len,
+                            output, output_len);

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--0fC0yQYhV8hAN5cD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgaui/AAoJEB2Cnv7KVigSRykMAJf6vCxNc4Drzw2L1srxLBdd
bzcGoi2g7KZJvJuhLB6ZtEsZ4RQL24x1ETXTAVEdPnk4yKZayKG3MjCZAFHAbF0Z
p49NVg/QF6qgUVfw/AaoqX/aonVc2oHUbd7fvx3XJCdz26B9U5aPCxFIx7vHBGCo
05j0A3FFty0klO0v6RJYVups+0MAHk2phlHrAZu683ZwZDmOYEMwqY1BL+vo+eLQ
2SrbuGH9+e2VkygXGyUqnnMESnVgl6FggkkkfH5s9e1U2BohnrDKJ9vsJGk//sQY
DuFsv+EwF0ij9fDY/202YrYEkdq2kEOUoGpmbHDMpYuXF8LonCWLpxJMX5QalUBA
LIOob5rXWz7LLTZPv5QJT0JWPdDL0UIH0L58VSyx4IyqWsGXzk93f+dhFX59kFle
QiV5+y+4FEJN3Hx0IUcLOciB7hOxXln61rpZ644ZLe1ImVByYRWI2bJOtHuwdIDi
xC9PEoRq1NyS3NCvj8yds/Uk7terKI5saNZRlHg2fQ==
=OEgn
-----END PGP SIGNATURE-----

--0fC0yQYhV8hAN5cD--

