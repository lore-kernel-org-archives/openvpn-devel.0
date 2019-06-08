Date: Sat, 8 Jun 2019 17:11:24 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190608151124.GB1097@...1296...>
References: <6dc68129-a70d-2283-9ab7-b7621e6871b2@...68...>
 <3b604c5e-1421-4286-0a54-2875e0ec1645@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="6zipuvUKAEymKn2g"
Content-Disposition: inline
In-Reply-To: <3b604c5e-1421-4286-0a54-2875e0ec1645@...1227...>
Subject: Re: [Openvpn-devel] RFC: release/2.4 (OpenVPN 2.4.7) patch for
 building with LibreSSL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Matthias Andree <matthias.andree@...68...>, openvpn-devel@lists.sourceforge.net, Luca Pizzamiglio <pizzamig@...1249...>

--6zipuvUKAEymKn2g
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jun 08, 2019 at 02:57:27PM +0200, Arne Schwabe wrote:
> Am 07.06.19 um 20:26 schrieb Matthias Andree:
> > FreeBSD has received a patch contribution to enable OpenVPN 2.4.x to be
> > built with LibreSSL. I'm seeking comments, and yes I am aware of
> > master's a47508606be2c6359d4b27c3b65b72dfe4786222 commit description
> > that claims LibreSSL isn't in the best shape for TLS 1.3.
> >=20
>=20
> I think got/merged already a similar patch to master. So this patch
> might be just a backport of it?

cherry-picking a47508606be2c6359d to 2.4 doesn't work "trivially", as
there are some conflicts - I think it might make sense to backport it,
but have no time to do it myself and test against the different library
variants (1.0, 1.1.1, libressl) .

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--6zipuvUKAEymKn2g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJc+9AbAAoJEB2Cnv7KVigSjLUL/1e7dZWWRwb3OCHLe5srr/EZ
zglz4RUuGmzdAMLLjxupPgeZImU4gcU4GCupKQPkx4iQBq7njnZMChznkUPN2HL4
HO6FqvvRAxpGufuQ7lTPn7Cs1qzpbupRymAb/nmYLt7cufRBJONMPeqUcQ/wbf6M
d/45QeGpVueSO3wkpqEYYuZXyAEp7NyLEKLkT1mzcmqUaE2oFJFqNNi1666SbTpt
f3eW63Q6Lkan4GpkrRh6R9vvJcXeChlCT0Ki3BmZ2LiB+6Iizx0S8N+FwyylHKLk
O4B129mO9R8BweeRzTUxzNTXH1oYLanklTJd6Dc39+d0jTXppIDLsLO9WSXPTDuw
8fuRAZGei5MlU5GVnBkEUQ7w2CItQ0UOGVkpKiSliCA2al1Y4kRKpchZtf77uy4S
ZcbsDMT6pNahEHYAlZqkjuZxA98aYKTcUBiVUxpVFE67ccAPPHHvp3KZIyFXKGLZ
hNg566AEWhxQQSqWUjmnzoGzjgRBIhfet6qLIF5EQg==
=3SJ7
-----END PGP SIGNATURE-----

--6zipuvUKAEymKn2g--

