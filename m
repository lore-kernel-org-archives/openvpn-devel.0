From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 17 Jul 2025 15:54:28 +0000
In-Reply-To: <gerrit.1752486326000.I33e9272b4196c7634db2fb33a75ae4261660867f@...2715...>
References: <gerrit.1752486326000.I33e9272b4196c7634db2fb33a75ae4261660867f@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, ralf@...2726..., frank@...2641...,
 lstipakov@...277..., antonio@...2726...
Message-ID: <ba9719e25d218933396b9e4cea265ac714091f19-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RfRdt1YZEZg="; charset=UTF-8
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

--RfRdt1YZEZg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici, s=
tipa.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/1084?usp=3Demail )

Change subject: dco: Add support for float notifications
......................................................................


Patch Set 3: Code-Review-1

(1 comment)

Patchset:

PS3:
*b00m*

so this is the testbed: ununtu 20.04 server with backported float notificat=
ion patch, commit 31aedd7fb plus this patch.

one server instance, with 2 UDP sockets (one udp6/dual-stack, one udp4 only=
).  Client connecting to the UDP4 socket (so v6 mapped is not relevant).

Server has --reneg-sec 60, and in between renegotiations the client is made=
 to roam between LAN and WiFi (by unplugging and replugging the LAN cable).=
  It floats quite happily, and then explodes - it's something with timing, =
float, and server-triggered renegotiation, though I do not really know what=
 sequence of things I need.  `peer-id 2` is the floating client, `peer-id 1=
` is just sticking around.

