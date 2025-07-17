From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 17 Jul 2025 16:02:30 +0000
In-Reply-To: <gerrit.1752486326000.I33e9272b4196c7634db2fb33a75ae4261660867f@...2715...>
References: <gerrit.1752486326000.I33e9272b4196c7634db2fb33a75ae4261660867f@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, ralf@...2726..., frank@...2641...,
 lstipakov@...277..., antonio@...2726...
Message-ID: <7fe52a92aed0584b3b1e61c3f6ab74be5cf5077e-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nOOLpbHW91g="; charset=UTF-8
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

--nOOLpbHW91g=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici, s=
tipa.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/1084?usp=3Demail )

Change subject: dco: Add support for float notifications
......................................................................


Patch Set 3:

(1 comment)

Patchset:

PS3:
so here's the last successful TLS reneg, one minute earlier

```
2025-07-17 17:45:02 us=3D482995 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
63385 peer-id=3D2 TLS: soft reset sec=3D59/59 bytes=3D0/-1 pkts=3D0/0 aead_=
limit_send=3D0/60129542137 aead_limit_recv=3D0/60129542137
2025-07-17 17:45:02 us=3D483272 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
63385 peer-id=3D2 dco_del_key: peer-id 2, slot 1
2025-07-17 17:45:02 us=3D483585 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
63385 peer-id=3D2 UDPv4 WRITE [54] to [AF_INET]193.149.48.172:63385 (via [A=
F_INET]195.30.8.84%ens160): P_CONTROL_SOFT_RESET_V1 kid=3D6 [ ] pid=3D10600=
 DATA len=3D40
2025-07-17 17:45:02 us=3D490075 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
63385 peer-id=3D2 UDPv4 READ [66] from [AF_INET]193.149.48.172:63385 (via [=
AF_INET]195.30.8.84%ens160): P_CONTROL_SOFT_RESET_V1 kid=3D6 [ ] pid=3D1060=
0 DATA len=3D52
2025-07-17 17:45:02 us=3D490260 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
63385 peer-id=3D2 UDPv4 WRITE [62] to [AF_INET]193.149.48.172:63385 (via [A=
F_INET]195.30.8.84%ens160): P_ACK_V1 kid=3D6 [ ] DATA len=3D52
2025-07-17 17:45:02 us=3D495340 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
63385 peer-id=3D2 UDPv4 READ [355] from [AF_INET]193.149.48.172:63385 (via =
[AF_INET]195.30.8.84%ens160): P_CONTROL_V1 kid=3D6 [ ] pid=3D10856 DATA len=
=3D341
2025-07-17 17:45:02 us=3D505576 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
63385 peer-id=3D2 UDPv4 WRITE [1262] to [AF_INET]193.149.48.172:63385 (via =
[AF_INET]195.30.8.84%ens160): P_CONTROL_V1 kid=3D6 [ ] pid=3D11112 DATA len=
=3D1248
2025-07-17 17:45:02 us=3D505746 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
63385 peer-id=3D2 UDPv4 WRITE [923] to [AF_INET]193.149.48.172:63385 (via [=
AF_INET]195.30.8.84%ens160): P_CONTROL_V1 kid=3D6 [ ] pid=3D11368 DATA len=
=3D909
2025-07-17 17:45:02 us=3D510213 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
63385 peer-id=3D2 UDPv4 READ [66] from [AF_INET]193.149.48.172:63385 (via [=
AF_INET]195.30.8.84%ens160): P_ACK_V1 kid=3D6 [ ] DATA len=3D56
2025-07-17 17:45:02 us=3D519114 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
63385 peer-id=3D2 UDPv4 READ [1262] from [AF_INET]193.149.48.172:63385 (via=
 [AF_INET]195.30.8.84%ens160): P_CONTROL_V1 kid=3D6 [ ] pid=3D11368 DATA le=
n=3D1248
2025-07-17 17:45:02 us=3D519243 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
63385 peer-id=3D2 UDPv4 WRITE [70] to [AF_INET]193.149.48.172:63385 (via [A=
F_INET]195.30.8.84%ens160): P_ACK_V1 kid=3D6 [ ] DATA len=3D60
2025-07-17 17:45:02 us=3D519353 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
63385 peer-id=3D2 UDPv4 READ [1262] from [AF_INET]193.149.48.172:63385 (via=
 [AF_INET]195.30.8.84%ens160): P_CONTROL_V1 kid=3D6 [ ] pid=3D11624 DATA le=
n=3D1248
2025-07-17 17:45:02 us=3D519471 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
63385 peer-id=3D2 UDPv4 WRITE [74] to [AF_INET]193.149.48.172:63385 (via [A=
F_INET]195.30.8.84%ens160): P_ACK_V1 kid=3D6 [ ] DATA len=3D64
2025-07-17 17:45:02 us=3D519586 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
63385 peer-id=3D2 UDPv4 READ [753] from [AF_INET]193.149.48.172:63385 (via =
[AF_INET]195.30.8.84%ens160): P_CONTROL_V1 kid=3D6 [ ] pid=3D11880 DATA len=
=3D739
2025-07-17 17:45:02 us=3D519991 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
63385 peer-id=3D2 VERIFY OK: depth=3D1, C=3DUS, ST=3DCalifornia, L=3DPleasa=
nton, O=3DOpenVPN community project, CN=3DOpenVPN community project CA, ema=
ilAddress=3Dsamuli@...515...
2025-07-17 17:45:02 us=3D520144 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
63385 peer-id=3D2 VERIFY OK: depth=3D0, C=3DDE, ST=3DBavaria, L=3DMunich, O=
=3DOpenVPN community project, OU=3DServer Testing, CN=3Dcron2-freebsd-tc-am=
d64, emailAddress=3Dgert@...2576...
2025-07-17 17:45:02 us=3D525244 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
63385 peer-id=3D2 UDPv4 WRITE [121] to [AF_INET]193.149.48.172:63385 (via [=
AF_INET]195.30.8.84%ens160): P_CONTROL_V1 kid=3D6 [ ] pid=3D12136 DATA len=
=3D107
2025-07-17 17:45:02 us=3D530446 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
63385 peer-id=3D2 UDPv4 READ [525] from [AF_INET]193.149.48.172:63385 (via =
[AF_INET]195.30.8.84%ens160): P_CONTROL_V1 kid=3D6 [ ] pid=3D12136 DATA len=
=3D511
2025-07-17 17:45:02 us=3D530543 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
63385 peer-id=3D2 peer info: IV_VER=3D2.7_alpha2
2025-07-17 17:45:02 us=3D530583 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
63385 peer-id=3D2 peer info: IV_PLAT=3Dmac
2025-07-17 17:45:02 us=3D530619 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
63385 peer-id=3D2 peer info: IV_TCPNL=3D1
2025-07-17 17:45:02 us=3D530646 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
63385 peer-id=3D2 peer info: IV_MTU=3D1600
2025-07-17 17:45:02 us=3D530666 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
63385 peer-id=3D2 peer info: IV_NCP=3D2
2025-07-17 17:45:02 us=3D530687 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
63385 peer-id=3D2 peer info: IV_CIPHERS=3DAES-256-GCM:AES-128-GCM:CHACHA20-=
POLY1305
2025-07-17 17:45:02 us=3D530705 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
63385 peer-id=3D2 peer info: IV_PROTO=3D3998
2025-07-17 17:45:02 us=3D530726 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
63385 peer-id=3D2 peer info: IV_LZ4=3D1
2025-07-17 17:45:02 us=3D530755 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
63385 peer-id=3D2 peer info: IV_LZ4v2=3D1
2025-07-17 17:45:02 us=3D530779 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
63385 peer-id=3D2 peer info: IV_LZO=3D1
2025-07-17 17:45:02 us=3D530801 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
63385 peer-id=3D2 peer info: IV_COMP_STUB=3D1
2025-07-17 17:45:02 us=3D530821 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
63385 peer-id=3D2 peer info: IV_COMP_STUBv2=3D1
2025-07-17 17:45:02 us=3D530859 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
63385 peer-id=3D2 Note: 'compress migrate' detected remote peer with compre=
ssion enabled.
2025-07-17 17:45:02 us=3D531008 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
63385 peer-id=3D2 UDPv4 WRITE [286] to [AF_INET]193.149.48.172:63385 (via [=
AF_INET]195.30.8.84%ens160): P_CONTROL_V1 kid=3D6 [ ] pid=3D12392 DATA len=
=3D272
2025-07-17 17:45:02 us=3D535798 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
63385 peer-id=3D2 UDPv4 READ [78] from [AF_INET]193.149.48.172:63385 (via [=
AF_INET]195.30.8.84%ens160): P_ACK_V1 kid=3D6 [ ] DATA len=3D68
2025-07-17 17:45:02 us=3D535906 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
63385 peer-id=3D2 Control Channel: TLSv1.2, cipher TLS-ECDHE-RSA-WITH-CHACH=
A20-POLY1305-SHA256, 2048 bit key
2025-07-17 17:45:02 us=3D536025 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
63385 peer-id=3D2 dco_install_key: peer_id=3D2 keyid=3D6, currently 1 keys =
installed
2025-07-17 17:45:02 us=3D536058 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
63385 peer-id=3D2 dco_new_key: slot 1, key-id 6, peer-id 2, cipher AES-256-=
GCM
2025-07-17 17:45:05 us=3D707606 dco_get_peer_stats_multi
2025-07-17 17:45:05 us=3D707964 dco_parse_peer_multi: parsing message...
2025-07-17 17:45:05 us=3D707999 dco_update_peer_stat / dco_read_bytes: 1408
2025-07-17 17:45:05 us=3D708017 dco_update_peer_stat / dco_write_bytes: 1200
2025-07-17 17:45:05 us=3D708032 dco_update_peer_stat / tun_read_bytes: 0
2025-07-17 17:45:05 us=3D708051 dco_update_peer_stat / tun_write_bytes: 0
2025-07-17 17:45:05 us=3D708071 dco_parse_peer_multi: parsing message...
```



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1084?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I33e9272b4196c7634db2fb33a75ae4261660867f
Gerrit-Change-Number: 1084
Gerrit-PatchSet: 3
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ralf_lici <ralf@...2726...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Thu, 17 Jul 2025 16:02:30 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--nOOLpbHW91g=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos, ralf_lic=
i, stipa. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1084?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1084?tab=3Dcomments">Patch Set #3:</a> </p><p style=3D"white-space: pre-wra=
p; word-wrap: break-word;">so here&#39;s the last successful TLS reneg, one=
 minute earlier</p><p style=3D"white-space: pre-wrap; word-wrap: break-word=
