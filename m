From: "selvanair (Code Review)" <gerrit@...515...>
Date: Sat, 15 Nov 2025 17:16:53 +0000
In-Reply-To: <gerrit.1761818969000.I5ea90594493ab5cb858f7495f773e080b379e8e8@...2715...>
References: <gerrit.1761818969000.I5ea90594493ab5cb858f7495f773e080b379e8e8@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277..., gert@...1296...
Message-ID: <764b247a825d682506896e376978eb6dce661cab-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3Kv7rGCK5bM="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: win32: ensure plugin
 dir has the trailing slash
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--3Kv7rGCK5bM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa.

selvanair has posted comments on this change by stipa. ( http://gerrit.open=
vpn.net/c/openvpn/+/1332?usp=3Demail )

Change subject: win32: ensure plugin dir has the trailing slash
......................................................................


Patch Set 2:

(2 comments)

Patchset:

PS2:
> This is a bit annoying, with the back and forth of `PATHCCH_ENSURE_TRAILI=
NG_SLASH` in the iservice,  [=E2=80=A6]
A work around is to use PathCchAddBackslash() followed by PathCchCanonicali=
ze() avoiding the dependence on the `PATHCCH_ENSURE_TRAILING_SLASH` flag.


File src/openvpn/win32.c:

http://gerrit.openvpn.net/c/openvpn/+/1332/comment/3384bb13_c17698f4?usp=3D=
email :
PS2, Line 1607:         && (wcsnicmp(plugin_dir, plugin_path, wcslen(plugin=
_dir)) =3D=3D 0))
Is the logic right here? We are canonicalizing plugin_dir, but not plugin_p=
ath. Are we sure plugin_path cannot not contain "../"? The latter being use=
r supplied, its more important to canonicalize it than the path read from H=
KLM.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1332?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5ea90594493ab5cb858f7495f773e080b379e8e8
Gerrit-Change-Number: 1332
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: selvanair <selva.nair@...277...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Sat, 15 Nov 2025 17:16:53 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>

--3Kv7rGCK5bM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, stipa. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1332?usp=3Demail">View =
Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1332?tab=3Dcomments&amp;usp=3Demail">Patch Set #2:</a> </p><p><blockquote =
style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Thi=
s is a bit annoying, with the back and forth of `PATHCCH_ENSURE_TRAILING_SL=
ASH` in the iservice,  [=E2=80=A6]</blockquote></p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">A work around is to use=
 PathCchAddBackslash() followed by PathCchCanonicalize() avoiding the depen=
dence on the `PATHCCH_ENSURE_TRAILING_SLASH` flag.</p></li></ul></li><li st=
yle=3D"margin: 0; padding: 0;"><p>File src/openvpn/win32.c:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/1332/comment/3384bb13_c17698f4?usp=3Demail">Patch Set #2, Line 16=
07:</a> <code style=3D"font-family:monospace,monospace">        &amp;&amp; =
(wcsnicmp(plugin_dir, plugin_path, wcslen(plugin_dir)) =3D=3D 0))</code></p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">Is the logic right here? We are canonicalizing plugin_dir, but not plugin=
_path. Are we sure plugin_path cannot not contain &quot;../&quot;? The latt=
er being user supplied, its more important to canonicalize it than the path=
 read from HKLM.</p></li></ul></li></ul><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1332?usp=3Demail">change 1332</a>. To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit.op=
envpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D=
"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtyp=
e=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1332?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5ea90594493ab5cb858f7495f77=
3e080b379e8e8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1332 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
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
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 15 Nov 2025 17:16:53=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>

</body></html>=

--3Kv7rGCK5bM=--

