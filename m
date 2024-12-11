From: "syzzer (Code Review)" <gerrit@...515...>
Date: Wed, 11 Dec 2024 21:15:40 +0000
In-Reply-To: <gerrit.1731290343000.I057f007577f10c6ac917ee4620ee3d2559187dc7@...2715...>
References: <gerrit.1731290343000.I057f007577f10c6ac917ee4620ee3d2559187dc7@...2715...>
Reply-To: steffan@...1856..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606..., gert@...1296...
Message-ID: <05b5a9d885a5d03e70028a4e30889007aea27df5-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="M7cVi9PJqN4="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Trigger
 renegotiation of data key if getting close to the AEAD usage ...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: MaxF <max@...2606...>, flichtenheld <frank@...2641...>, cron2 <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--M7cVi9PJqN4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, cron2, flichtenheld, plaisthos.

syzzer has posted comments on this change. ( http://gerrit.openvpn.net/c/op=
envpn/+/796?usp=3Demail )

Change subject: Trigger renegotiation of data key if getting close to the A=
EAD usage limit
......................................................................


Patch Set 12: Code-Review-1

(5 comments)

Patchset:

PS12:
Looks good in general. Math checks out. Some minor nits and one fundamental=
 remark to consider.


File src/openvpn/ssl.c:

http://gerrit.openvpn.net/c/openvpn/+/796/comment/2fd3c45a_2a4cdbb4 :
PS12, Line 144:     /* set limit to 7/8 of the limit so the renogiation can=
 succeed before
renegotiation


http://gerrit.openvpn.net/c/openvpn/+/796/comment/a6fc21b4_8bd28a4d :
PS12, Line 146:     limit =3D limit * 7/8;
Consider adding overflow checks. I know, unlikely, and doesn=C2=B4t result =
in an unsafe situation, but if cipher_get_aead_limits at some point could r=
eturn values close to 2**64, this calculation could result in very low limi=
t values.


http://gerrit.openvpn.net/c/openvpn/+/796/comment/7971040c_bac1d94b :
PS12, Line 149:         PRIi64 " for block and packets before renegotiation=
",
This suggests a hard limit, but it's a soft limit we can (and typically wil=
l) exceed. Without the 64-bit pid, we had a hard limit at 2**32-1. To be ab=
le to claim we never exceed the real limit (the "8/8" value), we should con=
sider adding a hard limit enforcement.


http://gerrit.openvpn.net/c/openvpn/+/796/comment/502879b2_3c1a0f24 :
PS12, Line 3027:         || aead_usage_limit_reached(usage_limit, &key_ctx_=
bi->decrypt,
This is a safety precaution? The sending party is ultimately responsible fo=
r not exceeding the limit of course. (But I admit, in practice this would l=
ikely prevent buggy peers from exceeding the limit.)



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/796?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I057f007577f10c6ac917ee4620ee3d2559187dc7
Gerrit-Change-Number: 796
Gerrit-PatchSet: 12
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: syzzer <steffan@...1856...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: MaxF <max@...2606...>
Gerrit-Comment-Date: Wed, 11 Dec 2024 21:15:40 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--M7cVi9PJqN4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: MaxF, cron2, flichtenheld, plaist=
hos. </p>
<p>Patch set 12:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span=
></p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/796?usp=3Demail">V=
iew Change</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/796?tab=3Dcomments">Patch Set #12:</a> </p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">Looks good in general. Math checks out. Som=
e minor nits and one fundamental remark to consider.</p></li></ul></li><li =
style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl.c:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/796/comment/2fd3c45a_2a4cdbb4">Patch Set #12, Line 144:</a> <code=
 style=3D"font-family:monospace,monospace">    /* set limit to 7/8 of the l=
imit so the renogiation can succeed before</code></p><p style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">renegotiation</p></li><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/796/comment/a6fc21b4_8bd28a4d">Patch S=
et #12, Line 146:</a> <code style=3D"font-family:monospace,monospace">    l=
imit =3D limit * 7/8;</code></p><p style=3D"white-space: pre-wrap; word-wra=
p: break-word;">Consider adding overflow checks. I know, unlikely, and does=
n=C2=B4t result in an unsafe situation, but if cipher_get_aead_limits at so=
me point could return values close to 2**64, this calculation could result =
in very low limit values.</p></li><li style=3D"margin: 0; padding: 0 0 0 16=
px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/796/comment/7971040c_bac1d94b">Patch Set #12, Line 149:</a> <co=
de style=3D"font-family:monospace,monospace">        PRIi64 &quot; for bloc=
k and packets before renegotiation&quot;,</code></p><p style=3D"white-space=
: pre-wrap; word-wrap: break-word;">This suggests a hard limit, but it&#39;=
s a soft limit we can (and typically will) exceed. Without the 64-bit pid, =
we had a hard limit at 2**32-1. To be able to claim we never exceed the rea=
l limit (the &quot;8/8&quot; value), we should consider adding a hard limit=
 enforcement.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
796/comment/502879b2_3c1a0f24">Patch Set #12, Line 3027:</a> <code style=3D=
"font-family:monospace,monospace">        || aead_usage_limit_reached(usage=
_limit, &amp;key_ctx_bi-&gt;decrypt,</code></p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">This is a safety precaution? The sending par=
ty is ultimately responsible for not exceeding the limit of course. (But I =
admit, in practice this would likely prevent buggy peers from exceeding the=
 limit.)</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/796?usp=3Demail">change 796</a>. To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/=
settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/796?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I057f007577f10c6ac917ee4620e=
e3d2559187dc7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 796 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 12 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: syzzer &lt;steffan@...1856...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@...2606...&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 11 Dec 2024 21:15:40=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--M7cVi9PJqN4=--

