From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 9 Dec 2025 14:47:47 +0000
In-Reply-To: <gerrit.1760995553000.I31ac2a763209114267c35c4a9182a12d8d82f6fe@...2715...>
References: <gerrit.1760995553000.I31ac2a763209114267c35c4a9182a12d8d82f6fe@...2715...>
Reply-To: arne-openvpn@...1227..., davidben@...410...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <6b86e37f493d61863eb503cfcaea3e7a8f849d2c-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Rk1ucuV2yw4="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: ssl_openssl: Fix
 some CRL mixups
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: davidben <davidben@...410...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Rk1ucuV2yw4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: davidben, flichtenheld.

plaisthos has posted comments on this change by davidben. ( http://gerrit.o=
penvpn.net/c/openvpn/+/1289?usp=3Demail )

Change subject: ssl_openssl: Fix some CRL mixups
......................................................................


Patch Set 2: Code-Review-2

(1 comment)

Patchset:

PS2:
There seem to be a problem when the CRL file gets invalid:

I setup OpenVPN with a normal setup

(gdb) run
Starting program: /home/arne/openvpn-cmake-debug/openvpn --server 10.33.0.0=
 255.255.255.0 --server-ipv6 fd00:f00f:babe::1/64 --topology subnet --cert =
/home/arne/ut-ca/server.pem --key /home/arne/ut-ca/server.key --dev tun --v=
erb 4 --data-ciphers AES-256-GCM:AES-128-GCM:AES-192-GCM --tun-mtu 1400 --k=
eepalive 10 25 --push explicit-exit-notify\ 3 --verb 4 --crl-verify /home/a=
rne/ut-ca/ca.crl --ca /home/arne/ut-ca/ca.pem

[...]

Then connected a client and that went fine.

Then I replaced the CRL file with an invalid one:

rm ca.crl && touch ca.crl

Connecting the client again first works fine (connection gets rejected)



2025-12-09 14:43:11 us=3D78031 Connection Attempt MULTI: multi_create_insta=
nce called
2025-12-09 14:43:11 us=3D78143 udp4:192.168.188.75:58649 Re-using SSL/TLS c=
ontext
2025-12-09 14:43:11 us=3D78267 udp4:192.168.188.75:58649 Control Channel MT=
U parms [ mss_fix:0 max_frag:0 tun_mtu:1250 tun_max_mtu:0 headroom:126 payl=
oad:1600 tailroom:126 ET:0 ]
2025-12-09 14:43:11 us=3D78293 udp4:192.168.188.75:58649 Data Channel MTU p=
arms [ mss_fix:0 max_frag:0 tun_mtu:1400 tun_max_mtu:1600 headroom:136 payl=
oad:1768 tailroom:562 ET:0 ]
2025-12-09 14:43:11 us=3D82903 udp4:192.168.188.75:58649 VERIFY WARNING: de=
pth=3D0, unable to get certificate CRL: C=3DKG, ST=3DNA, O=3DOpenVPN-TEST, =
CN=3DTest-Client, emailAddress=3Darne@...515...
2025-12-09 14:43:11 us=3D83007 udp4:192.168.188.75:58649 VERIFY WARNING: de=
pth=3D1, unable to get certificate CRL: C=3DKG, ST=3DNA, L=3DBISHKEK, O=3DO=
penVPN-TEST, emailAddress=3Darne@...515...
2025-12-09 14:43:11 us=3D83165 udp4:192.168.188.75:58649 VERIFY ERROR: CRL =
not loaded
2025-12-09 14:43:11 us=3D83238 udp4:192.168.188.75:58649 Sent fatal SSL ale=
rt: unknown CA
2025-12-09 14:43:11 us=3D83289 udp4:192.168.188.75:58649 OpenSSL: error:0A0=
00086:SSL routines::certificate verify failed:
2025-12-09 14:43:11 us=3D83330 udp4:192.168.188.75:58649 TLS_ERROR: BIO rea=
d tls_read_plaintext error
2025-12-09 14:43:11 us=3D83358 udp4:192.168.188.75:58649 TLS Error: TLS obj=
ect -> incoming plaintext read error
2025-12-09 14:43:11 us=3D83405 udp4:192.168.188.75:58649 TLS Error: TLS han=
dshake failed
2025-12-09 14:43:11 us=3D83550 Warning buffer of freed TLS session is still=
 in use (session->key[0].send_reliable->array[0])
2025-12-09 14:43:11 us=3D83686 udp4:192.168.188.75:58649 SIGUSR1[soft,tls-e=
rror] received, client-instance restarting
2025-12-09 14:43:11 us=3D83759 Packet (P_CONTROL_V1) with invalid or missin=
g SID from [AF_INET]192.168.188.75:58649 or wrong packet id
2025-12-09 14:43:13 us=3D380641 Packet (P_CONTROL_V1) with invalid or missi=
ng SID from [AF_INET]192.168.188.75:58649 or wrong packet id
2025-12-09 14:43:13 us=3D380799 Packet (P_CONTROL_V1) with invalid or missi=
ng SID from [AF_INET]192.168.188.75:58649 or wrong packet id


But then reconnecting again leads to a segfault:


2025-12-09 14:43:14 us=3D950844 Connection Attempt MULTI: multi_create_inst=
ance called
2025-12-09 14:43:14 us=3D950963 udp4:192.168.188.75:59576 Re-using SSL/TLS =
context
2025-12-09 14:43:14 us=3D951112 udp4:192.168.188.75:59576 Control Channel M=
TU parms [ mss_fix:0 max_frag:0 tun_mtu:1250 tun_max_mtu:0 headroom:126 pay=
load:1600 tailroom:126 ET:0 ]
2025-12-09 14:43:14 us=3D951162 udp4:192.168.188.75:59576 Data Channel MTU =
parms [ mss_fix:0 max_frag:0 tun_mtu:1400 tun_max_mtu:1600 headroom:136 pay=
load:1768 tailroom:562 ET:0 ]
2025-12-09 14:43:14 us=3D955828 udp4:192.168.188.75:59576 VERIFY WARNING: d=
epth=3D0, unable to get certificate CRL: C=3DKG, ST=3DNA, O=3DOpenVPN-TEST,=
 CN=3DTest-Client, emailAddress=3Darne@...515...
