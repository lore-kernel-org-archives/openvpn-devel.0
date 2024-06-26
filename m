From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 26 Jun 2024 12:29:20 +0000
In-Reply-To: <gerrit.1713800630000.I1c038dc4ec80d3499582d81eee61fee74f26e693@...2715...>
References: <gerrit.1713800630000.I1c038dc4ec80d3499582d81eee61fee74f26e693@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5e47ba70cd91ae5e0b1003e35aa328d67ace228d-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gKenYOu5wb8="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: configure: Try to
 detect LZO with pkg-config
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

--gKenYOu5wb8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/556?usp=3Demail )

Change subject: configure: Try to detect LZO with pkg-config
......................................................................


Patch Set 7: Code-Review+2

(2 comments)

Patchset:

PS6:
> close... [=E2=80=A6]
I think the pc is broken... everything LZO itself includes uses <lzo/lzocon=
f.h>... but it's the same (`Cflags: -I${includedir}/lzo`) on gentoo... wher=
e it just happens to work because `/usr/include` is in the include path any=
way.  Gah.


Patchset:

PS7:
Tested on FreeBSD 14, "configure with no option" -> succeeds & builds fine =
(LZO in /usr/local/..., make using `-I/usr/local/include/lzo -I/usr/local/i=
nclude` because that's where cmocka and lz4 are living).  Disabling LZ4 mak=
es compilation succeed with only `-I/usr/local/include/lzo`.  This is good =
:-)

All the buildbots still succeed, which means this hasn't broken explicitly =
setting "whatever we used before".

oi2024 has lzo in `/usr/include/`, so, boring case.

obsd75 has lzo in `/usr/local/include/lzo`, patched configure works, compil=
e works.  With `--disable-lz4` there is no mention of `-I/usr/local/include=
` anymore, and it still succeeds ;-)

nbsd81 has `/usr/pkg/include/lzo/` and the patched configure finds it fine,=
 and then barfs on

```
configure:18379: checking for lzo1x.h
configure:18379: gcc -c -g -O2 -std=3Dc99 -I/usr/pkg/include/lzo  conftest.=
c >&5
In file included from conftest.c:136:0:
/usr/pkg/include/lzo/lzodefs.h:1035:6: error: #error "unexpected configurat=
ion -
 check your compiler defines"
 #    error "unexpected configuration - check your compiler defines"
      ^
```

which is something weird about UINT_MAX testing against LZO_0xffffffffL.  N=
ot sure how to fix that.  It does not break on the buildbot as that one has=
 a symlink from `/usr/include/lzo -> /usr/pkg/include/lzo` (to apease older=
 source trees) - with that, the configure change works fine.  Without, it b=
ombs.  I would still tend to progress the patch, unless someone has a good =
idea how to tackle this...



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/556?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1c038dc4ec80d3499582d81eee61fee74f26e693
Gerrit-Change-Number: 556
Gerrit-PatchSet: 7
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Wed, 26 Jun 2024 12:29:20 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: cron2 <gert@...1296...>
Gerrit-MessageType: comment

--gKenYOu5wb8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>Patch set 7:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/556?usp=3Demail">Vi=
ew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/556?tab=3Dcomments">Patch Set #6:</a> </p><p><blockquote style=3D"borde=
r-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">close... [=E2=80=
=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">I think the pc is broken... everything LZO itself includes uses &lt;lz=
o/lzoconf.h&gt;... but it&#39;s the same (`Cflags: -I${includedir}/lzo`) on=
 gentoo... where it just happens to work because `/usr/include` is in the i=
nclude path anyway.  Gah.</p></li></ul></li><li style=3D"margin: 0; padding=
: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/556?tab=3Dcomments">Patch Set #=
7:</a> </p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Teste=
d on FreeBSD 14, &quot;configure with no option&quot; -&gt; succeeds &amp; =
builds fine (LZO in /usr/local/..., make using `-I/usr/local/include/lzo -I=
/usr/local/include` because that&#39;s where cmocka and lz4 are living).  D=
isabling LZ4 makes compilation succeed with only `-I/usr/local/include/lzo`=
.  This is good :-)</p><p style=3D"white-space: pre-wrap; word-wrap: break-=
word;">All the buildbots still succeed, which means this hasn&#39;t broken =
explicitly setting &quot;whatever we used before&quot;.</p><p style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">oi2024 has lzo in `/usr/include/=
`, so, boring case.</p><p style=3D"white-space: pre-wrap; word-wrap: break-=
word;">obsd75 has lzo in `/usr/local/include/lzo`, patched configure works,=
 compile works.  With `--disable-lz4` there is no mention of `-I/usr/local/=
include` anymore, and it still succeeds ;-)</p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">nbsd81 has `/usr/pkg/include/lzo/` and the p=
atched configure finds it fine, and then barfs on</p><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">```<br>configure:18379: c=
hecking for lzo1x.h<br>configure:18379: gcc -c -g -O2 -std=3Dc99 -I/usr/pkg=
/include/lzo  conftest.c &gt;&amp;5<br>In file included from conftest.c:136=
:0:<br>/usr/pkg/include/lzo/lzodefs.h:1035:6: error: #error &quot;unexpecte=
d configuration -<br> check your compiler defines&quot;<br> #    error &quo=
t;unexpected configuration - check your compiler defines&quot;<br>      ^<b=
r>```</pre><p style=3D"white-space: pre-wrap; word-wrap: break-word;">which=
 is something weird about UINT_MAX testing against LZO_0xffffffffL.  Not su=
re how to fix that.  It does not break on the buildbot as that one has a sy=
mlink from `/usr/include/lzo -&gt; /usr/pkg/include/lzo` (to apease older s=
ource trees) - with that, the configure change works fine.  Without, it bom=
bs.  I would still tend to progress the patch, unless someone has a good id=
ea how to tackle this...</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/556?usp=3Demail">change 556</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/556?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1c038dc4ec80d3499582d81eee6=
1fee74f26e693 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 556 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 26 Jun 2024 12:29:20=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--gKenYOu5wb8=--

