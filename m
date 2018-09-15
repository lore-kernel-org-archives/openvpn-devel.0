Date: Sat, 15 Sep 2018 10:00:20 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180915080020.GQ962@...1296...>
References: <DM5PR08MB3642F01D339F64AF7E9029EFB9190@...2422...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="lFd1dPlLw0MeZdw2"
Content-Disposition: inline
In-Reply-To: <DM5PR08MB3642F01D339F64AF7E9029EFB9190@...2422...>
Subject: Re: [Openvpn-devel] Traffic through Cloudflare
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Morris, Russell" <rmorris@...1315...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--lFd1dPlLw0MeZdw2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Sep 14, 2018 at 09:10:12PM +0000, Morris, Russell wrote:
>=20
> Perhaps a dumb question, but I recently set up my (HTTPS) server through =
Cloudflare, enabling their proxy service. Now when I try to connect to Open=
VPN, I get the following?
>=20
> WARNING: Bad encapsulated packet length from peer (18516), which must be =
> 0 and <=3D 1626 - please ensure that --tun-mtu or --link-mtu is equal on =
both peers - this condition could also indicate a possible active attack on=
 the TCP link - [Attempting restart...]
>=20
> Have other seen this? Is it expected?
>=20
> Thanks in advance!

OpenVPN is not using HTTPS, so you can't connect through a reverse proxy=20
(which is what Cloudflare does).

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--lFd1dPlLw0MeZdw2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbnLwUAAoJEB2Cnv7KVigS8wUMAIM1tJWSrsQ4nYYf32zy5Uue
t+nA4z+GuWX57kkoSxqsP/LYx77YBR2RqAisNlcE5JFUbdKnvAwHKi/fHjibbhPu
UeqPYxapGT3+wFFrHO06cZXCZp7ziXgT9o0H7UQgu76/xJPDhhGxaj5WupmyXmhn
3lc0Vuuzv/npLqYj10h2A0+Njz2JtPcAH/ZWfZ4ABgUVfhaCnX1C5LgeBZ351Ncg
xuokvhM7BwMo0KVlmWpIeIuGcU3Qd0mat9qGvp7Fipp/RW1IpgOT4LtgUCD3siIB
6kKKhWerc9iKe1UiKnnOHu8qo+D/NMPpg0SqSlQ2cIfCndzBvvmQdm7Qmd2kMPBM
BwtJ83ZKwit/+WXdlIkfm59pfcdVFVjg+op8PbxFFLfWpPHhPSqrud+tYVWG4EMD
xDzHmXhPWjwXdRSQvhPegZhTqdKaQyBhlxXsjA546pAGrQ9bIgVl1f/fSN84/cq0
ZHojOQUYCEtu5/OXmI8dbo1aSg2zZDM4S5Nw3T/l+g==
=BXmg
-----END PGP SIGNATURE-----

--lFd1dPlLw0MeZdw2--

