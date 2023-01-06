Date: Fri, 6 Jan 2023 19:23:46 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y7hnMtVcspp0akPv@...1296...>
References: <20221227223506.34136-1-gert@...1296...>
 <4c469f03-c631-6839-7bd3-3ddda1b4f0b2@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="MPS2yEVn+CmWDpS9"
Content-Disposition: inline
In-Reply-To: <4c469f03-c631-6839-7bd3-3ddda1b4f0b2@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Undo FreeBSD 12.x workaround on IPv6
 ifconfig for 12.4 and up
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--MPS2yEVn+CmWDpS9
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jan 06, 2023 at 11:32:31AM +0100, Arne Schwabe wrote:
> > +#if defined(TARGET_FREEBSD) && __FreeBSD_version >=3D 1200000 \
> > +	&& __FreeBSD_version <=3D 1200000
> > +    /* On FreeBSD 12.0-12.3, there is ipv6_activate_all_interfaces=3D"=
YES"
>=20
>=20
> That does not look right. Should the second one be < 1300000? Otherwise=20
> I would rather simplify the expression to __FreeBSD_version =3D=3D 120000=
0=20
> since that is what it currently is.

Of course that needs to be 1300000 (and of course it "worked" in my=20
test on FreeBSD 13...  but it seems I forgot to re-test on 12.2/12.3)

v2 RSN.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--MPS2yEVn+CmWDpS9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjuGcyAAoJEB2Cnv7KVigSXQUMAKzhm1YGp1d1Uv9ykEE7g0uj
oObPOPeFJSdKQ2sQhc3064zGyxj+0qSFzzuNr/yoU1SNFCApnjDaISEZMGh+D+xG
oe04XpY+7UgAt4K+3sfRTGLvBTir37+X4vcz49+ZkcKfsQnhWB6E7jiVpUA/VLk7
owlayD4yfTSVYEBnmCgzKOMMvrp+RSNmYsm4miieS2Y9k+dVNeuXuF/F5PGYsYZh
orbhhGTT1yXZ2avOS2mqt9oJzCjueCEiP7vUOEnjzRpOvX0orVVMKSMI67e5ixod
oPcv/K7NfSBf+c2WOUtRfj8CxH98bpKOrKfiVkInu7NwQWPGgOEWB09yB4NxNWtt
k5X+1i3VbhtTn78hKuquVR9gdpNYZ9r0AuxyJxsdQ0lBOTo7h+aloS+7fo0cqiEJ
O8Hi0RQHIiDbFdHNvR8foj6FJvgakLVoaCbyDzxPVwhf8EpvnY3jP7m2nnNQcUSX
QsCHK6aKkgGXOMa7/KB4WnIso6qFyhwPJSzZQoV6Yw==
=u63o
-----END PGP SIGNATURE-----

--MPS2yEVn+CmWDpS9--

