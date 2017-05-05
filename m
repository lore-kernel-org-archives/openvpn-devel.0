From: Dirkjan Bussink <d.bussink@...277...>
Content-Type: multipart/mixed;
	boundary="Apple-Mail=_E584511B-2F75-4514-8EEF-24FEA7D98D23"
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Message-Id: <C0618847-3DAF-4E68-8143-A0BECC5DFD40@...277...>
Date: Fri, 5 May 2017 13:38:45 +0200
Subject: [Openvpn-devel] Fix for OpenVPN MTU Tunnel computation bug for TLS
	reconnects
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--Apple-Mail=_E584511B-2F75-4514-8EEF-24FEA7D98D23
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


When testing upgrading OpenVPN from 2.3 to 2.4, we ran into an issue where
every time the same client reconnects the MTU for the tunnel used shrinks,
eventually leading to packets being dropped by OpenVPN.

Reproduced the problem with a 2 node setup, one as the server and the other
one as a client. Each time the client is restarted the packet sizes shrink
until it breaks.=20

Configuration for the server:

/etc/openvpn/server.conf

port 1194
proto udp
dev tun

ca /etc/openvpn/easy-rsa/keys/ca.crt
cert /etc/openvpn/easy-rsa/keys/server.crt
key /etc/openvpn/easy-rsa/keys/server.key
dh none

server 192.168.1.0 255.255.255.0
topology subnet
client-config-dir /etc/openvpn/ccd

client-to-client
keepalive 10 120

user nobody
group nogroup
persist-key
persist-tun
status /var/run/openvpn-status.log
log    /var/log/openvpn/openvpn.log
verb 5

Configuration for the client:

/etc/openvpn/client.conf

client
dev tun
proto udp
float
remote 172.28.128.4 1194
user nobody
group nogroup

persist-key
persist-tun

ca /etc/openvpn/easy-rsa/keys/172.28.128.5-ca.crt
cert /etc/openvpn/easy-rsa/keys/172.28.128.5.crt
key /etc/openvpn/easy-rsa/keys/172.28.128.5.key
log /var/log/openvpn/openvpn.log

ns-cert-type server
verb 5

What happens during the first time the client connects from the perspective
of the logs is the following (server log):

May 05 10:50:59 test-primary systemd[1]: Started OpenVPN connection to serv=
er.
May 05 10:50:59 test-primary ovpn-server[17464]: Failed to extract curve fr=
om certificate (UNDEF), using secp384r1 instead.
May 05 10:50:59 test-primary ovpn-server[17464]: ECDH curve secp384r1 added
May 05 10:50:59 test-primary ovpn-server[17464]: TLS-Auth MTU parms [ L:162=
1 D:1212 EF:38 EB:0 ET:0 EL:3 ]
May 05 10:50:59 test-primary ovpn-server[17464]: TUN/TAP device tun0 opened
May 05 10:50:59 test-primary ovpn-server[17464]: TUN/TAP TX queue length se=
t to 100
May 05 10:50:59 test-primary ovpn-server[17464]: do_ifconfig, tt->did_ifcon=
fig_ipv6_setup=3D0
May 05 10:50:59 test-primary ovpn-server[17464]: /sbin/ip link set dev tun0=
 up mtu 1500
May 05 10:50:59 test-primary ovpn-server[17464]: /sbin/ip addr add dev tun0=
 192.168.1.1/24 broadcast 192.168.1.255
