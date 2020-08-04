Date: Tue, 4 Aug 2020 22:20:10 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200804202010.GV75094@...1296...>
References: <20200729113835.2415-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="LiQwW4YX+w4axhAx"
Content-Disposition: inline
In-Reply-To: <20200729113835.2415-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2] Rework NCP compability logic and
 drop BF-CBC support by default
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

--LiQwW4YX+w4axhAx
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jul 29, 2020 at 01:38:35PM +0200, Arne Schwabe wrote:
> This reworks the NCP logic to be more strict about what is
> considered an acceptable result of an NCP negotiation. It also
> us to finally drop BF-CBC support by default.

I think the goals are good, but there are two corner cases in the
code that are not quite right yet

[ RUN      ] test_extract_client_ciphers
[       OK ] test_extract_client_ciphers
[ RUN      ] test_poor_man
[  ERROR   ] --- Test failed with exception: Segmentation fault(11)
[  FAILED  ] test_poor_man
[ RUN      ] test_ncp_best
[       OK ] test_ncp_best
[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] 4 test(s) run.
[  PASSED  ] 3 test(s).
[  FAILED  ] 1 test(s), listed below:
[  FAILED  ] test_poor_man

 1 FAILED TEST(S)
FAIL: ncp_testdriver


... and unfortunately, it also segfaults when a 2.2 client connects -=20
so, on my server test rig all openvpn processes are gone after 2.2=20
has tested...

2020-08-04 22:05:05 us=3D274264 194.97.140.21:43906 TLS: Initial packet fro=
m [AF_INET6]::ffff:194.97.140.21:43906, sid=3D3c3a2afa adfd47fa
2020-08-04 22:05:05 us=3D390684 194.97.140.21:43906 VERIFY OK: depth=3D1, C=
=3DUS, ST=3DCalifornia, L=3DPleasanton, O=3DOpenVPN community project, CN=
=3DOpenVPN community project CA, emailAddress=3Dsamuli@...515...
2020-08-04 22:05:05 us=3D390938 194.97.140.21:43906 VERIFY OK: depth=3D0, C=
=3DDE, ST=3DBavaria, L=3DMunich, O=3DOpenVPN community project, CN=3Dcron2-=
freebsd-tc-amd64-22, ??=3DGert Doering, emailAddress=3Dgert@...1296...
2020-08-04 22:05:05 us=3D604124 194.97.140.21:43906 Control Channel: TLSv1.=
0, cipher TLS-ECDHE-RSA-WITH-AES-256-CBC-SHA, 2048 bit key
2020-08-04 22:05:05 us=3D604229 194.97.140.21:43906 [cron2-freebsd-tc-amd64=
-22] Peer Connection Initiated with [AF_INET6]::ffff:194.97.140.21:43906
2020-08-04 22:05:05 us=3D604292 cron2-freebsd-tc-amd64-22/194.97.140.21:439=
06 MULTI_sva: pool returned IPv4=3D10.204.1.18, IPv6=3Dfd00:abcd:204:1::1003
2020-08-04 22:05:05 us=3D604386 cron2-freebsd-tc-amd64-22/194.97.140.21:439=
06 mcccp1 (enter): ret=3D3, deferred=3D0
2020-08-04 22:05:05 us=3D604438 cron2-freebsd-tc-amd64-22/194.97.140.21:439=
06 MULTI: Learn: 10.204.1.18 -> cron2-freebsd-tc-amd64-22/194.97.140.21:439=
06
2020-08-04 22:05:05 us=3D604531 cron2-freebsd-tc-amd64-22/194.97.140.21:439=
06 MULTI: primary virtual IP for cron2-freebsd-tc-amd64-22/194.97.140.21:43=
906: 10.204.1.18
2020-08-04 22:05:05 us=3D604614 cron2-freebsd-tc-amd64-22/194.97.140.21:439=
06 MULTI: Learn: fd00:abcd:204:1::1003 -> cron2-freebsd-tc-amd64-22/194.97.=
140.21:43906
2020-08-04 22:05:05 us=3D604658 cron2-freebsd-tc-amd64-22/194.97.140.21:439=
06 MULTI: primary virtual IPv6 for cron2-freebsd-tc-amd64-22/194.97.140.21:=
43906: fd00:abcd:204:1::1003

Program received signal SIGSEGV, Segmentation fault.
0x00007ffff7d9112d in ?? () from /lib64/libc.so.6
(gdb) where
#0  0x00007ffff7d9112d in ?? () from /lib64/libc.so.6
#1  0x00005555555d2299 in ncp_get_best_cipher (server_list=3D0x55555562bf78=
 "AES-256-GCM:AES-128-GCM", peer_info=3Dpeer_info@...1851...=3D0x0,=20
    remote_cipher=3D0x55555566a800 "BF-CBC", gc=3Dgc@...1851...=3D0x5555556=
