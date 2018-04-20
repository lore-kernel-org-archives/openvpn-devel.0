Date: Fri, 20 Apr 2018 10:00:26 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180420080026.GZ69387@...1296...>
References: <d75b57da-d1ca-d4ca-41c1-f9af06ec54bb@...1918...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="2feB3zb0jOhi7Lym"
Content-Disposition: inline
In-Reply-To: <d75b57da-d1ca-d4ca-41c1-f9af06ec54bb@...1918...>
Subject: Re: [Openvpn-devel] [Patch] Support client reason from auth plugin
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Eric Thorpe <eric@...1918...>
Cc: openvpn-devel@lists.sourceforge.net

--2feB3zb0jOhi7Lym
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Apr 20, 2018 at 03:20:26PM +1000, Eric Thorpe wrote:
> This patch allows for a client reason to be returned from an auth plugin=
=20
> and sent to the connecting client on an auth fail. This change is=20
> backwards compatible with existing plugins and hasn't caused issues with=
=20
> existing plugins like the included pam plugin in our testing. The main=20
> purpose of this change is to support dynamic challenge/response from=20
> plugins, currently this is only possible from the management interface.

I find this highly interesting, so "feature ACK".  No idea about the
code though... David and Selva understand plugins :-)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--2feB3zb0jOhi7Lym
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJa2Z4ZAAoJEB2Cnv7KVigSx9ML/iZAp3LWNqIa6fVeNqGnQpN7
yB3R+Nowy48HCVu+vxQexGDhlOIuoyIicBQ8LDoz+MpPQl00YJpSA/T5tzS57p7p
YChQ4O+G2M95qMDF8njbw65xdiOCms51ToMgzNGktDrnsTaeXwCgjJPWA7yNexYI
E86IstVQ/tcqbjZcF6CWzVT6OPxPlhFW9DkJPYWgxQOQ/DojpMuaGJ+rgSV7araT
1mBR2P9ciAz1uCLP6S8l9bTjvJRnjl3wQRIHf6y8prrafkB8d/zB7SK4PvlHBylp
w/i+s1PjpIndMT6o2sKKFmJjmDnAvZ8kJ1BNezaWXERZApFj5AbQ6f+1G1L8226s
UFiimc03wWeA60cQxMzRWtW0RglMjE5Q4k6g/+S/2Qb4QEByFyMEReeAnHAkZat5
9PLnwOaROroOfuTj4g2S2C+aqtLRgmbK8ipOXYon6sUClkUU0z+NG5pY9mgJl4Y3
mN4zgta4doaGrd3426AmTD8C3I1RTkDhSEcMOZX6UA==
=J9zu
-----END PGP SIGNATURE-----

--2feB3zb0jOhi7Lym--

