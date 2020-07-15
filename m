References: <20200711093655.23686-1-arne@...1227...>
 <20200711093655.23686-8-arne@...1227...>
 <a2282048-26d1-8f1c-44bb-a2226efb0e13@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <afd42ef2-9359-1ff5-f7e1-1986d727bb53@...1227...>
Date: Wed, 15 Jul 2020 15:22:28 +0200
MIME-Version: 1.0
In-Reply-To: <a2282048-26d1-8f1c-44bb-a2226efb0e13@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wIZXA9ZGBPUbT6D7JeSPL6NDLxOgI0gg7"
Subject: Re: [Openvpn-devel] [PATCH v5 08/14] client-connect: Add
 CC_RET_DEFERRED and cope with deferred client-connect
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wIZXA9ZGBPUbT6D7JeSPL6NDLxOgI0gg7
Content-Type: multipart/mixed; boundary="EkesJElIqfaQhvEB7nko3JeQHYp0kKXc6"

--EkesJElIqfaQhvEB7nko3JeQHYp0kKXc6
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 14.07.20 um 14:32 schrieb Antonio Quartulli:
> can we please add a variable for the index and make all these long lines
> saner? Now they are really ugly:
>=20
> int idx =3D defer_state->cur_handler_index;
> while (cc_succeeded
>        && client_connect_handlers[idx].main !=3D NULL)
>=20
> and also the lines in the loop itself.

we can but we need to do add

defer_state->cur_handler_index =3D idx;

in that case so the idx is saved for the next time the function is
called from a deferred context. Or you make it int* idx and do
client_connect_handlers[*idx]

Arne


--EkesJElIqfaQhvEB7nko3JeQHYp0kKXc6--

--wIZXA9ZGBPUbT6D7JeSPL6NDLxOgI0gg7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl8PAxQACgkQFRhsZwKx
RFR6Vg//TIJMTu7ou0hmhPIPQWreSOHb0vP0crUa0QQMYw0Lo1x51Gu4AJxNFY1L
gEG1lVGyckLk2Rty4RejrGjTIHJ5LBre9aj6VCSqiJ+Wn268jMDS1jnE/WGXy4ie
ncdcFC1JyMwI9HGYxCsEE2r8QyPhHVh0ktDHQ02N0pUtOPi42+aybRC62DMfUfw5
sPnO7eybvM02j7fMEmg7QWTbSTQfot7nHniVwcIceHlue+9n7BWIbvSeX2zJGWUo
OSAhjxx/sNaCO5/s7lqTOk0IfqDyJcT1qyuST7nB6638ABFMGbaEDHad7963WM2c
JZ8mgEruPKAokTDmAuhQIwhr7JV5hVUDeUqWXOe9S4RrJ46rnSb+KLnpxMf5UQiq
5LO0h5ukSAQCUYO7mcjzuiZ0gN2WpKqktc93ko9Eb2FnVwTGYtAtk8E6BItgR1AG
VxBggVrMzsDuUGDy+pnTmd+xeR7+hQ9MSWlNWJ5gAwmqvK0CnGdOMXVxqj+30Opi
p1cISfD56+TlCGJXwrcorX0VjrJYqIPXeCbJjlLqVAoIinRv2XBBOBWZbBKICgDE
oyPakayUbKzzuJxsvSIUA/oGnUt6fedW7nT/7OiQdEijGyuLDw3B3SfGjUfLo/JL
gZmz2O06LBH1N3b0l7ct0u6poZl078XaSOO3ylm59liWTi3JsSg=
=Rh85
-----END PGP SIGNATURE-----

--wIZXA9ZGBPUbT6D7JeSPL6NDLxOgI0gg7--

