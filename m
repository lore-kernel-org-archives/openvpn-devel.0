Date: Sat, 3 Apr 2021 11:56:40 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210403095640.GW976@...1296...>
References: <20210402134529.27866-1-gert@...1296...>
 <b92f02afa4d8156edd55c2126ae6352c.squirrel@...2260...>
 <20210402185720.GS976@...1296...>
 <c76250866ae96447a3ec712f04b4b346.squirrel@...2260...>
 <458e1fb5-a725-781b-c048-4f0e07440c7b@...1227...>
 <1cf9fe7a309a622eb0ddd79a34dd3af4.squirrel@...2556...>
 <a0648ba0-41ed-5eef-4f36-d41bcb636823@...2181...>
 <ec1f603d169af78b5fdf0cbc3b6f4e52.squirrel@...2556...>
 <9b3b2029-bb7d-ab1d-a69b-0d910565fad2@...2181...>
 <e477a1210a2efee09ee2eaccb604e164.squirrel@...2556...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="z57goIx8GvGkKnvt"
Content-Disposition: inline
In-Reply-To: <e477a1210a2efee09ee2eaccb604e164.squirrel@...2556...>
Subject: Re: [Openvpn-devel] [PATCH] Fix 'compress migrate' for 2.2 clients.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Matter <simon.matter@...2249...>
Cc: Antonio Quartulli <a@...2181...>, Arne Schwabe <arne@...1227...>, Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--z57goIx8GvGkKnvt
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Apr 03, 2021 at 11:52:59AM +0200, Simon Matter wrote:
> > It sounds like there is no answer to this?
> > Then why are we even discussing further?
>=20
> It could be at least one feature to prevent people from moving over to
> WireGuard?

Unless people can come up with real use cases why compression makes
sense for them, and just move over to wireguard "BECAUSE IT HAS NO
COMPRESSION EITHER, BUT YOU TOOK IT AWAY FROM ME!! STAMP FOOT!" this
is hardly a compelling argument.

Wireguard is a good protocol, and if what it can do for you is *enough*,
it might be a better solution.

OpenVPN solves a vastly larger problem space, so any comparision to
wireguard based on features that wireguard doesn't have is a bit weird.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--z57goIx8GvGkKnvt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgaDvYAAoJEB2Cnv7KVigSC30L/3bAKtK44M6LCvbd7NEr9OEC
Fh8RfG5BQMYezUqHdfxDnim5oYhJsxSdNV42gtkYluxTfVCZvnooIsaL3/S8TXNl
7HNugOThddUXGNCsP91cm46vEBYJgPH5dOMDRdf1rCyTUdFdXWB9F1j2ruXoglPr
EoTF86zEZj+ryRGfQ3xdS0Zq2+9dUmOVZZjPfLtvTNvdS65udKgdzJW1YQefQYdb
8+w9CVSN995W/Zkuhlvw6zwMjDF6XhWWzOW3xbAkwh4bA6IC22zOSC+fdyFur8md
epERkN48O/Tfa6jGf+/VFePJ5KMQY/Uiz9nubG1uV7xPvIQWiGfUWhuhhYtmlKXr
iQwkDiuXTCvsi+YDMsMaqi2D/LHhG69y9bIf59I96DS+zAbWGz5CnzAUNmrwCaPq
r4FgmXMU4JAtPdIDDn6K47EdR+2AkkV8JVmYEx5Lg6g3GW4dD5tCdd01ocFK+t2d
GCsKHLfcm7289rM8A+v0dulr1107aNCogOcO7KkV+g==
=1PeF
-----END PGP SIGNATURE-----

--z57goIx8GvGkKnvt--

