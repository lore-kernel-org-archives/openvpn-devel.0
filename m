Date: Wed, 7 May 2025 11:11:06 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <aBsjqjXwhr4TxTWb@...1296...>
References: <20250507085632.15329-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="97FlI3jjXM9/TN9B"
Content-Disposition: inline
In-Reply-To: <20250507085632.15329-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH ovpn-net-next] ovpn: don't drop skb's
 dst when xmitting packet
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Antonio Quartulli <antonio@...515...>, sd@...2891..., Gert Doering <gert@...1296...>

--97FlI3jjXM9/TN9B
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, May 07, 2025 at 10:56:32AM +0200, Antonio Quartulli wrote:
> Clear the IFF_XMIT_DST_RELEASE flag during interface setup to allow
> the route entry (skb's dst) to survive and thus be inspected
> by the routing logic.

Tested, fixes the problem I reported in

  https://github.com/OpenVPN/ovpn-net-next/issues/2

... and is also the arguably correct thing to do - packet forwarding
resolves a next-hop for us, so we should ensure we see & use it :-)

Tested-by: Gert Doering <gert@...1296...>
Acked-by: Gert Doering <gert@...1296...>

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--97FlI3jjXM9/TN9B
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJoGyOqAAoJEB2Cnv7KVigSvgQL/0PnRJFa9Ov+ttm8LeMY5UTV
46SvvrmC2R3futlObbFVBEK2PPIvmHeIP+J5VOItbSsy7Dh2SZ3vGdMzIcLuJROL
zivYcLG4LlHOrOGhHNnd0Wz8vMLSuSgotiqwQmY+JVbO1Gq4x57POKlOMugZCRmW
7OfVbXY+PDhzEienj1tbjOG+Tx1ffEdaWW+jMfC1aum/3iRdIDJP9YVBJbRb4GbW
FtrRDc8oKbdwQwRWO3XlF5LXs7WhOX8IYXoI0PEcIqHtHDg7m0o3cvLMgellrB3P
eqkrBjZt4eOrmPeO4dsgUYE9AtdgGuL6Du+PK38oC5jRP6sJQKeOD6Masg7Bqh6n
G1IKDr1NqdbTogPPf9tEg+Co+7QJslqVmNI+1W2al8LOFicTB/AI9h9zNvu59EEs
vSfzqywC3/ifiGUw6x62Lk4NJtolQ8b0ZFAaCPKlWbnT5D97Q8Y+YTcmVNxQgCnM
7TZiNOQvvPeEKhcCJq4ek3x2F7FF45JgQySv+S0ftQ==
=ahwU
-----END PGP SIGNATURE-----

--97FlI3jjXM9/TN9B--