2025-12-09 14:43:14 us=3D955883 udp4:192.168.188.75:59576 VERIFY WARNING: d=
epth=3D1, unable to get certificate CRL: C=3DKG, ST=3DNA, L=3DBISHKEK, O=3D=
OpenVPN-TEST, emailAddress=3Darne@...515...
2025-12-09 14:43:14 us=3D955942 udp4:192.168.188.75:59576 VERIFY ERROR: CRL=
 not loaded
2025-12-09 14:43:14 us=3D955961 udp4:192.168.188.75:59576 Sent fatal SSL al=
ert: unknown CA
2025-12-09 14:43:14 us=3D955981 udp4:192.168.188.75:59576 OpenSSL: error:0A=
000086:SSL routines::certificate verify failed:
2025-12-09 14:43:14 us=3D955988 udp4:192.168.188.75:59576 TLS_ERROR: BIO re=
ad tls_read_plaintext error
2025-12-09 14:43:14 us=3D955996 udp4:192.168.188.75:59576 TLS Error: TLS ob=
ject -> incoming plaintext read error
2025-12-09 14:43:14 us=3D956005 udp4:192.168.188.75:59576 TLS Error: TLS ha=
ndshake failed
2025-12-09 14:43:14 us=3D956018 Warning buffer of freed TLS session is stil=
l in use (session->key[0].send_reliable->array[0])
2025-12-09 14:43:14 us=3D956061 udp4:192.168.188.75:59576 SIGUSR1[soft,tls-=
error] received, client-instance restarting
2025-12-09 14:43:14 us=3D956089 Packet (P_CONTROL_V1) with invalid or missi=
ng SID from [AF_INET]192.168.188.75:59576 or wrong packet id
\


2025-12-09 14:43:28 us=3D286692 Connection Attempt MULTI: multi_create_inst=
ance called
2025-12-09 14:43:28 us=3D286782 udp4:192.168.188.75:60010 Re-using SSL/TLS =
context
2025-12-09 14:43:28 us=3D287024 udp4:192.168.188.75:60010 OpenSSL: error:03=
08010C:digital envelope routines::unsupported:Global default library contex=
t, Algorithm (none : 0), Properties (<null>)
2025-12-09 14:43:28 us=3D287031 udp4:192.168.188.75:60010 OpenSSL: error:04=
80006C:PEM routines::no start line:
2025-12-09 14:43:28 us=3D287034 udp4:192.168.188.75:60010 CRL: cannot read =
CRL from file /home/arne/ut-ca/ca.crl
2025-12-09 14:43:28 us=3D287036 udp4:192.168.188.75:60010 CRL: loaded 1 CRL=
s from file /home/arne/ut-ca/ca.crl
2025-12-09 14:43:28 us=3D287058 udp4:192.168.188.75:60010 Control Channel M=
TU parms [ mss_fix:0 max_frag:0 tun_mtu:1250 tun_max_mtu:0 headroom:126 pay=
load:1600 tailroom:126 ET:0 ]
2025-12-09 14:43:28 us=3D287061 udp4:192.168.188.75:60010 Data Channel MTU =
parms [ mss_fix:0 max_frag:0 tun_mtu:1400 tun_max_mtu:1600 headroom:136 pay=
load:1768 tailroom:562 ET:0 ]
2025-12-09 14:43:28 us=3D292177 udp4:192.168.188.75:60010 VERIFY OK: depth=
=3D1, C=3DKG, ST=3DNA, L=3DBISHKEK, O=3DOpenVPN-TEST, emailAddress=3Darne@...220...=
..515...
2025-12-09 14:43:28 us=3D292774 udp4:192.168.188.75:60010 VERIFY OK: depth=
=3D0, C=3DKG, ST=3DNA, O=3DOpenVPN-TEST, CN=3DTest-Client, emailAddress=3Da=
rne@...515...
2025-12-09 14:43:28 us=3D293487 udp4:192.168.188.75:60010 peer info: IV_VER=
=3D2.7_rc3
2025-12-09 14:43:28 us=3D293559 udp4:192.168.188.75:60010 peer info: IV_PLA=
T=3Dmac
2025-12-09 14:43:28 us=3D293612 udp4:192.168.188.75:60010 peer info: IV_TCP=
NL=3D1
2025-12-09 14:43:28 us=3D293639 udp4:192.168.188.75:60010 peer info: IV_MTU=
=3D1600
2025-12-09 14:43:28 us=3D293652 udp4:192.168.188.75:60010 peer info: IV_NCP=
=3D2
2025-12-09 14:43:28 us=3D293664 udp4:192.168.188.75:60010 peer info: IV_CIP=
HERS=3DAES-256-GCM:AES-128-GCM:CHACHA20-POLY1305
2025-12-09 14:43:28 us=3D293704 udp4:192.168.188.75:60010 peer info: IV_PRO=
TO=3D8094
2025-12-09 14:43:28 us=3D293775 udp4:192.168.188.75:60010 peer info: ID=3De=
7afaf
2025-12-09 14:43:28 us=3D293793 udp4:192.168.188.75:60010 peer info: IV_LZO=
_STUB=3D1
2025-12-09 14:43:28 us=3D293799 udp4:192.168.188.75:60010 peer info: IV_COM=
P_STUB=3D1
2025-12-09 14:43:28 us=3D293804 udp4:192.168.188.75:60010 peer info: IV_COM=
P_STUBv2=3D1
2025-12-09 14:43:28 us=3D293983 udp4:192.168.188.75:60010 TLS: move_session=
: dest=3DTM_ACTIVE src=3DTM_INITIAL reinit_src=3D1
2025-12-09 14:43:28 us=3D294092 udp4:192.168.188.75:60010 TLS: tls_multi_pr=
ocess: initial untrusted session promoted to trusted
2025-12-09 14:43:28 us=3D294701 udp4:192.168.188.75:60010 Control Channel: =
TLSv1.3, cipher TLSv1.3 TLS_AES_256_GCM_SHA384, peer certificate: 2048 bits=
 RSA, signature: ecdsa-with-SHA256, peer temporary key: 768 bits X25519MLKE=
