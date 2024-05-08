From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 8 May 2024 13:49:12 +0000
In-Reply-To: <gerrit.1713800630000.I1c038dc4ec80d3499582d81eee61fee74f26e693@...2715...>
References: <gerrit.1713800630000.I1c038dc4ec80d3499582d81eee61fee74f26e693@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a68253e3a9fe94267be93d79241164c8cb5fc4ab-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="G9aiYYH87dM="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: configure: Try to
 detect LZO with pkg-config first
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

--G9aiYYH87dM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/556?usp=3Demail )

Change subject: configure: Try to detect LZO with pkg-config first
......................................................................


Patch Set 2:

(1 comment)

Patchset:

PS2:
Does not work for me yet.

Applied this to a fresh git checkout on fbsd14, which has pkg-config and lz=
o2.pc, but it still failed.

Relevant parts from config.log:

```
configure:18781: checking for LZO
configure:18788: $PKG_CONFIG --exists --print-errors "lzo2"
configure:18791: $? =3D 0
configure:18805: $PKG_CONFIG --exists --print-errors "lzo2"
configure:18808: $? =3D 0
configure:18848: result: yes
configure:18850: checking for lzo1x_1_15_compress in -llzo2
configure:18879: cc -o conftest -g -O2 -std=3Dc99   conftest.c -llzo2   -ln=
v >&5
ld: error: unable to find library -llzo2
```

and from pkgconf output
```
gert@...2801... $ pkg-config --cflags lzo2
-I/usr/local/include/lzo
gert@...2801... $ pkg-config --libs lzo2
-L/usr/local/lib -llzo2



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/556?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1c038dc4ec80d3499582d81eee61fee74f26e693
Gerrit-Change-Number: 556
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Wed, 08 May 2024 13:49:12 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--G9aiYYH87dM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/556?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/5=
56?tab=3Dcomments">Patch Set #2:</a> </p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Does not work for me yet.</p><p style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">Applied this to a fresh git checkout =
on fbsd14, which has pkg-config and lzo2.pc, but it still failed.</p><p sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">Relevant parts from co=
nfig.log:</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">```=
<br>configure:18781: checking for LZO<br>configure:18788: $PKG_CONFIG --exi=
sts --print-errors &quot;lzo2&quot;<br>configure:18791: $? =3D 0<br>configu=
re:18805: $PKG_CONFIG --exists --print-errors &quot;lzo2&quot;<br>configure=
:18808: $? =3D 0<br>configure:18848: result: yes<br>configure:18850: checki=
ng for lzo1x_1_15_compress in -llzo2<br>configure:18879: cc -o conftest -g =
-O2 -std=3Dc99   conftest.c -llzo2   -lnv &gt;&amp;5<br>ld: error: unable t=
o find library -llzo2<br>```</p><p style=3D"white-space: pre-wrap; word-wra=
p: break-word;">and from pkgconf output<br>```<br>gert@...2801... $ pkg-con=
fig --cflags lzo2<br>-I/usr/local/include/lzo<br>gert@...2801... $ pkg-conf=
ig --libs lzo2<br>-L/usr/local/lib -llzo2</p></li></ul></li></ul><p>To view=
, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/556?usp=3Demail">c=
hange 556</a>. To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope =
itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/556?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1c038dc4ec80d3499582d81eee6=
1fee74f26e693 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 556 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 08 May 2024 13:49:12=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--G9aiYYH87dM=--

