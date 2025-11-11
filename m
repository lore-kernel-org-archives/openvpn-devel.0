From: "d12fk (Code Review)" <gerrit@...515...>
Date: Tue, 11 Nov 2025 12:51:15 +0000
References: <gerrit.1762865473000.I13e34119303e056fdb51ff9925f4944171c824f2@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <fd1b24eae4247b7a8fef295e57d645eda549933f-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uIoGxJ+JjE0="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: msvc: fix struct
 initialization for v19 compilers
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

--uIoGxJ+JjE0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1366?usp=3Demail

to review the following change.


Change subject: msvc: fix struct initialization for v19 compilers
......................................................................

msvc: fix struct initialization for v19 compilers

Newer version of MSVC do not show the error anymore, but I do get, e.g.:

  test_crypto.c(538,23): error C2059: syntax error: '}'

with version 19.38.33133 installed on a test system.

Change-Id: I13e34119303e056fdb51ff9925f4944171c824f2
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M src/openvpn/ssl_verify_mbedtls.c
M tests/unit_tests/openvpn/test_crypto.c
M tests/unit_tests/openvpn/test_pkcs11.c
3 files changed, 3 insertions(+), 3 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/66/1366/1

diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbed=
tls.c
index 9e2aa19..80ef837 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -230,7 +230,7 @@
      * headers and footer */
     struct buffer pem =3D alloc_buf_gc(cert->raw.len * 3 + 100, &gc);

-    struct buffer der =3D {};
+    struct buffer der =3D { 0 };
     buf_set_read(&der, cert->raw.p, cert->raw.len);

     if (!crypto_pem_encode("CERTIFICATE", &pem, &der, &gc))
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/open=
vpn/test_crypto.c
index 93dfa42..ba386bd 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -535,7 +535,7 @@
                         0x1d, 0x6f, 0x64, 0x8b, 0xdf, 0x96, 0x59, 0x67, 0x=
76, 0xaf, 0xdb,
                         0x63, 0x77, 0xac, 0x43, 0x4c, 0x1c, 0x29, 0x3c, 0x=
cb, 0x04 };

-    uint8_t info[] =3D {};
+    uint8_t info[] =3D { 0 };

     int L =3D 42;
     uint8_t okm[42] =3D { 0x8d, 0xa4, 0xe7, 0x75, 0xa5, 0x63, 0xc1, 0x8f, =
0x71, 0x5f, 0x80,
diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/open=
vpn/test_pkcs11.c
index 81d2280..44bfa1d 100644
--- a/tests/unit_tests/openvpn/test_pkcs11.c
+++ b/tests/unit_tests/openvpn/test_pkcs11.c
@@ -411,7 +411,7 @@
 test_tls_ctx_use_pkcs11(void **state)
 {
     (void)state;
-    struct tls_root_ctx tls_ctx =3D {};
+    struct tls_root_ctx tls_ctx =3D { 0 };
     uint8_t sha1[HASHSIZE];
     for (struct test_cert *c =3D certs; c->cert; c++)
     {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1366?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I13e34119303e056fdb51ff9925f4944171c824f2
Gerrit-Change-Number: 1366
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--uIoGxJ+JjE0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>d12fk would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1366?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">msvc: fix struct initialization for v19 com=
pilers<br><br>Newer version of MSVC do not show the error anymore, but I do=
 get, e.g.:<br><br>  test_crypto.c(538,23): error C2059: syntax error: &#39=
;}&#39;<br><br>with version 19.38.33133 installed on a test system.<br><br>=
Change-Id: I13e34119303e056fdb51ff9925f4944171c824f2<br>Signed-off-by: Heik=
o Hund &lt;heiko@...2662...&gt;<br>---<br>M src/openvpn/ssl_verify_mbedtls.=
c<br>M tests/unit_tests/openvpn/test_crypto.c<br>M tests/unit_tests/openvpn=
/test_pkcs11.c<br>3 files changed, 3 insertions(+), 3 deletions(-)<br><br><=
/pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/cha=
nges/66/1366/1</pre><pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;"><span>diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/=
openvpn/ssl_verify_mbedtls.c</span><br><span>index 9e2aa19..80ef837 100644<=
/span><br><span>--- a/src/openvpn/ssl_verify_mbedtls.c</span><br><span>+++ =
b/src/openvpn/ssl_verify_mbedtls.c</span><br><span>@@ -230,7 +230,7 @@</spa=
n><br><span>      * headers and footer */</span><br><span>     struct buffe=
r pem =3D alloc_buf_gc(cert-&gt;raw.len * 3 + 100, &amp;gc);</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer =
der =3D {};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct buffer der =3D { 0 };</span><br><span>     buf_set_read(&amp;der, cert-&=
gt;raw.p, cert-&gt;raw.len);</span><br><span> </span><br><span>     if (!cr=
ypto_pem_encode(&quot;CERTIFICATE&quot;, &amp;pem, &amp;der, &amp;gc))</spa=
n><br><span>diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/uni=
t_tests/openvpn/test_crypto.c</span><br><span>index 93dfa42..ba386bd 100644=
</span><br><span>--- a/tests/unit_tests/openvpn/test_crypto.c</span><br><sp=
an>+++ b/tests/unit_tests/openvpn/test_crypto.c</span><br><span>@@ -535,7 +=
535,7 @@</span><br><span>                         0x1d, 0x6f, 0x64, 0x8b, 0=
xdf, 0x96, 0x59, 0x67, 0x76, 0xaf, 0xdb,</span><br><span>                  =
       0x63, 0x77, 0xac, 0x43, 0x4c, 0x1c, 0x29, 0x3c, 0xcb, 0x04 };</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_=
t info[] =3D {};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 uint8_t info[] =3D { 0 };</span><br><span> </span><br><span>     int L =3D=
 42;</span><br><span>     uint8_t okm[42] =3D { 0x8d, 0xa4, 0xe7, 0x75, 0xa=
5, 0x63, 0xc1, 0x8f, 0x71, 0x5f, 0x80,</span><br><span>diff --git a/tests/u=
nit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/openvpn/test_pkcs11.c</s=
pan><br><span>index 81d2280..44bfa1d 100644</span><br><span>--- a/tests/uni=
t_tests/openvpn/test_pkcs11.c</span><br><span>+++ b/tests/unit_tests/openvp=
n/test_pkcs11.c</span><br><span>@@ -411,7 +411,7 @@</span><br><span> test_t=
ls_ctx_use_pkcs11(void **state)</span><br><span> {</span><br><span>     (vo=
id)state;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct t=
ls_root_ctx tls_ctx =3D {};</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct tls_root_ctx tls_ctx =3D { 0 };</span><br><span>     uin=
t8_t sha1[HASHSIZE];</span><br><span>     for (struct test_cert *c =3D cert=
s; c-&gt;cert; c++)</span><br><span>     {</span><br><span></span><br></pre=
><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1366?us=
p=3Demail">change 1366</a>. To unsubscribe, or for help writing mail filter=
s, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">setting=
s</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><lin=
k itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1366?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I13e34119303e056fdb51ff9925f=
4944171c824f2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1366 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--uIoGxJ+JjE0=--

