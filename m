From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 18 Jul 2025 08:39:45 +0000
In-Reply-To: <gerrit.1752486326000.I33e9272b4196c7634db2fb33a75ae4261660867f@...2715...>
References: <gerrit.1752486326000.I33e9272b4196c7634db2fb33a75ae4261660867f@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, ralf@...2726..., frank@...2641...,
 lstipakov@...277..., antonio@...2726...
Message-ID: <9afdbf7d69630eccf93b13884a448e626be06649-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OXyyIkve3AU="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco: Add support for
 float notifications
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ralf_lici <ralf@...2726...>
Cc: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--OXyyIkve3AU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos, ralf_=
lici, stipa.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/1084?usp=3Demail )

Change subject: dco: Add support for float notifications
......................................................................


Patch Set 5:

(1 comment)

Patchset:

PS5:
So, it segfaulted again - which is a different bug than the AF_INET6 thing =
(which seems fixed).  Not sure how to trigger it yet... I had 2 sockets, an=
d 3 clients this time (something stable on the udp6 socket with peer-id 0 +=
 1, and the floating client on the udp4 socket with peer-id 2).

It got confused again about "something", then tried to delete the peer, and=
 segfaulted at the same place (race condition between userspace already hav=
ing deleted half the peer info and then kernel sending up a message?)

Trying to extract the interesting bits

