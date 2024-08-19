From: "selvanair (Code Review)" <gerrit@...515...>
Date: Mon, 19 Aug 2024 19:28:48 +0000
References: <gerrit.1724095724000.Ic6f089896191145f68ce9a11023587d05dcec4d8@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <6141bc032f787fc6c79682370ed9c68feb206ce2-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Ullopsym8so="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add a test for
 loading certificate and key to ssl context
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

--Ullopsym8so=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/729?usp=3Demail

to review the following change.


Change subject: Add a test for loading certificate and key to ssl context
......................................................................

Add a test for loading certificate and key to ssl context

The test certificate used in test_ssl.c is updated to use 2048 bit
RSA and the matching key is added.

Tests include loading certificate and key as inlined pem as well as
from files. Note that loading the key also checks that it matches
the certificate, providing an indirect test that the latter was loaded
correctly.

Change-Id: Ic6f089896191145f68ce9a11023587d05dcec4d8
Signed-off-by: Selva Nair <selva.nair@...277...>
---
M tests/unit_tests/openvpn/test_ssl.c
1 file changed, 113 insertions(+), 13 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/29/729/1

diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn=
/test_ssl.c
index da375af..651f302 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -79,18 +79,58 @@
     return;
 }

-const char *unittest_cert =3D "-----BEGIN CERTIFICATE-----\n"
-                            "MIIBuTCCAUCgAwIBAgIUTLtjSBzx53qZRvZ6Ur7D9kgoO=
HkwCgYIKoZIzj0EAwIw\n"
-                            "EzERMA8GA1UEAwwIdW5pdHRlc3QwIBcNMjMxMTIxMDk1N=
DQ3WhgPMjA3ODA4MjQw\n"
-                            "OTU0NDdaMBMxETAPBgNVBAMMCHVuaXR0ZXN0MHYwEAYHK=
oZIzj0CAQYFK4EEACID\n"
-                            "YgAEHYB2hn2xx3f4lClXDtdi36P19pMZA+kI1Dkv/Vn10=
vBZ/j9oa+P99T8duz/e\n"
-                            "QlPeHpesNJO4fX8iEDj6+vMeWejOT7jAQ4MmG5EZjpcBK=
xCfwFooEvzu8bVujUcu\n"
-                            "wTQEo1MwUTAdBgNVHQ4EFgQUPcgBEVXjF5vYfDsInoE3d=
F6UfQswHwYDVR0jBBgw\n"
-                            "FoAUPcgBEVXjF5vYfDsInoE3dF6UfQswDwYDVR0TAQH/B=
AUwAwEB/zAKBggqhkjO\n"
-                            "PQQDAgNnADBkAjBLPAGrQAyinigqiu0RomoV8TVaknVLF=
Sq6H6A8jgvzfsFCUK1O\n"
-                            "dvNZhFPM6idKB+oCME2JLOBANCSV8o7aJzq7SYHKwPyb1=
J4JFlwKe/0Jpv7oh9b1\n"
-                            "IJbuaM9Z/VSKbrIXGg=3D=3D\n"
-                            "-----END CERTIFICATE-----\n";
+static const char *const unittest_cert =3D
+    "-----BEGIN CERTIFICATE-----\n"
+    "MIIDYzCCAkugAwIBAgIRALrXTx4lqa8QgF7uGjISxmcwDQYJKoZIhvcNAQELBQAw\n"
+    "GDEWMBQGA1UEAwwNT1ZQTiBURVNUIENBMTAgFw0yMzAzMTMxNjA5MThaGA8yMTIz\n"
+    "MDIxNzE2MDkxOFowGTEXMBUGA1UEAwwOb3Zwbi10ZXN0LXJzYTEwggEiMA0GCSqG\n"
+    "SIb3DQEBAQUAA4IBDwAwggEKAoIBAQC7xFoR6fmoyfsJIQDKKgbYgFw0MzVuDAmp\n"
+    "Rx6KTEihgTchkQx9fHddWbKiOUbcEnQi3LNux7P4QVl/4dRR3skisBug6Vd5LXeB\n"
+    "GZqmpu5XZiF4DgLz1lX21G0aOogFWkie2qGEcso40159x9FBDl5A3sLP18ubeex0\n"
+    "pd/BzDFv6SLOTyVWO/GCNc8IX/i0uN4mLvoVU00SeqwTPnS+CRXrSq4JjGDJLsXl\n"
+    "0/PlxkjsgU0yOOA0Z2d8Fzk3wClwP6Hc49BOMWKstUIhLbG2DcIv8l29EuEj2w3j\n"
+    "u/7gkewol96XQ2twpPvpoVAaiVh/m7hQUcQORQCD6eJcDjOZVCArAgMBAAGjgaQw\n"
+    "gaEwCQYDVR0TBAIwADAdBgNVHQ4EFgQUqYnRaBHrZmKLtMZES5AuwqzJkGYwUwYD\n"
+    "VR0jBEwwSoAU3MLDNDOK13DqflQ8ra7FeGBXK06hHKQaMBgxFjAUBgNVBAMMDU9W\n"
+    "UE4gVEVTVCBDQTGCFD55ErHXpK2JXS3WkfBm0NB1r3vKMBMGA1UdJQQMMAoGCCsG\n"
+    "AQUFBwMCMAsGA1UdDwQEAwIHgDANBgkqhkiG9w0BAQsFAAOCAQEAZVcXrezA9Aby\n"
+    "sfUNHAsMxrex/EO0PrIPSrmSmc9sCiD8cCIeB6kL8c5iPPigoWW0uLA9zteDRFes\n"
+    "ez+Z8wBY6g8VQ0tFPURDooUg5011GZPDcuw7/PsI4+I2J9q6LHEp+6Oo4faSn/kl\n"
+    "yWYCLjM4FZdGXbOijDacQJiN6HcRv0UdodBrEVRf7YHJJmMCbCI7ZUGW2zef/+rO\n"
+    "e4Lkxh0MLYqCkNKH5ZfoGTC4Oeb0xKykswAanqgR60r+upaLU8PFuI2L9M3vc6KU\n"
+    "F6MgVGSxl6eylJgDYckvJiAbmcp2PD/LRQQOxQA0yqeAMg2cbdvclETuYD6zoFfu\n"
+    "Y8aO7dvDlw=3D=3D\n"
+    "-----END CERTIFICATE-----\n";
+
+static const char *const unittest_key =3D
+    "-----BEGIN PRIVATE KEY-----\n"
+    "MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC7xFoR6fmoyfsJ\n"
+    "IQDKKgbYgFw0MzVuDAmpRx6KTEihgTchkQx9fHddWbKiOUbcEnQi3LNux7P4QVl/\n"
+    "4dRR3skisBug6Vd5LXeBGZqmpu5XZiF4DgLz1lX21G0aOogFWkie2qGEcso40159\n"
+    "x9FBDl5A3sLP18ubeex0pd/BzDFv6SLOTyVWO/GCNc8IX/i0uN4mLvoVU00SeqwT\n"
+    "PnS+CRXrSq4JjGDJLsXl0/PlxkjsgU0yOOA0Z2d8Fzk3wClwP6Hc49BOMWKstUIh\n"
+    "LbG2DcIv8l29EuEj2w3ju/7gkewol96XQ2twpPvpoVAaiVh/m7hQUcQORQCD6eJc\n"
+    "DjOZVCArAgMBAAECggEACqkuWAAJ3cyCBVWrXs8eDmLTWV9i9DmYvtS75ixIn2rf\n"
+    "v3cl12YevN0f6FgKLuqZT3Vqdqq+DCVhuIIQ9QkKMH8BQpSdE9NCCsFyZ23o8Gtr\n"
+    "EQ7ymfecb+RFwYx7NpqWrvZI32VJGArgPZH/zorLTTGYrAZbmBtHEqRsXOuEDw97\n"
+    "slwwcWaa9ztaYC8/N/7fgsnydaCFSaOByRlWuyvSmHvn6ZwLv8ANOshY6fstC0Jb\n"
+    "BW0GpSe9eZPjpl71VT2RtpghqLV5+iAoFDHoT+eZvBospcUGtfcZSU7RrBjKB8+a\n"
+    "U1d6hwKhduVs2peIQzl+FiOSdWriLcsZv79q4sBhsQKBgQDUDVTf5BGJ8apOs/17\n"
+    "YVk+Ad8Ey8sXvsfk49psmlCRa8Z4g0LVXfrP94qzhtl8U5kE9hs3nEF4j/kX1ZWG\n"
+    "k11tdsNTZN5x5bbAgEgPA6Ap6J/uto0HS8G0vSv0lyBymdKA3p/i5Dx+8Nc9cGns\n"
+    "LGI9MvviLX7pQFIkvbaCkdKwYwKBgQDirowjWZnm7BgVhF0G1m3DY9nQTYYU185W\n"
+    "UESaO5/nVzwUrA+FypJamD+AvmlSuY8rJeQAGAS6nQr9G8/617r+GwJnzRtxC6Vl\n"
+    "4OF5BJRsD70oX4CFOOlycMoJ8tzcYVH7NI8KVocjxb+QW82hqSvEwSsvnwwn3eOW\n"
+    "nr5u5vIHmQKBgCuc3lL6Dl1ntdZgEIdau0cUjXDoFUo589TwxBDIID/4gaZxoMJP\n"
+    "hPFXAVDxMDPw4azyjSB/47tPKTUsuYcnMfT8kynIujOEwnSPLcLgxQU5kgM/ynuw\n"
+    "qhNpQOwaVRMc7f2RTCMXPBYDpNE/GJn5eu8JWGLpZovEreBeoHX0VffvAoGAVrWn\n"
+    "+3mxykhzaf+oyg3KDNysG+cbq+tlDVVE+K5oG0kePVYX1fjIBQmJ+QhdJ3y9jCbB\n"
+    "UVveqzeZVXqHEw/kgoD4aZZmsdZfnVnpRa5/y9o1ZDUr50n+2nzUe/u/ijlb77iK\n"
+    "Is04gnGJNoI3ZWhdyrSNfXjcYH+bKClu9OM4n7kCgYAorc3PAX7M0bsQrrqYxUS8\n"
+    "56UU0YdhAgYitjM7Fm/0iIm0vDpSevxL9js4HnnsSMVR77spCBAGOCCZrTcI3Ejg\n"
+    "xKDYzh1xlfMRjJBuBu5Pd55ZAv9NXFGpsX5SO8fDZQJMwpcbQH36+UdqRRFDpjJ0\n"
+    "ZbX6nKcJ7jciJVKJds59Jg=3D=3D\n"
+    "-----END PRIVATE KEY-----\n";

 static const char *
 get_tmp_dir(void)
