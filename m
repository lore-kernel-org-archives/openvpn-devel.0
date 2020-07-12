Date: Sun, 12 Jul 2020 09:50:26 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200712075026.GI1431@...1296...>
References: <20200711093655.23686-1-arne@...1227...>
 <202007111648.06BGmZ2N073942@...2054...>
 <591d5259-e8d7-a2e0-e3bd-cd9db28e3df8@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="VremfEz/oqFumKTK"
Content-Disposition: inline
In-Reply-To: <591d5259-e8d7-a2e0-e3bd-cd9db28e3df8@...1227...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Allow changing fallback
 cipher from ccd files/client-connect
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--VremfEz/oqFumKTK
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Jul 12, 2020 at 01:28:56AM +0200, Arne Schwabe wrote:
> > With the patch *and* forcing NCP on the server side by only allowing=20
> > CAMELLIA-128-CBC:
> >
> >   $ cat ccd/freebsd-74-amd64
> >   ncp-ciphers CAMELLIA-128-CBC
> >   cipher CAMELLIA-128-CBC
> >
> > it will actually do that:
[..]
>=20
> cipher only sets the fallback cipher if we find no common cipher. All
> ciphers in ncp-ciphers are still preferred to cipher. So to have the
> server pick the --cipher from the either general config or ccd config,
> none of the cipher in ncp-ciphers may be supported by the peer (so not
> in ncp-ciphers/ncp-ciphers and not as --cipher)

More details on the scenario:

The client here is a stock 2.4 client, with "nothing" in the config -=20
so it sends IV_NCP=3D1, but no cipher list, and OCC cipher is "bf-cbc".

In ccd/, if I have *just* "ncp-ciphers CAMELLIA-128-CBC", it will actually
fallback to "bf-cbc".  Which matches your description: no common ciphers
(IV_NCP=3D1 =3D AES-128-GCM:AES-256-GCM) -> fallback cipher (bf-cbc).


So, shorter: you're right :-) - and if we want to force a cipher for a
NCP-capable client, it needs "cipher" *and* "ncp-ciphers" in ccd/, because
otherwise NCP will just override our config.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--VremfEz/oqFumKTK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfCsDBAAoJEB2Cnv7KVigSTMkL/iPFWe0lgygInSsxwXYPOW6m
6Xkf78V3TZ5d9eMxqCmwYvjj/Tiaq12XrN61JSVkeOU5On5nNfO7vj2R/eGHdKjm
5j1tbN1jIAiE85iFyP75k9HsufZvufYBvOxG4dwfzWBarKTZ4D09NRHn47WQ/EGN
U3UVE8wLQbAq+cwyq3Mw0XDr2yI1eChR6LPAu03tJYM4Qtz1StUdSfkmeIiVVPcN
KXGT4Isev6eqhk64cAn4OuIpte89MpWuvq/iKlFTQCg7+2IpRyRR/fOUYogEm8q5
X5VuZ5Ln1vqRQqZqyuVZJ01wc1ji7YVM4f85cbo6ML+jfU7n2f3irZtC2dCFuurK
c3VPpHcG5INgT9pGLucvyTUomxZS26FjeCkBOoSI+DiXLcELDge5UyUs2qbruMIU
HEKJ5pz2cHbEcxethKjx+GODpTSJeDMUDTTQU8ZurWET4YANdOo1/Y9QxCr289OM
D+UAmap2LKaKsv00oSYAEsbxlUobbYvGtXy8HhIASA==
=GFEc
-----END PGP SIGNATURE-----

--VremfEz/oqFumKTK--