;">```<br>2025-07-17 17:45:02 us=3D482995 cron2-freebsd-tc-amd64/udp4:193.1=
49.48.172:63385 peer-id=3D2 TLS: soft reset sec=3D59/59 bytes=3D0/-1 pkts=
=3D0/0 aead_limit_send=3D0/60129542137 aead_limit_recv=3D0/60129542137<br>2=
025-07-17 17:45:02 us=3D483272 cron2-freebsd-tc-amd64/udp4:193.149.48.172:6=
3385 peer-id=3D2 dco_del_key: peer-id 2, slot 1<br>2025-07-17 17:45:02 us=
=3D483585 cron2-freebsd-tc-amd64/udp4:193.149.48.172:63385 peer-id=3D2 UDPv=
4 WRITE [54] to [AF_INET]193.149.48.172:63385 (via [AF_INET]195.30.8.84%ens=
160): P_CONTROL_SOFT_RESET_V1 kid=3D6 [ ] pid=3D10600 DATA len=3D40<br>2025=
-07-17 17:45:02 us=3D490075 cron2-freebsd-tc-amd64/udp4:193.149.48.172:6338=
5 peer-id=3D2 UDPv4 READ [66] from [AF_INET]193.149.48.172:63385 (via [AF_I=
NET]195.30.8.84%ens160): P_CONTROL_SOFT_RESET_V1 kid=3D6 [ ] pid=3D10600 DA=
TA len=3D52<br>2025-07-17 17:45:02 us=3D490260 cron2-freebsd-tc-amd64/udp4:=
193.149.48.172:63385 peer-id=3D2 UDPv4 WRITE [62] to [AF_INET]193.149.48.17=
2:63385 (via [AF_INET]195.30.8.84%ens160): P_ACK_V1 kid=3D6 [ ] DATA len=3D=
52<br>2025-07-17 17:45:02 us=3D495340 cron2-freebsd-tc-amd64/udp4:193.149.4=
8.172:63385 peer-id=3D2 UDPv4 READ [355] from [AF_INET]193.149.48.172:63385=
 (via [AF_INET]195.30.8.84%ens160): P_CONTROL_V1 kid=3D6 [ ] pid=3D10856 DA=
