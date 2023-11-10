Date: Fri, 10 Nov 2023 08:23:02 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <ZU3aVt0EgPyOQWEe@...1296...>
References: <13E5C41C-8358-4252-A751-8FDA9EE95B7D@...2722...>
 <0acc8d93-6175-4d7e-a39a-269a9652ac3e@...1823...>
 <f2f54207-f37c-4c0d-96a3-a600cd2bb811@...1823...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="7iB8DGFjGH4a94hS"
Content-Disposition: inline
In-Reply-To: <f2f54207-f37c-4c0d-96a3-a600cd2bb811@...1823...>
Subject: Re: [Openvpn-devel] OpenVPN 2.6.7 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Dmitry Melekhov <dm@...1823...>
Cc: openvpn-devel@lists.sourceforge.net

--7iB8DGFjGH4a94hS
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Nov 10, 2023 at 11:19:58AM +0400, Dmitry Melekhov wrote:
> OK, now I know what is broken.
>=20
> I have so called multihomed server,=A0 and multihomed udp does not work in
> 2.6.7.
>=20
> On server with only one external interface everything works OK.

Are you using --multihome in your config?  If not, please add this - UDP
on a server with multiple IP addresses of the same family (v4 or v6) can
not work reliably without --multihome.

If it does not work with --multihome, please send logs.

(There is one multihome-related code change in 2.6.6 -> 2.6.7, but that
should only ever trigger if you use DCO)

gert


--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--7iB8DGFjGH4a94hS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJlTdpWAAoJEB2Cnv7KVigS4KcMAII/IqP+NJ1BE9ZNGh9VaT6S
Pm+iyxOcsODslbe5qnBwQH19QUNTQTlANAJER0tHSDDpnKq3XtUDhxnWo8fIDGIF
Pxp9duOf3zwHyKW2yOyYyoaza6K2tv9O5HbFxTm+CMUTVrsQkogRz4IDLul9tCao
5Evg7/Ddh5+5FnxMuESDLpHAzp/5Euao7D5G2+IRwEvT8LnxQvEeI0HxU4ZQESUn
XDYnpGAQRgtS8pVM981ojo2fEBgvf9kL2aLzEkNxbShLvqiWGgeTcs9Dli2552cA
68d53OTiinYBkf602IezeRjsEcgw12Y7JA5cGXcq82EPHyKzannZUZ8h4YmXRfen
1k2s70kT52M0C6rdE0fC7UtQRTb/ipGZFvBXn9bRoNz+s1ZOL/BZMJ9WRmddU3B5
sOCRbAC0GzW3/gPT59jyyqhJcMancZONWWWRU5xxF4Q/DZ1e9AekFNIqgvgCu12O
ZygGyURq48nKyB900NnUSxTSvDSojxDeuPzo4nuWRg==
=SKcR
-----END PGP SIGNATURE-----

--7iB8DGFjGH4a94hS--