M768, peer signing digest/type: rsa_pss_rsae_sha256 RSASSA-PSS, key agreeme=
nt: X25519MLKEM768
2025-12-09 14:43:28 us=3D294754 udp4:192.168.188.75:60010 [Test-Client] Pee=
r Connection Initiated with [AF_INET]192.168.188.75:60010
2025-12-09 14:43:28 us=3D294784 Test-Client/udp4:192.168.188.75:60010 MULTI=
_sva: pool returned IPv4=3D10.33.0.2, IPv6=3Dfd00:f00f:babe::1001
2025-12-09 14:43:28 us=3D295142 Test-Client/udp4:192.168.188.75:60010 Data =
Channel MTU parms [ mss_fix:1360 max_frag:0 tun_mtu:1400 tun_max_mtu:1600 h=
eadroom:136 payload:1768 tailroom:562 ET:0 ]
2025-12-09 14:43:28 us=3D295205 Test-Client/udp4:192.168.188.75:60010 Outgo=
ing dynamic tls-crypt: Cipher 'AES-256-CTR' initialized with 256 bit key
2025-12-09 14:43:28 us=3D295223 Test-Client/udp4:192.168.188.75:60010 Outgo=
ing dynamic tls-crypt: Using 256 bit message hash 'SHA256' for HMAC authent=
ication
2025-12-09 14:43:28 us=3D295230 Test-Client/udp4:192.168.188.75:60010 Incom=
ing dynamic tls-crypt: Cipher 'AES-256-CTR' initialized with 256 bit key
2025-12-09 14:43:28 us=3D295238 Test-Client/udp4:192.168.188.75:60010 Incom=
ing dynamic tls-crypt: Using 256 bit message hash 'SHA256' for HMAC authent=
ication
2025-12-09 14:43:28 us=3D295297 Test-Client/udp4:192.168.188.75:60010 MULTI=
: Learn: 10.33.0.2 -> Test-Client/udp4:192.168.188.75:60010
2025-12-09 14:43:28 us=3D295333 Test-Client/udp4:192.168.188.75:60010 MULTI=
: primary virtual IP for Test-Client/udp4:192.168.188.75:60010: 10.33.0.2
2025-12-09 14:43:28 us=3D295352 Test-Client/udp4:192.168.188.75:60010 MULTI=
: Learn: fd00:f00f:babe::1001 -> Test-Client/udp4:192.168.188.75:60010
2025-12-09 14:43:28 us=3D295359 Test-Client/udp4:192.168.188.75:60010 MULTI=
: primary virtual IPv6 for Test-Client/udp4:192.168.188.75:60010: fd00:f00f=
:babe::1001
2025-12-09 14:43:28 us=3D295389 Test-Client/udp4:192.168.188.75:60010 SENT =
CONTROL [Test-Client]: 'PUSH_REPLY,explicit-exit-notify 3,tun-ipv6,route-ga=
teway 10.33.0.1,topology subnet,ping 10,ping-restart 25,ifconfig-ipv6 fd00:=
f00f:babe::1001/64 fd00:f00f:babe::2,ifconfig 10.33.0.2 255.255.255.0,peer-=
id 0,cipher AES-256-GCM,protocol-flags cc-exit tls-ekm dyn-tls-crypt,tun-mt=
u 1400' (status=3D1)
2025-12-09 14:43:29 us=3D319915 Test-Client/udp4:192.168.188.75:60010 Data =
Channel: cipher 'AES-256-GCM', rx-peer-id: 0, tx-peer-id: 0
2025-12-09 14:43:29 us=3D320027 Test-Client/udp4:192.168.188.75:60010 Timer=
s: ping 10, ping-restart 50
2025-12-09 14:43:29 us=3D320051 Test-Client/udp4:192.168.188.75:60010 Proto=
col options: protocol-flags cc-exit tls-ekm dyn-tls-crypt
2025-12-09 14:43:37 us=3D293135 Test-Client/udp4:192.168.188.75:60010 CC-EE=
N exit message received by peer
2025-12-09 14:43:37 us=3D293196 Test-Client/udp4:192.168.188.75:60010 Delay=
ed exit in 5 seconds
2025-12-09 14:43:42 us=3D321905 Test-Client/udp4:192.168.188.75:60010 SIGTE=
RM[soft,delayed-exit] received, client-instance exiting
2025-12-09 14:43:42 us=3D322142 ovpn_handle_peer: received data for a non-e=
xisting peer 0
2025-12-09 14:43:58 us=3D52079 Connection Attempt MULTI: multi_create_insta=
nce called
2025-12-09 14:43:58 us=3D52177 udp4:192.168.188.75:58033 Re-using SSL/TLS c=
ontext
2025-12-09 14:43:58 us=3D52342 udp4:192.168.188.75:58033 OpenSSL: error:030=
8010C:digital envelope routines::unsupported:Global default library context=
, Algorithm (none : 0), Properties (<null>)
2025-12-09 14:43:58 us=3D52349 udp4:192.168.188.75:58033 OpenSSL: error:048=
0006C:PEM routines::no start line:
2025-12-09 14:43:58 us=3D52352 udp4:192.168.188.75:58033 CRL: cannot read C=
RL from file /home/arne/ut-ca/ca.crl
2025-12-09 14:43:58 us=3D52354 udp4:192.168.188.75:58033 CRL: loaded 0 CRLs=
 from file /home/arne/ut-ca/ca.crl
2025-12-09 14:43:58 us=3D52375 udp4:192.168.188.75:58033 Control Channel MT=
U parms [ mss_fix:0 max_frag:0 tun_mtu:1250 tun_max_mtu:0 headroom:126 payl=
oad:1600 tailroom:126 ET:0 ]
2025-12-09 14:43:58 us=3D52378 udp4:192.168.188.75:58033 Data Channel MTU p=
arms [ mss_fix:0 max_frag:0 tun_mtu:1400 tun_max_mtu:1600 headroom:136 payl=
oad:1768 tailroom:562 ET:0 ]
2025-12-09 14:43:58 us=3D57062 udp4:192.168.188.75:58033 VERIFY WARNING: de=
pth=3D0, unable to get certificate CRL: C=3DKG, ST=3DNA, O=3DOpenVPN-TEST, =
CN=3DTest-Client, emailAddress=3Darne@...515...
2025-12-09 14:43:58 us=3D57086 udp4:192.168.188.75:58033 VERIFY WARNING: de=
pth=3D1, unable to get certificate CRL: C=3DKG, ST=3DNA, L=3DBISHKEK, O=3DO=
penVPN-TEST, emailAddress=3Darne@...515...
2025-12-09 14:43:58 us=3D57129 udp4:192.168.188.75:58033 VERIFY ERROR: CRL =
not loaded
2025-12-09 14:43:58 us=3D57142 udp4:192.168.188.75:58033 Sent fatal SSL ale=
rt: unknown CA
2025-12-09 14:43:58 us=3D57155 udp4:192.168.188.75:58033 OpenSSL: error:0A0=
00086:SSL routines::certificate verify failed:
2025-12-09 14:43:58 us=3D57157 udp4:192.168.188.75:58033 TLS_ERROR: BIO rea=
d tls_read_plaintext error
2025-12-09 14:43:58 us=3D57160 udp4:192.168.188.75:58033 TLS Error: TLS obj=
ect -> incoming plaintext read error
2025-12-09 14:43:58 us=3D57164 udp4:192.168.188.75:58033 TLS Error: TLS han=
dshake failed
2025-12-09 14:43:58 us=3D57175 Warning buffer of freed TLS session is still=
 in use (session->key[0].send_reliable->array[0])