TA len=3D341<br>2025-07-17 17:45:02 us=3D505576 cron2-freebsd-tc-amd64/udp4=
:193.149.48.172:63385 peer-id=3D2 UDPv4 WRITE [1262] to [AF_INET]193.149.48=
.172:63385 (via [AF_INET]195.30.8.84%ens160): P_CONTROL_V1 kid=3D6 [ ] pid=
=3D11112 DATA len=3D1248<br>2025-07-17 17:45:02 us=3D505746 cron2-freebsd-t=
c-amd64/udp4:193.149.48.172:63385 peer-id=3D2 UDPv4 WRITE [923] to [AF_INET=
]193.149.48.172:63385 (via [AF_INET]195.30.8.84%ens160): P_CONTROL_V1 kid=
=3D6 [ ] pid=3D11368 DATA len=3D909<br>2025-07-17 17:45:02 us=3D510213 cron=
2-freebsd-tc-amd64/udp4:193.149.48.172:63385 peer-id=3D2 UDPv4 READ [66] fr=
om [AF_INET]193.149.48.172:63385 (via [AF_INET]195.30.8.84%ens160): P_ACK_V=
1 kid=3D6 [ ] DATA len=3D56<br>2025-07-17 17:45:02 us=3D519114 cron2-freebs=
d-tc-amd64/udp4:193.149.48.172:63385 peer-id=3D2 UDPv4 READ [1262] from [AF=
_INET]193.149.48.172:63385 (via [AF_INET]195.30.8.84%ens160): P_CONTROL_V1 =
kid=3D6 [ ] pid=3D11368 DATA len=3D1248<br>2025-07-17 17:45:02 us=3D519243 =
cron2-freebsd-tc-amd64/udp4:193.149.48.172:63385 peer-id=3D2 UDPv4 WRITE [7=
0] to [AF_INET]193.149.48.172:63385 (via [AF_INET]195.30.8.84%ens160): P_AC=
K_V1 kid=3D6 [ ] DATA len=3D60<br>2025-07-17 17:45:02 us=3D519353 cron2-fre=
ebsd-tc-amd64/udp4:193.149.48.172:63385 peer-id=3D2 UDPv4 READ [1262] from =
[AF_INET]193.149.48.172:63385 (via [AF_INET]195.30.8.84%ens160): P_CONTROL_=
V1 kid=3D6 [ ] pid=3D11624 DATA len=3D1248<br>2025-07-17 17:45:02 us=3D5194=
71 cron2-freebsd-tc-amd64/udp4:193.149.48.172:63385 peer-id=3D2 UDPv4 WRITE=
 [74] to [AF_INET]193.149.48.172:63385 (via [AF_INET]195.30.8.84%ens160): P=
