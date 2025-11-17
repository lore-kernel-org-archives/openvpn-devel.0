From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 17 Nov 2025 07:59:54 +0000
In-Reply-To: <gerrit.1761324750000.Ie7ad637223c332f7611c09b20a8d7a3a92d97ec7@...2715...>
References: <gerrit.1761324750000.Ie7ad637223c332f7611c09b20a8d7a3a92d97ec7@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <e602dbbdcbb2806d1a1f526633d792b179b25b62-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3KHSsquT0GA="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--3KHSsquT0GA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#7) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1302?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/02/1302/7

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie7ad637223c332f7611c09b20a8d7a3a92d97ec7
Gerrit-Change-Number: 1302
Gerrit-PatchSet: 7
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--3KHSsquT0GA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #7</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1302?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">ssl: Clean up type handling in pars=
e_early_negotiation_tlvs()<br><br>buf_read_u16 does not return uint16_t.<br=
><br>Change-Id: Ie7ad637223c332f7611c09b20a8d7a3a92d97ec7<br>Signed-off-by:=
 Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;g=
ert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/13=
02<br>Message-Id: &lt;20251116215433.29257-1-gert@...1296...&gt;<br>URL: ht=
tps://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34487.htm=
l<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/op=
envpn/ssl.c<br>1 file changed, 4 insertions(+), 13 deletions(-)<br><br></pr=
e><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/change=
s/02/1302/7</pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</spa=
n><br><span>index 4841837..8501693 100644</span><br><span>--- a/src/openvpn=
/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -2194,11 =
+2194,6 @@</span><br><span>     }</span><br><span> }</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || d=
efined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pra=
gma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span> /**</span><br><span>  * Handle readi=
ng key data, peer-info, username/password, OCC</span><br><span>  * from the=
 TLS control channel (cleartext).</span><br><span>@@ -2522,9 +2517,9 @@</sp=
an><br><span>             goto error;</span><br><span>         }</span><br>=
<span>         /* read type */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        uint16_t type =3D buf_read_u16(buf);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        uint16_t len =3D buf_read_u16(buf);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (buf_len(b=
uf) &lt; len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  int type =3D buf_read_u16(buf);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        int len =3D buf_read_u16(buf);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (type &lt; 0 || len &lt; 0 || =
buf_len(buf) &lt; len)</span><br><span>         {</span><br><span>         =
    goto error;</span><br><span>         }</span><br><span>@@ -2536,7 +2531=
,7 @@</span><br><span>                 {</span><br><span>                  =
   goto error;</span><br><span>                 }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                uint16_t flags =3D buf_read_u16=
(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   int flags =3D buf_read_u16(buf);</span><br><span> </span><br><span>     =
            if (flags &amp; EARLY_NEG_FLAG_RESEND_WKC)</span><br><span>    =
             {</span><br><span>@@ -3963,10 +3958,6 @@</span><br><span>     =
}</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span> void</span><br><span> tls_pr=
epend_opcode_v1(const struct tls_multi *multi, struct buffer *buf)</span><b=
r><span> {</span><br><span></span><br></pre><p>To view, visit <a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/1302?usp=3Demail">change 1302</a>. To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtyp=
e=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" ite=
mtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/1302?usp=3Demail"/><meta itemprop=3D"name"=
 content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
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

--3KHSsquT0GA=--

