From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 8 Oct 2025 16:53:51 +0000
References: <gerrit.1759942426000.I4a5c46f321709c83a4a921366630fb8e02834701@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <b091c177c19f6c506abe07cb60c8fe6ee940137b-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GsVEQJV242o="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: lzo: Fix conversion
 warning
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

--GsVEQJV242o=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1260?usp=3Demail

to review the following change.


Change subject: lzo: Fix conversion warning
......................................................................

lzo: Fix conversion warning

We already have an assert ensuring the value is sane,
so just add the cast.

Change-Id: I4a5c46f321709c83a4a921366630fb8e02834701
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/lzo.c
1 file changed, 1 insertion(+), 10 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/60/1260/1

diff --git a/src/openvpn/lzo.c b/src/openvpn/lzo.c
index 8daaec0..8307b59 100644
--- a/src/openvpn/lzo.c
+++ b/src/openvpn/lzo.c
@@ -72,11 +72,6 @@
     *header =3D NO_COMPRESS_BYTE;
 }
=20
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static void
 lzo_decompress(struct buffer *buf, struct buffer work, struct compress_con=
text *compctx,
                const struct frame *frame)
@@ -107,7 +102,7 @@
         }

         ASSERT(buf_safe(&work, zlen));
-        work.len =3D zlen;
+        work.len =3D (int)zlen;

         dmsg(D_COMP, "LZO decompress %d -> %d", buf->len, work.len);
         compctx->pre_decompress +=3D buf->len;
@@ -126,10 +121,6 @@
     }
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 const struct compress_alg lzo_alg =3D { "lzo", lzo_compress_init, lzo_comp=
ress_uninit, lzo_compress,
                                       lzo_decompress };
 #endif /* ENABLE_LZO */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1260?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4a5c46f321709c83a4a921366630fb8e02834701
Gerrit-Change-Number: 1260
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--GsVEQJV242o=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1260?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">lzo: Fix conversion warning<br><br>We alrea=
dy have an assert ensuring the value is sane,<br>so just add the cast.<br><=
br>Change-Id: I4a5c46f321709c83a4a921366630fb8e02834701<br>Signed-off-by: F=
rank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/lzo.c<br>=
1 file changed, 1 insertion(+), 10 deletions(-)<br><br></pre><pre class=3D"=
blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/60/1260/1</pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/src/openvpn/lzo.c b/src/openvpn/lzo.c</span><br><span>inde=
x 8daaec0..8307b59 100644</span><br><span>--- a/src/openvpn/lzo.c</span><br=
><span>+++ b/src/openvpn/lzo.c</span><br><span>@@ -72,11 +72,6 @@</span><br=
><span>     *header =3D NO_COMPRESS_BYTE;</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC=
__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span> static void</span><br><span>=
 lzo_decompress(struct buffer *buf, struct buffer work, struct compress_con=
text *compctx,</span><br><span>                const struct frame *frame)</=
span><br><span>@@ -107,7 +102,7 @@</span><br><span>         }</span><br><sp=
an> </span><br><span>         ASSERT(buf_safe(&amp;work, zlen));</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        work.len =3D zlen;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        work.len =3D (int=
)zlen;</span><br><span> </span><br><span>         dmsg(D_COMP, &quot;LZO de=
compress %d -&gt; %d&quot;, buf-&gt;len, work.len);</span><br><span>       =
  compctx-&gt;pre_decompress +=3D buf-&gt;len;</span><br><span>@@ -126,10 +=
121,6 @@</span><br><span>     }</span><br><span> }</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || def=
ined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragm=
a GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
> const struct compress_alg lzo_alg =3D { &quot;lzo&quot;, lzo_compress_ini=
t, lzo_compress_uninit, lzo_compress,</span><br><span>                     =
                  lzo_decompress };</span><br><span> #endif /* ENABLE_LZO *=
/</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1260?usp=3Demail">change 1260</a>. To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn=
.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http=
://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"=
http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1260?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4a5c46f321709c83a4a92136663=
0fb8e02834701 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1260 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--GsVEQJV242o=--