```
2025-07-18 10:32:39 us=3D870590 dco_do_read
2025-07-18 10:32:39 us=3D870769 ovpn-dco: received CMD_PEER_FLOAT_NTF, ifin=
dex: 5651, peer-id 2, address: [AF_INET]193.149.48.173:62227
2025-07-18 10:32:39 us=3D870881 peer 2 (cron2-freebsd-tc-amd64) floated fro=
m udp4:193.149.48.172:62227 to [AF_INET]193.149.48.173:62227
2025-07-18 10:32:43 us=3D883102 dco_do_read
2025-07-18 10:32:43 us=3D883230 ovpn-dco: received CMD_PEER_FLOAT_NTF, ifin=
dex: 5651, peer-id 2, address: [AF_INET]193.149.48.172:62227
2025-07-18 10:32:43 us=3D883293 peer 2 (cron2-freebsd-tc-amd64) floated fro=
m udp4:193.149.48.173:62227 to [AF_INET]193.149.48.172:62227
(everything fine)

2025-07-18 10:32:55 us=3D935486 dco_get_peer_stats_multi
2025-07-18 10:32:55 us=3D935798 dco_parse_peer_multi: parsing message...
2025-07-18 10:32:55 us=3D935851 dco_update_peer_stat: no link RX bytes prov=
ided in reply for peer 2
2025-07-18 10:32:55 us=3D935881 dco_update_peer_stat: no link TX bytes prov=
ided in reply for peer 2
2025-07-18 10:32:55 us=3D935900 dco_update_peer_stat: no VPN RX bytes provi=
ded in reply for peer 2
2025-07-18 10:32:55 us=3D935919 dco_update_peer_stat: no VPN TX bytes provi=
ded in reply for peer 2
2025-07-18 10:32:55 us=3D937904 dco_parse_peer_multi: parsing message...
2025-07-18 10:32:55 us=3D937991 dco_update_peer_stat / dco_read_bytes: 976
2025-07-18 10:32:55 us=3D938052 dco_update_peer_stat / dco_write_bytes: 440
2025-07-18 10:32:55 us=3D938098 dco_update_peer_stat / tun_read_bytes: 0
2025-07-18 10:32:55 us=3D938151 dco_update_peer_stat / tun_write_bytes: 0
2025-07-18 10:32:55 us=3D938212 dco_parse_peer_multi: parsing message...
2025-07-18 10:32:55 us=3D938270 dco_update_peer_stat / dco_read_bytes: 400
2025-07-18 10:32:55 us=3D938322 dco_update_peer_stat / dco_write_bytes: 440
2025-07-18 10:32:55 us=3D938366 dco_update_peer_stat / tun_read_bytes: 0
2025-07-18 10:32:55 us=3D938425 dco_update_peer_stat / tun_write_bytes: 0
2025-07-18 10:32:55 us=3D938483 dco_parse_peer_multi: parsing message...
2025-07-18 10:32:55 us=3D938535 dco_update_peer_stat / dco_read_bytes: 13840
2025-07-18 10:32:55 us=3D938579 dco_update_peer_stat / dco_write_bytes: 134=
40
2025-07-18 10:32:55 us=3D938638 dco_update_peer_stat / tun_read_bytes: 10920
2025-07-18 10:32:55 us=3D938695 dco_update_peer_stat / tun_write_bytes: 109=
20
2025-07-18 10:32:55 us=3D939599 dco_do_read
2025-07-18 10:32:55 us=3D939755 dco_do_read: netlink reports error (-4): Tr=
y again

(this "no RX bytes for peer 2" is what I saw yesterday as well, and the "Tr=
y again")

2025-07-18 10:33:00 us=3D100235 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
62227 peer-id=3D2 TLS: soft reset sec=3D56/56 bytes=3D0/-1 pkts=3D0/0 aead_=
limit_send=3D0/60129542137 aead_limit_recv=3D0/60129542137
2025-07-18 10:33:00 us=3D100434 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
62227 peer-id=3D2 Sent warning SSL alert: close notify
2025-07-18 10:33:00 us=3D100719 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
62227 peer-id=3D2 dco_del_key: peer-id 2, slot 1

(this still looks normal, skipping the UDP read/write)

2025-07-18 10:33:00 us=3D132607 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
62227 peer-id=3D2 VERIFY OK: depth=3D1, C=3DUS, ST=3DCalifornia, L=3DPleasa=
nton, O=3DOpenVPN community project, CN=3DOpenVPN community project CA, ema=
ilAddress=3Dsamuli@...515...
2025-07-18 10:33:00 us=3D132851 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
62227 peer-id=3D2 VERIFY OK: depth=3D0, C=3DDE, ST=3DBavaria, L=3DMunich, O=
=3DOpenVPN community project, OU=3DServer Testing, CN=3Dcron2-freebsd-tc-am=
d64, emailAddress=3Dgert@...2576...
2025-07-18 10:33:00 us=3D133145 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
62227 peer-id=3D2 peer info: IV_VER=3D2.7_alpha2
2025-07-18 10:33:00 us=3D133198 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
62227 peer-id=3D2 peer info: IV_PLAT=3Dmac
2025-07-18 10:33:00 us=3D133238 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
62227 peer-id=3D2 peer info: IV_TCPNL=3D1
2025-07-18 10:33:00 us=3D133283 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
62227 peer-id=3D2 peer info: IV_MTU=3D1600
2025-07-18 10:33:00 us=3D133315 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
62227 peer-id=3D2 peer info: IV_NCP=3D2
2025-07-18 10:33:00 us=3D133348 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
62227 peer-id=3D2 peer info: IV_CIPHERS=3DAES-256-GCM:AES-128-GCM:CHACHA20-=
POLY1305
2025-07-18 10:33:00 us=3D133385 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
62227 peer-id=3D2 peer info: IV_PROTO=3D3998
2025-07-18 10:33:00 us=3D133418 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
62227 peer-id=3D2 peer info: IV_LZ4=3D1
2025-07-18 10:33:00 us=3D133453 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
62227 peer-id=3D2 peer info: IV_LZ4v2=3D1
2025-07-18 10:33:00 us=3D133487 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
62227 peer-id=3D2 peer info: IV_LZO=3D1
2025-07-18 10:33:00 us=3D133521 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
62227 peer-id=3D2 peer info: IV_COMP_STUB=3D1
2025-07-18 10:33:00 us=3D133553 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
62227 peer-id=3D2 peer info: IV_COMP_STUBv2=3D1
2025-07-18 10:33:00 us=3D133592 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
62227 peer-id=3D2 Note: 'compress migrate' detected remote peer with compre=
ssion enabled.
2025-07-18 10:33:00 us=3D133743 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
62227 peer-id=3D2 UDPv4 WRITE [236] to [AF_INET]193.149.48.172:62227: P_CON=
TROL_V1 kid=3D2 [ ] pid=3D4456 DATA len=3D222
2025-07-18 10:33:00 us=3D133834 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
62227 peer-id=3D2 UDPv4 WRITE [287] to [AF_INET]193.149.48.172:62227: P_CON=
TROL_V1 kid=3D2 [ ] pid=3D4712 DATA len=3D273
2025-07-18 10:33:00 us=3D137204 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
62227 peer-id=3D2 UDPv4 READ [78] from [AF_INET]193.149.48.172:62227: P_ACK=
_V1 kid=3D2 [ ] DATA len=3D68
2025-07-18 10:33:00 us=3D140572 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
62227 peer-id=3D2 UDPv4 READ [82] from [AF_INET]193.149.48.172:62227: P_ACK=
_V1 kid=3D2 [ ] DATA len=3D72
2025-07-18 10:33:00 us=3D140640 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
62227 peer-id=3D2 Control Channel: TLSv1.3, cipher TLSv1.3 TLS_AES_256_GCM_=
SHA384, peer certificate: 2048 bits RSA, signature: RSA-SHA1, peer temporar=
y key: 253 bits X25519, peer signing digest/type: SHA256 RSASSA-PSS
2025-07-18 10:33:00 us=3D140720 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
62227 peer-id=3D2 dco_install_key: peer_id=3D2 keyid=3D2, currently 1 keys =
installed
2025-07-18 10:33:00 us=3D140767 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
62227 peer-id=3D2 dco_new_key: slot 1, key-id 2, peer-id 2, cipher AES-256-=
GCM
2025-07-18 10:33:00 us=3D951542 dco_do_read
2025-07-18 10:33:00 us=3D951670 ovpn-dco: received CMD_PEER_FLOAT_NTF, ifin=
dex: 5651, peer-id 2, address: [AF_INET]193.149.48.172:62227
2025-07-18 10:33:00 us=3D951736 closing instance cron2-freebsd-tc-amd64/udp=
4:193.149.48.172:62227 peer-id=3D2
2025-07-18 10:33:00 us=3D951806 dco_get_peer_stats_multi
2025-07-18 10:33:00 us=3D952053 dco_parse_peer_multi: parsing message...
2025-07-18 10:33:00 us=3D952099 dco_update_peer_stat / dco_read_bytes: 976
2025-07-18 10:33:00 us=3D952135 dco_update_peer_stat / dco_write_bytes: 440
2025-07-18 10:33:00 us=3D952169 dco_update_peer_stat / tun_read_bytes: 0
2025-07-18 10:33:00 us=3D952478 dco_update_peer_stat / tun_write_bytes: 0
2025-07-18 10:33:00 us=3D952541 dco_parse_peer_multi: parsing message...
2025-07-18 10:33:00 us=3D952580 dco_update_peer_stat / dco_read_bytes: 400
2025-07-18 10:33:00 us=3D952614 dco_update_peer_stat / dco_write_bytes: 440
2025-07-18 10:33:00 us=3D952663 dco_update_peer_stat / tun_read_bytes: 0
2025-07-18 10:33:00 us=3D952707 dco_update_peer_stat / tun_write_bytes: 0
2025-07-18 10:33:00 us=3D952754 dco_parse_peer_multi: parsing message...
2025-07-18 10:33:00 us=3D952791 dco_parse_peer_multi: cannot store DCO stat=
s for peer 2
2025-07-18 10:33:00 us=3D952892 register signal: SIGTERM (close_context)
2025-07-18 10:33:00 us=3D952943 dco_del_peer: peer-id 2
2025-07-18 10:33:00 us=3D972424 Sent warning SSL alert: close notify
2025-07-18 10:33:00 us=3D972698 Sent warning SSL alert: close notify

Program received signal SIGSEGV, Segmentation fault.
0x0000555555599ef3 in multi_process_float (m=3Dm@...1851...=3D0x7fffffffbcc=
0, mi=3Dmi@...1851...=3D0x5555556a2050, sock=3D0x55555564dbe0) at multi.c:3=
258
3258        msg(D_MULTI_MEDIUM, "peer %" PRIu32 " (%s) floated from %s to %=
s",
(gdb) list
3253
3254            msg(D_MULTI_MEDIUM, "closing instance %s", multi_instance_s=
tring(ex_mi, false, &gc));
3255            multi_close_instance(m, ex_mi, false);
3256        }
3257
3258        msg(D_MULTI_MEDIUM, "peer %" PRIu32 " (%s) floated from %s to %=
s",
3259            mi->context.c2.tls_multi->peer_id,
3260            tls_common_name(mi->context.c2.tls_multi, false),
3261            mroute_addr_print(&mi->real, &gc),
3262            print_link_socket_actual(&m->top.c2.from, &gc));
(gdb) print mi->context.c2.tls_multi
$1 =3D (struct tls_multi *) 0x0
```



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1084?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I33e9272b4196c7634db2fb33a75ae4261660867f
Gerrit-Change-Number: 1084
Gerrit-PatchSet: 5
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <antonio@...2726...>
Gerrit-Attention: ralf_lici <ralf@...2726...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Fri, 18 Jul 2025 08:39:45 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--OXyyIkve3AU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, ordex, plaisthos, r=
alf_lici, stipa. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1084?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1084?tab=3Dcomments">Patch Set #5:</a> </p><p style=3D"white-space: pre-wra=
p; word-wrap: break-word;">So, it segfaulted again - which is a different b=
ug than the AF_INET6 thing (which seems fixed).  Not sure how to trigger it=
 yet... I had 2 sockets, and 3 clients this time (something stable on the u=
dp6 socket with peer-id 0 + 1, and the floating client on the udp4 socket w=
ith peer-id 2).</p><p style=3D"white-space: pre-wrap; word-wrap: break-word=
;">It got confused again about &quot;something&quot;, then tried to delete =
the peer, and segfaulted at the same place (race condition between userspac=
e already having deleted half the peer info and then kernel sending up a me=
ssage?)</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Tryin=
g to extract the interesting bits</p><p style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">```<br>2025-07-18 10:32:39 us=3D870590 dco_do_read<br>=
2025-07-18 10:32:39 us=3D870769 ovpn-dco: received CMD_PEER_FLOAT_NTF, ifin=
dex: 5651, peer-id 2, address: [AF_INET]193.149.48.173:62227<br>2025-07-18 =
10:32:39 us=3D870881 peer 2 (cron2-freebsd-tc-amd64) floated from udp4:193.=
149.48.172:62227 to [AF_INET]193.149.48.173:62227<br>2025-07-18 10:32:43 us=
=3D883102 dco_do_read<br>2025-07-18 10:32:43 us=3D883230 ovpn-dco: received=
 CMD_PEER_FLOAT_NTF, ifindex: 5651, peer-id 2, address: [AF_INET]193.149.48=
