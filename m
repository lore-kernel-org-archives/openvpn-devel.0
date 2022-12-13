Date: Tue, 13 Dec 2022 22:37:32 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y5jwnIHp5iTOLTiG@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="VKVuUFzLBdGA3NZQ"
Content-Disposition: inline
Subject: [Openvpn-devel] DCO p2p TLS ASSERT()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--VKVuUFzLBdGA3NZQ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I've managed to break p2p TLS again...  not sure how I did this, but
anyway.

This is "master + kp 1/4" running on FreeBSD, in a p2p --tls-server
instance.  It passed the first few tests, but then got left alone for
an hour, trying to reestablish the connection to the "missing --tls-client".

Dec 13 22:18:41 fbsd14 tun-udp-p2p-tls-sha256[19966]: TLS Error: TLS key ne=
gotiation failed to occur within 60 seconds (check your network connectivit=
y)
Dec 13 22:18:41 fbsd14 tun-udp-p2p-tls-sha256[19966]: TLS Error: TLS handsh=
ake failed
Dec 13 22:18:41 fbsd14 tun-udp-p2p-tls-sha256[19966]: dco_update_keys: peer=
_id=3D3710010
Dec 13 22:18:55 fbsd14 tun-udp-p2mp-topology-subnet[19846]: Failed to get p=
eer stats: Operation not supported (errno=3D45)
Dec 13 22:18:56 fbsd14 tun-udp-p2p-tls-sha256[19966]: dco_update_keys: peer=
_id=3D3710010
Dec 13 22:18:56 fbsd14 tun-udp-p2p-tls-sha256[19966]: UDPv6 WRITE [14] to [=
AF_INET6]::ffff:195.30.8.84:34745: P_CONTROL_HARD_RESET_SERVER_V2 kid=3D0 [=
 ] pid=3D0 DATA len=3D0
Dec 13 22:18:56 fbsd14 tun-udp-p2p-tls-sha256[19966]: dco_update_keys: peer=
_id=3D3710010
Dec 13 22:18:58 fbsd14 syslogd: last message repeated 1 times
Dec 13 22:18:58 fbsd14 tun-udp-p2p-tls-sha256[19966]: UDPv6 WRITE [14] to [=
AF_INET6]::ffff:195.30.8.84:34745: P_CONTROL_HARD_RESET_SERVER_V2 kid=3D0 [=
 ] pid=3D0 DATA len=3D0
Dec 13 22:18:58 fbsd14 tun-udp-p2p-tls-sha256[19966]: dco_update_keys: peer=
_id=3D3710010
Dec 13 22:19:02 fbsd14 syslogd: last message repeated 1 times
...
Dec 13 22:19:57 fbsd14 tun-udp-p2p-tls-sha256[19966]: TLS Error: TLS key ne=
gotiation failed to occur within 60 seconds (check your network connectivit=
y)
Dec 13 22:19:57 fbsd14 tun-udp-p2p-tls-sha256[19966]: TLS Error: TLS handsh=
ake failed
Dec 13 22:19:57 fbsd14 tun-udp-p2p-tls-sha256[19966]: dco_update_keys: peer=
_id=3D3710010
Dec 13 22:20:12 fbsd14 syslogd: last message repeated 1 times
Dec 13 22:20:12 fbsd14 tun-udp-p2p-tls-sha256[19966]: UDPv6 WRITE [14] to [=
AF_INET6]::ffff:195.30.8.84:34745: P_CONTROL_HARD_RESET_SERVER_V2 kid=3D0 [=
 ] pid=3D0 DATA len=3D0
Dec 13 22:20:12 fbsd14 tun-udp-p2p-tls-sha256[19966]: dco_update_keys: peer=
_id=3D3710010
...

Reconnecting *then*, the session did not work, and kernel/userland got
all confused about key state:

Dec 13 22:24:44 fbsd14 tun-udp-p2p-tls-sha256[19966]: UDPv6 READ [14] from =
[AF_INET6]2001:608:1:995a:250:56ff:febb:2084:35757: P_CONTROL_HARD_RESET_CL=
IENT_V2 kid=3D0 [ ] pid=3D0 DATA len=3D0
Dec 13 22:24:44 fbsd14 tun-udp-p2p-tls-sha256[19966]: TLS: Initial packet f=
rom [AF_INET6]2001:608:1:995a:250:56ff:febb:2084:35757, sid=3D01cf646f 5315=
8ed8
Dec 13 22:24:44 fbsd14 tun-udp-p2p-tls-sha256[19966]: dco_update_keys: peer=
_id=3D3710010
Dec 13 22:24:44 fbsd14 tun-udp-p2p-tls-sha256[19966]: UDPv6 WRITE [26] to [=
AF_INET6]2001:608:1:995a:250:56ff:febb:2084:35757: P_CONTROL_HARD_RESET_SER=
VER_V2 kid=3D0 [ 0 ] pid=3D0 DATA len=3D0
Dec 13 22:24:44 fbsd14 tun-udp-p2p-tls-sha256[19966]: dco_update_keys: peer=
_id=3D3710010
Dec 13 22:24:44 fbsd14 tun-udp-p2p-tls-sha256[19966]: UDPv6 READ [299] from=
 [AF_INET6]2001:608:1:995a:250:56ff:febb:2084:35757: P_CONTROL_V1 kid=3D0 [=
 0 ] pid=3D1 DATA len=3D273
Dec 13 22:24:44 fbsd14 tun-udp-p2p-tls-sha256[19966]: dco_update_keys: peer=
_id=3D3710010
...
Dec 13 22:24:44 fbsd14 tun-udp-p2p-tls-sha256[19966]: dco_update_keys: peer=
_id=3D3710010
Dec 13 22:24:45 fbsd14 tun-udp-p2p-tls-sha256[19966]: UDPv6 READ [100] from=
 [AF_INET6]2001:608:1:995a:250:56ff:febb:2084:35757: P_DATA_V2 kid=3D0 DATA=
 len=3D99
Dec 13 22:24:45 fbsd14 tun-udp-p2p-tls-sha256[19966]: dco_update_keys: peer=
_id=3D3710010
Dec 13 22:24:47 fbsd14 tun-udp-p2p-tls-sha256[19966]: UDPv6 READ [116] from=
 [AF_INET6]2001:608:1:995a:250:56ff:febb:2084:35757: P_DATA_V2 kid=3D0 DATA=
 len=3D115
Dec 13 22:24:47 fbsd14 tun-udp-p2p-tls-sha256[19966]: dco_update_keys: peer=
_id=3D3710010
Dec 13 22:24:47 fbsd14 tun-udp-p2p-tls-sha256[19966]: UDPv6 READ [116] from=
 [AF_INET6]2001:608:1:995a:250:56ff:febb:2084:35757: P_DATA_V2 kid=3D0 DATA=
 len=3D115

(why do I see an UDPv6 READ with P_DATA_V2 here, when it should be
doing this in kernel?)

...
Dec 13 22:24:59 fbsd14 tun-udp-p2p-tls-sha256[19966]: UDPv6 READ [1512] fro=
m [AF_INET6]2001:608:1:995a:250:56ff:febb:2084:35757: P_DATA_V2 kid=3D0 DAT=
A len=3D1511
Dec 13 22:24:59 fbsd14 tun-udp-p2p-tls-sha256[19966]: dco_update_keys: peer=
_id=3D3710010
Dec 13 22:24:59 fbsd14 tun-udp-p2p-tls-sha256[19966]: Swapping primary and =
secondary keys, now: id1=3D0 id2=3D0
Dec 13 22:24:59 fbsd14 tun-udp-p2p-tls-sha256[19966]: dco_swap_keys: peer-i=
d 3710010
Dec 13 22:24:59 fbsd14 tun-udp-p2p-tls-sha256[19966]: UDPv6 READ [1512] fro=
m [AF_INET6]2001:608:1:995a:250:56ff:febb:2084:35757: P_DATA_V2 kid=3D0 DAT=
A len=3D1511
...