May 05 10:50:59 test-primary ovpn-server[17464]: Data Channel MTU parms [ L=
:1621 D:1450 EF:121 EB:406 ET:0 EL:3 ]
May 05 10:50:59 test-primary ovpn-server[17464]: Could not determine IPv4/I=
Pv6 protocol. Using AF_INET
May 05 10:50:59 test-primary ovpn-server[17464]: Socket Buffers: R=3D[21299=
2->212992] S=3D[212992->212992]
May 05 10:50:59 test-primary ovpn-server[17464]: UDPv4 link local (bound): =
[AF_INET][undef]:1194
May 05 10:50:59 test-primary ovpn-server[17464]: UDPv4 link remote: [AF_UNS=
PEC]
May 05 10:50:59 test-primary ovpn-server[17464]: GID set to nogroup
May 05 10:50:59 test-primary ovpn-server[17464]: UID set to nobody
May 05 10:50:59 test-primary ovpn-server[17464]: MULTI: multi_init called, =
r=3D256 v=3D256
May 05 10:50:59 test-primary ovpn-server[17464]: IFCONFIG POOL: base=3D192.=
168.1.2 size=3D252, ipv6=3D0
May 05 10:50:59 test-primary ovpn-server[17464]: Initialization Sequence Co=
mpleted
May 05 10:52:27 test-primary ovpn-server[17464]: MULTI: multi_create_instan=
ce called
May 05 10:52:27 test-primary ovpn-server[17464]: 172.28.128.5:1194 Re-using=
 SSL/TLS context
May 05 10:52:27 test-primary ovpn-server[17464]: 172.28.128.5:1194 Control =
Channel MTU parms [ L:1621 D:1212 EF:38 EB:0 ET:0 EL:3 ]
May 05 10:52:27 test-primary ovpn-server[17464]: 172.28.128.5:1194 Data Cha=
nnel MTU parms [ L:1621 D:1450 EF:121 EB:406 ET:0 EL:3 ]
May 05 10:52:27 test-primary ovpn-server[17464]: 172.28.128.5:1194 Local Op=
tions String (VER=3DV4): 'V4,dev-type tun,link-mtu 1541,tun-mtu 1500,proto =
UDPv4,cipher BF-CBC,auth SHA1,keysize 128,key-method 2,tls-server'
May 05 10:52:27 test-primary ovpn-server[17464]: 172.28.128.5:1194 Expected=
 Remote Options String (VER=3DV4): 'V4,dev-type tun,link-mtu 1541,tun-mtu 1=