```
2025-07-17 17:45:32 us=3D32787 freebsd-74-amd64/udp6:194.97.140.3:61704 pee=
r-id=3D1 Control Channel: TLSv1.2, cipher TLS-ECDHE-RSA-WITH-AES-256-GCM-SH=
A384, 2048 bit key
2025-07-17 17:45:32 us=3D32932 freebsd-74-amd64/udp6:194.97.140.3:61704 pee=
r-id=3D1 dco_install_key: peer_id=3D1 keyid=3D6, currently 1 keys installed
2025-07-17 17:45:32 us=3D32963 freebsd-74-amd64/udp6:194.97.140.3:61704 pee=
r-id=3D1 dco_new_key: slot 1, key-id 6, peer-id 1, cipher AES-256-GCM
2025-07-17 17:45:32 us=3D658862 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
63385 peer-id=3D2 Swapping primary and secondary keys to primary-id=3D6 sec=
ondary-id=3D5
2025-07-17 17:45:32 us=3D658933 cron2-freebsd-tc-amd64/udp4:193.149.48.172:=
63385 peer-id=3D2 dco_swap_keys: peer-id 2
2025-07-17 17:45:59 us=3D350653 dco_do_read
2025-07-17 17:45:59 us=3D350790 ovpn-dco: received CMD_PEER_FLOAT_NTF, ifin=
dex: 5501, peer-id 2, address: [AF_INET]193.149.48.173:63385
2025-07-17 17:45:59 us=3D350937 peer 2 (cron2-freebsd-tc-amd64) floated fro=
m udp4:193.149.48.172:63385 to [AF_INET6]::ffff:193.149.48.173:63385 (via :=
:ffff:195.30.8.84%ens160)
2025-07-17 17:46:02 us=3D32434 cron2-freebsd-tc-amd64/udp6:193.149.48.173:6=
3385 peer-id=3D2 TLS: soft reset sec=3D60/59 bytes=3D0/-1 pkts=3D0/0 aead_l=
imit_send=3D0/60129542137 aead_limit_recv=3D0/60129542137
2025-07-17 17:46:02 us=3D32639 cron2-freebsd-tc-amd64/udp6:193.149.48.173:6=
3385 peer-id=3D2 dco_del_key: peer-id 2, slot 1
2025-07-17 17:46:02 us=3D32911 cron2-freebsd-tc-amd64/udp6:193.149.48.173:6=
3385 peer-id=3D2 UDPv4 WRITE [54] to [AF_INET6]::ffff:193.149.48.173:63385 =
(via ::ffff:195.30.8.84%ens160): P_CONTROL_SOFT_RESET_V1 kid=3D7 [ ] pid=3D=
12648 DATA len=3D40
2025-07-17 17:46:02 us=3D32981 cron2-freebsd-tc-amd64/udp6:193.149.48.173:6=
3385 peer-id=3D2 write UDPv4 []: Address family not supported by protocol (=
fd=3D7,code=3D97)
2025-07-17 17:46:02 us=3D352420 dco_do_read
2025-07-17 17:46:02 us=3D352549 ovpn-dco: received CMD_PEER_FLOAT_NTF, ifin=
dex: 5501, peer-id 2, address: [AF_INET]193.149.48.172:63385
2025-07-17 17:46:02 us=3D352705 peer 2 (cron2-freebsd-tc-amd64) floated fro=
m udp6:193.149.48.173:63385 to [AF_INET6]::ffff:193.149.48.172:63385 (via :=
:ffff:195.30.8.84%ens160)
2025-07-17 17:46:02 us=3D529069 freebsd-74-amd64/udp6:194.97.140.3:61704 pe=
er-id=3D1 Swapping primary and secondary keys to primary-id=3D6 secondary-i=
d=3D5
2025-07-17 17:46:02 us=3D529153 freebsd-74-amd64/udp6:194.97.140.3:61704 pe=
er-id=3D1 dco_swap_keys: peer-id 1
2025-07-17 17:46:04 us=3D286241 cron2-freebsd-tc-amd64/udp6:193.149.48.172:=
63385 peer-id=3D2 UDPv4 WRITE [54] to [AF_INET6]::ffff:193.149.48.172:63385=
 (via ::ffff:195.30.8.84%ens160): P_CONTROL_SOFT_RESET_V1 kid=3D7 [ ] pid=
=3D12904 DATA len=3D40
2025-07-17 17:46:04 us=3D286325 cron2-freebsd-tc-amd64/udp6:193.149.48.172:=
63385 peer-id=3D2 write UDPv4 []: Address family not supported by protocol =
(fd=3D7,code=3D97)
2025-07-17 17:46:05 us=3D364294 dco_get_peer_stats_multi
2025-07-17 17:46:05 us=3D364768 dco_parse_peer_multi: parsing message...
2025-07-17 17:46:05 us=3D364822 dco_update_peer_stat: no link RX bytes prov=
ided in reply for peer 2
2025-07-17 17:46:05 us=3D364854 dco_update_peer_stat: no link TX bytes prov=
ided in reply for peer 2
2025-07-17 17:46:05 us=3D364913 dco_update_peer_stat: no VPN RX bytes provi=
ded in reply for peer 2
2025-07-17 17:46:05 us=3D364931 dco_update_peer_stat: no VPN TX bytes provi=
ded in reply for peer 2
2025-07-17 17:46:05 us=3D364994 dco_parse_peer_multi: parsing message...
2025-07-17 17:46:05 us=3D365028 dco_update_peer_stat / dco_read_bytes: 1648
2025-07-17 17:46:05 us=3D365057 dco_update_peer_stat / dco_write_bytes: 1440
2025-07-17 17:46:05 us=3D365103 dco_update_peer_stat / tun_read_bytes: 0
2025-07-17 17:46:05 us=3D365129 dco_update_peer_stat / tun_write_bytes: 0
2025-07-17 17:46:05 us=3D365145 dco_parse_peer_multi: parsing message...
2025-07-17 17:46:05 us=3D365180 dco_update_peer_stat / dco_read_bytes: 53648
2025-07-17 17:46:05 us=3D365208 dco_update_peer_stat / dco_write_bytes: 532=
48
2025-07-17 17:46:05 us=3D365269 dco_update_peer_stat / tun_read_bytes: 43264
2025-07-17 17:46:05 us=3D365304 dco_update_peer_stat / tun_write_bytes: 432=
64
2025-07-17 17:46:05 us=3D366195 dco_do_read
2025-07-17 17:46:05 us=3D366301 dco_do_read: netlink reports error (-4): Tr=
y again
2025-07-17 17:46:08 us=3D370284 dco_do_read
2025-07-17 17:46:08 us=3D370355 ovpn-dco: received CMD_PEER_FLOAT_NTF, ifin=
dex: 5501, peer-id 2, address: [AF_INET]193.149.48.172:63385
2025-07-17 17:46:08 us=3D370416 closing instance cron2-freebsd-tc-amd64/udp=
6:193.149.48.172:63385 peer-id=3D2
2025-07-17 17:46:08 us=3D370469 dco_get_peer_stats_multi
2025-07-17 17:46:08 us=3D370666 dco_parse_peer_multi: parsing message...
2025-07-17 17:46:08 us=3D370811 dco_update_peer_stat / dco_read_bytes: 1648
2025-07-17 17:46:08 us=3D370856 dco_update_peer_stat / dco_write_bytes: 1440
2025-07-17 17:46:08 us=3D370887 dco_update_peer_stat / tun_read_bytes: 0
2025-07-17 17:46:08 us=3D370918 dco_update_peer_stat / tun_write_bytes: 0
2025-07-17 17:46:08 us=3D371212 dco_parse_peer_multi: parsing message...
2025-07-17 17:46:08 us=3D371249 dco_parse_peer_multi: cannot store DCO stat=
s for peer 2
2025-07-17 17:46:08 us=3D371410 register signal: SIGTERM (close_context)
2025-07-17 17:46:08 us=3D371534 dco_del_peer: peer-id 2
```

