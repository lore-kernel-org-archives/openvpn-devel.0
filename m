From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 19 Jan 2026 14:11:45 +0000
In-Reply-To: <gerrit.1768830991000.Ifd3e953104a67c8bf2a225e179865e3dbd0dbfbc@...2715...>
References: <gerrit.1768830991000.Ifd3e953104a67c8bf2a225e179865e3dbd0dbfbc@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <c1780141b33f159941e65dca9f08c16b0d945f99-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3rDZPFZ3txM="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix rare crash when
 read buffer are not initialised and read is still...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--3rDZPFZ3txM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change by plaisthos. ( http://gerr=
it.openvpn.net/c/openvpn/+/1477?usp=3Demail )

Change subject: Fix rare crash when read buffer are not initialised and rea=
d is still signalled
......................................................................


Patch Set 1: Code-Review-2

(3 comments)

Patchset:

PS1:
t_client TCP tests fail across many platforms with this change


Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/1477/comment/1fc8d999_ff64750f?usp=3D=
email :
PS1, Line 26: The client side must be on Linux. Other platform do not repro=
duce this
"platforms"


http://gerrit.openvpn.net/c/openvpn/+/1477/comment/d0a1f917_c009ea97?usp=3D=
email :
PS1, Line 49: So the link_socket_read_tcp will run into the assert.
Superfluous "the" before "link_socket_read_tcp"



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1477?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifd3e953104a67c8bf2a225e179865e3dbd0dbfbc
Gerrit-Change-Number: 1477
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Mon, 19 Jan 2026 14:11:45 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--3rDZPFZ3txM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1477?usp=3Demail">V=
iew Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1477?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">t_client T=
CP tests fail across many platforms with this change</p></li></ul></li><li =
style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-st=
yle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/1477/comment/1fc8d999_ff64750f?usp=3Demail">Patch Set #1, Line 26:</a> <c=
ode style=3D"font-family:monospace,monospace">The client side must be on Li=
nux. Other platform do not reproduce this</code></p><p class=3D"blocks" sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">&quot;platforms&quot;<=
/p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1477/comment/d=
0a1f917_c009ea97?usp=3Demail">Patch Set #1, Line 49:</a> <code style=3D"fon=
t-family:monospace,monospace">So the link_socket_read_tcp will run into the=
 assert.</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word=
-wrap: break-word;">Superfluous &quot;the&quot; before &quot;link_socket_re=
ad_tcp&quot;</p></li></ul></li></ul><p>To view, visit <a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1477?usp=3Demail">change 1477</a>. To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit.openvp=
n.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/1477?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifd3e953104a67c8bf2a225e1798=
65e3dbd0dbfbc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1477 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 19 Jan 2026 14:11:45=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--3rDZPFZ3txM=--

