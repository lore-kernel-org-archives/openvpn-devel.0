Date: Thu, 23 Mar 2023 13:03:18 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <ZBxABqx/VGMY4R62@...1296...>
References: <20230322192757.20767-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="XdzQO1hpJOqc3Qq/"
Content-Disposition: inline
In-Reply-To: <20230322192757.20767-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v4] dco-linux: implement
 dco_get_peer_stats{, multi} API
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--XdzQO1hpJOqc3Qq/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Mar 22, 2023 at 08:27:57PM +0100, Antonio Quartulli wrote:
> With this API it is possible to retrieve the stats for a specific peer
> or for all peers and then update the userspace counters with the value
> reported by DCO.
>=20
> Change-Id: Ia3990b86b1be7ca844fb1674b39ce0d60528ccff
> Signed-off-by: Antonio Quartulli <a@...2181...>

This *looks* very reasonable, but only half of it works for me.

...
tun-udp-p2mp[492453]: OpenVPN 2.7_git [git:vw/master/5a8fb55ac8cf4019] x86_=
64-pc-linux-gnu [SSL (mbed TLS)] [LZO] [LZ4] [EPOLL] [MH/PKTINFO] [AEAD] [D=
CO] built on Mar 23 2023
tun-udp-p2mp[492453]: DCO version: 0.2.20230313
...
tun-udp-p2mp[492454]: dco_get_peer_stats_multi
tun-udp-p2mp[492454]: dco_parse_peer_multi: parsing message...
tun-udp-p2mp[492454]: dco_update_peer_stat: no link RX bytes provided in re=
ply for peer 0
tun-udp-p2mp[492454]: dco_update_peer_stat: no link TX bytes provided in re=
ply for peer 0
tun-udp-p2mp[492454]: dco_update_peer_stat / tun_read_bytes: 240
tun-udp-p2mp[492454]: dco_update_peer_stat / tun_write_bytes: 96
tun-udp-p2mp[492454]: dco_parse_peer_multi: parsing message...
tun-udp-p2mp[492454]: dco_update_peer_stat: no link RX bytes provided in re=
ply for peer 1
tun-udp-p2mp[492454]: dco_update_peer_stat: no link TX bytes provided in re=
ply for peer 1
tun-udp-p2mp[492454]: dco_update_peer_stat / tun_read_bytes: 776
tun-udp-p2mp[492454]: dco_update_peer_stat / tun_write_bytes: 80


So neither for p2p tls nor for --server setups, I am receiving "link bytes",
only tun*bytes.

I have not checked the kernel side if I *should* receive anything, but
this looks incomplete - either the kernel side is not yet ready (not
a showstopper) or there is a desync in the tags used, which might or
might not prevent merging...

Antonio, any ideas?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--XdzQO1hpJOqc3Qq/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJkHEAGAAoJEB2Cnv7KVigS8nQMAJddMGYA7VXH0D+BC/UwY7tD
sKMosmtABfHtmWuFa2S+QAqe/SbmRd2sPK/vsobPReCk8sdcRLiRZSKbmx4+COuh
KDhELB1BKITAw4oPjPXQ8G4cqPT4qWMKAK4vOfqQDmbhhi7k9eS6ngnk1Oy6U+jj
dAgwUg2thViG81BhTNZKEwPMrdW2sbmJ0dC1Qk79IqtIuhsLN9OlqyvPROsKypPV
cQ3qe+Yg5OBxf269/WD6WeOdxpdYDqLGI9i8feyGyDo0hanRXMLtojJYqPoavmFJ
K3hyNKfsIHM/VB1J2/lc7/d41l+z6tkRst7zGopwh9F9FUAskoqIy9V8NOaYQ/Tt
j9VgCGLD2EhwyI3Nyo8if7pEZNWF+yID6uslPA+tSEhF9SVv2LZSJ0Y8THu3Qipq
+USvRCbsgn2BiuVGYJ9Vqkkjk829xBsydRqn0lzJw//GU0bQgmsOq1daAsH58zA0
myf5bq8uHx6Xt12TDjktcTZKFiIHybPvni9j+Zyylg==
=9yLg
-----END PGP SIGNATURE-----

--XdzQO1hpJOqc3Qq/--