(why does it want to close peer 2?  so something went fishy already at this=
 point)

```
Program received signal SIGSEGV, Segmentation fault.
0x00005555555989b3 in multi_process_float (m=3Dm@...1851...=3D0x7fffffffbb9=
0, mi=3Dmi@...1851...=3D0x555555772a70,
    sock=3D0x5555556c7a20) at multi.c:3258
3258        msg(D_MULTI_MEDIUM, "peer %" PRIu32 " (%s) floated from %s to %=
s",
(gdb) where
#0  0x00005555555989b3 in multi_process_float (m=3Dm@...1851...=3D0x7ffffff=
fbb90, mi=3Dmi@...1851...=3D0x555555772a70,
    sock=3D0x5555556c7a20) at multi.c:3258
#1  0x0000555555598f53 in multi_process_incoming_dco (m=3Dm@...1851...=3D0x=
7fffffffbb90) at multi.c:3393
#2  0x000055555559d7e0 in multi_io_process_io (m=3Dm@...1851...=3D0x7ffffff=
fbb90) at multi_io.c:534
#3  0x000055555559c740 in tunnel_server_loop (multi=3D0x7fffffffbb90) at mu=
lti.c:4287
#4  tunnel_server (top=3D0x7fffffffd0c0) at multi.c:4339
#5  0x00005555555a1f29 in openvpn_main (argc=3D5, argv=3D0x7fffffffe598) at=
 openvpn.c:318
#6  0x00007ffff7d72083 in __libc_start_main (main=3D0x55555555fb70 <main>, =
argc=3D5, argv=3D0x7fffffffe598,
    init=3D<optimized out>, fini=3D<optimized out>, rtld_fini=3D<optimized =
out>, stack_end=3D0x7fffffffe588)
    at ../csu/libc-start.c:308
#7  0x000055555555fbae in _start () at openvpn.c:395
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

the kernel log around that time says

```
Jul 17 17:46:01 ubuntu2004 kernel: [3570425.002983] tun7: peer 2 floated to=
 193.149.48.173:63385
Jul 17 17:46:01 ubuntu2004 kernel: [3570426.825096] tun7: sending keepalive=
 to peer 1
Jul 17 17:46:01 ubuntu2004 kernel: [3570426.825119] tun7: scheduling keepal=
ive work: now=3D1752767170 next_run=3D1752767161 delta=3D9
Jul 17 17:46:02 ubuntu2004 kernel: [3570427.685495] deleting key slot 1, ke=
y_id=3D5
Jul 17 17:46:02 ubuntu2004 kernel: [3570428.004618] tun7: peer 2 floated to=
 193.149.48.172:63385