500,proto UDPv4,cipher BF-CBC,auth SHA1,keysize 128,key-method 2,tls-client'
May 05 10:52:27 test-primary ovpn-server[17464]: 172.28.128.5:1194 TLS: Ini=
tial packet from [AF_INET]172.28.128.5:1194, sid=3D59ea927a 09799019
May 05 10:52:27 test-primary ovpn-server[17464]: 172.28.128.5:1194 VERIFY O=
K: depth=3D1, C=3DUS, ST=3DCA, L=3DSan Francisco, O=3DGitHub, OU=3DEnterpri=
se, CN=3DGitHub Enterprise VPN, name=3DGitHub Enterprise VPN, emailAddress=
=3Denterprise@...1714...
May 05 10:52:27 test-primary ovpn-server[17464]: 172.28.128.5:1194 VERIFY O=
K: depth=3D0, C=3DUS, ST=3DCA, L=3DSan Francisco, O=3DGitHub, OU=3DEnterpri=
se, CN=3D172.28.128.5, name=3DGitHub Enterprise VPN, emailAddress=3Denterpr=
ise@...1714...
May 05 10:52:27 test-primary ovpn-server[17464]: 172.28.128.5:1194 peer inf=
o: IV_VER=3D2.4.0
May 05 10:52:27 test-primary ovpn-server[17464]: 172.28.128.5:1194 peer inf=
o: IV_PLAT=3Dlinux
May 05 10:52:27 test-primary ovpn-server[17464]: 172.28.128.5:1194 peer inf=
o: IV_PROTO=3D2
May 05 10:52:27 test-primary ovpn-server[17464]: 172.28.128.5:1194 peer inf=
o: IV_NCP=3D2
May 05 10:52:27 test-primary ovpn-server[17464]: 172.28.128.5:1194 peer inf=
o: IV_LZ4=3D1
May 05 10:52:27 test-primary ovpn-server[17464]: 172.28.128.5:1194 peer inf=
o: IV_LZ4v2=3D1
May 05 10:52:27 test-primary ovpn-server[17464]: 172.28.128.5:1194 peer inf=
o: IV_LZO=3D1
May 05 10:52:27 test-primary ovpn-server[17464]: 172.28.128.5:1194 peer inf=
o: IV_COMP_STUB=3D1
May 05 10:52:27 test-primary ovpn-server[17464]: 172.28.128.5:1194 peer inf=
o: IV_COMP_STUBv2=3D1
May 05 10:52:27 test-primary ovpn-server[17464]: 172.28.128.5:1194 peer inf=
o: IV_TCPNL=3D1
May 05 10:52:27 test-primary ovpn-server[17464]: 172.28.128.5:1194 Control =
Channel: TLSv1.2, cipher TLSv1/SSLv3 ECDHE-RSA-AES256-GCM-SHA384, 2048 bit =
RSA
May 05 10:52:27 test-primary ovpn-server[17464]: 172.28.128.5:1194 [172.28.=
128.5] Peer Connection Initiated with [AF_INET]172.28.128.5:1194
May 05 10:52:27 test-primary ovpn-server[17464]: 172.28.128.5/172.28.128.5:=
1194 OPTIONS IMPORT: reading client specific options from: /etc/openvpn/ccd=
/172.28.128.5
May 05 10:52:27 test-primary ovpn-server[17464]: 172.28.128.5/172.28.128.5:=
1194 MULTI: Learn: 192.168.1.2 -> 172.28.128.5/172.28.128.5:1194
May 05 10:52:27 test-primary ovpn-server[17464]: 172.28.128.5/172.28.128.5:=
1194 MULTI: primary virtual IP for 172.28.128.5/172.28.128.5:1194: 192.168.=
1.2
May 05 10:52:28 test-primary ovpn-server[17464]: 172.28.128.5/172.28.128.5:=
1194 PUSH: Received control message: 'PUSH_REQUEST'
May 05 10:52:28 test-primary ovpn-server[17464]: 172.28.128.5/172.28.128.5:=
1194 SENT CONTROL [172.28.128.5]: 'PUSH_REPLY,route-gateway 192.168.1.1,top=
ology subnet,ping 10,ping-restart 120,ifconfig 192.168.1.2 255.255.255.0,pe=
er-id 0,cipher AES-256-GCM' (status=3D1)
May 05 10:52:28 test-primary ovpn-server[17464]: 172.28.128.5/172.28.128.5:=
1194 Data Channel MTU parms [ L:1549 D:1450 EF:49 EB:406 ET:0 EL:3 ]
May 05 10:52:28 test-primary ovpn-server[17464]: 172.28.128.5/172.28.128.5:=
1194 Data Channel Encrypt: Cipher 'AES-256-GCM' initialized with 256 bit key
May 05 10:52:28 test-primary ovpn-server[17464]: 172.28.128.5/172.28.128.5:=
1194 Data Channel Decrypt: Cipher 'AES-256-GCM' initialized with 256 bit key
May 05 10:52:29 test-primary ovpn-server[17464]: 172.28.128.5/172.28.128.5:=
1194 MULTI: bad source address from client [172.28.128.5], packet dropped

What can be seen here is that the client initially connects and sets up the
TLS control channel. The interesting MTU related bits are the first occurre=
nce
of "Data Channel MTU parms [ L:1621 D:1450 EF:121 EB:406 ET:0 EL:3 ]" from =
the
initial setup which comes from
https://github.com/OpenVPN/openvpn/blob/7a1b6a0dd706a81897457b0456a951c0b30=
bbcfb/src/openvpn/init.c#L4055.

There's another entry for it with=20
"Data Channel MTU parms [ L:1549 D:1450 EF:49 EB:406 ET:0 EL:3 ]" that come=
s from
https://github.com/OpenVPN/openvpn/blob/f3705dd1e711ee9f8546b841e4b18e9e9a2=
24975/src/openvpn/ssl.c#L1986.
So there's an adjustment that happens twice, once for for the client
initialization and once for the TLS connection setup.

When a client reconnects, the following is shown in the logs:

May 05 10:57:29 test-primary ovpn-server[17464]: 172.28.128.5/172.28.128.5:=
1194 TLS: new session incoming connection from [AF_INET]172.28.128.5:1194
May 05 10:57:29 test-primary ovpn-server[17464]: 172.28.128.5/172.28.128.5:=
1194 VERIFY OK: depth=3D1, C=3DUS, ST=3DCA, L=3DSan Francisco, O=3DGitHub, =
OU=3DEnterprise, CN=3DGitHub Enterprise VPN, name=3DGitHub Enterprise VPN, =
emailAddress=3Denterprise@...1714...
May 05 10:57:29 test-primary ovpn-server[17464]: 172.28.128.5/172.28.128.5:=
1194 VERIFY OK: depth=3D0, C=3DUS, ST=3DCA, L=3DSan Francisco, O=3DGitHub, =
OU=3DEnterprise, CN=3D172.28.128.5, name=3DGitHub Enterprise VPN, emailAddr=
ess=3Denterprise@...1714...
May 05 10:57:29 test-primary ovpn-server[17464]: 172.28.128.5/172.28.128.5:=
1194 peer info: IV_VER=3D2.4.0
May 05 10:57:29 test-primary ovpn-server[17464]: 172.28.128.5/172.28.128.5:=
1194 peer info: IV_PLAT=3Dlinux
May 05 10:57:29 test-primary ovpn-server[17464]: 172.28.128.5/172.28.128.5:=
1194 peer info: IV_PROTO=3D2
May 05 10:57:29 test-primary ovpn-server[17464]: 172.28.128.5/172.28.128.5:=
1194 peer info: IV_NCP=3D2
May 05 10:57:29 test-primary ovpn-server[17464]: 172.28.128.5/172.28.128.5:=
1194 peer info: IV_LZ4=3D1
May 05 10:57:29 test-primary ovpn-server[17464]: 172.28.128.5/172.28.128.5:=
1194 peer info: IV_LZ4v2=3D1
May 05 10:57:29 test-primary ovpn-server[17464]: 172.28.128.5/172.28.128.5:=
1194 peer info: IV_LZO=3D1
May 05 10:57:29 test-primary ovpn-server[17464]: 172.28.128.5/172.28.128.5:=
1194 peer info: IV_COMP_STUB=3D1
May 05 10:57:29 test-primary ovpn-server[17464]: 172.28.128.5/172.28.128.5:=
1194 peer info: IV_COMP_STUBv2=3D1
May 05 10:57:29 test-primary ovpn-server[17464]: 172.28.128.5/172.28.128.5:=
1194 peer info: IV_TCPNL=3D1
May 05 10:57:29 test-primary ovpn-server[17464]: 172.28.128.5/172.28.128.5:=
1194 TLS: move_session: dest=3DTM_ACTIVE src=3DTM_UNTRUSTED reinit_src=3D1
May 05 10:57:29 test-primary ovpn-server[17464]: 172.28.128.5/172.28.128.5:=
1194 TLS: tls_multi_process: untrusted session promoted to semi-trusted
May 05 10:57:29 test-primary ovpn-server[17464]: 172.28.128.5/172.28.128.5:=
1194 Control Channel: TLSv1.2, cipher TLSv1/SSLv3 ECDHE-RSA-AES256-GCM-SHA3=
84, 2048 bit RSA
May 05 10:57:30 test-primary ovpn-server[17464]: 172.28.128.5/172.28.128.5:=
1194 PUSH: Received control message: 'PUSH_REQUEST'
May 05 10:57:30 test-primary ovpn-server[17464]: 172.28.128.5/172.28.128.5:=
1194 SENT CONTROL [172.28.128.5]: 'PUSH_REPLY,route-gateway 192.168.1.1,top=
ology subnet,ping 10,ping-restart 120,ifconfig 192.168.1.2 255.255.255.0,pe=
er-id 0,cipher AES-256-GCM' (status=3D1)
May 05 10:57:30 test-primary ovpn-server[17464]: 172.28.128.5/172.28.128.5:=
1194 Data Channel MTU parms [ L:1477 D:1450 EF:-23 EB:406 ET:0 EL:3 ]
May 05 10:57:30 test-primary ovpn-server[17464]: 172.28.128.5/172.28.128.5:=
1194 Data Channel Encrypt: Cipher 'AES-256-GCM' initialized with 256 bit key
May 05 10:57:30 test-primary ovpn-server[17464]: 172.28.128.5/172.28.128.5:=
1194 Data Channel Decrypt: Cipher 'AES-256-GCM' initialized with 256 bit key

