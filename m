From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 24 Oct 2025 16:52:53 +0000
References: <gerrit.1761324750000.Ie7ad637223c332f7611c09b20a8d7a3a92d97ec7@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <40e3384c8df52fc80c1750b0f07ed932beb700e9-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TAMT6+7GM7g="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl: Clean up type
 handling in parse_early_negotiation_tlvs()
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

--TAMT6+7GM7g=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1302?usp=3Demail

to review the following change.


Change subject: ssl: Clean up type handling in parse_early_negotiation_tlvs=
()
......................................................................

ssl: Clean up type handling in parse_early_negotiation_tlvs()

buf_read_u16 does not return uint16_t.

Change-Id: Ie7ad637223c332f7611c09b20a8d7a3a92d97ec7
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/ssl.c
1 file changed, 4 insertions(+), 13 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/02/1302/1

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 819a1ef..9a3ba88 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2195,11 +2195,6 @@
     }
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /**
  * Handle reading key data, peer-info, username/password, OCC
  * from the TLS control channel (cleartext).
@@ -2530,9 +2525,9 @@
             goto error;
         }
         /* read type */
-        uint16_t type =3D buf_read_u16(buf);
-        uint16_t len =3D buf_read_u16(buf);
-        if (buf_len(buf) < len)
+        int type =3D buf_read_u16(buf);
+        int len =3D buf_read_u16(buf);
+        if (type < 0 || len < 0 || buf_len(buf) < len)
         {
             goto error;
         }
@@ -2544,7 +2539,7 @@
                 {
                     goto error;
                 }
-                uint16_t flags =3D buf_read_u16(buf);
+                int flags =3D buf_read_u16(buf);

                 if (flags & EARLY_NEG_FLAG_RESEND_WKC)
                 {
@@ -3975,10 +3970,6 @@
     }
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 tls_prepend_opcode_v1(const struct tls_multi *multi, struct buffer *buf)
 {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1302?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie7ad637223c332f7611c09b20a8d7a3a92d97ec7
Gerrit-Change-Number: 1302
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--TAMT6+7GM7g=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1302?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">ssl: Clean up type handling in parse_early_=
negotiation_tlvs()<br><br>buf_read_u16 does not return uint16_t.<br><br>Cha=
nge-Id: Ie7ad637223c332f7611c09b20a8d7a3a92d97ec7<br>Signed-off-by: Frank L=
ichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/ssl.c<br>1 file=
 changed, 4 insertions(+), 13 deletions(-)<br><br></pre><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git p=
ull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/02/1302/1</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index 819=
a1ef..9a3ba88 100644</span><br><span>--- a/src/openvpn/ssl.c</span><br><spa=
n>+++ b/src/openvpn/ssl.c</span><br><span>@@ -2195,11 +2195,6 @@</span><br>=
<span>     }</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pu=
sh</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnos=
tic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span> /**</span><br><span>  * Handle reading key data, peer-inf=
o, username/password, OCC</span><br><span>  * from the TLS control channel =
(cleartext).</span><br><span>@@ -2530,9 +2525,9 @@</span><br><span>        =
     goto error;</span><br><span>         }</span><br><span>         /* rea=
d type */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uint=
16_t type =3D buf_read_u16(buf);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        uint16_t len =3D buf_read_u16(buf);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        if (buf_len(buf) &lt; len)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        int type =3D buf_re=
ad_u16(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 int len =3D buf_read_u16(buf);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (type &lt; 0 || len &lt; 0 || buf_len(buf) &lt; len)=
</span><br><span>         {</span><br><span>             goto error;</span>=
<br><span>         }</span><br><span>@@ -2544,7 +2539,7 @@</span><br><span>=
                 {</span><br><span>                     goto error;</span><=
br><span>                 }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                uint16_t flags =3D buf_read_u16(buf);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                int flags =3D buf_r=
ead_u16(buf);</span><br><span> </span><br><span>                 if (flags =
&amp; EARLY_NEG_FLAG_RESEND_WKC)</span><br><span>                 {</span><=
br><span>@@ -3975,10 +3970,6 @@</span><br><span>     }</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if d=
efined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span> void</span><br><span> tls_prepend_opcode_v1(const =
struct tls_multi *multi, struct buffer *buf)</span><br><span> {</span><br><=
span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1302?usp=3Demail">change 1302</a>. To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings=
?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/1302?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie7ad637223c332f7611c09b20a8=
d7a3a92d97ec7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1302 </div>
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

--TAMT6+7GM7g=--

