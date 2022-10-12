Date: Wed, 12 Oct 2022 16:38:34 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Y0bRartX32suvWIb@...1296...>
References: <20220812134154.16729-3-kprovost@...2661...>
 <202208201401.27KE12Cm014083@...2054...>
 <YwDwvG++hK0nJI2F@...1296...>
 <21B552DE-38FE-41F0-8FC7-606EA4C06093@...1376...>
 <Yz72rrCsJCjBgE4T@...1296...>
 <3B9F182D-0936-4799-B1B0-D269DBB3C2E6@...1376...>
 <Yz/35K6JddVNg9F9@...1296...> <Y0W/3bWLuTuYZvxs@...1296...>
 <Y0ZhI7jZ0/aXQ4l0@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="GC+Tgxm8N+QuzqsX"
Content-Disposition: inline
In-Reply-To: <Y0ZhI7jZ0/aXQ4l0@...1296...>
Subject: Re: [Openvpn-devel] route/iroute handling on FreeBSD
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Kristof Provost <kp@...1249...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--GC+Tgxm8N+QuzqsX
Content-Type: multipart/mixed; boundary="pNUC95ccDEsf1xCq"
Content-Disposition: inline

--pNUC95ccDEsf1xCq
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

people have alreadycomplained at me that I write so long e-mails today,
so I can write more...

On Wed, Oct 12, 2022 at 08:39:31AM +0200, Gert Doering wrote:
> Factor 1: single-peer (client or p2p) vs. multi-peer
>=20
>  single-peer -> DCO has only 1 peer, all packets that go into the=20
>                 tun/dco interface are sent out to the single peer
>                 ("dumb pipe mode") - exactly like tun(4) behaves
>=20
>                 If a subnet is configured on the interface, packets to
>                 ALL IPs (!=3D local) in that subnet are sent to the other
>                 side.  No next-hop lookup is done.

This is "sort of" handled in if_ovpn.c today

ovpn_route_peer(struct ovpn_softc *sc, struct mbuf **m0,
    const struct sockaddr *dst)
{
...
        /* Shortcut if we're a client (or are a server and have only one cl=
ient). */
        if (sc->peercount =3D=3D 1)
                return (ovpn_find_only_peer(sc));


... so this works for the client, but has one interesting drawback on the
server - if there is only a single client connected, the server will send
ALL to-be-tunneled packets to that client.  As soon as client #2 connects,
packets are properly sorted.

[..]
> Factor 2: IFF_POINTOPOINT vs. IFF_BROADCAST
>=20
>  This seems to be a *BSD-specific thing, aka "there is nothing in the
>  Linux specific code that seems to bother with this".

I've whacked at if_ovpn.c and dco_freebsd.c a bit now, and I seem
to have working code for both ends.  I am not a FreeBSD kernel coder,
so I have no idea how many behavioural standards I am violating,=20
but it makes "real subnet mode in OpenVPN" work for me, with DCO.

Kernel patch attached, OpenVPN patches will follow soonish (outside
of this e-mail thread).

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--pNUC95ccDEsf1xCq
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-if_ovpn-4-implement-ioctl-to-set-if_flags.patch"
Content-Transfer-Encoding: quoted-printable

=46rom ddb95b7f57d78498003f3212b23e6adb0b5a9828 Mon Sep 17 00:00:00 2001
=46rom: Gert Doering <gert@...1296...>
Date: Wed, 12 Oct 2022 15:30:07 +0200
Subject: [PATCH] if_ovpn(4): implement ioctl() to set if_flags

Fully working openvpn(8) --iroute support needs real subnet config
on ovpn(4) interfaces (IFF_BROADCAST), while client-side/p2p
configs need IFF_POINTOPOINT setting.  So make this configurable.
---
 sys/net/if_ovpn.c | 41 +++++++++++++++++++++++++++++++++++++++++
 sys/net/if_ovpn.h |  1 +
 2 files changed, 42 insertions(+)

diff --git a/sys/net/if_ovpn.c b/sys/net/if_ovpn.c
index ed0ff178972..dfb475e3072 100644
--- a/sys/net/if_ovpn.c
+++ b/sys/net/if_ovpn.c
@@ -1081,6 +1081,44 @@ ovpn_set_peer(struct ifnet *ifp, const nvlist_t *nvl)
 	return (0);
 }
