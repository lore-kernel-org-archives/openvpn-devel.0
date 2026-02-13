From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 13 Feb 2026 18:44:53 +0000
References: <gerrit.1771008284000.Ibc7a6d8c61b9e584bf5d2d13fb5072b7a28fc53b@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <08e11a916819217ce30e51f3b1c4b70e3e6f215b-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TtruBdqRc0o="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--TtruBdqRc0o=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1524?usp=3Demail

to review the following change.


Change subject: tls_crypt: Avoid a sign-compare warning
......................................................................

tls_crypt: Avoid a sign-compare warning

We already checked that this isn't negative
so just use a cast.

Change-Id: Ibc7a6d8c61b9e584bf5d2d13fb5072b7a28fc53b
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/tls_crypt.c
1 file changed, 1 insertion(+), 10 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/24/1524/1

diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 44aaad9..92acbc0 100644
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ibc7a6d8c61b9e584bf5d2d13fb5072b7a28fc53b
Gerrit-Change-Number: 1524
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--TtruBdqRc0o=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1524?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">tls_crypt: Avoid a sign-compare warning<br>=
<br>We already checked that this isn&#39;t negative<br>so just use a cast.<=
br><br>Change-Id: Ibc7a6d8c61b9e584bf5d2d13fb5072b7a28fc53b<br>Signed-off-b=
y: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/tls_c=
rypt.c<br>1 file changed, 1 insertion(+), 10 deletions(-)<br><br></pre><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/24/1=
524/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.=
c</span><br><span>index 44aaad9..92acbc0 100644</span><br><span>--- a/src/o=
penvpn/tls_crypt.c</span><br><span>+++ b/src/openvpn/tls_crypt.c</span><br>=
<span>@@ -206,11 +206,6 @@</span><br><span>     return false;</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign=
-compare&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> bool=
</span><br><span> tls_crypt_unwrap(const struct buffer *src, struct buffer =
*dst, struct crypto_options *opt)</span><br><span> {</span><br><span>@@ -72=
8,7 +723,7 @@</span><br><span>             msg(M_FATAL, &quot;ERROR: failed=
 to base64 decode provided metadata&quot;);</span><br><span>             go=
to cleanup;</span><br><span>         }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        if (decoded_len &gt; TLS_CRYPT_V2_MAX_METADATA_LEN=
 - 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if ((u=
nsigned int)decoded_len &gt; TLS_CRYPT_V2_MAX_METADATA_LEN - 1)</span><br><=
span>         {</span><br><span>             msg(M_FATAL, &quot;ERROR: meta=
data too long (%d bytes, max %u bytes)&quot;, decoded_len,</span><br><span>=
                 TLS_CRYPT_V2_MAX_METADATA_LEN - 1);</span><br><span>@@ -80=
1,7 +796,3 @@</span><br><span> </span><br><span>     gc_free(&amp;gc);</spa=
n><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || def=
ined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragm=
a GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
endif</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/1524?usp=3Demail">change 1524</a>. To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit.ope=
nvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1524?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ibc7a6d8c61b9e584bf5d2d13fb5=
072b7a28fc53b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1524 </div>
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

--TtruBdqRc0o=--