Jul 17 17:46:02 ubuntu2004 kernel: [3570428.182001] key swapped: (old prima=
ry) 5 <-> (new primary) 6
Jul 17 17:46:03 ubuntu2004 kernel: [3570429.235584] tun7: ping received fro=
m peer 1
Jul 17 17:46:08 ubuntu2004 kernel: [3570431.015784] tun7: peer 2 floated to=
 193.149.48.173:63385
Jul 17 17:46:08 ubuntu2004 kernel: [3570434.022364] tun7: peer 2 floated to=
 193.149.48.172:63385
Jul 17 17:46:08 ubuntu2004 kernel: [3570434.024151] tun7: del peer 2
Jul 17 17:46:08 ubuntu2004 kernel: [3570434.024169] tun7: deleting peer wit=
h id 2, reason 1
Jul 17 17:46:10 ubuntu2004 kernel: [3570436.040898] tun7: scheduling keepal=
ive work: now=3D1752767171 next_run=3D1752767170 delta=3D1
Jul 17 17:46:11 ubuntu2004 kernel: [3570437.064852] tun7: sending keepalive=
 to peer 1
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
Gerrit-Comment-Date: Thu, 17 Jul 2025 15:54:28 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--RfRdt1YZEZg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos, ralf_lic=
i, stipa. </p>
<p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1084?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1084?tab=3Dcomments">Patch Set #3:</a> </p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">*b00m*</p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">so this is the testbed: ununtu 20.04 server with b=
ackported float notification patch, commit 31aedd7fb plus this patch.</p><p=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">one server instanc=
e, with 2 UDP sockets (one udp6/dual-stack, one udp4 only).  Client connect=
ing to the UDP4 socket (so v6 mapped is not relevant).</p><p style=3D"white=
-space: pre-wrap; word-wrap: break-word;">Server has --reneg-sec 60, and in=
 between renegotiations the client is made to roam between LAN and WiFi (by=
 unplugging and replugging the LAN cable).  It floats quite happily, and th=