_ACK_V1 kid=3D6 [ ] DATA len=3D64<br>2025-07-17 17:45:02 us=3D519586 cron2-=
freebsd-tc-amd64/udp4:193.149.48.172:63385 peer-id=3D2 UDPv4 READ [753] fro=
m [AF_INET]193.149.48.172:63385 (via [AF_INET]195.30.8.84%ens160): P_CONTRO=
L_V1 kid=3D6 [ ] pid=3D11880 DATA len=3D739<br>2025-07-17 17:45:02 us=3D519=
991 cron2-freebsd-tc-amd64/udp4:193.149.48.172:63385 peer-id=3D2 VERIFY OK:=
 depth=3D1, C=3DUS, ST=3DCalifornia, L=3DPleasanton, O=3DOpenVPN community =
project, CN=3DOpenVPN community project CA, emailAddress=3Dsamuli@...515...=
<br>2025-07-17 17:45:02 us=3D520144 cron2-freebsd-tc-amd64/udp4:193.149.48.=
172:63385 peer-id=3D2 VERIFY OK: depth=3D0, C=3DDE, ST=3DBavaria, L=3DMunic=
h, O=3DOpenVPN community project, OU=3DServer Testing, CN=3Dcron2-freebsd-t=
c-amd64, emailAddress=3Dgert@...2576...<br>2025-07-17 17:45:02 us=3D525244 =
cron2-freebsd-tc-amd64/udp4:193.149.48.172:63385 peer-id=3D2 UDPv4 WRITE [1=
21] to [AF_INET]193.149.48.172:63385 (via [AF_INET]195.30.8.84%ens160): P_C=
ONTROL_V1 kid=3D6 [ ] pid=3D12136 DATA len=3D107<br>2025-07-17 17:45:02 us=
=3D530446 cron2-freebsd-tc-amd64/udp4:193.149.48.172:63385 peer-id=3D2 UDPv=
4 READ [525] from [AF_INET]193.149.48.172:63385 (via [AF_INET]195.30.8.84%e=
ns160): P_CONTROL_V1 kid=3D6 [ ] pid=3D12136 DATA len=3D511<br>2025-07-17 1=
7:45:02 us=3D530543 cron2-freebsd-tc-amd64/udp4:193.149.48.172:63385 peer-i=
d=3D2 peer info: IV_VER=3D2.7_alpha2<br>2025-07-17 17:45:02 us=3D530583 cro=
n2-freebsd-tc-amd64/udp4:193.149.48.172:63385 peer-id=3D2 peer info: IV_PLA=
T=3Dmac<br>2025-07-17 17:45:02 us=3D530619 cron2-freebsd-tc-amd64/udp4:193.=
149.48.172:63385 peer-id=3D2 peer info: IV_TCPNL=3D1<br>2025-07-17 17:45:02=
 us=3D530646 cron2-freebsd-tc-amd64/udp4:193.149.48.172:63385 peer-id=3D2 p=
