Date: Sun, 25 Dec 2022 09:48:37 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y6gOZY9XiZP+ppAN@...1296...>
References: <20221224194253.3202231-1-arne@...1227...>
 <20221224194253.3202231-5-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="h1XvgxLdKjRKpZhS"
Content-Disposition: inline
In-Reply-To: <20221224194253.3202231-5-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 4/9] Ensure we do not promote a
 TA_TIMEOUT to a TA_WRITE/TA_READ event with dco
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

--h1XvgxLdKjRKpZhS
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Dec 24, 2022 at 08:42:48PM +0100, Arne Schwabe wrote:
> with dco sometimes we end up promoting a timeout event to write
> event or read event. For the residual read, this problem is probably
> not solvable without changing the kernel DCO API
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>

This one breaks TCP on a DCO-enabled server for me, though I can't
see any obvious reason why.  Basic p2mp tcp server, nothing fancy.

With "3/7" (1413b38d0eacafb6, as in master) it works fine.

With "4/7" (just this patch, on top of master) the "TCP gremlin test"
looks good - that's what I started last night, and no crashes/BUGs - but
an actual TCP client fails...

Client log:


2022-12-25 09:41:32 VERIFY OK: depth=3D0, C=3DUS, ST=3DCalifornia, L=3DPlea=
santon, O=3DOpenVPN community project, CN=3Dserver, emailAddress=3Dsamuli@...220...=
..515...
2022-12-25 09:41:32 WARNING: 'link-mtu' is used inconsistently, local=3D'li=
nk-mtu 1547', remote=3D'link-mtu 1544'
2022-12-25 09:41:32 Control Channel: TLSv1.3, cipher TLSv1.3 TLS_AES_256_GC=
M_SHA384, peer certificate: 2048 bit RSA, signature: RSA-SHA1
2022-12-25 09:41:32 [server] Peer Connection Initiated with [AF_INET]195.30=
.8.84:51194
2022-12-25 09:41:33 SENT CONTROL [server]: 'PUSH_REQUEST' (status=3D1)
2022-12-25 09:41:39 SENT CONTROL [server]: 'PUSH_REQUEST' (status=3D1)
2022-12-25 09:41:43 TLS Error: local/remote TLS keys are out of sync: [AF_I=
NET]195.30.8.84:51194 (received key id: 0, known key ids:  [key#0 state=3DS=
_ACTIVE auth=3DKS_AUTH_TRUE id=3D0 sid=3D87065d72 c3889e05] [key#1 state=3D=
S_UNDEF auth=3DKS_AUTH_FALSE id=3D0 sid=3D00000000 00000000] [key#2 state=
=3DS_UNDEF auth=3DKS_AUTH_FALSE id=3D0 sid=3D00000000 00000000])
2022-12-25 09:41:44 SENT CONTROL [server]: 'PUSH_REQUEST' (status=3D1)
2022-12-25 09:41:50 SENT CONTROL [server]: 'PUSH_REQUEST' (status=3D1)
2022-12-25 09:41:53 TLS Error: local/remote TLS keys are out of sync: [AF_I=
NET]195.30.8.84:51194 (received key id: 0, known key ids:  [key#0 state=3DS=
_ACTIVE auth=3DKS_AUTH_TRUE id=3D0 sid=3D87065d72 c3889e05] [key#1 state=3D=
S_UNDEF auth=3DKS_AUTH_FALSE id=3D0 sid=3D00000000 00000000] [key#2 state=
=3DS_UNDEF auth=3DKS_AUTH_FALSE id=3D0 sid=3D00000000 00000000])
2022-12-25 09:41:55 SENT CONTROL [server]: 'PUSH_REQUEST' (status=3D1)


server log

2022-12-25 09:41:32 us=3D809562 TCP connection established with [AF_INET6]:=
:ffff:194.97.140.5:28517
2022-12-25 09:41:32 us=3D809600 TCPv6_SERVER link local: (not bound)
2022-12-25 09:41:32 us=3D809615 TCPv6_SERVER link remote: [AF_INET6]::ffff:=
194.97.140.5:28517
2022-12-25 09:41:32 us=3D809775 194.97.140.5:28517 TLS: Initial packet from=
 [AF_INET6]::ffff:194.97.140.5:28517, sid=3D130a42ff 79d3e7e6
