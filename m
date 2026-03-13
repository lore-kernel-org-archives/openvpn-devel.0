From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 13 Mar 2026 17:41:26 +0000
In-Reply-To: <gerrit.1773243451000.I7843ff1422cc3b46870749b2daab1698646d43eb@...2715...>
References: <gerrit.1773243451000.I7843ff1422cc3b46870749b2daab1698646d43eb@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <2f58f0b05d15df75095de06b8473d888772129ea-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5HLn0n/hbHM="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: AWS-LC: Add missing
 return and cast in ssl_tls1_PRF
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--5HLn0n/hbHM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/1567?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: AWS-LC: Add missing return and cast in ssl_tls1_PRF
......................................................................

AWS-LC: Add missing return and cast in ssl_tls1_PRF

Change-Id: I7843ff1422cc3b46870749b2daab1698646d43eb
Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1567
Message-Id: <20260313153034.31872-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
107.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/crypto_openssl.c
1 file changed, 2 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/67/1567/4

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index de3878d..b6e2106 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -1412,7 +1412,8 @@
 ssl_tls1_PRF(const uint8_t *label, size_t label_len, const uint8_t *sec, s=
ize_t slen, uint8_t *out1,
              size_t olen)
 {
-    CRYPTO_tls1_prf(EVP_md5_sha1(), out1, olen, sec, slen, label, label_le=
n, NULL, 0, NULL, 0);
+    return CRYPTO_tls1_prf(EVP_md5_sha1(), out1, olen, sec, slen,
+                           (const char *)label, label_len, NULL, 0, NULL, =
0);
 }
 #elif !defined(LIBRESSL_VERSION_NUMBER) && !defined(ENABLE_CRYPTO_WOLFSSL)
 #if defined(__GNUC__) || defined(__clang__)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1567?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7843ff1422cc3b46870749b2daab1698646d43eb
Gerrit-Change-Number: 1567
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--5HLn0n/hbHM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by plaisthos.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1567?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">AWS-LC: Add missing return a=
nd cast in ssl_tls1_PRF<br><br>Change-Id: I7843ff1422cc3b46870749b2daab1698=
646d43eb<br>Signed-off-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>=
Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Gerrit URL: https:/=
/gerrit.openvpn.net/c/openvpn/+/1567<br>Message-Id: &lt;20260313153034.3187=
2-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@=
lists.sourceforge.net/msg36107.html<br>Signed-off-by: Gert Doering &lt;gert=
@...1296...&gt;<br>---<br>M src/openvpn/crypto_openssl.c<br>1 file changed,=
 2 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://g=
errit.openvpn.net:29418/openvpn refs/changes/67/1567/4</pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c</span><br><spa=
n>index de3878d..b6e2106 100644</span><br><span>--- a/src/openvpn/crypto_op=
enssl.c</span><br><span>+++ b/src/openvpn/crypto_openssl.c</span><br><span>=
@@ -1412,7 +1412,8 @@</span><br><span> ssl_tls1_PRF(const uint8_t *label, s=
ize_t label_len, const uint8_t *sec, size_t slen, uint8_t *out1,</span><br>=
<span>              size_t olen)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    CRYPTO_tls1_prf(EVP_md5_sha1(), out1, o=
len, sec, slen, label, label_len, NULL, 0, NULL, 0);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return CRYPTO_tls1_prf(EVP_md5_sha1()=
, out1, olen, sec, slen,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                           (const char *)label, label_len, NULL, 0, NU=
LL, 0);</span><br><span> }</span><br><span> #elif !defined(LIBRESSL_VERSION=
_NUMBER) &amp;&amp; !defined(ENABLE_CRYPTO_WOLFSSL)</span><br><span> #if de=
fined(__GNUC__) || defined(__clang__)</span><br><span></span><br></pre><p>T=
o view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1567?usp=3De=
mail">change 1567</a>. To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>=
.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1567?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7843ff1422cc3b46870749b2daa=
b1698646d43eb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1567 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--5HLn0n/hbHM=--