@@ -105,6 +145,44 @@
     return ret;
 }

+static struct
+{
+    struct gc_arena gc;
+    const char *certfile;
+    const char *keyfile;
+} global_state;
+
+static int
+init(void **state)
+{
+    (void) state;
+    global_state.gc =3D gc_new();
+    global_state.certfile =3D platform_create_temp_file(get_tmp_dir(), "ce=
rt", &global_state.gc);
+    global_state.keyfile =3D platform_create_temp_file(get_tmp_dir(), "key=
", &global_state.gc);
+
+    int certfd =3D open(global_state.certfile, O_RDWR);
+    int keyfd =3D open(global_state.keyfile, O_RDWR);
+    if (certfd < 0 || keyfd < 0)
+    {
+        fail_msg("make tmpfile for certificate or key data failed (error =
=3D %d)", errno);
+    }
+    assert_int_equal(write(certfd, unittest_cert, strlen(unittest_cert)), =
strlen(unittest_cert));
+    assert_int_equal(write(keyfd, unittest_key, strlen(unittest_key)), str=
len(unittest_key));
+    close(certfd);
+    close(keyfd);
+    return 0;
+}
+
+static int
+cleanup(void **state)
+{
+    (void) state;
+    unlink(global_state.certfile);
+    unlink(global_state.keyfile);
+    gc_free(&global_state.gc);
+    return 0;
+}
+
 static void
 crypto_pem_encode_certificate(void **state)
 {
@@ -136,6 +214,27 @@
 }

 static void
+test_load_certificate_and_key(void **state)
+{
+    (void) state;
+    struct tls_root_ctx ctx =3D { 0 };
+
+    /* test loading of inlined cert and key.
+     * loading the key also checks that it matches the loaded certificate
+     */
+    tls_ctx_client_new(&ctx);
+    tls_ctx_load_cert_file(&ctx, unittest_cert, true);
+    assert_int_equal(tls_ctx_load_priv_file(&ctx, unittest_key, true), 0);
+    tls_ctx_free(&ctx);
+
+    /* test loading of cert and key from file */
+    tls_ctx_client_new(&ctx);
+    tls_ctx_load_cert_file(&ctx, global_state.certfile, false);
+    assert_int_equal(tls_ctx_load_priv_file(&ctx, global_state.keyfile, fa=
lse), 0);
+    tls_ctx_free(&ctx);
+}
+
+static void
 init_implicit_iv(struct crypto_options *co)
 {
     cipher_ctx_t *cipher =3D co->key_ctx_bi.encrypt.cipher;
@@ -352,6 +451,7 @@

     const struct CMUnitTest tests[] =3D {
         cmocka_unit_test(crypto_pem_encode_certificate),
+        cmocka_unit_test(test_load_certificate_and_key),
         cmocka_unit_test(test_data_channel_roundtrip_aes_128_gcm),
         cmocka_unit_test(test_data_channel_roundtrip_aes_192_gcm),
         cmocka_unit_test(test_data_channel_roundtrip_aes_256_gcm),
@@ -366,7 +466,7 @@
     tls_init_lib();
 #endif

-    int ret =3D cmocka_run_group_tests_name("ssl tests", tests, NULL, NULL=
);
+    int ret =3D cmocka_run_group_tests_name("ssl tests", tests, init, clea=
nup);

 #if defined(ENABLE_CRYPTO_OPENSSL)
     tls_free_lib();

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/729?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic6f089896191145f68ce9a11023587d05dcec4d8
Gerrit-Change-Number: 729
Gerrit-PatchSet: 1
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--Ullopsym8so=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>selvanair would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/729?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Add a test for loading certificate and key to ssl context<br>=
<br>The test certificate used in test_ssl.c is updated to use 2048 bit<br>R=
SA and the matching key is added.<br><br>Tests include loading certificate =
and key as inlined pem as well as<br>from files. Note that loading the key =
also checks that it matches<br>the certificate, providing an indirect test =
that the latter was loaded<br>correctly.<br><br>Change-Id: Ic6f089896191145=
f68ce9a11023587d05dcec4d8<br>Signed-off-by: Selva Nair &lt;selva.nair@...1664...=
7...&gt;<br>---<br>M tests/unit_tests/openvpn/test_ssl.c<br>1 file changed,=
 113 insertions(+), 13 deletions(-)<br><br></pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn=
.net:29418/openvpn refs/changes/29/729/1</pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;"><span>diff --git a/tests/unit_te=
sts/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c</span><br><spa=
n>index da375af..651f302 100644</span><br><span>--- a/tests/unit_tests/open=
vpn/test_ssl.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_ssl.c</s=
pan><br><span>@@ -79,18 +79,58 @@</span><br><span>     return;</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-const char *unittest_cert =3D &quot;-----BEGIN CERTIFICATE-----\n&quot;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
      &quot;MIIBuTCCAUCgAwIBAgIUTLtjSBzx53qZRvZ6Ur7D9kgoOHkwCgYIKoZIzj0EAwI=
w\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
                &quot;EzERMA8GA1UEAwwIdW5pdHRlc3QwIBcNMjMxMTIxMDk1NDQ3WhgPM=
jA3ODA4MjQw\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                          &quot;OTU0NDdaMBMxETAPBgNVBAMMCHVuaXR0ZXN0MHYwEAY=
HKoZIzj0CAQYFK4EEACID\n&quot;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                            &quot;YgAEHYB2hn2xx3f4lClXDtdi36P19pMZA=
+kI1Dkv/Vn10vBZ/j9oa+P99T8duz/e\n&quot;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                            &quot;QlPeHpesNJO4fX8iEDj6+vM=
eWejOT7jAQ4MmG5EZjpcBKxCfwFooEvzu8bVujUcu\n&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                            &quot;wTQEo1MwUTAdB=
gNVHQ4EFgQUPcgBEVXjF5vYfDsInoE3dF6UfQswHwYDVR0jBBgw\n&quot;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                            &quot;FoA=
UPcgBEVXjF5vYfDsInoE3dF6UfQswDwYDVR0TAQH/BAUwAwEB/zAKBggqhkjO\n&quot;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                           =
 &quot;PQQDAgNnADBkAjBLPAGrQAyinigqiu0RomoV8TVaknVLFSq6H6A8jgvzfsFCUK1O\n&q=
uot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
           &quot;dvNZhFPM6idKB+oCME2JLOBANCSV8o7aJzq7SYHKwPyb1J4JFlwKe/0Jpv=
7oh9b1\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                     &quot;IJbuaM9Z/VSKbrIXGg=3D=3D\n&quot;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                            &quot;---=
--END CERTIFICATE-----\n&quot;;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+static const char *const unittest_cert =3D</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    &quot;-----BEGIN CERTIFICATE-----\n&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;MIID=
YzCCAkugAwIBAgIRALrXTx4lqa8QgF7uGjISxmcwDQYJKoZIhvcNAQELBQAw\n&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;GDEWMBQGA1UEAwwN=
T1ZQTiBURVNUIENBMTAgFw0yMzAzMTMxNjA5MThaGA8yMTIz\n&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    &quot;MDIxNzE2MDkxOFowGTEXMBUGA1UE=
AwwOb3Zwbi10ZXN0LXJzYTEwggEiMA0GCSqG\n&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    &quot;SIb3DQEBAQUAA4IBDwAwggEKAoIBAQC7xFoR6fmo=
yfsJIQDKKgbYgFw0MzVuDAmp\n&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    &quot;Rx6KTEihgTchkQx9fHddWbKiOUbcEnQi3LNux7P4QVl/4dRR3ski=
sBug6Vd5LXeB\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    &quot;GZqmpu5XZiF4DgLz1lX21G0aOogFWkie2qGEcso40159x9FBDl5A3sLP18ubeex0=
\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;p=
d/BzDFv6SLOTyVWO/GCNc8IX/i0uN4mLvoVU00SeqwTPnS+CRXrSq4JjGDJLsXl\n&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;0/PlxkjsgU0yO=
OA0Z2d8Fzk3wClwP6Hc49BOMWKstUIhLbG2DcIv8l29EuEj2w3j\n&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    &quot;u/7gkewol96XQ2twpPvpoVAai=
Vh/m7hQUcQORQCD6eJcDjOZVCArAgMBAAGjgaQw\n&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    &quot;gaEwCQYDVR0TBAIwADAdBgNVHQ4EFgQUqYnRa=
BHrZmKLtMZES5AuwqzJkGYwUwYD\n&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    &quot;VR0jBEwwSoAU3MLDNDOK13DqflQ8ra7FeGBXK06hHKQaMBgxF=
jAUBgNVBAMMDU9W\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    &quot;UE4gVEVTVCBDQTGCFD55ErHXpK2JXS3WkfBm0NB1r3vKMBMGA1UdJQQMMAoGC=
CsG\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quo=
t;AQUFBwMCMAsGA1UdDwQEAwIHgDANBgkqhkiG9w0BAQsFAAOCAQEAZVcXrezA9Aby\n&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;sfUNHAsMxr=
ex/EO0PrIPSrmSmc9sCiD8cCIeB6kL8c5iPPigoWW0uLA9zteDRFes\n&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    &quot;ez+Z8wBY6g8VQ0tFPURDoo=
Ug5011GZPDcuw7/PsI4+I2J9q6LHEp+6Oo4faSn/kl\n&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    &quot;yWYCLjM4FZdGXbOijDacQJiN6HcRv0Udod=
BrEVRf7YHJJmMCbCI7ZUGW2zef/+rO\n&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    &quot;e4Lkxh0MLYqCkNKH5ZfoGTC4Oeb0xKykswAanqgR60r+up=
aLU8PFuI2L9M3vc6KU\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    &quot;F6MgVGSxl6eylJgDYckvJiAbmcp2PD/LRQQOxQA0yqeAMg2cbdvclETuYD=
6zoFfu\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &=
quot;Y8aO7dvDlw=3D=3D\n&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    &quot;-----END CERTIFICATE-----\n&quot;;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+static const char *const unittest_key =3D</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    &quot;-----BEGIN PRIVATE KEY-----=
\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;M=
IIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC7xFoR6fmoyfsJ\n&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;IQDKKgbYgFw0M=
zVuDAmpRx6KTEihgTchkQx9fHddWbKiOUbcEnQi3LNux7P4QVl/\n&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    &quot;4dRR3skisBug6Vd5LXeBGZqmp=
u5XZiF4DgLz1lX21G0aOogFWkie2qGEcso40159\n&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    &quot;x9FBDl5A3sLP18ubeex0pd/BzDFv6SLOTyVWO=
/GCNc8IX/i0uN4mLvoVU00SeqwT\n&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    &quot;PnS+CRXrSq4JjGDJLsXl0/PlxkjsgU0yOOA0Z2d8Fzk3wClwP=
6Hc49BOMWKstUIh\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    &quot;LbG2DcIv8l29EuEj2w3ju/7gkewol96XQ2twpPvpoVAaiVh/m7hQUcQORQCD6=
eJc\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quo=
t;DjOZVCArAgMBAAECggEACqkuWAAJ3cyCBVWrXs8eDmLTWV9i9DmYvtS75ixIn2rf\n&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;v3cl12YevN=
0f6FgKLuqZT3Vqdqq+DCVhuIIQ9QkKMH8BQpSdE9NCCsFyZ23o8Gtr\n&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    &quot;EQ7ymfecb+RFwYx7NpqWrv=
ZI32VJGArgPZH/zorLTTGYrAZbmBtHEqRsXOuEDw97\n&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    &quot;slwwcWaa9ztaYC8/N/7fgsnydaCFSaOByR=
lWuyvSmHvn6ZwLv8ANOshY6fstC0Jb\n&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    &quot;BW0GpSe9eZPjpl71VT2RtpghqLV5+iAoFDHoT+eZvBospc=
UGtfcZSU7RrBjKB8+a\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    &quot;U1d6hwKhduVs2peIQzl+FiOSdWriLcsZv79q4sBhsQKBgQDUDVTf5BGJ8a=
pOs/17\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &=
quot;YVk+Ad8Ey8sXvsfk49psmlCRa8Z4g0LVXfrP94qzhtl8U5kE9hs3nEF4j/kX1ZWG\n&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;k11tdsN=
TZN5x5bbAgEgPA6Ap6J/uto0HS8G0vSv0lyBymdKA3p/i5Dx+8Nc9cGns\n&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;LGI9MvviLX7pQFIkvba=
CkdKwYwKBgQDirowjWZnm7BgVhF0G1m3DY9nQTYYU185W\n&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &quot;UESaO5/nVzwUrA+FypJamD+AvmlSuY8=
rJeQAGAS6nQr9G8/617r+GwJnzRtxC6Vl\n&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    &quot;4OF5BJRsD70oX4CFOOlycMoJ8tzcYVH7NI8KVocjxb+=
QW82hqSvEwSsvnwwn3eOW\n&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    &quot;nr5u5vIHmQKBgCuc3lL6Dl1ntdZgEIdau0cUjXDoFUo589TwxBDIID/=
4gaZxoMJP\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  &quot;hPFXAVDxMDPw4azyjSB/47tPKTUsuYcnMfT8kynIujOEwnSPLcLgxQU5kgM/ynuw\n&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;qhNp=
QOwaVRMc7f2RTCMXPBYDpNE/GJn5eu8JWGLpZovEreBeoHX0VffvAoGAVrWn\n&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;+3mxykhzaf+oyg3K=
DNysG+cbq+tlDVVE+K5oG0kePVYX1fjIBQmJ+QhdJ3y9jCbB\n&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    &quot;UVveqzeZVXqHEw/kgoD4aZZmsdZf=
nVnpRa5/y9o1ZDUr50n+2nzUe/u/ijlb77iK\n&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    &quot;Is04gnGJNoI3ZWhdyrSNfXjcYH+bKClu9OM4n7kC=
gYAorc3PAX7M0bsQrrqYxUS8\n&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    &quot;56UU0YdhAgYitjM7Fm/0iIm0vDpSevxL9js4HnnsSMVR77spCBAG=
OCCZrTcI3Ejg\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    &quot;xKDYzh1xlfMRjJBuBu5Pd55ZAv9NXFGpsX5SO8fDZQJMwpcbQH36+UdqRRFDpjJ0=
\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;Z=
bX6nKcJ7jciJVKJds59Jg=3D=3D\n&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    &quot;-----END PRIVATE KEY-----\n&quot;;</span><br><spa=
n> </span><br><span> static const char *</span><br><span> get_tmp_dir(void)=
</span><br><span>@@ -105,6 +145,44 @@</span><br><span>     return ret;</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+static struct</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
gc_arena gc;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st char *certfile;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   const char *keyfile;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+} global_state;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+init(void **state)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    (void) state;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    global_state.gc =3D gc_new();</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    global_state.certfile =3D platf=
orm_create_temp_file(get_tmp_dir(), &quot;cert&quot;, &amp;global_state.gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    global_state.k=
eyfile =3D platform_create_temp_file(get_tmp_dir(), &quot;key&quot;, &amp;g=
lobal_state.gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    int certfd =3D ope=
n(global_state.certfile, O_RDWR);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    int keyfd =3D open(global_state.keyfile, O_RDWR);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (certfd &lt; 0 || ke=
yfd &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        fail_msg(&quot=
;make tmpfile for certificate or key data failed (error =3D %d)&quot;, errn=
o);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(write(cer=
tfd, unittest_cert, strlen(unittest_cert)), strlen(unittest_cert));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(write(=
keyfd, unittest_key, strlen(unittest_key)), strlen(unittest_key));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    close(certfd);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    close(keyfd);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cleanup(=
void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    (void) state;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    unlink(global_state.ce=
rtfile);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unlink(=
global_state.keyfile);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    gc_free(&amp;global_state.gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    return 0;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span> static void</span><br><span> crypto_pem_encode_certificate(void=
 **state)</span><br><span> {</span><br><span>@@ -136,6 +214,27 @@</span><br=
><span> }</span><br><span> </span><br><span> static void</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+test_load_certificate_and_key(void **s=
tate)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    (void) state;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct tls_root_ctx ctx =3D { =
0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* test loading of inlined cer=
t and key.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * lo=
ading the key also checks that it matches the loaded certificate</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    tls_ctx_client_new(&amp;ctx);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    tls_ctx_load_cert_file(=
&amp;ctx, unittest_cert, true);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_int_equal(tls_ctx_load_priv_file(&amp;ctx, unittest_=
key, true), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
tls_ctx_free(&amp;ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* test loa=
ding of cert and key from file */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    tls_ctx_client_new(&amp;ctx);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    tls_ctx_load_cert_file(&amp;ctx, global_sta=
te.certfile, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_int_equal(tls_ctx_load_priv_file(&amp;ctx, global_state.keyfile=
, false), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tl=
s_ctx_free(&amp;ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span> init_i=
mplicit_iv(struct crypto_options *co)</span><br><span> {</span><br><span>  =
   cipher_ctx_t *cipher =3D co-&gt;key_ctx_bi.encrypt.cipher;</span><br><sp=
an>@@ -352,6 +451,7 @@</span><br><span> </span><br><span>     const struct =
CMUnitTest tests[] =3D {</span><br><span>         cmocka_unit_test(crypto_p=
em_encode_certificate),</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        cmocka_unit_test(test_load_certificate_and_key),</span><br><spa=
n>         cmocka_unit_test(test_data_channel_roundtrip_aes_128_gcm),</span=
><br><span>         cmocka_unit_test(test_data_channel_roundtrip_aes_192_gc=
m),</span><br><span>         cmocka_unit_test(test_data_channel_roundtrip_a=
es_256_gcm),</span><br><span>@@ -366,7 +466,7 @@</span><br><span>     tls_i=
nit_lib();</span><br><span> #endif</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int ret =3D cmocka_run_group_tests_name=
(&quot;ssl tests&quot;, tests, NULL, NULL);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    int ret =3D cmocka_run_group_tests_name(&quot;s=
sl tests&quot;, tests, init, cleanup);</span><br><span> </span><br><span> #=
if defined(ENABLE_CRYPTO_OPENSSL)</span><br><span>     tls_free_lib();</spa=
n><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/729?usp=3Demail">change 729</a>. To unsubscribe, or fo=
r help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/set=
tings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/729?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic6f089896191145f68ce9a11023=
587d05dcec4d8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 729 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--Ullopsym8so=--

