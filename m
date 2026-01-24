From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 24 Jan 2026 18:21:35 +0000
In-Reply-To: <gerrit.1769015758000.Iff1343a2f8cc7e32b8f36b359a00248e4dc3e8c9@...2715...>
References: <gerrit.1769015758000.Iff1343a2f8cc7e32b8f36b359a00248e4dc3e8c9@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <48aa363ffa2c78cfa3698ecf3d382115a86f87d2-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RGdtVD2ELXA="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: status: Avoid
 conversion warnings in status_read/status_printf
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--RGdtVD2ELXA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

cron2 has posted comments on this change by flichtenheld. ( http://gerrit.o=
penvpn.net/c/openvpn/+/1485?usp=3Demail )

Change subject: status: Avoid conversion warnings in status_read/status_pri=
ntf
......................................................................


Patch Set 2: Code-Review-1

(1 comment)

File src/openvpn/status.c:

http://gerrit.openvpn.net/c/openvpn/+/1485/comment/d724e493_5742107d?usp=3D=
email :
PS2, Line 241:                 if (write(so->fd, buf, (unsigned int)len) !=
=3D len)
this change confuses me.  In my manpage, `write()` wants a `size_t count` (=
linux) or `size_t nbytes` (FreeBSD), and so `size_t len` should be perfectl=
y fine.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1485?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iff1343a2f8cc7e32b8f36b359a00248e4dc3e8c9
Gerrit-Change-Number: 1485
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Sat, 24 Jan 2026 18:21:35 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--RGdtVD2ELXA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1485?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/status.c:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1485/comment/d724e493_5742107d?usp=3Demail">Patch Set =
#2, Line 241:</a> <code style=3D"font-family:monospace,monospace">         =
       if (write(so-&gt;fd, buf, (unsigned int)len) !=3D len)</code></p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">th=
is change confuses me.  In my manpage, `write()` wants a `size_t count` (li=
nux) or `size_t nbytes` (FreeBSD), and so `size_t len` should be perfectly =
fine.</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1485?usp=3Demail">change 1485</a>. To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/s=
ettings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://sch=
ema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1485?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vie=
w Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iff1343a2f8cc7e32b8f36b359a0=
0248e4dc3e8c9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1485 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 24 Jan 2026 18:21:35=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--RGdtVD2ELXA=--

