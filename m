From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 4 Apr 2026 15:05:50 +0000
In-Reply-To: <gerrit.1774974242000.Iacbd8195cdedc7226bddc686ca8dccf9f25f8842@...2715...>
References: <gerrit.1774974242000.Iacbd8195cdedc7226bddc686ca8dccf9f25f8842@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <f2af3e23eb86d829447c75af6c1c20ed09b3cfb0-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pIUcYXeb35I="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add unit test for
 printing various details of certificates
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

--pIUcYXeb35I=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/1598?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: Add unit test for printing various details of certificates
......................................................................

Add unit test for printing various details of certificates

These unit tests will ensure that refactoring of these methods does not
change the output.

Change-Id: Iacbd8195cdedc7226bddc686ca8dccf9f25f8842
Signed-off-by: Arne Schwabe <arne@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1598
Message-Id: <20260331173403.3082-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
389.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M tests/unit_tests/openvpn/test_ssl.c
1 file changed, 82 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/98/1598/4

diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn=
/test_ssl.c
index 2b73ee7..0e9cecf 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -46,7 +46,9 @@
 #include "test_common.h"
 #include "ssl.h"
 #include "buffer.h"
+#include "cert_data.h"
 #include "packet_id.h"
+#include "ssl_verify.h"

 /* Mock function to be allowed to include win32.c which is required for
  * getting the temp directory */
@@ -750,6 +752,83 @@
     test_data_channel_known_vectors_run(false);
 }