.172:62227<br>2025-07-18 10:32:43 us=3D883293 peer 2 (cron2-freebsd-tc-amd6=
4) floated from udp4:193.149.48.173:62227 to [AF_INET]193.149.48.172:62227<=
br>(everything fine)</p><p style=3D"white-space: pre-wrap; word-wrap: break=
-word;">2025-07-18 10:32:55 us=3D935486 dco_get_peer_stats_multi<br>2025-07=
-18 10:32:55 us=3D935798 dco_parse_peer_multi: parsing message...<br>2025-0=
7-18 10:32:55 us=3D935851 dco_update_peer_stat: no link RX bytes provided i=
n reply for peer 2<br>2025-07-18 10:32:55 us=3D935881 dco_update_peer_stat:=
 no link TX bytes provided in reply for peer 2<br>2025-07-18 10:32:55 us=3D=
935900 dco_update_peer_stat: no VPN RX bytes provided in reply for peer 2<b=
r>2025-07-18 10:32:55 us=3D935919 dco_update_peer_stat: no VPN TX bytes pro=
vided in reply for peer 2<br>2025-07-18 10:32:55 us=3D937904 dco_parse_peer=
_multi: parsing message...<br>2025-07-18 10:32:55 us=3D937991 dco_update_pe=
er_stat / dco_read_bytes: 976<br>2025-07-18 10:32:55 us=3D938052 dco_update=
_peer_stat / dco_write_bytes: 440<br>2025-07-18 10:32:55 us=3D938098 dco_up=
date_peer_stat / tun_read_bytes: 0<br>2025-07-18 10:32:55 us=3D938151 dco_u=
pdate_peer_stat / tun_write_bytes: 0<br>2025-07-18 10:32:55 us=3D938212 dco=
_parse_peer_multi: parsing message...<br>2025-07-18 10:32:55 us=3D938270 dc=
o_update_peer_stat / dco_read_bytes: 400<br>2025-07-18 10:32:55 us=3D938322=
 dco_update_peer_stat / dco_write_bytes: 440<br>2025-07-18 10:32:55 us=3D93=
