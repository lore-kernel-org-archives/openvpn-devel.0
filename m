From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Sun, 8 Oct 2023 09:47:12 +0000
In-Reply-To: <gerrit.1692364556000.I4f29953b91cf8e8daf2c9503da44073ad96d0ff5@...2715...>
References: <gerrit.1692364556000.I4f29953b91cf8e8daf2c9503da44073ad96d0ff5@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <39b5ae48dae7798c274f60d3950016bc1e76275d-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="019WkgXHiQE="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Remove ability to
 use configurations without TLS by default
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--019WkgXHiQE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/325?usp=3Demail )

Change subject: Remove ability to use configurations without TLS by default
......................................................................


Patch Set 3:

(6 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/325/comment/8f8747a9_a15b8621 :
PS2, Line 12: line or the configuration itself. This will server as a last =
and final
> "serve"
Done


File doc/man-sections/protocol-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/325/comment/8dd9511d_12101566 :
PS2, Line 237: --secret args
> I think we should at least add a basic documentation for the "allow-depre=
cated-insecure-static-crypt [=E2=80=A6]
I am not sure about this. I left it


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/325/comment/d2cedde6_e37b659b :
PS2, Line 618: ,\
> Change trailing comma to full stop.
Done


http://gerrit.openvpn.net/c/openvpn/+/325/comment/a02ba0ac_5ead8aa4 :
PS2, Line 756: secret
> Should be we change the "secret" here?
Done


http://gerrit.openvpn.net/c/openvpn/+/325/comment/f1bbbe12_653561e4 :
PS2, Line 2843:             "OpenVPN 2.7 allow using this configuration whe=
n using "
> "allows"
Done


http://gerrit.openvpn.net/c/openvpn/+/325/comment/5449a47c_a226efcb :
PS2, Line 2845: configuration
> "proper configuration" =3D> "TLS mode"?
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/325?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4f29953b91cf8e8daf2c9503da44073ad96d0ff5
Gerrit-Change-Number: 325
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Sun, 08 Oct 2023 09:47:12 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--019WkgXHiQE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/325?usp=3Demail">View C=
hange</a></p><p>6 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/325/comment/8f8747a9_a15b8621">Patch Set #2, Line 12:</a> <code style=
=3D"font-family:monospace,monospace">line or the configuration itself. This=
 will server as a last and final</code></p><p><blockquote style=3D"border-l=
eft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">&quot;serve&quot;</b=
lockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Do=
ne</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File doc/man-s=
ections/protocol-options.rst:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/325/comment/8dd9511d=
_12101566">Patch Set #2, Line 237:</a> <code style=3D"font-family:monospace=
,monospace">--secret args</code></p><p><blockquote style=3D"border-left: 1p=
x solid #aaa; margin: 10px 0; padding: 0 10px;">I think we should at least =
add a basic documentation for the &quot;allow-deprecated-insecure-static-cr=
ypt [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wra=
p: break-word;">I am not sure about this. I left it</p></li></ul></li><li s=
tyle=3D"margin: 0; padding: 0;"><p>File src/openvpn/options.c:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/325/comment/d2cedde6_e37b659b">Patch Set #2, Line 618:</a> <co=
de style=3D"font-family:monospace,monospace">,\</code></p><p><blockquote st=
yle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Chang=
e trailing comma to full stop.</blockquote></p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/325/comment/a02ba0ac_5ead8aa4">Patch Set #2, Line 756=
:</a> <code style=3D"font-family:monospace,monospace">secret</code></p><p><=
blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0=
 10px;">Should be we change the &quot;secret&quot; here?</blockquote></p><p=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/325/comment/f1bbbe12_653561=
e4">Patch Set #2, Line 2843:</a> <code style=3D"font-family:monospace,monos=
pace">            &quot;OpenVPN 2.7 allow using this configuration when usi=
ng &quot;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; ma=
rgin: 10px 0; padding: 0 10px;">&quot;allows&quot;</blockquote></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/325/comment/5449a47c_a226efcb">=
Patch Set #2, Line 2845:</a> <code style=3D"font-family:monospace,monospace=
">configuration</code></p><p><blockquote style=3D"border-left: 1px solid #a=
aa; margin: 10px 0; padding: 0 10px;">&quot;proper configuration&quot; =3D&=
gt; &quot;TLS mode&quot;?</blockquote></p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/325?usp=3Demail">change 325</=
a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D=
"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtyp=
e=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/325?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4f29953b91cf8e8daf2c9503da4=
4073ad96d0ff5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 325 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 08 Oct 2023 09:47:12=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--019WkgXHiQE=--

