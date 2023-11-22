Date: Wed, 22 Nov 2023 22:51:06 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <ZV53yiEO_4y2TvGy@...1296...>
References: <20231122143110.58520-1-dazo+openvpn@...2108...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="NrRHyydSIsg5t1Og"
Content-Disposition: inline
In-Reply-To: <20231122143110.58520-1-dazo+openvpn@...2108...>
Subject: Re: [Openvpn-devel] [PATCH release/2.6] Remove --tls-export-cert
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <dazo+openvpn@...2108...>
Cc: openvpn-devel@lists.sourceforge.net, David Sommerseth <davids@...515...>

--NrRHyydSIsg5t1Og
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 22, 2023 at 03:31:10PM +0100, David Sommerseth wrote:
> From: David Sommerseth <davids@...515...>
>=20
> As OpenVPN 2.6+ is doing some adoptions to the license text, all
> prior contributors need to accept this new text.  Unfortunately, Mathieu
> Giannecchini who implemented the --tls-export-cert feature did not
> respond at all.  Without an explicit acceptance we need to remove this
> feature to avoid potential legal complications.
>=20
> If this is still a wanted feature, it will need to be re-implemented
> from scratch.

Is this significantly different from the "master" patch that it needs
an extra 2.6 patch?

(So now I have 4 patches to deal with, not "1 that goes to master +
release/2.6"...)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--NrRHyydSIsg5t1Og
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJlXnfKAAoJEB2Cnv7KVigS/gUMAJ0PiI6JETsDe6IaTeb4FiAq
CV8mf2VcrZ5Tq4bvvqsduuDPKwO8Au9pHeRyulR5lI4skKCGGegiPjEb0/30daFu
+QdL932Vts7Cmq1FJpnwSnZ7hxcedo7XSr7QKmrQzh+50dGTpHP0lxlqgVKWUqek
4/JqsYZVO/Oiq9Xv/v1kglVj1p48NFSD58uTjfHiYtuKIHAdlzYG6QsampdDvOBN
WFN9YcmRShPH8laQmfvIXOUuWKXhzZ0an8OAftOpe8vNeBVy5tshmnoSiYbbnS9q
ZEYgwRJjZjJXqKGl7+8peiPIb+OLXpQJdvf+ccEB6cjX920HhWqQqkd2JO1WqHFK
9L5hTxymi6Taxuit7Nf+U6fT2O4qrDshDBTQGVJyDYiYWjpNJ+75FST7+qBmwmA7
i7gHmaUmhmqknkcFHp/FyPR0oqdxxQGnpG85hJGXXx4ynyZU+usQp6OwmHgWeuqy
nlV1ZUw3P2EyTSYaT4BjgrZy8xKMf87Iaj+JdNCAPA==
=kL3Q
-----END PGP SIGNATURE-----

--NrRHyydSIsg5t1Og--