8366 dco_update_peer_stat / tun_read_bytes: 0<br>2025-07-18 10:32:55 us=3D9=
38425 dco_update_peer_stat / tun_write_bytes: 0<br>2025-07-18 10:32:55 us=
=3D938483 dco_parse_peer_multi: parsing message...<br>2025-07-18 10:32:55 u=
s=3D938535 dco_update_peer_stat / dco_read_bytes: 13840<br>2025-07-18 10:32=
:55 us=3D938579 dco_update_peer_stat / dco_write_bytes: 13440<br>2025-07-18=
 10:32:55 us=3D938638 dco_update_peer_stat / tun_read_bytes: 10920<br>2025-=
07-18 10:32:55 us=3D938695 dco_update_peer_stat / tun_write_bytes: 10920<br=
>2025-07-18 10:32:55 us=3D939599 dco_do_read<br>2025-07-18 10:32:55 us=3D93=
9755 dco_do_read: netlink reports error (-4): Try again</p><p style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">(this &quot;no RX bytes for peer=
 2&quot; is what I saw yesterday as well, and the &quot;Try again&quot;)</p=
><p style=3D"white-space: pre-wrap; word-wrap: break-word;">2025-07-18 10:3=
3:00 us=3D100235 cron2-freebsd-tc-amd64/udp4:193.149.48.172:62227 peer-id=
=3D2 TLS: soft reset sec=3D56/56 bytes=3D0/-1 pkts=3D0/0 aead_limit_send=3D=
0/60129542137 aead_limit_recv=3D0/60129542137<br>2025-07-18 10:33:00 us=3D1=
00434 cron2-freebsd-tc-amd64/udp4:193.149.48.172:62227 peer-id=3D2 Sent war=
ning SSL alert: close notify<br>2025-07-18 10:33:00 us=3D100719 cron2-freeb=
sd-tc-amd64/udp4:193.149.48.172:62227 peer-id=3D2 dco_del_key: peer-id 2, s=
lot 1</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">(this s=
till looks normal, skipping the UDP read/write)</p><p style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">2025-07-18 10:33:00 us=3D132607 cron2-fr=
eebsd-tc-amd64/udp4:193.149.48.172:62227 peer-id=3D2 VERIFY OK: depth=3D1, =
C=3DUS, ST=3DCalifornia, L=3DPleasanton, O=3DOpenVPN community project, CN=
=3DOpenVPN community project CA, emailAddress=3Dsamuli@...515...<br>2025-07=
-18 10:33:00 us=3D132851 cron2-freebsd-tc-amd64/udp4:193.149.48.172:62227 p=
eer-id=3D2 VERIFY OK: depth=3D0, C=3DDE, ST=3DBavaria, L=3DMunich, O=3DOpen=
VPN community project, OU=3DServer Testing, CN=3Dcron2-freebsd-tc-amd64, em=
ailAddress=3Dgert@...2576...<br>2025-07-18 10:33:00 us=3D133145 cron2-freeb=
sd-tc-amd64/udp4:193.149.48.172:62227 peer-id=3D2 peer info: IV_VER=3D2.7_a=
lpha2<br>2025-07-18 10:33:00 us=3D133198 cron2-freebsd-tc-amd64/udp4:193.14=
9.48.172:62227 peer-id=3D2 peer info: IV_PLAT=3Dmac<br>2025-07-18 10:33:00 =
us=3D133238 cron2-freebsd-tc-amd64/udp4:193.149.48.172:62227 peer-id=3D2 pe=
er info: IV_TCPNL=3D1<br>2025-07-18 10:33:00 us=3D133283 cron2-freebsd-tc-a=
md64/udp4:193.149.48.172:62227 peer-id=3D2 peer info: IV_MTU=3D1600<br>2025=
-07-18 10:33:00 us=3D133315 cron2-freebsd-tc-amd64/udp4:193.149.48.172:6222=
7 peer-id=3D2 peer info: IV_NCP=3D2<br>2025-07-18 10:33:00 us=3D133348 cron=
2-freebsd-tc-amd64/udp4:193.149.48.172:62227 peer-id=3D2 peer info: IV_CIPH=
ERS=3DAES-256-GCM:AES-128-GCM:CHACHA20-POLY1305<br>2025-07-18 10:33:00 us=
=3D133385 cron2-freebsd-tc-amd64/udp4:193.149.48.172:62227 peer-id=3D2 peer=
 info: IV_PROTO=3D3998<br>2025-07-18 10:33:00 us=3D133418 cron2-freebsd-tc-=
