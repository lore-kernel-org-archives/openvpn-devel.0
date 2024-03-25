From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 25 Mar 2024 14:30:49 +0000
References: <gerrit.1711377047000.If0dcdde30879fd6185efb2ad31399c1629c04d22@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <8be38848bbb0b6931888dfd560d9f6c45897274d-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7zJd+7iLJgE="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: mbedtls: avoid
 warning with GCC 13+
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

--7zJd+7iLJgE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/548?usp=3Demail

to review the following change.


Change subject: mbedtls: avoid warning with GCC 13+
......................................................................

mbedtls: avoid warning with GCC 13+

crypto_mbedtls.c:568:1: error:
conflicting types for =E2=80=98cipher_ctx_init=E2=80=99 due to enum/integer=
 mismatch;
have =E2=80=98void(mbedtls_cipher_context_t *, const uint8_t *, const char =
*, const mbedtls_operation_t)=E2=80=99
[...] [-Werror=3Denum-int-mismatch]
crypto_backend.h:341:6: note:
previous declaration of =E2=80=98cipher_ctx_init=E2=80=99 with type
=E2=80=98void(cipher_ctx_t *, const uint8_t *, const char *, int)=E2=80=99 =
[...]

Previous compiler versions did not complain.

Change-Id: If0dcdde30879fd6185efb2ad31399c1629c04d22
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/crypto_mbedtls.c
1 file changed, 2 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/48/548/1

diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 1a39752..91485cb 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -566,11 +566,12 @@

 void
 cipher_ctx_init(mbedtls_cipher_context_t *ctx, const uint8_t *key,
-                const char *ciphername, const mbedtls_operation_t operatio=
n)
+                const char *ciphername, int enc)
 {
     ASSERT(NULL !=3D ciphername && NULL !=3D ctx);
     CLEAR(*ctx);

+    const mbedtls_operation_t operation =3D (mbedtls_operation_t)enc;
     const mbedtls_cipher_info_t *kt =3D cipher_get(ciphername);
     ASSERT(kt);
     size_t key_bitlen =3D mbedtls_cipher_info_get_key_bitlen(kt);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/548?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If0dcdde30879fd6185efb2ad31399c1629c04d22
Gerrit-Change-Number: 548
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--7zJd+7iLJgE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/548?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">mbedtls: avoid warning with GCC 13+<br><br>crypto_mbedtls.c:5=
68:1: error:<br>conflicting types for =E2=80=98cipher_ctx_init=E2=80=99 due=
 to enum/integer mismatch;<br>have =E2=80=98void(mbedtls_cipher_context_t *=
, const uint8_t *, const char *, const mbedtls_operation_t)=E2=80=99<br>[..=
.] [-Werror=3Denum-int-mismatch]<br>crypto_backend.h:341:6: note:<br>previo=
us declaration of =E2=80=98cipher_ctx_init=E2=80=99 with type<br>=E2=80=98v=
oid(cipher_ctx_t *, const uint8_t *, const char *, int)=E2=80=99 [...]<br><=
br>Previous compiler versions did not complain.<br><br>Change-Id: If0dcdde3=
0879fd6185efb2ad31399c1629c04d22<br>Signed-off-by: Frank Lichtenheld &lt;fr=
ank@...2641...&gt;<br>---<br>M src/openvpn/crypto_mbedtls.c<br>1 file chang=
ed, 2 insertions(+), 1 deletion(-)<br><br></pre><pre style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.=
net:29418/openvpn refs/changes/48/548/1</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/cr=
ypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c</span><br><span>index 1a39752=
..91485cb 100644</span><br><span>--- a/src/openvpn/crypto_mbedtls.c</span><=
br><span>+++ b/src/openvpn/crypto_mbedtls.c</span><br><span>@@ -566,11 +566=
,12 @@</span><br><span> </span><br><span> void</span><br><span> cipher_ctx_=
init(mbedtls_cipher_context_t *ctx, const uint8_t *key,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                const char *ciphername, c=
onst mbedtls_operation_t operation)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                const char *ciphername, int enc)</span><br>=
<span> {</span><br><span>     ASSERT(NULL !=3D ciphername &amp;&amp; NULL !=
=3D ctx);</span><br><span>     CLEAR(*ctx);</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    const mbedtls_operation_t ope=
ration =3D (mbedtls_operation_t)enc;</span><br><span>     const mbedtls_cip=
her_info_t *kt =3D cipher_get(ciphername);</span><br><span>     ASSERT(kt);=
</span><br><span>     size_t key_bitlen =3D mbedtls_cipher_info_get_key_bit=
len(kt);</span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/548?usp=3Demail">change 548</a>. To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit.op=
envpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sche=
ma.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/548?usp=3Demail"/><meta itemprop=3D"name" content=3D"View =
Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If0dcdde30879fd6185efb2ad313=
99c1629c04d22 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 548 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--7zJd+7iLJgE=--

