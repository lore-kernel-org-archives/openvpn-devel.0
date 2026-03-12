From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 12 Mar 2026 07:44:18 +0000
In-Reply-To: <gerrit.1771008284000.Ibc7a6d8c61b9e584bf5d2d13fb5072b7a28fc53b@...2715...>
References: <gerrit.1771008284000.Ibc7a6d8c61b9e584bf5d2d13fb5072b7a28fc53b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <53d1ac2b300ad014eec1dfd9d51b65b4f9a21706-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YP8gYJFb8Ds="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: tls_crypt: Avoid a
 sign-compare warning
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

--YP8gYJFb8Ds=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/15=
24?usp=3Demail )

Change subject: tls_crypt: Avoid a sign-compare warning
......................................................................

tls_crypt: Avoid a sign-compare warning

We already checked that this isn't negative
so just use a cast.

Change-Id: Ibc7a6d8c61b9e584bf5d2d13fb5072b7a28fc53b
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1524
Message-Id: <20260306163010.2437-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
959.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/tls_crypt.c
1 file changed, 1 insertion(+), 10 deletions(-)




diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index c2b6268..70889dc 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -206,11 +206,6 @@
     return false;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 bool
 tls_crypt_unwrap(const struct buffer *src, struct buffer *dst, struct cryp=
to_options *opt)
 {
@@ -728,7 +723,7 @@
             msg(M_FATAL, "ERROR: failed to base64 decode provided metadata=
");
             goto cleanup;
         }
-        if (decoded_len > TLS_CRYPT_V2_MAX_METADATA_LEN - 1)
+        if ((unsigned int)decoded_len > TLS_CRYPT_V2_MAX_METADATA_LEN - 1)
         {
             msg(M_FATAL, "ERROR: metadata too long (%d bytes, max %u bytes=
)", decoded_len,
                 TLS_CRYPT_V2_MAX_METADATA_LEN - 1);
@@ -801,7 +796,3 @@

     gc_free(&gc);
 }
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1524?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ibc7a6d8c61b9e584bf5d2d13fb5072b7a28fc53b
Gerrit-Change-Number: 1524
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--YP8gYJFb8Ds=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1524?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">tls_crypt: Avoid a sign-compare warning<br><br>W=
e already checked that this isn&#39;t negative<br>so just use a cast.<br><b=
r>Change-Id: Ibc7a6d8c61b9e584bf5d2d13fb5072b7a28fc53b<br>Signed-off-by: Fr=
ank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert=
@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1524<=
br>Message-Id: &lt;20260306163010.2437-1-gert@...1296...&gt;<br>URL: https:=
//www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35959.html<br=
>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvp=
n/tls_crypt.c<br>1 file changed, 1 insertion(+), 10 deletions(-)<br><br></p=
re>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c</span><br=
><span>index c2b6268..70889dc 100644</span><br><span>--- a/src/openvpn/tls_=
crypt.c</span><br><span>+++ b/src/openvpn/tls_crypt.c</span><br><span>@@ -2=
06,11 +206,6 @@</span><br><span>     return false;</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defin=
ed(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign-compare&quot=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> bool</span><br><s=
pan> tls_crypt_unwrap(const struct buffer *src, struct buffer *dst, struct =
crypto_options *opt)</span><br><span> {</span><br><span>@@ -728,7 +723,7 @@=
</span><br><span>             msg(M_FATAL, &quot;ERROR: failed to base64 de=
code provided metadata&quot;);</span><br><span>             goto cleanup;</=
span><br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        if (decoded_len &gt; TLS_CRYPT_V2_MAX_METADATA_LEN - 1)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if ((unsigned int)d=
ecoded_len &gt; TLS_CRYPT_V2_MAX_METADATA_LEN - 1)</span><br><span>        =
 {</span><br><span>             msg(M_FATAL, &quot;ERROR: metadata too long=
 (%d bytes, max %u bytes)&quot;, decoded_len,</span><br><span>             =
    TLS_CRYPT_V2_MAX_METADATA_LEN - 1);</span><br><span>@@ -801,7 +796,3 @@=
</span><br><span> </span><br><span>     gc_free(&amp;gc);</span><br><span> =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnos=
tic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1524?usp=3Demail">change 1524</a>. To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/sett=
ings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema=
.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sc=
hema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/1524?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ibc7a6d8c61b9e584bf5d2d13fb5=
072b7a28fc53b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1524 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--YP8gYJFb8Ds=--