amd64/udp4:193.149.48.172:62227 peer-id=3D2 peer info: IV_LZ4=3D1<br>2025-0=
7-18 10:33:00 us=3D133453 cron2-freebsd-tc-amd64/udp4:193.149.48.172:62227 =
peer-id=3D2 peer info: IV_LZ4v2=3D1<br>2025-07-18 10:33:00 us=3D133487 cron=
2-freebsd-tc-amd64/udp4:193.149.48.172:62227 peer-id=3D2 peer info: IV_LZO=
=3D1<br>2025-07-18 10:33:00 us=3D133521 cron2-freebsd-tc-amd64/udp4:193.149=
.48.172:62227 peer-id=3D2 peer info: IV_COMP_STUB=3D1<br>2025-07-18 10:33:0=
0 us=3D133553 cron2-freebsd-tc-amd64/udp4:193.149.48.172:62227 peer-id=3D2 =
peer info: IV_COMP_STUBv2=3D1<br>2025-07-18 10:33:00 us=3D133592 cron2-free=
bsd-tc-amd64/udp4:193.149.48.172:62227 peer-id=3D2 Note: &#39;compress migr=
ate&#39; detected remote peer with compression enabled.<br>2025-07-18 10:33=
:00 us=3D133743 cron2-freebsd-tc-amd64/udp4:193.149.48.172:62227 peer-id=3D=
2 UDPv4 WRITE [236] to [AF_INET]193.149.48.172:62227: P_CONTROL_V1 kid=3D2 =
[ ] pid=3D4456 DATA len=3D222<br>2025-07-18 10:33:00 us=3D133834 cron2-free=
bsd-tc-amd64/udp4:193.149.48.172:62227 peer-id=3D2 UDPv4 WRITE [287] to [AF=
_INET]193.149.48.172:62227: P_CONTROL_V1 kid=3D2 [ ] pid=3D4712 DATA len=3D=
273<br>2025-07-18 10:33:00 us=3D137204 cron2-freebsd-tc-amd64/udp4:193.149.=
48.172:62227 peer-id=3D2 UDPv4 READ [78] from [AF_INET]193.149.48.172:62227=
: P_ACK_V1 kid=3D2 [ ] DATA len=3D68<br>2025-07-18 10:33:00 us=3D140572 cro=
n2-freebsd-tc-amd64/udp4:193.149.48.172:62227 peer-id=3D2 UDPv4 READ [82] f=
rom [AF_INET]193.149.48.172:62227: P_ACK_V1 kid=3D2 [ ] DATA len=3D72<br>20=
25-07-18 10:33:00 us=3D140640 cron2-freebsd-tc-amd64/udp4:193.149.48.172:62=
227 peer-id=3D2 Control Channel: TLSv1.3, cipher TLSv1.3 TLS_AES_256_GCM_SH=
A384, peer certificate: 2048 bits RSA, signature: RSA-SHA1, peer temporary =
key: 253 bits X25519, peer signing digest/type: SHA256 RSASSA-PSS<br>2025-0=
7-18 10:33:00 us=3D140720 cron2-freebsd-tc-amd64/udp4:193.149.48.172:62227 =
peer-id=3D2 dco_install_key: peer_id=3D2 keyid=3D2, currently 1 keys instal=
led<br>2025-07-18 10:33:00 us=3D140767 cron2-freebsd-tc-amd64/udp4:193.149.=
48.172:62227 peer-id=3D2 dco_new_key: slot 1, key-id 2, peer-id 2, cipher A=
ES-256-GCM<br>2025-07-18 10:33:00 us=3D951542 dco_do_read<br>2025-07-18 10:=
33:00 us=3D951670 ovpn-dco: received CMD_PEER_FLOAT_NTF, ifindex: 5651, pee=
r-id 2, address: [AF_INET]193.149.48.172:62227<br>2025-07-18 10:33:00 us=3D=
951736 closing instance cron2-freebsd-tc-amd64/udp4:193.149.48.172:62227 pe=
er-id=3D2<br>2025-07-18 10:33:00 us=3D951806 dco_get_peer_stats_multi<br>20=
25-07-18 10:33:00 us=3D952053 dco_parse_peer_multi: parsing message...<br>2=
025-07-18 10:33:00 us=3D952099 dco_update_peer_stat / dco_read_bytes: 976<b=
r>2025-07-18 10:33:00 us=3D952135 dco_update_peer_stat / dco_write_bytes: 4=
40<br>2025-07-18 10:33:00 us=3D952169 dco_update_peer_stat / tun_read_bytes=
: 0<br>2025-07-18 10:33:00 us=3D952478 dco_update_peer_stat / tun_write_byt=
es: 0<br>2025-07-18 10:33:00 us=3D952541 dco_parse_peer_multi: parsing mess=
age...<br>2025-07-18 10:33:00 us=3D952580 dco_update_peer_stat / dco_read_b=
ytes: 400<br>2025-07-18 10:33:00 us=3D952614 dco_update_peer_stat / dco_wri=
te_bytes: 440<br>2025-07-18 10:33:00 us=3D952663 dco_update_peer_stat / tun=
_read_bytes: 0<br>2025-07-18 10:33:00 us=3D952707 dco_update_peer_stat / tu=
n_write_bytes: 0<br>2025-07-18 10:33:00 us=3D952754 dco_parse_peer_multi: p=
arsing message...<br>2025-07-18 10:33:00 us=3D952791 dco_parse_peer_multi: =
cannot store DCO stats for peer 2<br>2025-07-18 10:33:00 us=3D952892 regist=
er signal: SIGTERM (close_context)<br>2025-07-18 10:33:00 us=3D952943 dco_d=
el_peer: peer-id 2<br>2025-07-18 10:33:00 us=3D972424 Sent warning SSL aler=
t: close notify<br>2025-07-18 10:33:00 us=3D972698 Sent warning SSL alert: =
close notify</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">=
Program received signal SIGSEGV, Segmentation fault.<br>0x0000555555599ef3 =
in multi_process_float (m=3Dm@...1851...=3D0x7fffffffbcc0, mi=3Dmi@...2029...=
..=3D0x5555556a2050, sock=3D0x55555564dbe0) at multi.c:3258<br>3258        =
msg(D_MULTI_MEDIUM, &quot;peer %&quot; PRIu32 &quot; (%s) floated from %s t=
o %s&quot;,<br>(gdb) list<br>3253<br>3254            msg(D_MULTI_MEDIUM, &q=
uot;closing instance %s&quot;, multi_instance_string(ex_mi, false, &amp;gc)=
);<br>3255            multi_close_instance(m, ex_mi, false);<br>3256       =
 }<br>3257<br>3258        msg(D_MULTI_MEDIUM, &quot;peer %&quot; PRIu32 &qu=
ot; (%s) floated from %s to %s&quot;,<br>3259            mi-&gt;context.c2.=
tls_multi-&gt;peer_id,<br>3260            tls_common_name(mi-&gt;context.c2=
.tls_multi, false),<br>3261            mroute_addr_print(&amp;mi-&gt;real, =
&amp;gc),<br>3262            print_link_socket_actual(&amp;m-&gt;top.c2.fro=
m, &amp;gc));<br>(gdb) print mi-&gt;context.c2.tls_multi<br>$1 =3D (struct =
tls_multi *) 0x0<br>```</p></li></ul></li></ul><p>To view, visit <a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1084?usp=3Demail">change 1084</a>. T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http=
://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"=
http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1084?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I33e9272b4196c7634db2fb33a75=
ae4261660867f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1084 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@...2726...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@...2804...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 18 Jul 2025 08:39:45=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--OXyyIkve3AU=--

