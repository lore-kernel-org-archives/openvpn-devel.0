Date: Sat, 28 Mar 2020 12:33:27 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20200328113327.GO1431@...1296...>
References: <20191116102835.22883-1-arne@...1227...>
 <2ce5e07d-ac3d-4034-c2e1-56a00cb332bc@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="WZgDvI3PL8w3LDGC"
Content-Disposition: inline
In-Reply-To: <2ce5e07d-ac3d-4034-c2e1-56a00cb332bc@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Reformat all source files
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

--WZgDvI3PL8w3LDGC
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Mar 27, 2020 at 04:24:00PM +0100, David Sommerseth wrote:
> On 16/11/2019 11:28, Arne Schwabe wrote:
> > Over time some patches slipped in that were not 100% complient to uncru=
stify
> > This rerun fixes those issues
[..]
> Only done quick code review and RHEL-7 build.  Changes looks reasonable a=
nd is
> by far closer to what I would expect our coding style to look like.
>=20
> Acked-By: David Sommerseth <davids@...515...>

... but it does not apply to current git master...?

Applying: Reformat all source files
error: patch failed: src/openvpn/tun.c:3418
error: src/openvpn/tun.c: patch does not apply
Patch failed at 0001 Reformat all source files

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--WZgDvI3PL8w3LDGC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJefzYGAAoJEB2Cnv7KVigS62IL+gJjJ5hrBnuhzshax+uhQu0L
vqfuweA0d3k3pHYT9FtF9vLlpPTc76YgSNqGd8+UIxrDf1jb096lqm5++aeuuIBV
oSRbWls8zXBXlnuOJq5vNY5HupdK7JWDyQ1v16ylu94C0Db8ABexmSd8k9v91Xw1
gurJ8uvyf2TSCycoe1Mi09cxcb71WYy3XRKx3NijKrNESqWH0Dj3GQUXYDF3uTze
6I2TnesAc/Gf7eTM9+Ji9+HsgNlwLACJojfPFZB2lLHlahJ+MbMDCDuISTlWjxab
BNaUCk86bVq6KYOgu5eqr7DSCRyX3/w4Oft6G+TZWXk6R37mQldGt6iy6gYN0EvQ
8/ixmJGQGH07dHmqZr+MgNbwXhnR8aPlBgULUKXB31P+YqCYV8F7v5Y3ByccwIdo
hEkC/W6KYrILeHQMpwW4WG7QUF8Tk+UT8Nb8nnn0Q/fyJIvlbM+KeKoTETKV00OJ
L2BDyjC/66o4/sQc26k67+BqFGLGHRl+lwpLkOe6zA==
=ZRRo
-----END PGP SIGNATURE-----

--WZgDvI3PL8w3LDGC--