eer info: IV_MTU=3D1600<br>2025-07-17 17:45:02 us=3D530666 cron2-freebsd-tc=
-amd64/udp4:193.149.48.172:63385 peer-id=3D2 peer info: IV_NCP=3D2<br>2025-=
07-17 17:45:02 us=3D530687 cron2-freebsd-tc-amd64/udp4:193.149.48.172:63385=
 peer-id=3D2 peer info: IV_CIPHERS=3DAES-256-GCM:AES-128-GCM:CHACHA20-POLY1=
305<br>2025-07-17 17:45:02 us=3D530705 cron2-freebsd-tc-amd64/udp4:193.149.=
48.172:63385 peer-id=3D2 peer info: IV_PROTO=3D3998<br>2025-07-17 17:45:02 =
us=3D530726 cron2-freebsd-tc-amd64/udp4:193.149.48.172:63385 peer-id=3D2 pe=
er info: IV_LZ4=3D1<br>2025-07-17 17:45:02 us=3D530755 cron2-freebsd-tc-amd=
64/udp4:193.149.48.172:63385 peer-id=3D2 peer info: IV_LZ4v2=3D1<br>2025-07=
-17 17:45:02 us=3D530779 cron2-freebsd-tc-amd64/udp4:193.149.48.172:63385 p=
eer-id=3D2 peer info: IV_LZO=3D1<br>2025-07-17 17:45:02 us=3D530801 cron2-f=
reebsd-tc-amd64/udp4:193.149.48.172:63385 peer-id=3D2 peer info: IV_COMP_ST=
UB=3D1<br>2025-07-17 17:45:02 us=3D530821 cron2-freebsd-tc-amd64/udp4:193.1=
49.48.172:63385 peer-id=3D2 peer info: IV_COMP_STUBv2=3D1<br>2025-07-17 17:=
45:02 us=3D530859 cron2-freebsd-tc-amd64/udp4:193.149.48.172:63385 peer-id=
=3D2 Note: &#39;compress migrate&#39; detected remote peer with compression=
 enabled.<br>2025-07-17 17:45:02 us=3D531008 cron2-freebsd-tc-amd64/udp4:19=