2025-12-09 14:43:58 us=3D57217 udp4:192.168.188.75:58033 SIGUSR1[soft,tls-e=
rror] received, client-instance restarting
2025-12-09 14:43:58 us=3D57246 Packet (P_CONTROL_V1) with invalid or missin=
g SID from [AF_INET]192.168.188.75:58033 or wrong packet id
2025-12-09 14:43:59 us=3D165790 Packet (P_CONTROL_V1) with invalid or missi=
ng SID from [AF_INET]192.168.188.75:58033 or wrong packet id
2025-12-09 14:43:59 us=3D165885 Packet (P_CONTROL_V1) with invalid or missi=
ng SID from [AF_INET]192.168.188.75:58033 or wrong packet id
2025-12-09 14:44:05 us=3D928745 Connection Attempt MULTI: multi_create_inst=
ance called
2025-12-09 14:44:05 us=3D928929 udp4:192.168.188.75:54942 Re-using SSL/TLS =
context

Program received signal SIGSEGV, Segmentation fault.
0x00007ffff7ba7cc5 in OPENSSL_sk_pop_free () from /lib/x86_64-linux-gnu/lib=
crypto.so.3

(gdb) bt
#0  0x00007ffff7ba7cc5 in OPENSSL_sk_pop_free () from /lib/x86_64-linux-gnu=
/libcrypto.so.3
#1  0x000055555561339a in backend_tls_ctx_reload_crl (ssl_ctx=3D0x55555576f=
260, crl_file=3D0x7fffffffe5f2 "/home/arne/ut-ca/ca.crl", crl_inline=3Dfals=
e)
    at /home/arne/openvpn-git/src/openvpn/ssl_openssl.c:1348
#2  0x0000555555608148 in tls_ctx_reload_crl (ssl_ctx=3D0x55555576f260, crl=
_file=3D0x7fffffffe5f2 "/home/arne/ut-ca/ca.crl", crl_file_inline=3Dfalse)
    at /home/arne/openvpn-git/src/openvpn/ssl.c:503
