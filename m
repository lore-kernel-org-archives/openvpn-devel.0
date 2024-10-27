From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 27 Oct 2024 09:41:32 +0000
In-Reply-To: <gerrit.1729867531000.I60f02c919767eb8f1b95253689a8233f5f68621d@...2715...>
References: <gerrit.1729867531000.I60f02c919767eb8f1b95253689a8233f5f68621d@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <2e0fdb79af56cbe699cb4ff88665df94ad459b1e-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qw0pqtVFImc="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Refuse clients if
 username or password is > USER_PASS_LEN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--qw0pqtVFImc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/787?usp=3Demail )

Change subject: Refuse clients if username or password is > USER_PASS_LEN
......................................................................


Patch Set 1: Code-Review-1

(1 comment)

Patchset:

PS1:
Okay, my client was not compiled the way I thought - so with --enable-pkcs1=
1, sending a long username to an unmodified server yields

```
Oct 27 10:30:59 gentoo tun-udp-p2mp-global-authpam[14201]: 194.97.140.21:36=
736 TLS Error: Auth Username/Password was not provided by peer
Oct 27 10:30:59 gentoo tun-udp-p2mp-global-authpam[14201]: 194.97.140.21:36=
736 TLS Error: TLS handshake failed
``

and with the patch it does a proper

```
Oct 27 10:34:48 gentoo tun-udp-p2mp-global-authpam[15712]: 194.97.140.21:60=
127 TLS INFO: Username (-230) or password (14)  long
...
Oct 27 10:34:48 gentoo tun-udp-p2mp-global-authpam[15712]: 194.97.140.21:60=
127 TLS Error: Username (230) or password (14) too long
```

and the client receives

```
2024-10-27 10:34:48 AUTH: Received control message: AUTH_FAILED,Username or=
 password is too long. Maximum length is 128 bytes
```

(the "-" 230 is my doing, I removed the abs() call to more clearly see what=
 is being returned).

Upgrading the patch to "-1" ;-) - I think the "TLS INFO:" line clould eithe=
r be removed (because it's duplicating the TLS Error: message later) or the=
 `abs()` should go, and the double space before `  long`)



--=20
To view, visit http://gerrit.openvpn.net/c/openvpn/+/787?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I60f02c919767eb8f1b95253689a8233f5f68621d
Gerrit-Change-Number: 787
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Sun, 27 Oct 2024 09:41:32 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--qw0pqtVFImc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/787?usp=3Demail">Vi=
ew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/787?tab=3Dcomments">Patch Set #1:</a> </p><p style=3D"white-space: pre-w=
rap; word-wrap: break-word;">Okay, my client was not compiled the way I tho=
ught - so with --enable-pkcs11, sending a long username to an unmodified se=
rver yields</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">`=
``<br>Oct 27 10:30:59 gentoo tun-udp-p2mp-global-authpam[14201]: 194.97.140=
.21:36736 TLS Error: Auth Username/Password was not provided by peer<br>Oct=
 27 10:30:59 gentoo tun-udp-p2mp-global-authpam[14201]: 194.97.140.21:36736=
 TLS Error: TLS handshake failed<br>``</p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">and with the patch it does a proper</p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">```<br>Oct 27 10:34:48 g=
entoo tun-udp-p2mp-global-authpam[15712]: 194.97.140.21:60127 TLS INFO: Use=
rname (-230) or password (14)  long<br>...<br>Oct 27 10:34:48 gentoo tun-ud=
p-p2mp-global-authpam[15712]: 194.97.140.21:60127 TLS Error: Username (230)=
 or password (14) too long<br>```</p><p style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">and the client receives</p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">```<br>2024-10-27 10:34:48 AUTH: Received c=
ontrol message: AUTH_FAILED,Username or password is too long. Maximum lengt=
h is 128 bytes<br>```</p><p style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">(the &quot;-&quot; 230 is my doing, I removed the abs() call to mo=
re clearly see what is being returned).</p><p style=3D"white-space: pre-wra=
p; word-wrap: break-word;">Upgrading the patch to &quot;-1&quot; ;-) - I th=
ink the &quot;TLS INFO:&quot; line clould either be removed (because it&#39=
;s duplicating the TLS Error: message later) or the `abs()` should go, and =
the double space before `  long`)</p></li></ul></li></ul><p>To view, visit =
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/787?usp=3Demail">change 78=
7</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"h=
ttp://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/787?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I60f02c919767eb8f1b95253689a=
8233f5f68621d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 787 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 27 Oct 2024 09:41:32=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--qw0pqtVFImc=--

