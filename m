Date: Tue, 23 Jun 2020 11:31:49 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200623093149.GF1431@...1296...>
References: <20200622113022.23047-1-davids@...515...>
 <CAKuzo_g7QxVL90ikT57H6b4+St2c860us6S3cN_6jbfeHujpzw@...278...>
 <a1cfd42d-e371-187a-55c2-f14a3a986b34@...1823...>
 <4562876f-45c1-d3bb-f725-52e9b78600de@...1227...>
 <20200623090252.GE1431@...1296...>
 <4f03e378-f327-21a6-9f11-fe06a42052b6@...1823...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="/aLBiNvUVU0lvNCt"
Content-Disposition: inline
In-Reply-To: <4f03e378-f327-21a6-9f11-fe06a42052b6@...1823...>
Subject: Re: [Openvpn-devel] [PATCH] systemd: Change the default cipher to
 AES-256-GCM for server configs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Dmitry Melekhov <dm@...1823...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--/aLBiNvUVU0lvNCt
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 23, 2020 at 01:12:42PM +0400, Dmitry Melekhov wrote:
> 23.06.2020 13:02, Gert Doering ??????????:
> > That patch is from Steffan, and review has been sitting in my lap for
> > way too long.  Need to see if it still applies.
>=20
> Unfortunately it is not compatible with 2.4.9, because of introduced=20
> change...

Depending on how intrusive that patch is, it won't go into 2.4.9 anyway
but into git master (to be 2.5.0 "some time this summer").

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--/aLBiNvUVU0lvNCt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJe8cwEAAoJEB2Cnv7KVigSI5ML/35OR9SsJPldz1WA3dACyXxg
eJRte46I9Xkv1QkdwZ7A2+p8pb8WyMihviWAXeahjq4sCKsYG/Ln36N8a8XBitUd
3HeU7zOhBHjtZwxFCQ3J2II45wjd2ieQv0qLUt/z3MdsoM8PEgYrh2mBGbUwuz/p
yxLZNXFjYEDrdco2VSU0us9nGdDRbmclKTNmebd6FJ3bv73ZwlEx5qbA81tbatkL
PBmjk2QWmwGB/nGxfQejfm09ldRnM4dHcAnNNrdB9p/uTVE7mPTwlnrpVmKf/cMT
OrxeWkuFUik2WmRF3Ry3O7oVKygPI+67faC30VQmGltqhlU3D8HqwzfZ+BcsNHdm
4WyXYy+0kmgMEZDd9n1jvQUQBV1NulFVQBb0cVNfpvHSF5PULPwP9GEAByygGuZy
NhSeeO+zs7iNAWtFdKXntz5aEBIRtYYbh7IurP1ajf9HKL3CGt5EaFUH5OU5kXYr
8O31wQbEgFGDtJxazKUNtnDjWbEu27nLIrMgE4qcnA==
=Q1sS
-----END PGP SIGNATURE-----

--/aLBiNvUVU0lvNCt--

