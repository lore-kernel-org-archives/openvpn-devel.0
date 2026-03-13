From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 13 Mar 2026 13:43:14 +0000
In-Reply-To: <gerrit.1773243451000.I7843ff1422cc3b46870749b2daab1698646d43eb@...2715...>
References: <gerrit.1773243451000.I7843ff1422cc3b46870749b2daab1698646d43eb@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <5486d66cdbeb2e183cfd5431c3063149481f28ec-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1F8G5mIrLcA="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--1F8G5mIrLcA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1567?usp=3Demail

to look at the new patch set (#3).

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: AWS-LC: Add missing return and cast in ssl_tls1_PRF
......................................................................

AWS-LC: Add missing return and cast in ssl_tls1_PRF

Change-Id: I7843ff1422cc3b46870749b2daab1698646d43eb
---
M src/openvpn/crypto_openssl.c
1 file changed, 2 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/67/1567/3

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
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--1F8G5mIrLcA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #3</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1567?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">AWS-LC: Add missing return a=
nd cast in ssl_tls1_PRF<br><br>Change-Id: I7843ff1422cc3b46870749b2daab1698=
646d43eb<br>---<br>M src/openvpn/crypto_openssl.c<br>1 file changed, 2 inse=
rtions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.o=
penvpn.net:29418/openvpn refs/changes/67/1567/3</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/op=
envpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c</span><br><span>index=
 de3878d..b6e2106 100644</span><br><span>--- a/src/openvpn/crypto_openssl.c=
</span><br><span>+++ b/src/openvpn/crypto_openssl.c</span><br><span>@@ -141=
2,7 +1412,8 @@</span><br><span> ssl_tls1_PRF(const uint8_t *label, size_t l=
abel_len, const uint8_t *sec, size_t slen, uint8_t *out1,</span><br><span> =
             size_t olen)</span><br><span> {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    CRYPTO_tls1_prf(EVP_md5_sha1(), out1, olen, sec,=
 slen, label, label_len, NULL, 0, NULL, 0);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return CRYPTO_tls1_prf(EVP_md5_sha1(), out1, ol=
en, sec, slen,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                      (const char *)label, label_len, NULL, 0, NULL, 0);</s=
pan><br><span> }</span><br><span> #elif !defined(LIBRESSL_VERSION_NUMBER) &=
amp;&amp; !defined(ENABLE_CRYPTO_WOLFSSL)</span><br><span> #if defined(__GN=
UC__) || defined(__clang__)</span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1567?usp=3Demail">chan=
ge 1567</a>. To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div =
itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"u=
rl" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1567?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7843ff1422cc3b46870749b2daa=
b1698646d43eb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1567 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--1F8G5mIrLcA=--