2022-12-25 09:41:32 us=3D822866 194.97.140.5:28517 VERIFY OK: depth=3D1, C=
=3DUS, ST=3DCalifornia, L=3DPleasanton, O=3DOpenVPN community project, CN=
=3DOpenVPN community project CA, emailAddress=3Dsamuli@...515...
2022-12-25 09:41:32 us=3D823211 194.97.140.5:28517 VERIFY OK: depth=3D0, C=
=3DDE, ST=3DBavaria, L=3DMunich, O=3DOpenVPN community project, OU=3DDCO F1=
4 client, CN=3Dfreebsd-14-amd64, emailAddress=3Dgert@...2576...
...
2022-12-25 09:41:32 us=3D824045 194.97.140.5:28517 TLS: move_session: dest=
=3DTM_ACTIVE src=3DTM_INITIAL reinit_src=3D1
2022-12-25 09:41:32 us=3D824186 194.97.140.5:28517 TLS: tls_multi_process: =
initial untrusted session promoted to trusted
2022-12-25 09:41:32 us=3D863377 194.97.140.5:28517 Control Channel: TLSv1.3=
, cipher TLSv1.3 TLS_AES_256_GCM_SHA384, peer certificate: 2048 bit RSA, si=
gnature: RSA-SHA256
2022-12-25 09:41:32 us=3D863449 194.97.140.5:28517 [freebsd-14-amd64] Peer =
Connection Initiated with [AF_INET6]::ffff:194.97.140.5:28517
...
2022-12-25 09:41:32 us=3D863895 freebsd-14-amd64/194.97.140.5:28517 Data Ch=
annel: using negotiated cipher 'AES-256-GCM'
2022-12-25 09:41:32 us=3D863935 freebsd-14-amd64/194.97.140.5:28517 Data Ch=
annel MTU parms [ mss_fix:1366 max_frag:0 tun_mtu:1500 tun_max_mtu:1600 hea=
droom:136 payload:1768 tailroom:562 ET:0 ]
2022-12-25 09:41:32 us=3D864176 freebsd-14-amd64/194.97.140.5:28517 SENT CO=
NTROL [freebsd-14-amd64]: 'PUSH_REPLY,route 10.220.0.0 255.255.0.0,route-ip=
v6 fd00:abcd:220::/48,tun-ipv6,route-gateway 10.220.1.1,topology subnet,pin=
g 10,ping-restart 30,compress stub-v2,ifconfig-ipv6 fd00:abcd:220:1::1002/6=
4 fd00:abcd:220:1::1,ifconfig 10.220.1.4 255.255.255.0,peer-id 0,cipher AES=
-256-GCM,key-derivation tls-ekm' (status=3D1)

and then nothing more, until the client gives up and reconnects.

With --verb 6, I see this dance...

2022-12-25 09:45:51 us=3D194027 freebsd-14-amd64/194.97.140.5:47015 Data Ch=
annel: using negotiated cipher 'AES-256-GCM'
2022-12-25 09:45:51 us=3D194058 freebsd-14-amd64/194.97.140.5:47015 Data Ch=
annel MTU parms [ mss_fix:1366 max_frag:0 tun_mtu:1500 tun_max_mtu:1600 hea=
droom:136 payload:1768 tailroom:562 ET:0 ]
2022-12-25 09:45:51 us=3D194134 freebsd-14-amd64/194.97.140.5:47015 dco_ins=
tall_key: peer_id=3D0 keyid=3D0, currently 0 keys installed
2022-12-25 09:45:51 us=3D194167 freebsd-14-amd64/194.97.140.5:47015 dco_new=
_key: slot 0, key-id 0, peer-id 0, cipher AES-256-GCM
2022-12-25 09:45:51 us=3D194317 freebsd-14-amd64/194.97.140.5:47015 SENT CO=
NTROL [freebsd-14-amd64]: 'PUSH_REPLY,route 10.220.0.0 255.255.0.0,route-ip=
v6 fd00:abcd:220::/48,tun-ipv6,route-gateway 10.220.1.1,topology subnet,pin=
g 10,ping-restart 30,compress stub-v2,ifconfig-ipv6 fd00:abcd:220:1::1002/6=
4 fd00:abcd:220:1::1,ifconfig 10.220.1.4 255.255.255.0,peer-id 0,cipher AES=
-256-GCM,key-derivation tls-ekm' (status=3D1)
2022-12-25 09:45:51 us=3D194363 freebsd-14-amd64/194.97.140.5:47015 dco_upd=
ate_keys: peer_id=3D0
2022-12-25 09:45:52 us=3D265607 freebsd-14-amd64/194.97.140.5:47015 dco_upd=
ate_keys: peer_id=3D0
2022-12-25 09:45:52 us=3D455630 dco_do_read
2022-12-25 09:45:52 us=3D455674 ovpn-dco: received OVPN_PACKET_ATTR_PACKET,=
 ifindex: 31370 peer-id: 0, len 49
