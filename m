From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 10 Mar 2026 13:21:27 +0000
In-Reply-To: <gerrit.1771008284000.Ibc7a6d8c61b9e584bf5d2d13fb5072b7a28fc53b@...2715...>
References: <gerrit.1771008284000.Ibc7a6d8c61b9e584bf5d2d13fb5072b7a28fc53b@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <f1b9c9a6b7c371898113d2df0e34fce12836c49e-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qFwbUgEwtCQ="; charset=UTF-8
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

--qFwbUgEwtCQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello cron2, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1524?usp=3Demail

to look at the new patch set (#4).

The change is no longer submittable: checks~ChecksSubmitRule is unsatisfied=
 now.


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/24/1524/4

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
=20
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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ibc7a6d8c61b9e584bf5d2d13fb5072b7a28fc53b
Gerrit-Change-Number: 1524
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--qFwbUgEwtCQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #4</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1524?usp=3Demail">View C=
hange</a></p><p>The change is no longer submittable: checks~ChecksSubmitRul=
e is unsatisfied now.</p><pre class=3D"blocks" style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">tls_crypt: Avoid a sign-compare warn=
ing<br><br>We already checked that this isn&#39;t negative<br>so just use a=
 cast.<br><br>Change-Id: Ibc7a6d8c61b9e584bf5d2d13fb5072b7a28fc53b<br>Signe=
d-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvp=
n/tls_crypt.c<br>1 file changed, 1 insertion(+), 10 deletions(-)<br><br></p=
re><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chang=
es/24/1524/4</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls=
_crypt.c</span><br><span>index c2b6268..70889dc 100644</span><br><span>--- =
a/src/openvpn/tls_crypt.c</span><br><span>+++ b/src/openvpn/tls_crypt.c</sp=
an><br><span>@@ -206,11 +206,6 @@</span><br><span>     return false;</span>=
<br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;=
-Wsign-compare&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
> bool</span><br><span> tls_crypt_unwrap(const struct buffer *src, struct b=
uffer *dst, struct crypto_options *opt)</span><br><span> {</span><br><span>=
@@ -728,7 +723,7 @@</span><br><span>             msg(M_FATAL, &quot;ERROR: =
failed to base64 decode provided metadata&quot;);</span><br><span>         =
    goto cleanup;</span><br><span>         }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        if (decoded_len &gt; TLS_CRYPT_V2_MAX_METADA=
TA_LEN - 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if ((unsigned int)decoded_len &gt; TLS_CRYPT_V2_MAX_METADATA_LEN - 1)</span=
><br><span>         {</span><br><span>             msg(M_FATAL, &quot;ERROR=
: metadata too long (%d bytes, max %u bytes)&quot;, decoded_len,</span><br>=
<span>                 TLS_CRYPT_V2_MAX_METADATA_LEN - 1);</span><br><span>=
@@ -801,7 +796,3 @@</span><br><span> </span><br><span>     gc_free(&amp;gc)=
;</span><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) =
|| defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#endif</span><br><span></span><br></pre><p>To view, visit <a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/1524?usp=3Demail">change 1524</a>. To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemty=
pe=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1524?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ibc7a6d8c61b9e584bf5d2d13fb5=
072b7a28fc53b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1524 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
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

</body></html>=

--qFwbUgEwtCQ=--

