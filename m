Date: Tue, 23 Nov 2021 15:37:34 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YZz8rvfK8ZLZW3iu@...1296...>
References: <CAGyAFMXpBRGHsTZQjRsr2ByoGx2G2isoqUwaZnwYX6NWWwZBpA@...278...>
 <CAKuzo_ggddGKgDewDWbjv3pNGAC-SK0dmD+Ay-c2HOHcVX5psA@...278...>
 <YZwNiBRC+V/E9OeI@...1296...>
 <CAKuzo_jicUu50x-CxGYE2DJjW0pwf06DCfMkhFn5vKz1AHCrcA@...278...>
 <YZyPoyofdC4M1CqU@...1296...>
 <CAGyAFMXE61tbhW=74jvoQLwegU2SjbFi8V-5JFGcEgO5=7OK2w@...278...>
 <YZzCbiezMd/zkrAO@...1296...>
 <CAGyAFMXZ9OJQJXxkOm6qVDEN4a9ZiMufgX5FTF2Bg9GtHrq4hA@...278...>
 <YZzXtauc1RuVvCGr@...1296...>
 <CAGyAFMXt4zN182f4womhiHFLtxhfhVU7fgxfZ4GAevhwKbAS0w@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="oBb0OB4xvHStzOW1"
Content-Disposition: inline
In-Reply-To: <CAGyAFMXt4zN182f4womhiHFLtxhfhVU7fgxfZ4GAevhwKbAS0w@...278...>
Subject: Re: [Openvpn-devel] OpenSSL build on Windows: OPENSSLDIR and
 MODULESDIR
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--oBb0OB4xvHStzOW1
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Nov 23, 2021 at 04:30:57PM +0200, Lev Stipakov wrote:
> See https://patchwork.openvpn.net/patch/2083/
>=20
> I only tested with procmon that openvpn.exe tries to load openssl.cnf
> from a trusted location.

Thanks.  For a non-windows person this looks good, but I leave the
final word on this to Selva - especially as he knows how to test this :-)

Do you have a MSVC build with this to use for testing?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--oBb0OB4xvHStzOW1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhnPyuAAoJEB2Cnv7KVigSErkL/Au6ox9/+TSiTm5fU0hZy6VD
2fLFK2f40QZ1U58n4wdvHexu9DPPC4Rmfsm9RwqK3psx1ysPH3MrLV6AP4s8CYIU
NlTixHLgJ/in0cajRGi6+VUeavwKl0SDoLFud8yhdwKUERW1Dgh1gYLQ9+gtihvK
ymMWP08u0oAGUNTC/94vtlkBixaG6FBVC4z2sIa60GNlz0nNSHJE05LDwSievkiC
4S/RWwyXJaY3kjet76RbYNOO7qQUZRjvpDxLXmuQ95bqH9BmFh7gGlIU6VRu8MrR
1ZJjI0Hfbq7Kiv9lkngbEZ2nICCwkTPEK2ZTwNzXqtsGdv3WK9R3/pB/5pijWdNe
0fX34Svof/Hl2CEjP7r9F1hpvfB4dL9aJ5jwGplAhLQun9AsjYZyGSndC3VB4jNu
dbDzMouLbot2cU35ro9VQo6cSqrPueDx4rJAW/HLyFyyjDU6QCfzwory/1DIu4X2
aqXI4hifBySoWHKG01NkGprl3ywXUh2dxHtv5bHtKA==
=Qp9q
-----END PGP SIGNATURE-----

--oBb0OB4xvHStzOW1--