#3  0x0000555555608e63 in key_state_init (session=3D0x55555576f970, ks=3D0x=
5555557700e0) at /home/arne/openvpn-git/src/openvpn/ssl.c:879
#4  0x000055555560924c in tls_session_init (multi=3D0x55555576f260, session=
=3D0x55555576f970) at /home/arne/openvpn-git/src/openvpn/ssl.c:1023
#5  0x0000555555609748 in tls_multi_init_finalize (multi=3D0x55555576f260, =
tls_mtu=3D1250) at /home/arne/openvpn-git/src/openvpn/ssl.c:1177
#6  0x0000555555592659 in do_init_frame_tls (c=3D0x55555577f2c0) at /home/a=
rne/openvpn-git/src/openvpn/init.c:3462
#7  0x0000555555594b45 in init_instance (c=3D0x55555577f2c0, env=3D0x555555=
6fdb30, flags=3D10) at /home/arne/openvpn-git/src/openvpn/init.c:4613
#8  0x0000555555595625 in inherit_context_child (dest=3D0x55555577f2c0, src=
=3D0x7fffffffb5d8, sock=3D0x5555556fd8e0) at /home/arne/openvpn-git/src/ope=
nvpn/init.c:4914
#9  0x00005555555aba4b in multi_create_instance (m=3D0x7fffffffb510, real=
=3D0x7fffffffafb0, sock=3D0x5555556fd8e0) at /home/arne/openvpn-git/src/ope=
nvpn/multi.c:737
#10 0x00005555555a8bec in multi_get_create_instance_udp (m=3D0x7fffffffb510=
, floated=3D0x7fffffffb3b0, sock=3D0x5555556fd8e0) at /home/arne/openvpn-gi=
t/src/openvpn/mudp.c:269
#11 0x00005555555b198e in multi_process_incoming_link (m=3D0x7fffffffb510, =
instance=3D0x0, mpp_flags=3D5, sock=3D0x5555556fd8e0) at /home/arne/openvpn=
-git/src/openvpn/multi.c:3357
#12 0x00005555555a8fd1 in multi_process_io_udp (m=3D0x7fffffffb510, sock=3D=
0x5555556fd8e0) at /home/arne/openvpn-git/src/openvpn/mudp.c:357
#13 0x00005555555b54b5 in multi_io_process_io (m=3D0x7fffffffb510) at /home=
/arne/openvpn-git/src/openvpn/multi_io.c:468
#14 0x00005555555b3629 in tunnel_server_loop (multi=3D0x7fffffffb510) at /h=
ome/arne/openvpn-git/src/openvpn/multi.c:4197
#15 0x00005555555b37da in tunnel_server (top=3D0x7fffffffcb50) at /home/arn=
e/openvpn-git/src/openvpn/multi.c:4249
#16 0x00005555555b8110 in openvpn_main (argc=3D31, argv=3D0x7fffffffe168) a=
t /home/arne/openvpn-git/src/openvpn/openvpn.c:309
#17 0x00005555555b8256 in main (argc=3D31, argv=3D0x7fffffffe168) at /home/=
arne/openvpn-git/src/openvpn/openvpn.c:384
(gdb)



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1289?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I31ac2a763209114267c35c4a9182a12d8d82f6fe
Gerrit-Change-Number: 1289
Gerrit-PatchSet: 2
Gerrit-Owner: davidben <davidben@...410...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: davidben <davidben@...410...>
Gerrit-Comment-Date: Tue, 09 Dec 2025 14:47:47 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--Rk1ucuV2yw4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: davidben, flichtenheld. </p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1289?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1289?tab=3Dcomments&amp;usp=3Demail">Patch Set #2:</a> </p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">There seem =
to be a problem when the CRL file gets invalid:</p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">I setup OpenVPN with a =
normal setup</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">(gdb) run<br>Starting program: /home/arne/openvpn-cmake-de=
bug/openvpn --server 10.33.0.0 255.255.255.0 --server-ipv6 fd00:f00f:babe::=
1/64 --topology subnet --cert /home/arne/ut-ca/server.pem --key /home/arne/=
ut-ca/server.key --dev tun --verb 4 --data-ciphers AES-256-GCM:AES-128-GCM:=
AES-192-GCM --tun-mtu 1400 --keepalive 10 25 --push explicit-exit-notify\ 3=
 --verb 4 --crl-verify /home/arne/ut-ca/ca.crl --ca /home/arne/ut-ca/ca.pem=
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">[...]</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Then connected a client and that went fine. </p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Then I repl=
aced the CRL file with an invalid one:</p><p class=3D"blocks" style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">rm ca.crl &amp;&amp; touch ca.cr=
l</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">Connecting the client again first works fine (connection gets rejecte=
d)</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-=
word;">2025-12-09 14:43:11 us=3D78031 Connection Attempt MULTI: multi_creat=
e_instance called<br>2025-12-09 14:43:11 us=3D78143 udp4:192.168.188.75:586=
49 Re-using SSL/TLS context<br>2025-12-09 14:43:11 us=3D78267 udp4:192.168.=
188.75:58649 Control Channel MTU parms [ mss_fix:0 max_frag:0 tun_mtu:1250 =
tun_max_mtu:0 headroom:126 payload:1600 tailroom:126 ET:0 ]<br>2025-12-09 1=
4:43:11 us=3D78293 udp4:192.168.188.75:58649 Data Channel MTU parms [ mss_f=
ix:0 max_frag:0 tun_mtu:1400 tun_max_mtu:1600 headroom:136 payload:1768 tai=
lroom:562 ET:0 ]<br>2025-12-09 14:43:11 us=3D82903 udp4:192.168.188.75:5864=
9 VERIFY WARNING: depth=3D0, unable to get certificate CRL: C=3DKG, ST=3DNA=
, O=3DOpenVPN-TEST, CN=3DTest-Client, emailAddress=3Darne@...515...<br>2025=
-12-09 14:43:11 us=3D83007 udp4:192.168.188.75:58649 VERIFY WARNING: depth=
=3D1, unable to get certificate CRL: C=3DKG, ST=3DNA, L=3DBISHKEK, O=3DOpen=
VPN-TEST, emailAddress=3Darne@...515...<br>2025-12-09 14:43:11 us=3D83165 u=
dp4:192.168.188.75:58649 VERIFY ERROR: CRL not loaded<br>2025-12-09 14:43:1=
1 us=3D83238 udp4:192.168.188.75:58649 Sent fatal SSL alert: unknown CA<br>=
2025-12-09 14:43:11 us=3D83289 udp4:192.168.188.75:58649 OpenSSL: error:0A0=
00086:SSL routines::certificate verify failed:<br>2025-12-09 14:43:11 us=3D=
83330 udp4:192.168.188.75:58649 TLS_ERROR: BIO read tls_read_plaintext erro=
r<br>2025-12-09 14:43:11 us=3D83358 udp4:192.168.188.75:58649 TLS Error: TL=
S object -&gt; incoming plaintext read error<br>2025-12-09 14:43:11 us=3D83=
405 udp4:192.168.188.75:58649 TLS Error: TLS handshake failed<br>2025-12-09=
 14:43:11 us=3D83550 Warning buffer of freed TLS session is still in use (s=
ession-&gt;key[0].send_reliable-&gt;array[0])<br>2025-12-09 14:43:11 us=3D8=
3686 udp4:192.168.188.75:58649 SIGUSR1[soft,tls-error] received, client-ins=
tance restarting<br>2025-12-09 14:43:11 us=3D83759 Packet (P_CONTROL_V1) wi=
th invalid or missing SID from [AF_INET]192.168.188.75:58649 or wrong packe=
t id<br>2025-12-09 14:43:13 us=3D380641 Packet (P_CONTROL_V1) with invalid =
or missing SID from [AF_INET]192.168.188.75:58649 or wrong packet id<br>202=
5-12-09 14:43:13 us=3D380799 Packet (P_CONTROL_V1) with invalid or missing =
SID from [AF_INET]192.168.188.75:58649 or wrong packet id</p><p class=3D"bl=
ocks" style=3D"white-space: pre-wrap; word-wrap: break-word;"><br>But then =
reconnecting again leads to a segfault:</p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;"><br>2025-12-09 14:43:14 us=3D95=
0844 Connection Attempt MULTI: multi_create_instance called<br>2025-12-09 1=
4:43:14 us=3D950963 udp4:192.168.188.75:59576 Re-using SSL/TLS context<br>2=
025-12-09 14:43:14 us=3D951112 udp4:192.168.188.75:59576 Control Channel MT=
U parms [ mss_fix:0 max_frag:0 tun_mtu:1250 tun_max_mtu:0 headroom:126 payl=
oad:1600 tailroom:126 ET:0 ]<br>2025-12-09 14:43:14 us=3D951162 udp4:192.16=
8.188.75:59576 Data Channel MTU parms [ mss_fix:0 max_frag:0 tun_mtu:1400 t=
un_max_mtu:1600 headroom:136 payload:1768 tailroom:562 ET:0 ]<br>2025-12-09=
 14:43:14 us=3D955828 udp4:192.168.188.75:59576 VERIFY WARNING: depth=3D0, =