Dec 13 22:26:16 fbsd14 tun-udp-p2p-tls-sha256[19966]: TLS: tls_multi_proces=
s: untrusted session promoted to trusted
Dec 13 22:26:16 fbsd14 tun-udp-p2p-tls-sha256[19966]: dco_update_keys: peer=
_id=3D9123839
Dec 13 22:26:16 fbsd14 tun-udp-p2p-tls-sha256[19966]: Swapping primary and =
secondary keys, now: id1=3D0 id2=3D-1

  "id2=3D-1"?

Dec 13 22:26:16 fbsd14 tun-udp-p2p-tls-sha256[19966]: dco_swap_keys: peer-i=
d 9123839
Dec 13 22:26:16 fbsd14 tun-udp-p2p-tls-sha256[19966]: Failed to swap keys: =
Link has been severed (errno=3D91)
Dec 13 22:26:16 fbsd14 tun-udp-p2p-tls-sha256[19966]: Cannot swap keys: Ope=
ration not permitted (-1)
Dec 13 22:26:16 fbsd14 tun-udp-p2p-tls-sha256[19966]: UDPv6 WRITE [364] to =
[AF_INET6]::ffff:195.30.8.84:55171: P_CONTROL_V1 kid=3D0 [ 5 4 3 2 ] pid=3D=
4 DATA len=3D326
Dec 13 22:26:16 fbsd14 tun-udp-p2p-tls-sha256[19966]: dco_update_keys: peer=
_id=3D9123839
Dec 13 22:26:16 fbsd14 tun-udp-p2p-tls-sha256[19966]: Swapping primary and =
secondary keys, now: id1=3D0 id2=3D-1
Dec 13 22:26:16 fbsd14 tun-udp-p2p-tls-sha256[19966]: dco_swap_keys: peer-i=
d 9123839
Dec 13 22:26:16 fbsd14 tun-udp-p2p-tls-sha256[19966]: Failed to swap keys: =
Link has been severed (errno=3D91)
Dec 13 22:26:16 fbsd14 tun-udp-p2p-tls-sha256[19966]: Cannot swap keys: Ope=
ration not permitted (-1)
Dec 13 22:26:16 fbsd14 tun-udp-p2p-tls-sha256[19966]: UDPv6 READ [22] from =
[AF_INET6]::ffff:195.30.8.84:55171: P_ACK_V1 kid=3D0 [ 4 ] DATA len=3D0
Dec 13 22:26:16 fbsd14 tun-udp-p2p-tls-sha256[19966]: Control Channel: TLSv=
1.2, cipher TLS-ECDHE-RSA-WITH-CHACHA20-POLY1305-SHA256, 2048 bit key
Dec 13 22:26:16 fbsd14 tun-udp-p2p-tls-sha256[19966]: [cron2-ubuntu-2004-am=
d64] Peer Connection Initiated with [AF_INET6]::ffff:195.30.8.84:55171
Dec 13 22:26:16 fbsd14 tun-udp-p2p-tls-sha256[19966]: dco_update_keys: peer=
_id=3D9123839
Dec 13 22:26:16 fbsd14 tun-udp-p2p-tls-sha256[19966]: Swapping primary and =
secondary keys, now: id1=3D0 id2=3D-1
Dec 13 22:26:16 fbsd14 tun-udp-p2p-tls-sha256[19966]: dco_swap_keys: peer-i=
d 9123839
Dec 13 22:26:16 fbsd14 tun-udp-p2p-tls-sha256[19966]: Failed to swap keys: =
Link has been severed (errno=3D91)
Dec 13 22:26:16 fbsd14 tun-udp-p2p-tls-sha256[19966]: Cannot swap keys: Ope=
ration not permitted (-1)
Dec 13 22:26:17 fbsd14 tun-udp-p2p-tls-sha256[19966]: dco_del_peer: peer-id=
 9123839
