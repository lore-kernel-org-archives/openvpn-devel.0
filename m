Date: Mon, 28 Nov 2022 14:26:31 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y4S3B/u3W8MO5Wbc@...1296...>
References: <20221012133457.1927871-1-arne@...1227...>
 <20221012133457.1927871-3-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="tsLzkvd31iAARcPS"
Content-Disposition: inline
In-Reply-To: <20221012133457.1927871-3-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 3/3] Call dco_p2p_add_new_peer again if
 the peer id changes
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

--tsLzkvd31iAARcPS
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Oct 12, 2022 at 03:34:56PM +0200, Arne Schwabe wrote:
> This allows a reconnect in p2p mode and has the side effect of updating
> the peer address with the peerid

Maybe I am just holding it wrong, but the patch does not change the
situation for my p2p reconnection problem.

First connect works fine (tls p2p, UDP, one side --tls-client, one side
--tls-server).

Second connect, server says

Nov 28 14:23:10 ubuntu2004 tun-udp-p2p-tls-sha256[770748]: TLS: new session=
 incoming connection from [AF_INET6]::ffff:194.97.140.5:13846
Nov 28 14:23:10 ubuntu2004 tun-udp-p2p-tls-sha256[770748]: VERIFY OK: depth=
=3D1, C=3DUS, ST=3DCalifornia, L=3DPleasanton, O=3DOpenVPN community projec=
t, CN=3DOpenVPN community project CA, emailAddress=3Dsamuli@...515...
Nov 28 14:23:10 ubuntu2004 tun-udp-p2p-tls-sha256[770748]: VERIFY OK: depth=
=3D0, C=3DDE, ST=3DBavaria, L=3DMunich, O=3DOpenVPN community project, OU=
=3DDCO F14 client, CN=3Dfreebsd-14-amd64, emailAddress=3Dgert@...2576...
Nov 28 14:23:10 ubuntu2004 tun-udp-p2p-tls-sha256[770748]: peer info: IV_CI=
PHERS=3DAES-256-GCM:AES-128-GCM:CHACHA20-POLY1305
Nov 28 14:23:10 ubuntu2004 tun-udp-p2p-tls-sha256[770748]: peer info: IV_PR=
OTO=3D42
Nov 28 14:23:10 ubuntu2004 tun-udp-p2p-tls-sha256[770748]: WARNING: 'link-m=
tu' is used inconsistently, local=3D'link-mtu 1553', remote=3D'link-mtu 154=
1'
Nov 28 14:23:10 ubuntu2004 tun-udp-p2p-tls-sha256[770748]: WARNING: 'auth' =
is used inconsistently, local=3D'auth SHA256', remote=3D'auth SHA1'
Nov 28 14:23:10 ubuntu2004 tun-udp-p2p-tls-sha256[770748]: P2P mode NCP neg=
otiation result: TLS_export=3D1, DATA_v2=3D1, peer-id 4549764, cipher=3DAES=
-256-GCM
Nov 28 14:23:10 ubuntu2004 tun-udp-p2p-tls-sha256[770748]: TLS: move_sessio=
n: dest=3DTM_ACTIVE src=3DTM_UNTRUSTED reinit_src=3D1
Nov 28 14:23:10 ubuntu2004 tun-udp-p2p-tls-sha256[770748]: TLS: tls_multi_p=
rocess: untrusted session promoted to trusted
Nov 28 14:23:10 ubuntu2004 tun-udp-p2p-tls-sha256[770748]: No encryption ke=
y found. Purging data channel keys
Nov 28 14:23:10 ubuntu2004 tun-udp-p2p-tls-sha256[770748]: Control Channel:=
 TLSv1.3, cipher TLSv1.3 TLS_AES_256_GCM_SHA384, peer certificate: 2048 bit=
 RSA, signature: RSA-SHA256
Nov 28 14:23:10 ubuntu2004 tun-udp-p2p-tls-sha256[770748]: [freebsd-14-amd6=
4] Peer Connection Initiated with [AF_INET6]::ffff:194.97.140.5:13846

... and then, nothing more from openvpn, and the kernel starts logging...

Nov 28 14:23:11 ubuntu2004 kernel: [22040621.308786] ovpn_udp_encap_recv: r=
eceived data from unknown peer (id: 4549764)
Nov 28 14:23:12 ubuntu2004 kernel: [22040622.140640] ovpn_udp_encap_recv: r=
eceived data from unknown peer (id: 4549764)
Nov 28 14:23:12 ubuntu2004 kernel: [22040622.212277] ovpn_udp_encap_recv: r=
eceived data from unknown peer (id: 4549764)


The recent patches *have* improved the situation noticeably, because
without them, the client would end up in a timeout (because UDP reply
packets would go to "the old address+port of the client") - so now
changing IPv4 <-> IPv6 between connection attempts works fine.  Just
"installation in kernel" doesn't.


I am slightly confused about the concept of peer-id here, though - so we
do P2P NCP, and the peer-id is EKM'ed.  Will that result in the *same*
peer-id on both sides?  Or in a pseudorandom number that differs per side
(in which case "tell the kernel" might end up with a different number)?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--tsLzkvd31iAARcPS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjhLcHAAoJEB2Cnv7KVigSGuIL/2w01HQuDAxtNdNfUjt90gWG
yK8LhcHi4HS2U3rwm/06BUArf9z6loRG+yspfH6W/+dWrIbA6gfcLCefW0WmWi2S
Z/qV0RFIYwGZ8Yymo5xl9K9IAl99T7WEzC1Y+SXMIruvPouo8IdUi6/Z/khdAS2M
knrJuPVxPe2iFLjoPaaGbPLETZwP71fmHJRRges0WQ2uOZIZqPGSxGbVwH6CTm5K
8ocLyvu3Br04erW/6UrcEPqPiQj/2GIF/m5dV9whq/y2ROfFezFBSfMnqzL3QeAK
BvqSDFsD+Wb0pO9S9pV4L/+kHGERvv8EbJRsXTCM7JtBHccMtywihxqhi+FWfsWO
yws2uVdBrSniE9u4t/FlyESnzm6C1fFkS58p85EFFl+nkfsW+58nLiSY4XS6qord
eLwidBgRdiPc9w7uELwCjO0vbzgGrmLUfVQUA32MDpgKiLZEhMtSYDzK/72vxfxB
cqR/pPiSenlvHTr26tzeqnWFkq+dMdcutVBbpin2Lg==
=gK4y
-----END PGP SIGNATURE-----

--tsLzkvd31iAARcPS--

