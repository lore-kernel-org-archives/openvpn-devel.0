Date: Tue, 27 Dec 2022 16:52:34 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y6sUwho45Sw58437@...1296...>
References: <20221227022404.3468137-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="5dGwuCIujXODB3wy"
Content-Disposition: inline
In-Reply-To: <20221227022404.3468137-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2 1/4] Ensure we do not promote a
 TA_TIMEOUT to a TA_READ event with dco
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

--5dGwuCIujXODB3wy
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Dec 27, 2022 at 03:24:01AM +0100, Arne Schwabe wrote:
> with dco sometimes we end up promoting a timeout event to read event.
> For the residual read, this problem is probably not solvable without
> changing the kernel DCO API (ie. passing our residual on new_peer to
> let the kernel handle assembling the next packet.)
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>

So after a long and extensive round of testing (this one as it is,
and 1/4+2/4 against the gremlins) I can say that it does not break
anything, and fixes the "too many TCP connects will cause a fd=3D-1
recv() and subsequent crash".

After some more discussion on IRC neither Arne and I seem to really
fully understand the residual stuff, so not merging this yet, more
study is needed...

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--5dGwuCIujXODB3wy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjqxTCAAoJEB2Cnv7KVigS6AUL/RpnM8YuOqd4drXTK0v0dmOM
9eJj0DVWkgo3Ni4VVOdEorjlam54G62COCcgbXeoDp9DNXvamfLyD6SjTWePPkzK
Ymol+i5ewUxlHUua1YOBWSn2YXXoveK19j7ZhYfW6gNydWrE3uepZ2xwUiPpz3Oe
lRyhc4apC3bDjaNtFYcmoObK7MOiF9KuPD6b7cXm2905gH4w+whHJNgOTyNDaqQ8
LigNy7F3kR0MkBXSgzy+ni73czocLykXU+AUYDBjMPEFzfpdqoS0AszbuOQBC7NW
W3eRSmzeqf1unt+b02KdF9sHU7iTtT6UxWRCQS7jGsnarRMGGKiaYFvIYlNrp1FP
pR1rwR3GFs0gmx9TQorEpBJjtKck4rGTYwGnbF5koa+Les5B2QoMjBsInYYEmBYq
L0sZzxu/fHI/qfDpT56m0DPFtfpcuQpsNXqSVl4KENb8XWRrAqTjgqyOIAgmApSp
KzMbnuqwbYYY3ECM0gJVyJ0DglALsnKpX2WoS5UF5Q==
=/ThB
-----END PGP SIGNATURE-----

--5dGwuCIujXODB3wy--