Dec 13 22:26:17 fbsd14 tun-udp-p2p-tls-sha256[19966]: dco_new_peer: peer-id=
 15538802, fd 7
Dec 13 22:26:17 fbsd14 tun-udp-p2p-tls-sha256[19966]: Data Channel: using n=
egotiated cipher 'AES-256-GCM'
Dec 13 22:26:17 fbsd14 tun-udp-p2p-tls-sha256[19966]: Data Channel MTU parm=
s [ mss_fix:1380 max_frag:0 tun_mtu:1500 tun_max_mtu:1600 headroom:136 payl=
oad:1768 tailroom:562 ET:0 ]
Dec 13 22:26:17 fbsd14 tun-udp-p2p-tls-sha256[19966]: dco_install_key: peer=
_id=3D15538802 keyid=3D0
Dec 13 22:26:17 fbsd14 tun-udp-p2p-tls-sha256[19966]: dco_new_key: slot 1, =
key-id 0, peer-id 15538802, cipher AES-256-GCM
Dec 13 22:26:17 fbsd14 tun-udp-p2p-tls-sha256[19966]: Initialization Sequen=
ce Completed
Dec 13 22:26:17 fbsd14 tun-udp-p2p-tls-sha256[19966]: dco_update_keys: peer=
_id=3D15538802
Dec 13 22:26:17 fbsd14 tun-udp-p2p-tls-sha256[19966]: Swapping primary and =
secondary keys, now: id1=3D0 id2=3D0
Dec 13 22:26:17 fbsd14 tun-udp-p2p-tls-sha256[19966]: dco_swap_keys: peer-i=
d 15538802
Dec 13 22:26:17 fbsd14 tun-udp-p2p-tls-sha256[19966]: Assertion failed at d=
co.c:197 (secondary->dco_status =3D=3D DCO_INSTALLED_PRIMARY)
Dec 13 22:26:17 fbsd14 tun-udp-p2p-tls-sha256[19966]: Exiting due to fatal =
error
Dec 13 22:26:17 fbsd14 tun-udp-p2p-tls-sha256[19966]: Closing DCO interface


... this is very likely not related to the counter patch 1/4 but more
a generic "state machines getting confused" thing.

Not sure I can reproduce this, but I do have the full "verb 6" log=20
for this server instance if one of you wants to have a look.


We have this GH issue about DCO Linux getting out of sync with userland
if tortured with "reneg-sec 15".  Seems we need to have a very close
look at renegotiations / key rotation, maybe combined with clients
disconnecting at inconvenient moments.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--VKVuUFzLBdGA3NZQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjmPCcAAoJEB2Cnv7KVigSDlkL/1FK73aqicy2SSB7MnmX4AN8
CSlZJ9znAYKSkl5m2+xNn9K5UTHuzC0K0fV3qNPIOPtNgMmF2+qmwqEh6NCXjYdh
I07dPeEpngJ5wxwV3VduL0GmfXSPwmHRear01bkRcMuk2p5MuO0QTV1C7P9rZ5i9
Cez9e3lZLZZp6VJ0OigTuInVEbpbiCaCMWov/dlzgDZp4T6wz8HG8k2GDv1/WVGG
sPtIwx8zWE3tblBZWZ7s4YzSuuX0S+8eu4W+T0AIeRdgFESXMobfYXHnjIOcyjFy
qFagjgVcy0O/IgZFAAy5LZEpcHS4JLEf5KqSnbhTqnom9HcMYC6FCG7kdYSAmmsf
pN6cHehsOFDwAW1CtCb0VvGCsmpD2ApK5X8M3wA6WiQcSCuyulS85cEurNI5IY9l
elFgUkie1pnav2AFpqFaAVstCDjBIcBpaGgbqPmTubPWTF7UJxh3d1MSGtbr8J7f
dkcvf9kAovRYeKlGDi6xdJj41GmStHOw5PeTaceL7Q==
=COL1
-----END PGP SIGNATURE-----

--VKVuUFzLBdGA3NZQ--