What can be seen here is that there's no client initialization since the
connection setup is reused. This can also be seen from the=20
"TLS: tls_multi_process: untrusted session promoted to semi-trusted" bit in=
 the
logs. This shows that we're reusing the TLS connection. What still happens
though is another MTU data channel change in=20
"Data Channel MTU parms [ L:1477 D:1450 EF:-23 EB:406 ET:0 EL:3 ]" happens.
This means the channel is shrinking. This happens on each restart of a clie=
nt:

May 05 11:00:06 test-primary ovpn-server[17464]: 172.28.128.5/172.28.128.5:=
1194 Data Channel MTU parms [ L:1405 D:1405 EF:-95 EB:406 ET:0 EL:3 ]

And after another restart:

May 05 11:00:39 test-primary ovpn-server[17464]: 172.28.128.5/172.28.128.5:=
1194 Data Channel MTU parms [ L:1333 D:1333 EF:-167 EB:406 ET:0 EL:3 ]

After a few restarts, OpenVPN packets start getting dropped with the follow=
ing error message:

May 05 11:00:41 test-primary ovpn-server[17464]: 172.28.128.5/172.28.128.5:=
1194 TCP/UDP packet too large on write to [AF_INET]172.28.128.5:1194 (tried=
=3D1419,max=3D1333)

This means not all traffic through the tunnel works anymore. This then lead=
s to
strange hard to debug issues where only bigger packets get dropped but smal=
ler
ones work. This issue is also reported in https://community.openvpn.net/ope=
nvpn/ticket/879.=20

I've attached a patch and also opened a pull request on GitHub at
https://github.com/OpenVPN/openvpn/pull/87

with the patch also attached to this email. I have no idea if this is the r=
ight
approach or if there's another way to know if the connection is reused or n=
ot
and if the frame calculation should be skipped or not.=20

--=20
Cheers,

Dirkjan


--Apple-Mail=_E584511B-2F75-4514-8EEF-24FEA7D98D23
Content-Disposition: attachment;
	filename=0001-Don-t-resize-the-MTU-windows-on-a-reused-connection.patch
Content-Type: application/octet-stream; x-unix-mode=0644;
	name="0001-Don-t-resize-the-MTU-windows-on-a-reused-connection.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=208142cb430c3a740ab1ef822532cee70019a2239d=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Dirkjan=20Bussink=20<d.bussink@...277...>=0A=
