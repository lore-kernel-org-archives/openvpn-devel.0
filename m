Date: Tue, 14 Nov 2023 08:05:58 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <ZVMcVuF1V_w9lNfO@...1296...>
References: <13E5C41C-8358-4252-A751-8FDA9EE95B7D@...2722...>
 <0acc8d93-6175-4d7e-a39a-269a9652ac3e@...1823...>
 <f2f54207-f37c-4c0d-96a3-a600cd2bb811@...1823...>
 <ZU3aVt0EgPyOQWEe@...1296...>
 <ae5ddbf4-44fd-4d4b-a045-53274aa9cc5d@...1823...>
 <fe0a4e43-4015-4834-a9bd-8764baf0134a@...1823...>
 <ZU39JoRBq8R_NgD6@...1296...> <ZU6I1MMD980Ervm-@...1296...>
 <CACDCbPq3O71Pjvaj0aBE8Dd-JQA3idZOxP+eyb=9if_MiLREQw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="+mc+GK6qXKiUKqhG"
Content-Disposition: inline
In-Reply-To: <CACDCbPq3O71Pjvaj0aBE8Dd-JQA3idZOxP+eyb=9if_MiLREQw@...278...>
Subject: Re: [Openvpn-devel] OpenVPN 2.6.7 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Greg Cox <gcox@...1057...>
Cc: Gert Doering <gert@...1296...>, Dmitry Melekhov <dm@...1823...>, openvpn-devel@lists.sourceforge.net

--+mc+GK6qXKiUKqhG
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Nov 12, 2023 at 06:08:48PM +0000, Greg Cox wrote:
> Spun this config up, then ran:
>=20
> iptables -t nat -A PREROUTING -i eth0 -p tcp -m multiport --dports 443,80
> -j REDIRECT --to-ports 1194
>=20
> Within 5 minutes the random web scanners found and segfaulted me.

... your port scanners are definitely better than mine - took more like 5
hours here to crash, but it confirms the current assumptions, ks->state
being S_UNDEF and ks->send_reliable being NULL.

Now, Arne's patch (if (ks->state =3D=3D S_UNDEF) { continue; }) *should* ha=
ve
fully fixed this, so I'm a bit surprised that we get "it still crashes"
reports...  will re-test with this setup and see what happens.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--+mc+GK6qXKiUKqhG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJlUxxWAAoJEB2Cnv7KVigSotML/i+uBeY8hqHB8iJhWgI+g84J
afE1pTuullnmnEl8DwUiNusXn6Pm8HhB4WAfKcXnRJDxK5hbLAx5MCB3xlMC0ycC
RclE1jwoRhrGXYuj8P7bkvs3vCL5CLuY6ZuVDGZAOV+52rifK2p0P0ZnRWDy4QPb
bZHDsJhnUIZeGaPDXLvBqG1CgNq1w4NrImYDA31IkZWUVRvKrFAva96K4eJc3wQM
dYPZTbHWSCVeG2r7jZ30Zk57wlYfq5JVH6zVhwrOzvg2heBNAF3TssxAi1QDjmYa
q7Bylhyt3RUoK5Vbumh5QNeXP6RBusKt8rD9tIK6qF2TD27TBnhQJ69w3uZxCPQe
9IWC2H7s72EQblcWRIPrw2WzNOEfzaaFG41Q4456Ie1D8a00AiUbLtxfvXpXPKII
u38qzJqOHkOQCIKOFFxi/FTBr63793pou2phJkIbJgYLhL/KtjSxPow+gsGmMuJb
nez2b32xZkjt3SM24GGHYDlQk6osslG8hkaa6BmiFw==
=Ihso
-----END PGP SIGNATURE-----

--+mc+GK6qXKiUKqhG--