3.149.48.172:63385 peer-id=3D2 UDPv4 WRITE [286] to [AF_INET]193.149.48.172=
:63385 (via [AF_INET]195.30.8.84%ens160): P_CONTROL_V1 kid=3D6 [ ] pid=3D12=
392 DATA len=3D272<br>2025-07-17 17:45:02 us=3D535798 cron2-freebsd-tc-amd6=
4/udp4:193.149.48.172:63385 peer-id=3D2 UDPv4 READ [78] from [AF_INET]193.1=
49.48.172:63385 (via [AF_INET]195.30.8.84%ens160): P_ACK_V1 kid=3D6 [ ] DAT=
A len=3D68<br>2025-07-17 17:45:02 us=3D535906 cron2-freebsd-tc-amd64/udp4:1=
93.149.48.172:63385 peer-id=3D2 Control Channel: TLSv1.2, cipher TLS-ECDHE-=
RSA-WITH-CHACHA20-POLY1305-SHA256, 2048 bit key<br>2025-07-17 17:45:02 us=
=3D536025 cron2-freebsd-tc-amd64/udp4:193.149.48.172:63385 peer-id=3D2 dco_=
install_key: peer_id=3D2 keyid=3D6, currently 1 keys installed<br>2025-07-1=
7 17:45:02 us=3D536058 cron2-freebsd-tc-amd64/udp4:193.149.48.172:63385 pee=
r-id=3D2 dco_new_key: slot 1, key-id 6, peer-id 2, cipher AES-256-GCM<br>20=
25-07-17 17:45:05 us=3D707606 dco_get_peer_stats_multi<br>2025-07-17 17:45:=
05 us=3D707964 dco_parse_peer_multi: parsing message...<br>2025-07-17 17:45=
:05 us=3D707999 dco_update_peer_stat / dco_read_bytes: 1408<br>2025-07-17 1=
7:45:05 us=3D708017 dco_update_peer_stat / dco_write_bytes: 1200<br>2025-07=
-17 17:45:05 us=3D708032 dco_update_peer_stat / tun_read_bytes: 0<br>2025-0=
7-17 17:45:05 us=3D708051 dco_update_peer_stat / tun_write_bytes: 0<br>2025=
-07-17 17:45:05 us=3D708071 dco_parse_peer_multi: parsing message...<br>```=
</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1084?usp=3Demail">change 1084</a>. To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settin=
gs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1084?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I33e9272b4196c7634db2fb33a75=
ae4261660867f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1084 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
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
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@...2804...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 17 Jul 2025 16:02:30=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--nOOLpbHW91g=--