3de50) at ssl_ncp.c:231
#2  0x000055555558ea38 in multi_client_set_protocol_options (c=3D0x55555563=
de50) at multi.c:1833
#3  multi_client_connect_late_setup (option_types_found=3D<optimized out>, =
mi=3D0x55555563dc90, m=3D0x7fffffffc410) at multi.c:2434
#4  multi_connection_established (mi=3D0x55555563dc90, m=3D0x7fffffffc410) =
at multi.c:2672
#5  multi_process_post (m=3Dm@...1851...=3D0x7fffffffc410, mi=3D0x55555563d=
c90, flags=3Dflags@...1851...=3D9) at multi.c:2989
#6  0x000055555558f802 in multi_process_incoming_link (m=3Dm@...1851...=3D0=
x7fffffffc410, instance=3Dinstance@...1851...=3D0x55555563dc90,=20
    mpp_flags=3Dmpp_flags@...1851...=3D9) at multi.c:3361


It seems to be failing on "peer_info" being "NULL" - this used to be=20
optional in 2.2, and we only made it "always send something" in 2.3 with
some of the more interesting IV_ variables.  If I call the 2.2 client
with "--push-peer-info", it will no longer core dump the server, but
then fail with

2020-08-04 22:08:30 us=3D121232 cron2-freebsd-tc-amd64-22/194.97.140.21:108=
72 PUSH: No common cipher between server and client. Server data-ciphers: '=
AES-256-GCM:AES-128-GCM', client supports cipher 'BF-CBC'

(as in the 2.3 case below)

The culprit is this code in ncp_get_best_cipher():

    if (remote_cipher =3D=3D NULL || strstr(peer_info, "IV_CIPHERS=3D"))

- that's the only place where we do not check for "peer_info !=3D NULL"
before looking into it.

I'm not exactly sure what the code *does*, TBH, but de-fusing the check
into

    if (remote_cipher =3D=3D NULL=20
        || (peer_info && strstr(peer_info, "IV_CIPHERS=3D") ))

makes it no longer crash (and also pass the unit test).



This patch also breaks connections from "default 2.3" clients, though in a=
=20
different way:

Aug  4 21:56:25 gentoo tun-udp-p2mp-112-mask[25184]: cron2-freebsd-tc-amd64=
-23/194.97.140.21:48168 PUSH: No common cipher between server and client. S=
erver data-ciphers: 'AES-256-GCM:AES-128-GCM', client supports cipher 'BF-C=
BC'
ug  4 21:56:27 gentoo tun-udp-p2mp-112-mask[25184]: cron2-freebsd-tc-amd64-=
23/194.97.140.21:48168 SENT CONTROL [cron2-freebsd-tc-amd64-23]: 'AUTH_FAIL=
ED,Data channel cipher negotiation failed (no shared cipher)' (status=3D1)

this is a server that has *no* "--cipher" in its config, and a client
that has nothing either and no NCP - so it advertises "OCC cipher bf-cbc",
which is no longer accepted on the server.

Is that intentional?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--LiQwW4YX+w4axhAx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfKcL5AAoJEB2Cnv7KVigS5LgL/1CNfDkfrKP8FONk+fMh/Obu
m4b6bGn2bvACsvRSZSDXSWLwXyOr/gq+P0gjCfPQHSPnp/zC2kzaVF3PrtezU02D
McALDJsGIKpN6CZHgJcXt8LGjhTaKcpC4+EXvAC4/n2vrg7BJum61591X5EvqQGh
16JQqqhyjPhzrvz23CScuSy/vaNdr3b/Q5C3lRjxSo/QVub5pw+9MQYmfN5P9N+F
ZVy3nypKN9BexERnFn5zkwkad9fJAI8dgaXKkae3ltS0qsVzBu+uIwLwgyUiHFbh
hZ4jjcGRLTCBbRalI26RQnUC7+wiqNyIznAYOGsTCKOBUmBCiOvUrEGg2rqAHVOb
NIaKeQ4A8D2UI8uVZrDdEuEmVR+44eC/8nSPrUnd2eL9UZFKl7OM7cxDKfyVA+hN
dSpAp1dWs08GpP8mU5Rnh6hqZcic/iiZFU36wkMFq1jZnHIfgVsYpffh2b/3M5Y9
MzkPeSHdM8nvJxN2Mz1Gp90slXimKnoMneLVreafUg==
=5C++
-----END PGP SIGNATURE-----

--LiQwW4YX+w4axhAx--