en explodes - it&#39;s something with timing, float, and server-triggered r=
enegotiation, though I do not really know what sequence of things I need.  =
`peer-id 2` is the floating client, `peer-id 1` is just sticking around.</p=
><p style=3D"white-space: pre-wrap; word-wrap: break-word;">```<br>2025-07-=
17 17:45:32 us=3D32787 freebsd-74-amd64/udp6:194.97.140.3:61704 peer-id=3D1=
 Control Channel: TLSv1.2, cipher TLS-ECDHE-RSA-WITH-AES-256-GCM-SHA384, 20=
48 bit key<br>2025-07-17 17:45:32 us=3D32932 freebsd-74-amd64/udp6:194.97.1=
40.3:61704 peer-id=3D1 dco_install_key: peer_id=3D1 keyid=3D6, currently 1 =
keys installed<br>2025-07-17 17:45:32 us=3D32963 freebsd-74-amd64/udp6:194.=
97.140.3:61704 peer-id=3D1 dco_new_key: slot 1, key-id 6, peer-id 1, cipher=
 AES-256-GCM<br>2025-07-17 17:45:32 us=3D658862 cron2-freebsd-tc-amd64/udp4=
:193.149.48.172:63385 peer-id=3D2 Swapping primary and secondary keys to pr=
imary-id=3D6 secondary-id=3D5<br>2025-07-17 17:45:32 us=3D658933 cron2-free=
bsd-tc-amd64/udp4:193.149.48.172:63385 peer-id=3D2 dco_swap_keys: peer-id 2=
<br>2025-07-17 17:45:59 us=3D350653 dco_do_read<br>2025-07-17 17:45:59 us=
=3D350790 ovpn-dco: received CMD_PEER_FLOAT_NTF, ifindex: 5501, peer-id 2, =
address: [AF_INET]193.149.48.173:63385<br>2025-07-17 17:45:59 us=3D350937 p=
eer 2 (cron2-freebsd-tc-amd64) floated from udp4:193.149.48.172:63385 to [A=
F_INET6]::ffff:193.149.48.173:63385 (via ::ffff:195.30.8.84%ens160)<br>2025=
-07-17 17:46:02 us=3D32434 cron2-freebsd-tc-amd64/udp6:193.149.48.173:63385=
 peer-id=3D2 TLS: soft reset sec=3D60/59 bytes=3D0/-1 pkts=3D0/0 aead_limit=
_send=3D0/60129542137 aead_limit_recv=3D0/60129542137<br>2025-07-17 17:46:0=
2 us=3D32639 cron2-freebsd-tc-amd64/udp6:193.149.48.173:63385 peer-id=3D2 d=
co_del_key: peer-id 2, slot 1<br>2025-07-17 17:46:02 us=3D32911 cron2-freeb=
sd-tc-amd64/udp6:193.149.48.173:63385 peer-id=3D2 UDPv4 WRITE [54] to [AF_I=
NET6]::ffff:193.149.48.173:63385 (via ::ffff:195.30.8.84%ens160): P_CONTROL=
_SOFT_RESET_V1 kid=3D7 [ ] pid=3D12648 DATA len=3D40<br>2025-07-17 17:46:02=
 us=3D32981 cron2-freebsd-tc-amd64/udp6:193.149.48.173:63385 peer-id=3D2 wr=
ite UDPv4 []: Address family not supported by protocol (fd=3D7,code=3D97)<b=
r>2025-07-17 17:46:02 us=3D352420 dco_do_read<br>2025-07-17 17:46:02 us=3D3=
52549 ovpn-dco: received CMD_PEER_FLOAT_NTF, ifindex: 5501, peer-id 2, addr=
ess: [AF_INET]193.149.48.172:63385<br>2025-07-17 17:46:02 us=3D352705 peer =
2 (cron2-freebsd-tc-amd64) floated from udp6:193.149.48.173:63385 to [AF_IN=
ET6]::ffff:193.149.48.172:63385 (via ::ffff:195.30.8.84%ens160)<br>2025-07-=
17 17:46:02 us=3D529069 freebsd-74-amd64/udp6:194.97.140.3:61704 peer-id=3D=
1 Swapping primary and secondary keys to primary-id=3D6 secondary-id=3D5<br=
>2025-07-17 17:46:02 us=3D529153 freebsd-74-amd64/udp6:194.97.140.3:61704 p=
eer-id=3D1 dco_swap_keys: peer-id 1<br>2025-07-17 17:46:04 us=3D286241 cron=
2-freebsd-tc-amd64/udp6:193.149.48.172:63385 peer-id=3D2 UDPv4 WRITE [54] t=
o [AF_INET6]::ffff:193.149.48.172:63385 (via ::ffff:195.30.8.84%ens160): P_=
CONTROL_SOFT_RESET_V1 kid=3D7 [ ] pid=3D12904 DATA len=3D40<br>2025-07-17 1=
7:46:04 us=3D286325 cron2-freebsd-tc-amd64/udp6:193.149.48.172:63385 peer-i=
d=3D2 write UDPv4 []: Address family not supported by protocol (fd=3D7,code=
=3D97)<br>2025-07-17 17:46:05 us=3D364294 dco_get_peer_stats_multi<br>2025-=
07-17 17:46:05 us=3D364768 dco_parse_peer_multi: parsing message...<br>2025=
-07-17 17:46:05 us=3D364822 dco_update_peer_stat: no link RX bytes provided=
 in reply for peer 2<br>2025-07-17 17:46:05 us=3D364854 dco_update_peer_sta=
t: no link TX bytes provided in reply for peer 2<br>2025-07-17 17:46:05 us=
=3D364913 dco_update_peer_stat: no VPN RX bytes provided in reply for peer =
2<br>2025-07-17 17:46:05 us=3D364931 dco_update_peer_stat: no VPN TX bytes =
provided in reply for peer 2<br>2025-07-17 17:46:05 us=3D364994 dco_parse_p=
eer_multi: parsing message...<br>2025-07-17 17:46:05 us=3D365028 dco_update=
_peer_stat / dco_read_bytes: 1648<br>2025-07-17 17:46:05 us=3D365057 dco_up=
date_peer_stat / dco_write_bytes: 1440<br>2025-07-17 17:46:05 us=3D365103 d=
co_update_peer_stat / tun_read_bytes: 0<br>2025-07-17 17:46:05 us=3D365129 =
dco_update_peer_stat / tun_write_bytes: 0<br>2025-07-17 17:46:05 us=3D36514=
5 dco_parse_peer_multi: parsing message...<br>2025-07-17 17:46:05 us=3D3651=
80 dco_update_peer_stat / dco_read_bytes: 53648<br>2025-07-17 17:46:05 us=
=3D365208 dco_update_peer_stat / dco_write_bytes: 53248<br>2025-07-17 17:46=
:05 us=3D365269 dco_update_peer_stat / tun_read_bytes: 43264<br>2025-07-17 =
17:46:05 us=3D365304 dco_update_peer_stat / tun_write_bytes: 43264<br>2025-=
07-17 17:46:05 us=3D366195 dco_do_read<br>2025-07-17 17:46:05 us=3D366301 d=
co_do_read: netlink reports error (-4): Try again<br>2025-07-17 17:46:08 us=
=3D370284 dco_do_read<br>2025-07-17 17:46:08 us=3D370355 ovpn-dco: received=
 CMD_PEER_FLOAT_NTF, ifindex: 5501, peer-id 2, address: [AF_INET]193.149.48=
.172:63385<br>2025-07-17 17:46:08 us=3D370416 closing instance cron2-freebs=
d-tc-amd64/udp6:193.149.48.172:63385 peer-id=3D2<br>2025-07-17 17:46:08 us=
=3D370469 dco_get_peer_stats_multi<br>2025-07-17 17:46:08 us=3D370666 dco_p=
arse_peer_multi: parsing message...<br>2025-07-17 17:46:08 us=3D370811 dco_=
update_peer_stat / dco_read_bytes: 1648<br>2025-07-17 17:46:08 us=3D370856 =
dco_update_peer_stat / dco_write_bytes: 1440<br>2025-07-17 17:46:08 us=3D37=
0887 dco_update_peer_stat / tun_read_bytes: 0<br>2025-07-17 17:46:08 us=3D3=
70918 dco_update_peer_stat / tun_write_bytes: 0<br>2025-07-17 17:46:08 us=
=3D371212 dco_parse_peer_multi: parsing message...<br>2025-07-17 17:46:08 u=
s=3D371249 dco_parse_peer_multi: cannot store DCO stats for peer 2<br>2025-=
07-17 17:46:08 us=3D371410 register signal: SIGTERM (close_context)<br>2025=
-07-17 17:46:08 us=3D371534 dco_del_peer: peer-id 2<br>```</p><p style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">(why does it want to close pe=
er 2?  so something went fishy already at this point)</p><pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">```<br>Program receiv=
ed signal SIGSEGV, Segmentation fault.<br>0x00005555555989b3 in multi_proce=
ss_float (m=3Dm@...1851...=3D0x7fffffffbb90, mi=3Dmi@...1851...=3D0x5555557=
72a70, <br>    sock=3D0x5555556c7a20) at multi.c:3258<br>3258        msg(D_=
MULTI_MEDIUM, &quot;peer %&quot; PRIu32 &quot; (%s) floated from %s to %s&q=
uot;,<br>(gdb) where<br>#0  0x00005555555989b3 in multi_process_float (m=3D=
m@...1851...=3D0x7fffffffbb90, mi=3Dmi@...1851...=3D0x555555772a70, <br>   =
 sock=3D0x5555556c7a20) at multi.c:3258<br>#1  0x0000555555598f53 in multi_=
