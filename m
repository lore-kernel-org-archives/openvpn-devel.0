From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 21 Jan 2026 14:22:32 +0000
In-Reply-To: <gerrit.1765571645000.Ib251d546d993b96ed3bd8cb9111bcc627cdb0fae@...2715...>
References: <gerrit.1765571645000.Ib251d546d993b96ed3bd8cb9111bcc627cdb0fae@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., steffan@...1856..., max@...2606...
Message-ID: <2fc30e2b1d0ccbd97b86114216cf99728f05b829-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7KPIHZt4L24="; charset=UTF-8
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Add support for
 Mbed TLS 4
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: MaxF <max@...2606...>
Cc: flichtenheld <frank@...2641...>, syzzer <steffan@...1856...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--7KPIHZt4L24=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, syzzer.

plaisthos has posted comments on this change by MaxF. ( http://gerrit.openv=
pn.net/c/openvpn/+/1441?usp=3Demail )

Change subject: Add support for Mbed TLS 4
......................................................................


Patch Set 5: Code-Review-1

(1 comment)

Patchset:

PS5:
There is something wrong with connecting to an OpenSSL based OpeNVPN, e.g. =
against community VPN:

sudo ./src/openvpn/openvpn --config ~/ovpn/confs/community.ovpn    --script=
-security 2

Password:
2026-01-21 15:21:34 DEPRECATED OPTION: --persist-key option ignored. Keys a=
re now always persisted across restarts.
2026-01-21 15:21:34 OpenVPN 2.7_rc5 [git:review/mbedtls4/2cc00e80bca26c1c+*=
] aarch64-apple-darwin25.2.0 [SSL (mbed TLS)] [LZO] [LZ4] [MH/RECVDA] [AEAD=
] built on Jan 21 2026
2026-01-21 15:21:34 library versions: mbed TLS 4.0.0, LZO 2.10
2026-01-21 15:21:34 TCP/UDP: Preserving recently used remote address: [AF_I=
NET]3.69.106.84:1194
2026-01-21 15:21:34 Socket Buffers: R=3D[786896->786896] S=3D[9216->9216]
2026-01-21 15:21:34 UDPv4 link local: (not bound)
2026-01-21 15:21:34 UDPv4 link remote: [AF_INET]3.69.106.84:1194
2026-01-21 15:21:34 TLS: Initial packet from [AF_INET]3.69.106.84:1194, sid=
=3D709f8846 9d2eb04d
2026-01-21 15:21:34 VERIFY OK: depth=3D1, C=3DUS, ST=3DCA, L=3DPleasanton, =
O=3Dopenvpn.net, OU=3DMy Organizational Unit, CN=3DChangeMe, emailAddress=
=3Dcommunity@...515...
2026-01-21 15:21:34 Validating certificate key usage
2026-01-21 15:21:34 VERIFY KU OK
2026-01-21 15:21:34 Validating certificate extended key usage
2026-01-21 15:21:34 ++ Certificate has EKU (str) TLS Web Server Authenticat=
ion, expects TLS Web Server Authentication
2026-01-21 15:21:34 NOTE: --mute triggered...
2026-01-21 15:21:34 2 variation(s) on previous 20 message(s) suppressed by =
--mute
2026-01-21 15:21:34 TLS_ERROR: read tls_read_plaintext error: SSL - * Recei=
ved NewSessionTicket Post Handshake Message. This error code is experimenta=
l and may be changed or removed without notice
2026-01-21 15:21:34 TLS Error: TLS object -> incoming plaintext read error
2026-01-21 15:21:34 TLS Error: TLS handshake failed



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1441?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib251d546d993b96ed3bd8cb9111bcc627cdb0fae
Gerrit-Change-Number: 1441
Gerrit-PatchSet: 5
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: syzzer <steffan@...1856...>
Gerrit-Attention: syzzer <steffan@...1856...>
Gerrit-Attention: MaxF <max@...2606...>
Gerrit-Comment-Date: Wed, 21 Jan 2026 14:22:32 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--7KPIHZt4L24=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, syzzer. </p>
<p>Patch set 5:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1441?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1441?tab=3Dcomments&amp;usp=3Demail">Patch Set #5:</a> </p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">There is so=
mething wrong with connecting to an OpenSSL based OpeNVPN, e.g. against com=
munity VPN:</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wra=
p: break-word;">sudo ./src/openvpn/openvpn --config ~/ovpn/confs/community.=
ovpn    --script-security 2</p><p class=3D"blocks" style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">Password:<br>2026-01-21 15:21:34 DEPRECATED=
 OPTION: --persist-key option ignored. Keys are now always persisted across=
 restarts. <br>2026-01-21 15:21:34 OpenVPN 2.7_rc5 [git:review/mbedtls4/2cc=
00e80bca26c1c+*] aarch64-apple-darwin25.2.0 [SSL (mbed TLS)] [LZO] [LZ4] [M=
H/RECVDA] [AEAD] built on Jan 21 2026<br>2026-01-21 15:21:34 library versio=
ns: mbed TLS 4.0.0, LZO 2.10<br>2026-01-21 15:21:34 TCP/UDP: Preserving rec=
ently used remote address: [AF_INET]3.69.106.84:1194<br>2026-01-21 15:21:34=
 Socket Buffers: R=3D[786896-&gt;786896] S=3D[9216-&gt;9216]<br>2026-01-21 =
15:21:34 UDPv4 link local: (not bound)<br>2026-01-21 15:21:34 UDPv4 link re=
mote: [AF_INET]3.69.106.84:1194<br>2026-01-21 15:21:34 TLS: Initial packet =
from [AF_INET]3.69.106.84:1194, sid=3D709f8846 9d2eb04d<br>2026-01-21 15:21=
:34 VERIFY OK: depth=3D1, C=3DUS, ST=3DCA, L=3DPleasanton, O=3Dopenvpn.net,=
 OU=3DMy Organizational Unit, CN=3DChangeMe, emailAddress=3Dcommunity@...1387...=
5...<br>2026-01-21 15:21:34 Validating certificate key usage<br>2026-01-21 =
15:21:34 VERIFY KU OK<br>2026-01-21 15:21:34 Validating certificate extende=
d key usage<br>2026-01-21 15:21:34 ++ Certificate has EKU (str) TLS Web Ser=
ver Authentication, expects TLS Web Server Authentication<br>2026-01-21 15:=
21:34 NOTE: --mute triggered...<br>2026-01-21 15:21:34 2 variation(s) on pr=
evious 20 message(s) suppressed by --mute<br>2026-01-21 15:21:34 TLS_ERROR:=
 read tls_read_plaintext error: SSL - * Received NewSessionTicket Post Hand=
shake Message. This error code is experimental and may be changed or remove=
d without notice<br>2026-01-21 15:21:34 TLS Error: TLS object -&gt; incomin=
g plaintext read error<br>2026-01-21 15:21:34 TLS Error: TLS handshake fail=
ed</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1441?usp=3Demail">change 1441</a>. To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/sett=
ings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema=
.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sc=
hema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/1441?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib251d546d993b96ed3bd8cb9111=
bcc627cdb0fae </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1441 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: syzzer &lt;steffan@...1856...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: syzzer &lt;steffan@...2115...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@...2606...&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 21 Jan 2026 14:22:32=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--7KPIHZt4L24=--