Date:=20Fri,=205=20May=202017=2013:17:40=20+0200=0ASubject:=20[PATCH]=20=
Don't=20resize=20the=20MTU=20windows=20on=20a=20reused=20connection=0A=0A=
This=20was=20causing=20MTU=20packet=20sizes=20to=20be=20shrunk=20each=20=
time=20a=20TLS=0Aconnection=20to=20a=20client=20was=20reused.=20Reuse=20=
happens=20easily=20when=20a=20client=0Acleanly=20restarts.=0A---=0A=20=
src/openvpn/crypto.h=20|=20=205=20+++++=0A=20src/openvpn/ssl.c=20=20=20=20=
|=2018=20+++++++++++-------=0A=202=20files=20changed,=2016=20=
insertions(+),=207=20deletions(-)=0A=0Adiff=20--git=20=
a/src/openvpn/crypto.h=20b/src/openvpn/crypto.h=0Aindex=20=
afd6fe51..410259f8=20100644=0A---=20a/src/openvpn/crypto.h=0A+++=20=
b/src/openvpn/crypto.h=0A@@=20-257,6=20+257,11=20@@=20struct=20=
crypto_options=0A=20#define=20CO_MUTE_REPLAY_WARNINGS=20(1<<2)=0A=20=20=20=
=20=20/**<=20Bit-flag=20indicating=20not=20to=20display=0A=20=20=20=20=20=
=20*=20=20=20replay=20warnings.=20*/=0A+#define=20=
CO_TLS_CONNECTION_REUSE=20(1<<4)=0A+=20=20=20=20/**<=20Bit-flag=20=
indicating=20if=20the=20TLS=20connection=0A+=20=20=20=20=20*=20=20=20is=20=
reused.=20This=20is=20needed=20so=20that=20framing=0A+=20=20=20=20=20*=20=
=20=20is=20not=20done=20multiple=20times=20on=20a=20reused=0A+=20=20=20=20=
=20*=20=20=20connection.=20*/=0A=20=20=20=20=20unsigned=20int=20flags;=20=
=20=20=20=20=20=20=20=20/**<=20Bit-flags=20determining=20behavior=20of=0A=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20*=20=20=20security=20operation=20functions.=20=
*/=0A=20};=0Adiff=20--git=20a/src/openvpn/ssl.c=20b/src/openvpn/ssl.c=0A=
index=20fca1e7c5..7ed928f3=20100644=0A---=20a/src/openvpn/ssl.c=0A+++=20=
b/src/openvpn/ssl.c=0A@@=20-1976,13=20+1976,17=20@@=20=
tls_session_update_crypto_params(struct=20tls_session=20*session,=0A=20=20=
=20=20=20=20=20=20=20session->opt->crypto_flags=20|=3D=20=
CO_PACKET_ID_LONG_FORM;=0A=20=20=20=20=20}=0A=20=0A-=20=20=20=20/*=20=
Update=20frame=20parameters:=20undo=20worst-case=20overhead,=20add=20=
actual=20overhead=20*/=0A-=20=20=20=20frame_add_to_extra_frame(frame,=20=
-(crypto_max_overhead()));=0A-=20=20=20=20=
crypto_adjust_frame_parameters(frame,=20&session->opt->key_type,=0A-=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20options->replay,=20packet_id_long_form);=0A-=20=20=
=20=20frame_finalize(frame,=20options->ce.link_mtu_defined,=20=
options->ce.link_mtu,=0A-=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20options->ce.tun_mtu_defined,=20options->ce.tun_mtu);=0A-=20=20=20=
=20frame_init_mssfix(frame,=20options);=0A+=20=20=20=20if=20=
(!BOOL_CAST(session->opt->crypto_flags=20&=20CO_TLS_CONNECTION_REUSE))=0A=
+=20=20=20=20{=0A+=20=20=20=20=20=20=20=20/*=20Update=20frame=20=
parameters:=20undo=20worst-case=20overhead,=20add=20actual=20overhead=20=
*/=0A+=20=20=20=20=20=20=20=20frame_add_to_extra_frame(frame,=20=
-(crypto_max_overhead()));=0A+=20=20=20=20=20=20=20=20=
crypto_adjust_frame_parameters(frame,=20&session->opt->key_type,=0A+=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20options->replay,=20=
packet_id_long_form);=0A+=20=20=20=20=20=20=20=20frame_finalize(frame,=20=
options->ce.link_mtu_defined,=20options->ce.link_mtu,=0A+=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
options->ce.tun_mtu_defined,=20options->ce.tun_mtu);=0A+=20=20=20=20=20=20=
=20=20frame_init_mssfix(frame,=20options);=0A+=20=20=20=20=20=20=20=20=
session->opt->crypto_flags=20|=3D=20CO_TLS_CONNECTION_REUSE;=0A+=20=20=20=
=20}=0A=20=20=20=20=20frame_print(frame,=20D_MTU_INFO,=20"Data=20Channel=20=
MTU=20parms");=0A=20=0A=20=20=20=20=20return=20=
tls_session_generate_data_channel_keys(session);=0A--=20=0A2.12.2=0A=0A=

--Apple-Mail=_E584511B-2F75-4514-8EEF-24FEA7D98D23--