=20
+static int
+ovpn_set_ifmode(struct ifnet *ifp, const nvlist_t *nvl)
+{
+	struct ovpn_softc *sc =3D ifp->if_softc;
+
+	if (nvl =3D=3D NULL)
+		return (EINVAL);
+
+	if (! nvlist_exists_number(nvl, "ifmode") )
+		return (EINVAL);
+
+        int ifmode =3D nvlist_get_number(nvl, "ifmode");
+
+	OVPN_WLOCK(sc);
+
+	/* deny this if UP */
+	if (ifp->if_flags & IFF_UP) {
+		OVPN_WUNLOCK(sc);
+		return (EBUSY);
+	}
+
+	switch (ifmode & ~IFF_MULTICAST) {
+	case IFF_POINTOPOINT:
+	case IFF_BROADCAST:
+		ifp->if_flags &=3D
+		    ~(IFF_BROADCAST|IFF_POINTOPOINT|IFF_MULTICAST);
+		ifp->if_flags |=3D ifmode;
+		break;
+	default:
+		OVPN_WUNLOCK(sc);
+		return (EINVAL);
+	}
+
+	OVPN_WUNLOCK(sc);
+
+	return (0);
+}
+
 static int
 ovpn_ioctl_set(struct ifnet *ifp, struct ifdrv *ifd)
 {
@@ -1135,6 +1173,9 @@ ovpn_ioctl_set(struct ifnet *ifp, struct ifdrv *ifd)
 	case OVPN_SET_PEER:
 		ret =3D ovpn_set_peer(ifp, nvl);
 		break;
+	case OVPN_SET_IFMODE:
+		ret =3D ovpn_set_ifmode(ifp, nvl);
+		break;
 	default:
 		ret =3D ENOTSUP;
 	}
diff --git a/sys/net/if_ovpn.h b/sys/net/if_ovpn.h
index 26a9907711c..fd1c21e7043 100644
--- a/sys/net/if_ovpn.h
+++ b/sys/net/if_ovpn.h
@@ -60,5 +60,6 @@ enum ovpn_key_cipher {
 #define OVPN_SEND_PKT		_IO  ('D', 9)
 #define OVPN_POLL_PKT		_IO  ('D', 10)
 #define OVPN_GET_PKT		_IO  ('D', 11)
+#define OVPN_SET_IFMODE		_IO  ('D', 12)
=20
 #endif
--=20
2.37.3


--pNUC95ccDEsf1xCq--

--GC+Tgxm8N+QuzqsX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjRtFqAAoJEB2Cnv7KVigSH9gL/RjqVzmI2cMt+InBrTUOe/2z
2gMZ8T402k1NxiMPoPzsyeqBKmz8fIDJ5O80HYH7vH8gOcqXddgqNy+ACAYVvaNS
BBBfb/OgKDHINK4HeYvexfVAGT0efHN60mPX1AWXh4uMx9hKwIZzTy05cFYq6qJU
27GF/TxJ0zbCxaM1ntz3eXW6YeQH6AgdtbODA+jpNaDjhtxEmoCUkAPFld1LeJjq
aVYoqeUpkCLMkHs+NxOnLePfEqprqzfSJxvovNbNyEbWuCB2cpTN1fd9hDM4f+9F
re8MDiYRk/ypuPg8tLLHMqiVCazfo0ahjAvUClDAWi7AEWDeRxMLGHR4g2I4x/mj
uz5voGpu+AZgqnGAZwt+Umjebfml9RhLOa1iGfWJuv30G5SIKN07Qwz0Z5OBJwDn
uMr7CXv1KdKqxpiSK+y5WdSuiuy5wUwaZdj0xPBhnySN21GPJhCdF8yIGRgODuv6
yfdlovs0+M70W6PnIqf1fWD9f8CPz4lUzOoRz4jjNA==
=uh4v
-----END PGP SIGNATURE-----

--GC+Tgxm8N+QuzqsX--