unable to get certificate CRL: C=3DKG, ST=3DNA, O=3DOpenVPN-TEST, CN=3DTest=
-Client, emailAddress=3Darne@...515...<br>2025-12-09 14:43:14 us=3D955883 u=
dp4:192.168.188.75:59576 VERIFY WARNING: depth=3D1, unable to get certifica=
te CRL: C=3DKG, ST=3DNA, L=3DBISHKEK, O=3DOpenVPN-TEST, emailAddress=3Darne=
@...515...<br>2025-12-09 14:43:14 us=3D955942 udp4:192.168.188.75:59576 VER=
IFY ERROR: CRL not loaded<br>2025-12-09 14:43:14 us=3D955961 udp4:192.168.1=
88.75:59576 Sent fatal SSL alert: unknown CA<br>2025-12-09 14:43:14 us=3D95=
5981 udp4:192.168.188.75:59576 OpenSSL: error:0A000086:SSL routines::certif=
icate verify failed:<br>2025-12-09 14:43:14 us=3D955988 udp4:192.168.188.75=
:59576 TLS_ERROR: BIO read tls_read_plaintext error<br>2025-12-09 14:43:14 =
us=3D955996 udp4:192.168.188.75:59576 TLS Error: TLS object -&gt; incoming =
plaintext read error<br>2025-12-09 14:43:14 us=3D956005 udp4:192.168.188.75=
:59576 TLS Error: TLS handshake failed<br>2025-12-09 14:43:14 us=3D956018 W=
arning buffer of freed TLS session is still in use (session-&gt;key[0].send=
_reliable-&gt;array[0])<br>2025-12-09 14:43:14 us=3D956061 udp4:192.168.188=
.75:59576 SIGUSR1[soft,tls-error] received, client-instance restarting<br>2=
025-12-09 14:43:14 us=3D956089 Packet (P_CONTROL_V1) with invalid or missin=
g SID from [AF_INET]192.168.188.75:59576 or wrong packet id<br>\</p><p clas=
s=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;"><br>20=
25-12-09 14:43:28 us=3D286692 Connection Attempt MULTI: multi_create_instan=
ce called<br>2025-12-09 14:43:28 us=3D286782 udp4:192.168.188.75:60010 Re-u=
sing SSL/TLS context<br>2025-12-09 14:43:28 us=3D287024 udp4:192.168.188.75=
:60010 OpenSSL: error:0308010C:digital envelope routines::unsupported:Globa=
l default library context, Algorithm (none : 0), Properties (&lt;null&gt;)<=
br>2025-12-09 14:43:28 us=3D287031 udp4:192.168.188.75:60010 OpenSSL: error=
:0480006C:PEM routines::no start line:<br>2025-12-09 14:43:28 us=3D287034 u=
dp4:192.168.188.75:60010 CRL: cannot read CRL from file /home/arne/ut-ca/ca=
.crl<br>2025-12-09 14:43:28 us=3D287036 udp4:192.168.188.75:60010 CRL: load=
ed 1 CRLs from file /home/arne/ut-ca/ca.crl<br>2025-12-09 14:43:28 us=3D287=
058 udp4:192.168.188.75:60010 Control Channel MTU parms [ mss_fix:0 max_fra=
g:0 tun_mtu:1250 tun_max_mtu:0 headroom:126 payload:1600 tailroom:126 ET:0 =
]<br>2025-12-09 14:43:28 us=3D287061 udp4:192.168.188.75:60010 Data Channel=
 MTU parms [ mss_fix:0 max_frag:0 tun_mtu:1400 tun_max_mtu:1600 headroom:13=
6 payload:1768 tailroom:562 ET:0 ]<br>2025-12-09 14:43:28 us=3D292177 udp4:=
192.168.188.75:60010 VERIFY OK: depth=3D1, C=3DKG, ST=3DNA, L=3DBISHKEK, O=
=3DOpenVPN-TEST, emailAddress=3Darne@...515...<br>2025-12-09 14:43:28 us=3D=
292774 udp4:192.168.188.75:60010 VERIFY OK: depth=3D0, C=3DKG, ST=3DNA, O=
=3DOpenVPN-TEST, CN=3DTest-Client, emailAddress=3Darne@...515...<br>2025-12=
-09 14:43:28 us=3D293487 udp4:192.168.188.75:60010 peer info: IV_VER=3D2.7_=
rc3<br>2025-12-09 14:43:28 us=3D293559 udp4:192.168.188.75:60010 peer info:=
 IV_PLAT=3Dmac<br>2025-12-09 14:43:28 us=3D293612 udp4:192.168.188.75:60010=
 peer info: IV_TCPNL=3D1<br>2025-12-09 14:43:28 us=3D293639 udp4:192.168.18=
8.75:60010 peer info: IV_MTU=3D1600<br>2025-12-09 14:43:28 us=3D293652 udp4=
:192.168.188.75:60010 peer info: IV_NCP=3D2<br>2025-12-09 14:43:28 us=3D293=
664 udp4:192.168.188.75:60010 peer info: IV_CIPHERS=3DAES-256-GCM:AES-128-G=
CM:CHACHA20-POLY1305<br>2025-12-09 14:43:28 us=3D293704 udp4:192.168.188.75=
:60010 peer info: IV_PROTO=3D8094<br>2025-12-09 14:43:28 us=3D293775 udp4:1=
92.168.188.75:60010 peer info: ID=3De7afaf<br>2025-12-09 14:43:28 us=3D2937=
93 udp4:192.168.188.75:60010 peer info: IV_LZO_STUB=3D1<br>2025-12-09 14:43=
:28 us=3D293799 udp4:192.168.188.75:60010 peer info: IV_COMP_STUB=3D1<br>20=
25-12-09 14:43:28 us=3D293804 udp4:192.168.188.75:60010 peer info: IV_COMP_=
STUBv2=3D1<br>2025-12-09 14:43:28 us=3D293983 udp4:192.168.188.75:60010 TLS=
: move_session: dest=3DTM_ACTIVE src=3DTM_INITIAL reinit_src=3D1<br>2025-12=
-09 14:43:28 us=3D294092 udp4:192.168.188.75:60010 TLS: tls_multi_process: =
initial untrusted session promoted to trusted<br>2025-12-09 14:43:28 us=3D2=
94701 udp4:192.168.188.75:60010 Control Channel: TLSv1.3, cipher TLSv1.3 TL=
S_AES_256_GCM_SHA384, peer certificate: 2048 bits RSA, signature: ecdsa-wit=
h-SHA256, peer temporary key: 768 bits X25519MLKEM768, peer signing digest/=
type: rsa_pss_rsae_sha256 RSASSA-PSS, key agreement: X25519MLKEM768<br>2025=
-12-09 14:43:28 us=3D294754 udp4:192.168.188.75:60010 [Test-Client] Peer Co=
nnection Initiated with [AF_INET]192.168.188.75:60010<br>2025-12-09 14:43:2=
8 us=3D294784 Test-Client/udp4:192.168.188.75:60010 MULTI_sva: pool returne=
d IPv4=3D10.33.0.2, IPv6=3Dfd00:f00f:babe::1001<br>2025-12-09 14:43:28 us=
=3D295142 Test-Client/udp4:192.168.188.75:60010 Data Channel MTU parms [ ms=
s_fix:1360 max_frag:0 tun_mtu:1400 tun_max_mtu:1600 headroom:136 payload:17=
68 tailroom:562 ET:0 ]<br>2025-12-09 14:43:28 us=3D295205 Test-Client/udp4:=
192.168.188.75:60010 Outgoing dynamic tls-crypt: Cipher &#39;AES-256-CTR&#3=
9; initialized with 256 bit key<br>2025-12-09 14:43:28 us=3D295223 Test-Cli=
ent/udp4:192.168.188.75:60010 Outgoing dynamic tls-crypt: Using 256 bit mes=
sage hash &#39;SHA256&#39; for HMAC authentication<br>2025-12-09 14:43:28 u=
s=3D295230 Test-Client/udp4:192.168.188.75:60010 Incoming dynamic tls-crypt=
: Cipher &#39;AES-256-CTR&#39; initialized with 256 bit key<br>2025-12-09 1=
4:43:28 us=3D295238 Test-Client/udp4:192.168.188.75:60010 Incoming dynamic =
tls-crypt: Using 256 bit message hash &#39;SHA256&#39; for HMAC authenticat=
ion<br>2025-12-09 14:43:28 us=3D295297 Test-Client/udp4:192.168.188.75:6001=
0 MULTI: Learn: 10.33.0.2 -&gt; Test-Client/udp4:192.168.188.75:60010<br>20=
25-12-09 14:43:28 us=3D295333 Test-Client/udp4:192.168.188.75:60010 MULTI: =
primary virtual IP for Test-Client/udp4:192.168.188.75:60010: 10.33.0.2<br>=
2025-12-09 14:43:28 us=3D295352 Test-Client/udp4:192.168.188.75:60010 MULTI=
: Learn: fd00:f00f:babe::1001 -&gt; Test-Client/udp4:192.168.188.75:60010<b=
r>2025-12-09 14:43:28 us=3D295359 Test-Client/udp4:192.168.188.75:60010 MUL=
TI: primary virtual IPv6 for Test-Client/udp4:192.168.188.75:60010: fd00:f0=
0f:babe::1001<br>2025-12-09 14:43:28 us=3D295389 Test-Client/udp4:192.168.1=
88.75:60010 SENT CONTROL [Test-Client]: &#39;PUSH_REPLY,explicit-exit-notif=
y 3,tun-ipv6,route-gateway 10.33.0.1,topology subnet,ping 10,ping-restart 2=
5,ifconfig-ipv6 fd00:f00f:babe::1001/64 fd00:f00f:babe::2,ifconfig 10.33.0.=
2 255.255.255.0,peer-id 0,cipher AES-256-GCM,protocol-flags cc-exit tls-ekm=
 dyn-tls-crypt,tun-mtu 1400&#39; (status=3D1)<br>2025-12-09 14:43:29 us=3D3=
