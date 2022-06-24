Date: Fri, 24 Jun 2022 12:35:47 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YrWTg6ZnqgtkezEP@...1296...>
References: <20220621161649.2872985-1-arne@...1227...>
 <20220621161649.2872985-5-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="M94lheRE7h3f+p/7"
Content-Disposition: inline
In-Reply-To: <20220621161649.2872985-5-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 5/6] Change default MTU in server mode
 to 1420 and push it to client
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

--M94lheRE7h3f+p/7
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 21, 2022 at 06:16:48PM +0200, Arne Schwabe wrote:
> This changes the default MTU of the tun-mtu to 1420 to avoid MTU related
> issues that are even more prominent when DCO server or clients are involv=
ed.

I'm not convinced that this change "by default" is a desirable change.

Being able to do that (pushable MTU) is good, but changing the default is
fairly fundamental, and it will break use cases that rely on 1500 inner
MTU (and outside fragmentation).=20

Originally, it was said that "with DCO, outside fragmentation is not
possible", but if I remember right, this turned out to be incorrect,
and implementations handle outside fragmentation just fine.  So there
seems to be no hard pressing need to change the default (I am willing
to be corrected if I misremember something).

Not saying that outside fragmentation is *desirable*, so for TCP,=20
"mssfix 1492 mtu" will (already) ensure we have no fragmentation
issues - whatever tun-mtu we have.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--M94lheRE7h3f+p/7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJitZODAAoJEB2Cnv7KVigSBt0L/0TPb1S0LYpdxjw9UyTqLF9A
o8tbVrZvbbLen/emZtEjhXell6G3d6YOSOAPRhtv145qg4gvCV5uh+z33HqoFx5N
xmrqj4x7Jw1VRypNzhO419hXBbMDHgBBN2KJd3Rb2u1k5Raxlb5fGAKv+day0JeH
KICGxST5t+wqL6Z2l0BXeYnJWDzI9Tf4nVhdklr7Dhdmtt/PkDmiSxlBfN1HCTE+
kdaj4InPa3VfxO/0exO6QTHWRZ2qI+pvpl0aVGlweyWIxB/Eig0eZV+R9t/BLDUs
gmZaeMTXsi1aYpB/xM3sQcLdFnsqRnminh0HL8fj4dye0l2ubMeqSQ/xi6mPPaCX
EGJ9QIBUYKjDIejeWvifLHQUuR9/lHWIrE+1VaZwzQ5fgS28kO1vGhOdjiscxWz0
My1ln+xosBqecKXSQAdKR8iGsV7X+XYBnItzEowQxKxniX2OhiwXl7rp/5aiF52v
cW+9g/iUaQj5wQsc0wKt4A6Ly1qnLT7pcTGAcfgz0A==
=pDfg
-----END PGP SIGNATURE-----

--M94lheRE7h3f+p/7--

