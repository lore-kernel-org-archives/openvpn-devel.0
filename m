From: "selvanair (Code Review)" <gerrit@...515...>
Date: Thu, 6 Nov 2025 20:30:43 +0000
In-Reply-To: <gerrit.1761516861000.I0e94068f467f2899daf133b032a785d2d7fc05e4@...2715...>
References: <gerrit.1761516861000.I0e94068f467f2899daf133b032a785d2d7fc05e4@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <ea94e5904e8f078d2a219b7e9a60922123e40dc9-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qXuf3ulWUcE="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: iservice: validate
 config path better
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--qXuf3ulWUcE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, d12fk, flichtenheld, plaisthos.

selvanair has posted comments on this change by d12fk. ( http://gerrit.open=
vpn.net/c/openvpn/+/1307?usp=3Demail )

Change subject: iservice: validate config path better
......................................................................


Patch Set 3:

(2 comments)

File src/openvpnserv/validate.c:

http://gerrit.openvpn.net/c/openvpn/+/1307/comment/68d02a1c_0271f54d?usp=3D=
email :
PS3, Line 88:     HRESULT res =3D PathCchCanonicalizeEx(config_dir, _counto=
f(config_dir), s->config_dir,
As you are effectively reverting commit 05a8ba808, also remove "HAVE_PATHCC=
H_ENSURE_TRAILING_SLASH" introduced by there and related changes in CMakeFi=
les.txt. Also the follow up commit d5e6b72460a.


http://gerrit.openvpn.net/c/openvpn/+/1307/comment/1a4c657c_0c6a5d1e?usp=3D=
email :
PS3, Line 85:     return res =3D=3D S_OK && wcsncmp(config_path, s->config_=
dir, wcslen(s->config_dir)) =3D=3D 0;
While at it, make this case insensitve.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1307?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0e94068f467f2899daf133b032a785d2d7fc05e4
Gerrit-Change-Number: 1307
Gerrit-PatchSet: 3
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: selvanair <selva.nair@...277...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Comment-Date: Thu, 06 Nov 2025 20:30:43 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--qXuf3ulWUcE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, d12fk, flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1307?usp=3Demail">View =
Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File src/openvpnserv/validate.c:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1307/comment/68d02a1c_0271f54d?usp=3Demail">Patch S=
et #3, Line 88:</a> <code style=3D"font-family:monospace,monospace">    HRE=
SULT res =3D PathCchCanonicalizeEx(config_dir, _countof(config_dir), s-&gt;=
config_dir,</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">As you are effectively reverting commit 05a8ba808, a=
lso remove &quot;HAVE_PATHCCH_ENSURE_TRAILING_SLASH&quot; introduced by the=
re and related changes in CMakeFiles.txt. Also the follow up commit d5e6b72=
460a.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"mar=
gin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1307/com=
ment/1a4c657c_0c6a5d1e?usp=3Demail">Patch Set #3, Line 85:</a> <code style=
=3D"font-family:monospace,monospace">    return res =3D=3D S_OK &amp;&amp; =
wcsncmp(config_path, s-&gt;config_dir, wcslen(s-&gt;config_dir)) =3D=3D 0;<=
/code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">While at it, make this case insensitve.</p></li></ul></li></ul><=
p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1307?usp=
=3Demail">change 1307</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1307?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0e94068f467f2899daf133b032a=
785d2d7fc05e4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1307 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: selvanair &lt;selva.nair@...277...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 06 Nov 2025 20:30:43=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>=

--qXuf3ulWUcE=--