process_incoming_dco (m=3Dm@...1851...=3D0x7fffffffbb90) at multi.c:3393<br=
>#2  0x000055555559d7e0 in multi_io_process_io (m=3Dm@...1851...=3D0x7fffff=
ffbb90) at multi_io.c:534<br>#3  0x000055555559c740 in tunnel_server_loop (=
multi=3D0x7fffffffbb90) at multi.c:4287<br>#4  tunnel_server (top=3D0x7ffff=
fffd0c0) at multi.c:4339<br>#5  0x00005555555a1f29 in openvpn_main (argc=3D=
5, argv=3D0x7fffffffe598) at openvpn.c:318<br>#6  0x00007ffff7d72083 in __l=
ibc_start_main (main=3D0x55555555fb70 &lt;main&gt;, argc=3D5, argv=3D0x7fff=
ffffe598, <br>    init=3D&lt;optimized out&gt;, fini=3D&lt;optimized out&gt=
;, rtld_fini=3D&lt;optimized out&gt;, stack_end=3D0x7fffffffe588)<br>    at=
 ../csu/libc-start.c:308<br>#7  0x000055555555fbae in _start () at openvpn.=
c:395<br>(gdb) list<br>3253<br>3254            msg(D_MULTI_MEDIUM, &quot;cl=
osing instance %s&quot;, multi_instance_string(ex_mi, false, &amp;gc));<br>=
3255            multi_close_instance(m, ex_mi, false);<br>3256        }<br>=
3257<br>3258        msg(D_MULTI_MEDIUM, &quot;peer %&quot; PRIu32 &quot; (%=
s) floated from %s to %s&quot;,<br>3259            mi-&gt;context.c2.tls_mu=
lti-&gt;peer_id,<br>3260            tls_common_name(mi-&gt;context.c2.tls_m=
ulti, false),<br>3261            mroute_addr_print(&amp;mi-&gt;real, &amp;g=
c),<br>3262            print_link_socket_actual(&amp;m-&gt;top.c2.from, &am=
p;gc));<br>(gdb) print mi-&gt;context.c2.tls_multi<br>$1 =3D (struct tls_mu=
lti *) 0x0<br>```</pre><p style=3D"white-space: pre-wrap; word-wrap: break-=
word;">the kernel log around that time says</p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">```<br>Jul 17 17:46:01 ubuntu2004 kernel: [3=
570425.002983] tun7: peer 2 floated to 193.149.48.173:63385<br>Jul 17 17:46=
:01 ubuntu2004 kernel: [3570426.825096] tun7: sending keepalive to peer 1<b=
r>Jul 17 17:46:01 ubuntu2004 kernel: [3570426.825119] tun7: scheduling keep=
alive work: now=3D1752767170 next_run=3D1752767161 delta=3D9<br>Jul 17 17:4=
6:02 ubuntu2004 kernel: [3570427.685495] deleting key slot 1, key_id=3D5<br=
>Jul 17 17:46:02 ubuntu2004 kernel: [3570428.004618] tun7: peer 2 floated t=
o 193.149.48.172:63385<br>Jul 17 17:46:02 ubuntu2004 kernel: [3570428.18200=
1] key swapped: (old primary) 5 &lt;-&gt; (new primary) 6<br>Jul 17 17:46:0=
3 ubuntu2004 kernel: [3570429.235584] tun7: ping received from peer 1<br>Ju=
l 17 17:46:08 ubuntu2004 kernel: [3570431.015784] tun7: peer 2 floated to 1=
93.149.48.173:63385<br>Jul 17 17:46:08 ubuntu2004 kernel: [3570434.022364] =
tun7: peer 2 floated to 193.149.48.172:63385<br>Jul 17 17:46:08 ubuntu2004 =
kernel: [3570434.024151] tun7: del peer 2<br>Jul 17 17:46:08 ubuntu2004 ker=
nel: [3570434.024169] tun7: deleting peer with id 2, reason 1<br>Jul 17 17:=
46:10 ubuntu2004 kernel: [3570436.040898] tun7: scheduling keepalive work: =
now=3D1752767171 next_run=3D1752767170 delta=3D1<br>Jul 17 17:46:11 ubuntu2=
004 kernel: [3570437.064852] tun7: sending keepalive to peer 1<br>```</p></=
li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/1084?usp=3Demail">change 1084</a>. To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">se=
ttings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1084?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 17 Jul 2025 15:54:28=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--RfRdt1YZEZg=--

