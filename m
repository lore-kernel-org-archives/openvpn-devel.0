Date: Thu, 6 Jun 2024 15:19:29 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <ZmG3YcvZhoPGkPe8@...1296...>
References: <ZmGqRY9vRywrLUHD@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="GBHAtRnPbOaL9mIa"
Content-Disposition: inline
In-Reply-To: <ZmGqRY9vRywrLUHD@...1296...>
Subject: Re: [Openvpn-devel] windows client tests needed
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

--GBHAtRnPbOaL9mIa
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jun 06, 2024 at 02:23:33PM +0200, Gert Doering wrote:
> Now - this code has been merged into "git master", and installers
> are here:
>=20
>    https://github.com/OpenVPN/openvpn-build/actions/runs/9391365526?pr=3D=
641
>=20
> (bottom of the page, "Artifacts", .zip files with a .msi inside).

... or (freshly repared) .msi with timestamp directly here:

https://build.openvpn.net/downloads/snapshots/github-actions/openvpn2/

(2024060T*-13ee7f90 or younger)

The filenames on that page are "build time - commit ID", and the script
did not work correctly for a month - so the 9d92221e commit "built today"
is actually a 4 week old commit...

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--GBHAtRnPbOaL9mIa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJmYbdhAAoJEB2Cnv7KVigSpzQMAKfPAfVhCjL7d+9UvbQcTfdx
kL1ilz4Ch+Qxty/3VwxYJzGPm8Daw+k1IG647aiNpvk0WxaiFYDlxQgQRjaV1xS3
v0zg7Ni/vdmjGHKvVWDPeT9cOUk/0pRpi7C2AV0j7CyjVRxqgqn28qcd03eq/Jwe
if3NGckyTQguYfUC3ngZRkcpffgwuXq943NLDmyY9gGca23aaTQHJ0DLNP8k/tpS
U7RsKif22psNzNlwtqL9qWtAN8rifyFKdyt6/tdOp+HaMBOJkxzOgN0s2ki4qT4K
0tI/5RyEJrrCaj6fas7Gh/Flfhk9f9aHp4nvlKz/L6th7Vz92VPgpa4+UEzDfvVD
oC9w0aU0ya2AuM+HEilGE+cZNeclWr7XcMMM5VesJ3rs/rSMB4ryTYxIHy5teJ4N
Src8EwkWFvAqiKHxD435ZCm2G+HV5VevsuPHx8N3OXB4IpTQ9Hmt30YSG0WE88jA
C6nqTAKP7xBDzRsnozObUNtEkDZii0jIpyQC7iQtcQ==
=2G9F
-----END PGP SIGNATURE-----

--GBHAtRnPbOaL9mIa--

