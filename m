Date: Sun, 16 May 2021 20:37:27 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210516183727.GW976@...1296...>
References: <20210125125628.30364-1-arne@...1227...>
 <20210125125628.30364-11-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="DAcROHIeMW+GxhID"
Content-Disposition: inline
In-Reply-To: <20210125125628.30364-11-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2 10/11] Implement --client-crresponse
 script options and plugin interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--DAcROHIeMW+GxhID
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jan 25, 2021 at 01:56:27PM +0100, Arne Schwabe wrote:
> This is allows scripts and pluginsto parse/react to a
> CR_RESPONSE message
>=20
> Patch V2: doc fixes, do not put script under ENABLE_PLUGIN

This one was left out to try for too long (sorry), and is no more applying=
=20
in a fairly big way...

error: patch failed: include/openvpn-plugin.h.in:84
error: include/openvpn-plugin.h.in: patch does not apply
error: patch failed: src/openvpn/init.c:2948
error: src/openvpn/init.c: patch does not apply
error: patch failed: src/openvpn/options.c:1284
error: src/openvpn/options.c: patch does not apply
error: patch failed: src/openvpn/options.h:440
error: src/openvpn/options.h: patch does not apply
error: patch failed: src/openvpn/push.c:228
error: src/openvpn/push.c: patch does not apply
error: patch failed: src/openvpn/ssl_common.h:316
error: src/openvpn/ssl_common.h: patch does not apply
error: patch failed: src/openvpn/ssl_verify.c:1232
error: src/openvpn/ssl_verify.c: patch does not apply
error: patch failed: src/openvpn/ssl_verify.h:209
error: src/openvpn/ssl_verify.h: patch does not apply

I assume you have a rebased version in your tree... can you resend
this one, please?

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--DAcROHIeMW+GxhID
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgoWP1AAoJEB2Cnv7KVigSJ5YMAJ2rEiTf59yV7D66qkhpkonV
txmF/L2tyL93eAMAVeOWDffTbw5zieLNRMERK+RtG/dW1uTu3nnQu+IKgxlCVZCe
acx0mFBjGd/7pNuT/AWvA6E4ZHunPbsafkvVU1NpQ2Nk08sRU/e3RMXjlsBqt+gI
Ytu2eMMVmN2ig1Iu3JhNQD4gD7Fb5K4ie4+t0ibO3d39tw9AjTo/0K4pq38wvo5P
MIB4S+cqwlrYKQE+TbNov6StG+vRQanuj5vgQbgjVpozoN0GEdMWkMcQF01Bqx2v
xXuEJG5UaIpmH/vKYz29RHGJ7IH00B5oojQHoxn63aCOqizdt26Engd1wbaCuJkO
nW6IjD6X62EoEkUQByyusKx+nrpaiKsiBzwFVot6FpMDzFgTvAbxLLeC2cXWOi6S
jtytj3F+Xy5aM6jN+EaIXwUHBGayez066XOPAtpCtMakRoezd/7b/3npCIqJZCIm
9/2Ap5hdIl+EeR68alWEjfVVLPmHKz7Ux08viMMbeA==
=bDUL
-----END PGP SIGNATURE-----

--DAcROHIeMW+GxhID--