19915 Test-Client/udp4:192.168.188.75:60010 Data Channel: cipher &#39;AES-2=
56-GCM&#39;, rx-peer-id: 0, tx-peer-id: 0<br>2025-12-09 14:43:29 us=3D32002=
7 Test-Client/udp4:192.168.188.75:60010 Timers: ping 10, ping-restart 50<br=
>2025-12-09 14:43:29 us=3D320051 Test-Client/udp4:192.168.188.75:60010 Prot=
ocol options: protocol-flags cc-exit tls-ekm dyn-tls-crypt<br>2025-12-09 14=
:43:37 us=3D293135 Test-Client/udp4:192.168.188.75:60010 CC-EEN exit messag=
e received by peer<br>2025-12-09 14:43:37 us=3D293196 Test-Client/udp4:192.=
168.188.75:60010 Delayed exit in 5 seconds<br>2025-12-09 14:43:42 us=3D3219=
05 Test-Client/udp4:192.168.188.75:60010 SIGTERM[soft,delayed-exit] receive=
d, client-instance exiting<br>2025-12-09 14:43:42 us=3D322142 ovpn_handle_p=
eer: received data for a non-existing peer 0<br>2025-12-09 14:43:58 us=3D52=
079 Connection Attempt MULTI: multi_create_instance called<br>2025-12-09 14=
:43:58 us=3D52177 udp4:192.168.188.75:58033 Re-using SSL/TLS context<br>202=
5-12-09 14:43:58 us=3D52342 udp4:192.168.188.75:58033 OpenSSL: error:030801=
0C:digital envelope routines::unsupported:Global default library context, A=
lgorithm (none : 0), Properties (&lt;null&gt;)<br>2025-12-09 14:43:58 us=3D=
52349 udp4:192.168.188.75:58033 OpenSSL: error:0480006C:PEM routines::no st=
art line:<br>2025-12-09 14:43:58 us=3D52352 udp4:192.168.188.75:58033 CRL: =
cannot read CRL from file /home/arne/ut-ca/ca.crl<br>2025-12-09 14:43:58 us=
=3D52354 udp4:192.168.188.75:58033 CRL: loaded 0 CRLs from file /home/arne/=
ut-ca/ca.crl<br>2025-12-09 14:43:58 us=3D52375 udp4:192.168.188.75:58033 Co=
ntrol Channel MTU parms [ mss_fix:0 max_frag:0 tun_mtu:1250 tun_max_mtu:0 h=
eadroom:126 payload:1600 tailroom:126 ET:0 ]<br>2025-12-09 14:43:58 us=3D52=
378 udp4:192.168.188.75:58033 Data Channel MTU parms [ mss_fix:0 max_frag:0=
 tun_mtu:1400 tun_max_mtu:1600 headroom:136 payload:1768 tailroom:562 ET:0 =
]<br>2025-12-09 14:43:58 us=3D57062 udp4:192.168.188.75:58033 VERIFY WARNIN=
G: depth=3D0, unable to get certificate CRL: C=3DKG, ST=3DNA, O=3DOpenVPN-T=
EST, CN=3DTest-Client, emailAddress=3Darne@...515...<br>2025-12-09 14:43:58=
 us=3D57086 udp4:192.168.188.75:58033 VERIFY WARNING: depth=3D1, unable to =