+#if defined(ENABLE_CRYPTO_MBEDTLS)
+static openvpn_x509_cert_t *
+get_certificate(const char *cert_str)
+{
+    mbedtls_x509_crt *cert;
+    ALLOC_OBJ_CLEAR(cert, mbedtls_x509_crt);
+    int ret =3D mbedtls_x509_crt_parse(cert, (const unsigned char *)cert_s=
tr,
+                                     strlen(cert_str) + 1);
+
+    assert_int_equal(ret, 0);
+    return cert;
+}
+
+static void
+free_certificate(openvpn_x509_cert_t *cert)
+{
+    mbedtls_x509_crt_free(cert);
+    free(cert);
+}
+#else
+static openvpn_x509_cert_t *
+get_certificate(const char *cert_str)
+{
+    BIO *in =3D BIO_new_mem_buf((char *)cert1, -1);
+    assert_non_null(in);
+    X509 *cert =3D PEM_read_bio_X509(in, NULL, NULL, NULL);
+    assert_non_null(cert);
+    BIO_free(in);
+    return cert;
+}
+
+static void
+free_certificate(openvpn_x509_cert_t *cert)
+{
+    X509_free(cert);
+}
+#endif
+
+void
+crypto_test_print_cert_details(void **state)
+{
+    openvpn_x509_cert_t *cert =3D get_certificate(cert1);
+    struct gc_arena gc =3D gc_new();
+
+    const char *fp =3D backend_x509_get_serial_hex(cert, &gc);
+
+    /* we messed this up between TLS libraries. But let's at least notice =
in
+     * the future ...*/
+#if defined(ENABLE_CRYPTO_MBEDTLS)
+    assert_string_equal(fp, "82:6B:DD:CC:BD:E5:5E:B7:08:F1:2D:68:00:3C:24:=
DE");
+#else
+    assert_string_equal(fp, "82:6b:dd:cc:bd:e5:5e:b7:08:f1:2d:68:00:3c:24:=
de");
+#endif
+
+    const char *sn =3D backend_x509_get_serial(cert, &gc);
+    assert_string_equal(sn, "173359713849739808110610111821055272158");
+
+    char username[TLS_USERNAME_LEN + 1] =3D { 0 }; /* null-terminated */
+
+    int ret =3D backend_x509_get_username(username, sizeof(username), "CN",
+                                        cert);
+
+    assert_string_equal(username, "ovpn-test-ec1");
+    assert_int_equal(ret, SUCCESS);
+
+#ifndef ENABLE_CRYPTO_MBEDTLS
+    /* mbed TLS does not implement this */
+    ret =3D backend_x509_get_username(username, sizeof(username), "serialN=
umber",
+                                    cert);
+    assert_int_equal(ret, SUCCESS);
+    assert_string_equal(username, "0x826BDDCCBDE55EB708F12D68003C24DE");
+#endif
+
+    gc_free(&gc);
+    free_certificate(cert);
+}
+

 int
 main(void)
@@ -773,7 +852,9 @@
         cmocka_unit_test(test_data_channel_roundtrip_aes_256_cbc),
         cmocka_unit_test(test_data_channel_roundtrip_bf_cbc),
         cmocka_unit_test(test_data_channel_known_vectors_epoch),
-        cmocka_unit_test(test_data_channel_known_vectors_shortpktid)
+        cmocka_unit_test(test_data_channel_known_vectors_shortpktid),
+        cmocka_unit_test(crypto_test_print_cert_details)
+
     };

 #if defined(ENABLE_CRYPTO_OPENSSL)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1598?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iacbd8195cdedc7226bddc686ca8dccf9f25f8842
Gerrit-Change-Number: 1598
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--pIUcYXeb35I=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by plaisthos.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1598?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">Add unit test for printing v=
arious details of certificates<br><br>These unit tests will ensure that ref=
actoring of these methods does not<br>change the output.<br><br>Change-Id: =
Iacbd8195cdedc7226bddc686ca8dccf9f25f8842<br>Signed-off-by: Arne Schwabe &l=
t;arne@...1227...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+=
/1598<br>Message-Id: &lt;20260331173403.3082-1-gert@...1296...&gt;<br>URL: =
https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36389.h=
tml<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M test=
s/unit_tests/openvpn/test_ssl.c<br>1 file changed, 82 insertions(+), 1 dele=
tion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/=
openvpn refs/changes/98/1598/4</pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;"><span>diff --git a/tests/unit_tests/openvp=
n/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c</span><br><span>index 2b=
73ee7..0e9cecf 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_s=
sl.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_ssl.c</span><br><s=
pan>@@ -46,7 +46,9 @@</span><br><span> #include &quot;test_common.h&quot;</=
span><br><span> #include &quot;ssl.h&quot;</span><br><span> #include &quot;=
buffer.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#incl=
ude &quot;cert_data.h&quot;</span><br><span> #include &quot;packet_id.h&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ss=
l_verify.h&quot;</span><br><span> </span><br><span> /* Mock function to be =
allowed to include win32.c which is required for</span><br><span>  * gettin=
g the temp directory */</span><br><span>@@ -750,6 +752,83 @@</span><br><spa=
n>     test_data_channel_known_vectors_run(false);</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if def=
ined(ENABLE_CRYPTO_MBEDTLS)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static openvpn_x509_cert_t *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+get_certificate(const char *cert_str)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    mbedtls_x509_crt *cert;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR(cert, mbedtls_x509_crt);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D mbedtls_x=
509_crt_parse(cert, (const unsigned char *)cert_str,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                     strl=
en(cert_str) + 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal=
(ret, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 cert;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+free_certificate(openvpn_x509_cert_t *cert)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    mbedtls_x509_crt_free(cert);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    free(cert);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#else</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static openvpn_x509_cert_t *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+get_certificate(const char *cert_str)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    BIO *in =3D BIO_new_mem_buf((char *)cert1, -1);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_non_null(in);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    X509 *cert =3D PEM_read=
_bio_X509(in, NULL, NULL, NULL);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_non_null(cert);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    BIO_free(in);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    return cert;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+free_certificate(openvpn_x509_=
cert_t *cert)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    X509_free(cert);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+crypto_test_p=
rint_cert_details(void **state)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    op=
envpn_x509_cert_t *cert =3D get_certificate(cert1);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char *fp =3D backend_x509_get_s=
erial_hex(cert, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* we mes=
sed this up between TLS libraries. But let&#39;s at least notice in</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     * the future ...*/</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(ENABLE_CRYP=
TO_MBEDTLS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_string_equal(fp, &quot;82:6B:DD:CC:BD:E5:5E:B7:08:F1:2D:68:00:3C:24:DE&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(fp,=
 &quot;82:6b:dd:cc:bd:e5:5e:b7:08:f1:2d:68:00:3c:24:de&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const char *sn =3D backend_x509_get_serial(cert, &amp;gc);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equ=
al(sn, &quot;173359713849739808110610111821055272158&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    char username[TLS_USERNAME_LEN + 1] =3D { 0 }; /*=
 null-terminated */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D bac=
kend_x509_get_username(username, sizeof(username), &quot;CN&quot;,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
            cert);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_eq=
ual(username, &quot;ovpn-test-ec1&quot;);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_int_equal(ret, SUCCESS);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#ifndef ENABLE_CRYPTO_MBEDTLS</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* mbed TLS does not implement this */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D backend_x50=
9_get_username(username, sizeof(username), &quot;serialNumber&quot;,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
          cert);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_int_equal(ret, SUCCESS);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_string_equal(username, &quot;0x826BDDCCBDE55EB708F1=
2D68003C24DE&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    free_certificate(cert);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> </span><br><span> int=
</span><br><span> main(void)</span><br><span>@@ -773,7 +852,9 @@</span><br>=
<span>         cmocka_unit_test(test_data_channel_roundtrip_aes_256_cbc),</=
span><br><span>         cmocka_unit_test(test_data_channel_roundtrip_bf_cbc=
),</span><br><span>         cmocka_unit_test(test_data_channel_known_vector=
s_epoch),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        cmoc=
ka_unit_test(test_data_channel_known_vectors_shortpktid)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_data_cha=
nnel_known_vectors_shortpktid),</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        cmocka_unit_test(crypto_test_print_cert_details)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     };</=
span><br><span> </span><br><span> #if defined(ENABLE_CRYPTO_OPENSSL)</span>=
<br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1598?usp=3Demail">change 1598</a>. To unsubscribe, or fo=
r help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/set=
tings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schem=
a.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://s=
chema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1598?usp=3Demail"/><meta itemprop=3D"name" content=3D"View =
Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iacbd8195cdedc7226bddc686ca8=
dccf9f25f8842 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1598 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--pIUcYXeb35I=--

