From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 17 Nov 2025 07:59:56 +0000
In-Reply-To: <gerrit.1761324750000.Ie7ad637223c332f7611c09b20a8d7a3a92d97ec7@...2715...>
References: <gerrit.1761324750000.Ie7ad637223c332f7611c09b20a8d7a3a92d97ec7@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <e602dbbdcbb2806d1a1f526633d792b179b25b62-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="J/5d5qHzCe0="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--J/5d5qHzCe0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
02?usp=3Demail )

Change subject: ssl: Clean up type handling in parse_early_negotiation_tlvs=
()
......................................................................

ssl: Clean up type handling in parse_early_negotiation_tlvs()

buf_read_u16 does not return uint16_t.

Change-Id: Ie7ad637223c332f7611c09b20a8d7a3a92d97ec7
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1302
Message-Id: <20251116215433.29257-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
487.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl.c
1 file changed, 4 insertions(+), 13 deletions(-)




diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 4841837..8501693 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2194,11 +2194,6 @@
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
@@ -2522,9 +2517,9 @@
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
@@ -2536,7 +2531,7 @@
                 {
                     goto error;
                 }
-                uint16_t flags =3D buf_read_u16(buf);
+                int flags =3D buf_read_u16(buf);

                 if (flags & EARLY_NEG_FLAG_RESEND_WKC)
                 {
@@ -3963,10 +3958,6 @@
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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie7ad637223c332f7611c09b20a8d7a3a92d97ec7
Gerrit-Change-Number: 1302
Gerrit-PatchSet: 7
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--J/5d5qHzCe0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1302?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">ssl: Clean up type handling in parse_early_negot=
iation_tlvs()<br><br>buf_read_u16 does not return uint16_t.<br><br>Change-I=
d: Ie7ad637223c332f7611c09b20a8d7a3a92d97ec7<br>Signed-off-by: Frank Lichte=
nheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...2132...=
.&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1302<br>Message=
-Id: &lt;20251116215433.29257-1-gert@...1296...&gt;<br>URL: https://www.mai=
l-archive.com/openvpn-devel@lists.sourceforge.net/msg34487.html<br>Signed-o=
ff-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/ssl.c<b=
r>1 file changed, 4 insertions(+), 13 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index=
 4841837..8501693 100644</span><br><span>--- a/src/openvpn/ssl.c</span><br>=
<span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -2194,11 +2194,6 @@</span>=
<br><span>     }</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnosti=
c push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC dia=
gnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span> /**</span><br><span>  * Handle reading key data, peer=
-info, username/password, OCC</span><br><span>  * from the TLS control chan=
nel (cleartext).</span><br><span>@@ -2522,9 +2517,9 @@</span><br><span>    =
         goto error;</span><br><span>         }</span><br><span>         /*=
 read type */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
uint16_t type =3D buf_read_u16(buf);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        uint16_t len =3D buf_read_u16(buf);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        if (buf_len(buf) &lt; len)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        int type =3D bu=
f_read_u16(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     int len =3D buf_read_u16(buf);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (type &lt; 0 || len &lt; 0 || buf_len(buf) &lt; =
len)</span><br><span>         {</span><br><span>             goto error;</s=
pan><br><span>         }</span><br><span>@@ -2536,7 +2531,7 @@</span><br><s=
pan>                 {</span><br><span>                     goto error;</sp=
an><br><span>                 }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                uint16_t flags =3D buf_read_u16(buf);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                int flags =3D b=
uf_read_u16(buf);</span><br><span> </span><br><span>                 if (fl=
ags &amp; EARLY_NEG_FLAG_RESEND_WKC)</span><br><span>                 {</sp=
an><br><span>@@ -3963,10 +3958,6 @@</span><br><span>     }</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span> void</span><br><span> tls_prepend_opcode_v1(co=
nst struct tls_multi *multi, struct buffer *buf)</span><br><span> {</span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1302?usp=3Demail">change 1302</a>. To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/sett=
ings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema=
.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sc=
hema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/1302?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie7ad637223c332f7611c09b20a8=
d7a3a92d97ec7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1302 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--J/5d5qHzCe0=--

