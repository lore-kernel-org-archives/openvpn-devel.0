Date: Sat, 25 Mar 2017 14:17:46 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170325131746.GC93896@...1296...>
References: <1490444478-13188-1-git-send-email-chipitsine@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="usyL0w4d7uF4jsG9"
Content-Disposition: inline
In-Reply-To: <1490444478-13188-1-git-send-email-chipitsine@...277...>
Subject: Re: [Openvpn-devel] [PATCH] resolve format string warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Ilya Shipitsin <chipitsine@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--usyL0w4d7uF4jsG9
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Mar 25, 2017 at 05:21:18PM +0500, Ilya Shipitsin wrote:
> [src/openvpn/options.c:1163]: (warning) %x in format string (no. 1) requi=
res 'unsigned int *' but the argument type is 'signed int *'.

Please use "uint8_t" then, and also adapt the "ret[i] =3D (uint8_t)byte"
line - the cast would then be obsolete.

Fixing compiler warnings needs to be done with a view of the surrounding
context, otherwise it just makes complicated and inconsistant code.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--usyL0w4d7uF4jsG9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJY1m36AAoJEB2Cnv7KVigSc1sL/3Ezx2LKALog212q1VRRNKu8
vuXAJzWstkDKJdf7DAcHzw59Zido4EGnxRVOjzoa7b9cqOSlLKwwCAWOIHKJLCYP
Xu2wXfC5fJ0Y4WIfjnL7+8rw6GhyNMqocGxP47/MJnCIofYzZfW4ku+EEys/3Ynw
HHbbVBD3yXwTfqbSvGvF/bPHHwEb9D4xHDGDsfVIGqNYwCVqOefk2NWcNxjYIIgo
pHl159wzrAlNNPnNWUmBQQBrux7b8UNIsw47iWNFNTu/vDAI+SQFqEg12aKGUemp
hBNTXRWdZxSdPUm9jwChZEy93rc09Q+whTfUQxRFsqh1VTAX9H3jdNc4YccM+j6W
Fx62G0Q5+WHwy7E6nIVOtMAqOhCZ/51dGXfMOWadkIuCJkcW0pNe2fAQDDUgc8/i
LjdOkyJAy6zSbg1+IHi73qLUIs6ev8A3XioWI8RphzDsxnXYyPcwdOSqbbfrfQMx
rDuKy+e+FI13D1TSqHD6tdK1v7qQK+Q8QNYDXTOxKg==
=g2yf
-----END PGP SIGNATURE-----

--usyL0w4d7uF4jsG9--