2022-12-25 09:45:53 us=3D336677 freebsd-14-amd64/194.97.140.5:47015 dco_upd=
ate_keys: peer_id=3D0
2022-12-25 09:45:54 us=3D408023 freebsd-14-amd64/194.97.140.5:47015 dco_upd=
ate_keys: peer_id=3D0
2022-12-25 09:45:54 us=3D740566 dco_do_read
2022-12-25 09:45:54 us=3D740653 ovpn-dco: received OVPN_PACKET_ATTR_PACKET,=
 ifindex: 31370 peer-id: 0, len 49
2022-12-25 09:45:55 us=3D478633 freebsd-14-amd64/194.97.140.5:47015 dco_upd=
ate_keys: peer_id=3D0
2022-12-25 09:45:56 us=3D550011 freebsd-14-amd64/194.97.140.5:47015 dco_upd=
ate_keys: peer_id=3D0
2022-12-25 09:45:57 us=3D620239 freebsd-14-amd64/194.97.140.5:47015 dco_upd=
ate_keys: peer_id=3D0
2022-12-25 09:45:58 us=3D85776 dco_do_read
2022-12-25 09:45:58 us=3D85865 ovpn-dco: received OVPN_PACKET_ATTR_PACKET, =
ifindex: 31370 peer-id: 0, len 49
2022-12-25 09:45:58 us=3D86702 dco_do_read
2022-12-25 09:45:58 us=3D86754 ovpn-dco: received OVPN_PACKET_ATTR_PACKET, =
ifindex: 31370 peer-id: 0, len 49

... but no incoming PUSH_REQUEST...

This is fully reproducible, no special timing or anything required,
just "TCP p2mp server with DCO, tcp client".


With DCO disabled (same server config, --disable-dco) initialization
progresses normally, and everything works..

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--h1XvgxLdKjRKpZhS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjqA5lAAoJEB2Cnv7KVigSz2UL/1u+NsuPNKiBb3G0a+1w+uy3
MIKEzeOZTr+ZYEmSBo5UGwUPEV3p4KDAzsJmdrfKPw5YtNmjUKqNtMr51X5pHrKI
fdhuql8SXOq+GFGb9oCB6MeWAz+ufnil4Yi49srsRZMDk3R6AZIzOpUOhXOaXFei
oYM2Q3fmyGHwdnmONJMomOVyWxmR0dncMwopOc+DJjHO/yNqp48NA6v9afr5XgEM
4AYaYutj0zREthva2GIDf/3af1Yu9mslfnYkVb1v01p049qeJTXdCekdnii8rSW4
WrRDyNQw779mY4RCxzCriIMMXNFE4A2xwtlgwflhHUhkGHtZjY16p/KmUt2/QDlD
wi7a5hWjQ2eSU+IbinYr93WQvQobLvAANnIBwlsWFmW8ntYo3zCWG24e30lw3RRk
dpgMtOaEElR/xF4A5iar5fELm1FTMZMJ9cvl94qvs9MggVX5/C17zMr5U3XbrWJY
TWijfERWx7Dr3q0JwGvfGAmqMyV7S6a6Hz+tutnqPQ==
=tJjj
-----END PGP SIGNATURE-----

--h1XvgxLdKjRKpZhS--

