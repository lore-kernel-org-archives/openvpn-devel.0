Date: Fri, 25 Nov 2022 10:17:05 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y4CIEQyzzFyICD9u@...1296...>
References: <20221012133457.1927871-1-arne@...1227...>
 <20221124230025.3205108-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="vKLCyoviTdv1guFL"
Content-Disposition: inline
In-Reply-To: <20221124230025.3205108-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2 2/3] Use dedicated multi->dco_peer_id
 for DCO instead of multi->peer_id
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

--vKLCyoviTdv1guFL
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Nov 25, 2022 at 12:00:25AM +0100, Arne Schwabe wrote:
> The lifetime and state machine of multi->peer_id does not exactly the
> lifetime/state of DCO. This is especially for p2p NCP where a reconnection
> can change the peer id. Also use this new field with value -1 to mean
> not installed, replacing the dco_peer_added field.
>=20
> Patch v2: fix one comparison checking for 0 instead of -1

This looks good, but fails the server test - after the first few
client connects it seems to get confused on peer installation, and dies
miserably

Nov 25 09:51:53 ubuntu2004 tun-udp-p2mp[641000]: MULTI: primary virtual IPv=
6 for freebsd-14-amd64/194.97.140.5:13776: fd00:abcd:220:2::1002
Nov 25 09:51:53 ubuntu2004 tun-udp-p2mp[641000]: dco_new_peer: netlink repo=
rts error (-6): Object exists: No such file or directory (errno=3D2)
Nov 25 09:51:53 ubuntu2004 tun-udp-p2mp[641000]: dco_new_peer: failed to se=
nd netlink message: File exists (-17)
Nov 25 09:51:53 ubuntu2004 tun-udp-p2mp[641000]: Cannot add peer to DCO: Fi=
le exists (-17)
Nov 25 09:51:53 ubuntu2004 tun-udp-p2mp[641000]: dco_set_peer: netlink repo=
rts object not found, ovpn-dco unloaded?
Nov 25 09:51:53 ubuntu2004 tun-udp-p2mp[641000]: dco_set_peer: failed to se=
nd netlink message: No such file or directory (-2)
Nov 25 09:51:53 ubuntu2004 tun-udp-p2mp[641000]: Cannot set parameters for =
DCO peer (id=3D4294967295): No such file or directory

   >>> now that id=3D hints at "something has not been initialized properly"
   >>> as that is "(unsiged int) -1"

Nov 25 09:51:53 ubuntu2004 tun-udp-p2mp[641000]: Data Channel: using negoti=
ated cipher 'AES-256-GCM'
Nov 25 09:51:53 ubuntu2004 tun-udp-p2mp[641000]: Data Channel MTU parms [ m=
ss_fix:1380 max_frag:0 tun_mtu:1500 tun_max_mtu:1600 headroom:136 payload:1=
768 tailroom:562 ET:0 ]
Nov 25 09:51:53 ubuntu2004 tun-udp-p2mp[641000]: dco_new_key: netlink repor=
ts object not found, ovpn-dco unloaded?
Nov 25 09:51:53 ubuntu2004 tun-udp-p2mp[641000]: dco_new_key: failed to sen=
d netlink message: No such file or directory (-2)
Nov 25 09:51:53 ubuntu2004 tun-udp-p2mp[641000]: Impossible to install key =
material in DCO: No such file or directory
Nov 25 09:51:53 ubuntu2004 tun-udp-p2mp[641000]: Exiting due to fatal error


(This is plain p2mp udp TLS server, with t_client client connecting to
it - same client cert, but new connection, new source ip/port - there
is a second client connected for client-to-client testing)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--vKLCyoviTdv1guFL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjgIgRAAoJEB2Cnv7KVigSjV8L/j8ArKUftj0AB2/zht2fptB1
fA2KVedl/u4bGxWaWpuZFSvnA16Ry/TAmdWECy2MRr+18sFbKSq2j8FYLaBxmkbl
EvieXkmRebib4IwKVlmvDJaa69jBFvNNnlEP4hvWKDWU66KmS+uwfgjPjXNwj4TT
jfvNsh9RD57/TGaUWxtITYFDYNTWK5zYz+O1nlzbjKbYFabmArFYZG02HTHQjrdN
2fvU+Vj4IhpMAIQZKASV4hvMhGHC3cnF7UpLYuwoWxLqnzb+Lhn1kPIphMdxpcdq
zGm8VIcH31qg5i4x8J174Z8liwAb/90jHbTBmWWK9VzgYF3tG7KPECaCHEheR1dj
JFyXZHFppQywXskBGD/c3z9WDPJqr1TFcSKk0w5CvLNITrrWgaq5Q6lFQjyzYc13
sgvmvrOgf6LuT/8ikwXPVI1v2Zb0HHuz4r0FE0t3DPBV0Qk4nHdDSK4lw2dSofgu
kOtjCDMx6NfqsuyjwTwVgt9YvcKJWZX4v+/RpDJmVQ==
=LFe5
-----END PGP SIGNATURE-----

--vKLCyoviTdv1guFL--

