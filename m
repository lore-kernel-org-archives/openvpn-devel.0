Date: Sat, 15 May 2021 20:05:18 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210515180518.GU976@...1296...>
References: <20210422151724.2132573-1-arne@...1227...>
 <20210501223545.3669495-1-arne@...1227...>
 <0cf4ecd5-6c4c-87b1-4ed8-baa8a1346eca@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ibvXbPoclXbYPFIN"
Content-Disposition: inline
In-Reply-To: <0cf4ecd5-6c4c-87b1-4ed8-baa8a1346eca@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Add connection_established as state in
 tls_multi->context_auth
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

--ibvXbPoclXbYPFIN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, May 13, 2021 at 10:03:58PM +0200, Antonio Quartulli wrote:
> On 02/05/2021 00:35, Arne Schwabe wrote:
> > the socket_info->connection_establish is set through
> > link_socket_set_outgoing_addr when we reach FULL_SYNC. This patch
> > introduces a new state in context_auth that replaces the
> > connection_established state for TLS connections. This make the state
> > machine easier to understand.
> >=20
> > Signed-off-by: Arne Schwabe <arne@...1227...>
[..]
> Acked-by: Antonio Quartulli <antonio@...515...>

This patch, applied on top of d49df6bdde0592c ("master as of today, with
the exponential backoff patch applied") breaks p2p TLS mode on the
server side.

Authentication and PUSH_REPLY works fine, but afterwards the server
complains about keys

May 15 20:01:44 gentoo tap-tcp-p2p[31731]: Key [AF_INET6]::ffff:194.97.140.=
21:60334 [0] not initialized (yet), dropping packet.
May 15 20:01:47 gentoo tap-tcp-p2p[31731]: Key [AF_INET6]::ffff:194.97.140.=
21:60334 [0] not initialized (yet), dropping packet.

(specifially, the test case is: TCP, TAP, tcp-server on the server, and
"--client" on the client for "9", and "--tls-client" for "9a" - both
break)


The client in this test runs about 8 weeks old master (7064ccb9fd3578c0).

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--ibvXbPoclXbYPFIN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgoA1aAAoJEB2Cnv7KVigStAQL/j0xqotFk86zHQPu7LSXwz5r
3olfu9z1kRUokPnE19riqpsk5snORO2Nzr20SI6Y9mnN6aU+UIVc6oaRaxsmuRyo
vew7dYsmb3FC6Z2ITxfuLpG/kC+BETXmq+HuSkKseewJ98j/XgpAWnjG4urW1+vh
yZ1roIoA7OQtxDPHj36DFAqx8/w4OHEL8MboL7pYhregFaypvoOh+wbtYUSfmSOJ
WWgJp653s1/y99wqS+Kqlvz56+WEl7wt2vFkdgzEUvrlc2T16h7M3sP1GxQl+Joc
8FJJ8ckZ4NJJFzCeNZ3D7N6U4ugwB3gWQCvKRn4D712O48osgW+T/rtVr+XheULT
jUzKWN814b0b/5X0qhzmLVGGmlx8xKV6+gJGkbTTzWmlIQsH9YIHfMfYlV1w9Y7k
3BWc5osUARh9z2lbDLDjxb0RnGMtZHajJLMXBQAX0mnmF1SZ51EptpXbAlfaHlyK
WgpRhuMfGsGoBjKFgXUG7TYzPs2sI2P7sO3Da4exAA==
=4t/D
-----END PGP SIGNATURE-----

--ibvXbPoclXbYPFIN--