get certificate CRL: C=3DKG, ST=3DNA, L=3DBISHKEK, O=3DOpenVPN-TEST, emailA=
ddress=3Darne@...515...<br>2025-12-09 14:43:58 us=3D57129 udp4:192.168.188.=
75:58033 VERIFY ERROR: CRL not loaded<br>2025-12-09 14:43:58 us=3D57142 udp=
4:192.168.188.75:58033 Sent fatal SSL alert: unknown CA<br>2025-12-09 14:43=
:58 us=3D57155 udp4:192.168.188.75:58033 OpenSSL: error:0A000086:SSL routin=
es::certificate verify failed:<br>2025-12-09 14:43:58 us=3D57157 udp4:192.1=
68.188.75:58033 TLS_ERROR: BIO read tls_read_plaintext error<br>2025-12-09 =
14:43:58 us=3D57160 udp4:192.168.188.75:58033 TLS Error: TLS object -&gt; i=
ncoming plaintext read error<br>2025-12-09 14:43:58 us=3D57164 udp4:192.168=
.188.75:58033 TLS Error: TLS handshake failed<br>2025-12-09 14:43:58 us=3D5=
7175 Warning buffer of freed TLS session is still in use (session-&gt;key[0=
].send_reliable-&gt;array[0])<br>2025-12-09 14:43:58 us=3D57217 udp4:192.16=
8.188.75:58033 SIGUSR1[soft,tls-error] received, client-instance restarting=
<br>2025-12-09 14:43:58 us=3D57246 Packet (P_CONTROL_V1) with invalid or mi=
ssing SID from [AF_INET]192.168.188.75:58033 or wrong packet id<br>2025-12-=
09 14:43:59 us=3D165790 Packet (P_CONTROL_V1) with invalid or missing SID f=
rom [AF_INET]192.168.188.75:58033 or wrong packet id<br>2025-12-09 14:43:59=
 us=3D165885 Packet (P_CONTROL_V1) with invalid or missing SID from [AF_INE=
T]192.168.188.75:58033 or wrong packet id<br>2025-12-09 14:44:05 us=3D92874=
5 Connection Attempt MULTI: multi_create_instance called<br>2025-12-09 14:4=
4:05 us=3D928929 udp4:192.168.188.75:54942 Re-using SSL/TLS context</p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Pro=
gram received signal SIGSEGV, Segmentation fault.<br>0x00007ffff7ba7cc5 in =
OPENSSL_sk_pop_free () from /lib/x86_64-linux-gnu/libcrypto.so.3</p><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">(gdb) bt<br>#0  0x00007ffff7ba7cc5 in OPENSSL_sk_pop_free () from /l=
ib/x86_64-linux-gnu/libcrypto.so.3<br>#1  0x000055555561339a in backend_tls=
_ctx_reload_crl (ssl_ctx=3D0x55555576f260, crl_file=3D0x7fffffffe5f2 &quot;=
/home/arne/ut-ca/ca.crl&quot;, crl_inline=3Dfalse)<br>    at /home/arne/ope=
nvpn-git/src/openvpn/ssl_openssl.c:1348<br>#2  0x0000555555608148 in tls_ct=
x_reload_crl (ssl_ctx=3D0x55555576f260, crl_file=3D0x7fffffffe5f2 &quot;/ho=
me/arne/ut-ca/ca.crl&quot;, crl_file_inline=3Dfalse)<br>    at /home/arne/o=
penvpn-git/src/openvpn/ssl.c:503<br>#3  0x0000555555608e63 in key_state_ini=
t (session=3D0x55555576f970, ks=3D0x5555557700e0) at /home/arne/openvpn-git=
/src/openvpn/ssl.c:879<br>#4  0x000055555560924c in tls_session_init (multi=
=3D0x55555576f260, session=3D0x55555576f970) at /home/arne/openvpn-git/src/=
openvpn/ssl.c:1023<br>#5  0x0000555555609748 in tls_multi_init_finalize (mu=
lti=3D0x55555576f260, tls_mtu=3D1250) at /home/arne/openvpn-git/src/openvpn=
/ssl.c:1177<br>#6  0x0000555555592659 in do_init_frame_tls (c=3D0x55555577f=
2c0) at /home/arne/openvpn-git/src/openvpn/init.c:3462<br>#7  0x00005555555=
94b45 in init_instance (c=3D0x55555577f2c0, env=3D0x5555556fdb30, flags=3D1=
0) at /home/arne/openvpn-git/src/openvpn/init.c:4613<br>#8  0x0000555555595=
625 in inherit_context_child (dest=3D0x55555577f2c0, src=3D0x7fffffffb5d8, =
sock=3D0x5555556fd8e0) at /home/arne/openvpn-git/src/openvpn/init.c:4914<br=
>#9  0x00005555555aba4b in multi_create_instance (m=3D0x7fffffffb510, real=
=3D0x7fffffffafb0, sock=3D0x5555556fd8e0) at /home/arne/openvpn-git/src/ope=
nvpn/multi.c:737<br>#10 0x00005555555a8bec in multi_get_create_instance_udp=
 (m=3D0x7fffffffb510, floated=3D0x7fffffffb3b0, sock=3D0x5555556fd8e0) at /=
home/arne/openvpn-git/src/openvpn/mudp.c:269<br>#11 0x00005555555b198e in m=
ulti_process_incoming_link (m=3D0x7fffffffb510, instance=3D0x0, mpp_flags=
=3D5, sock=3D0x5555556fd8e0) at /home/arne/openvpn-git/src/openvpn/multi.c:=
3357<br>#12 0x00005555555a8fd1 in multi_process_io_udp (m=3D0x7fffffffb510,=
 sock=3D0x5555556fd8e0) at /home/arne/openvpn-git/src/openvpn/mudp.c:357<br=
>#13 0x00005555555b54b5 in multi_io_process_io (m=3D0x7fffffffb510) at /hom=
e/arne/openvpn-git/src/openvpn/multi_io.c:468<br>#14 0x00005555555b3629 in =
tunnel_server_loop (multi=3D0x7fffffffb510) at /home/arne/openvpn-git/src/o=
penvpn/multi.c:4197<br>#15 0x00005555555b37da in tunnel_server (top=3D0x7ff=
fffffcb50) at /home/arne/openvpn-git/src/openvpn/multi.c:4249<br>#16 0x0000=
5555555b8110 in openvpn_main (argc=3D31, argv=3D0x7fffffffe168) at /home/ar=
ne/openvpn-git/src/openvpn/openvpn.c:309<br>#17 0x00005555555b8256 in main =
(argc=3D31, argv=3D0x7fffffffe168) at /home/arne/openvpn-git/src/openvpn/op=
envpn.c:384<br>(gdb)</pre></li></ul></li></ul><p>To view, visit <a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/1289?usp=3Demail">change 1289</a>. To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemt=
ype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" i=
temtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1289?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I31ac2a763209114267c35c4a918=
2a12d8d82f6fe </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1289 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: davidben &lt;davidben@...410...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: davidben &lt;davidben@...2975...=
...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 09 Dec 2025 14:47:47=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--Rk1ucuV2yw4=--

