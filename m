From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 8 Sep 2025 13:18:05 +0000
References: <gerrit.1757337482000.I327ecc9a85dd906517c28e71fe500883bfa028a4@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <b9669d89a110a3f575f39e778e0000fbcdb3e3a1-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JcxZT5PhbPo="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Switch test_ssl
 certificate from RSA 2048 to secp384r1
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

--JcxZT5PhbPo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1172?usp=3Demail

to review the following change.


Change subject: Switch test_ssl certificate from RSA 2048 to secp384r1
......................................................................

Switch test_ssl certificate from RSA 2048 to secp384r1

This allow the unit test to also run in environments that have seclevel
(SSL_CTX_set_security_level) set to 3.

Closes: openvpn/openvpn#830
Change-Id: I327ecc9a85dd906517c28e71fe500883bfa028a4
---
M tests/unit_tests/openvpn/test_ssl.c
1 file changed, 23 insertions(+), 46 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/72/1172/1

diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn=
/test_ssl.c
index 7bf5396..894d332 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -83,58 +83,35 @@
     return;
 }

+/* generated using
+ * openssl req -x509 -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -keyo=
ut - \
+ * -noenc -sha256 -days 3650 -subj '/CN=3Dovpn-test-secp384r1'  -nodes \
+ * -addext 'subjectAltName=3DDNS:unittest.example.com' \
+ * -addext 'extendedKeyUsage=3DclientAuth'
+ */
 static const char *const unittest_cert =3D
     "-----BEGIN CERTIFICATE-----\n"
-    "MIIDYzCCAkugAwIBAgIRALrXTx4lqa8QgF7uGjISxmcwDQYJKoZIhvcNAQELBQAw\n"
-    "GDEWMBQGA1UEAwwNT1ZQTiBURVNUIENBMTAgFw0yMzAzMTMxNjA5MThaGA8yMTIz\n"
-    "MDIxNzE2MDkxOFowGTEXMBUGA1UEAwwOb3Zwbi10ZXN0LXJzYTEwggEiMA0GCSqG\n"
-    "SIb3DQEBAQUAA4IBDwAwggEKAoIBAQC7xFoR6fmoyfsJIQDKKgbYgFw0MzVuDAmp\n"
-    "Rx6KTEihgTchkQx9fHddWbKiOUbcEnQi3LNux7P4QVl/4dRR3skisBug6Vd5LXeB\n"
-    "GZqmpu5XZiF4DgLz1lX21G0aOogFWkie2qGEcso40159x9FBDl5A3sLP18ubeex0\n"
-    "pd/BzDFv6SLOTyVWO/GCNc8IX/i0uN4mLvoVU00SeqwTPnS+CRXrSq4JjGDJLsXl\n"
-    "0/PlxkjsgU0yOOA0Z2d8Fzk3wClwP6Hc49BOMWKstUIhLbG2DcIv8l29EuEj2w3j\n"
-    "u/7gkewol96XQ2twpPvpoVAaiVh/m7hQUcQORQCD6eJcDjOZVCArAgMBAAGjgaQw\n"
-    "gaEwCQYDVR0TBAIwADAdBgNVHQ4EFgQUqYnRaBHrZmKLtMZES5AuwqzJkGYwUwYD\n"
-    "VR0jBEwwSoAU3MLDNDOK13DqflQ8ra7FeGBXK06hHKQaMBgxFjAUBgNVBAMMDU9W\n"
-    "UE4gVEVTVCBDQTGCFD55ErHXpK2JXS3WkfBm0NB1r3vKMBMGA1UdJQQMMAoGCCsG\n"
-    "AQUFBwMCMAsGA1UdDwQEAwIHgDANBgkqhkiG9w0BAQsFAAOCAQEAZVcXrezA9Aby\n"
-    "sfUNHAsMxrex/EO0PrIPSrmSmc9sCiD8cCIeB6kL8c5iPPigoWW0uLA9zteDRFes\n"
-    "ez+Z8wBY6g8VQ0tFPURDooUg5011GZPDcuw7/PsI4+I2J9q6LHEp+6Oo4faSn/kl\n"
-    "yWYCLjM4FZdGXbOijDacQJiN6HcRv0UdodBrEVRf7YHJJmMCbCI7ZUGW2zef/+rO\n"
-    "e4Lkxh0MLYqCkNKH5ZfoGTC4Oeb0xKykswAanqgR60r+upaLU8PFuI2L9M3vc6KU\n"
-    "F6MgVGSxl6eylJgDYckvJiAbmcp2PD/LRQQOxQA0yqeAMg2cbdvclETuYD6zoFfu\n"
-    "Y8aO7dvDlw=3D=3D\n"
+    "MIICBjCCAYygAwIBAgIUFoXgpP4beykV7tpgrjHQTWPGi4cwCgYIKoZIzj0EAwIw\n"
+    "HjEcMBoGA1UEAwwTb3Zwbi10ZXN0LXNlY3AzODRyMTAeFw0yNTA5MDgxMzExNTBa\n"
+    "Fw0zNTA5MDYxMzExNTBaMB4xHDAaBgNVBAMME292cG4tdGVzdC1zZWNwMzg0cjEw\n"
+    "djAQBgcqhkjOPQIBBgUrgQQAIgNiAAQVDmf+TZB3rW6zqWFox606u/PhA93ysX/h\n"
+    "1s2xyq9+QGzIdE/hks6p/Yzyu7RLOUjxvO0J45RHcYmo67DlvSOi496T3zrgvp1H\n"
+    "KfHD5ohMyvzw0+e8lmjJqJjn+PegMkOjgYowgYcwHQYDVR0OBBYEFCH1eYnaV8fh\n"
+    "E3Bv7lyrlYu24eoVMB8GA1UdIwQYMBaAFCH1eYnaV8fhE3Bv7lyrlYu24eoVMA8G\n"
+    "A1UdEwEB/wQFMAMBAf8wHwYDVR0RBBgwFoIUdW5pdHRlc3QuZXhhbXBsZS5jb20w\n"
+    "EwYDVR0lBAwwCgYIKwYBBQUHAwIwCgYIKoZIzj0EAwIDaAAwZQIxAL7q7jcwTOuq\n"
+    "5sp0Beq81Vnznd3gsDZYNs1OYRWH33xergDVKlBb6kCwus0dhghtVAIwIgT4ytkY\n"
+    "oAPx8LB3oP8ubEu1ue6V9jZln/cCiLyXDDtaiJOZHtDqHGfHqvc6rAok\n"
     "-----END CERTIFICATE-----\n";

 static const char *const unittest_key =3D
     "-----BEGIN PRIVATE KEY-----\n"
-    "MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC7xFoR6fmoyfsJ\n"
-    "IQDKKgbYgFw0MzVuDAmpRx6KTEihgTchkQx9fHddWbKiOUbcEnQi3LNux7P4QVl/\n"
-    "4dRR3skisBug6Vd5LXeBGZqmpu5XZiF4DgLz1lX21G0aOogFWkie2qGEcso40159\n"
-    "x9FBDl5A3sLP18ubeex0pd/BzDFv6SLOTyVWO/GCNc8IX/i0uN4mLvoVU00SeqwT\n"
-    "PnS+CRXrSq4JjGDJLsXl0/PlxkjsgU0yOOA0Z2d8Fzk3wClwP6Hc49BOMWKstUIh\n"
-    "LbG2DcIv8l29EuEj2w3ju/7gkewol96XQ2twpPvpoVAaiVh/m7hQUcQORQCD6eJc\n"
-    "DjOZVCArAgMBAAECggEACqkuWAAJ3cyCBVWrXs8eDmLTWV9i9DmYvtS75ixIn2rf\n"
-    "v3cl12YevN0f6FgKLuqZT3Vqdqq+DCVhuIIQ9QkKMH8BQpSdE9NCCsFyZ23o8Gtr\n"
-    "EQ7ymfecb+RFwYx7NpqWrvZI32VJGArgPZH/zorLTTGYrAZbmBtHEqRsXOuEDw97\n"
-    "slwwcWaa9ztaYC8/N/7fgsnydaCFSaOByRlWuyvSmHvn6ZwLv8ANOshY6fstC0Jb\n"
-    "BW0GpSe9eZPjpl71VT2RtpghqLV5+iAoFDHoT+eZvBospcUGtfcZSU7RrBjKB8+a\n"
-    "U1d6hwKhduVs2peIQzl+FiOSdWriLcsZv79q4sBhsQKBgQDUDVTf5BGJ8apOs/17\n"
-    "YVk+Ad8Ey8sXvsfk49psmlCRa8Z4g0LVXfrP94qzhtl8U5kE9hs3nEF4j/kX1ZWG\n"
-    "k11tdsNTZN5x5bbAgEgPA6Ap6J/uto0HS8G0vSv0lyBymdKA3p/i5Dx+8Nc9cGns\n"
-    "LGI9MvviLX7pQFIkvbaCkdKwYwKBgQDirowjWZnm7BgVhF0G1m3DY9nQTYYU185W\n"
-    "UESaO5/nVzwUrA+FypJamD+AvmlSuY8rJeQAGAS6nQr9G8/617r+GwJnzRtxC6Vl\n"
-    "4OF5BJRsD70oX4CFOOlycMoJ8tzcYVH7NI8KVocjxb+QW82hqSvEwSsvnwwn3eOW\n"
-    "nr5u5vIHmQKBgCuc3lL6Dl1ntdZgEIdau0cUjXDoFUo589TwxBDIID/4gaZxoMJP\n"
-    "hPFXAVDxMDPw4azyjSB/47tPKTUsuYcnMfT8kynIujOEwnSPLcLgxQU5kgM/ynuw\n"
-    "qhNpQOwaVRMc7f2RTCMXPBYDpNE/GJn5eu8JWGLpZovEreBeoHX0VffvAoGAVrWn\n"
-    "+3mxykhzaf+oyg3KDNysG+cbq+tlDVVE+K5oG0kePVYX1fjIBQmJ+QhdJ3y9jCbB\n"
-    "UVveqzeZVXqHEw/kgoD4aZZmsdZfnVnpRa5/y9o1ZDUr50n+2nzUe/u/ijlb77iK\n"
-    "Is04gnGJNoI3ZWhdyrSNfXjcYH+bKClu9OM4n7kCgYAorc3PAX7M0bsQrrqYxUS8\n"
-    "56UU0YdhAgYitjM7Fm/0iIm0vDpSevxL9js4HnnsSMVR77spCBAGOCCZrTcI3Ejg\n"
-    "xKDYzh1xlfMRjJBuBu5Pd55ZAv9NXFGpsX5SO8fDZQJMwpcbQH36+UdqRRFDpjJ0\n"
-    "ZbX6nKcJ7jciJVKJds59Jg=3D=3D\n"
-    "-----END PRIVATE KEY-----\n";
+    "MIG2AgEAMBAGByqGSM49AgEGBSuBBAAiBIGeMIGbAgEBBDAXBC7tpa9UepoMVZlM\n"
+    "    OxUubkECGK7aWFebxDc3UPoEQemEPMOCdkWBSU/t7Mm4R66hZANiAAQVDmf+TZB3\=
n"
+    "    rW6zqWFox606u/PhA93ysX/h1s2xyq9+QGzIdE/hks6p/Yzyu7RLOUjxvO0J45RH\=
n"
+    "    cYmo67DlvSOi496T3zrgvp1HKfHD5ohMyvzw0+e8lmjJqJjn+PegMkM=3D\n"
+    "-----END PRIVATE KEY-----";
+

 static const char *
 get_tmp_dir(void)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1172?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I327ecc9a85dd906517c28e71fe500883bfa028a4
Gerrit-Change-Number: 1172
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--JcxZT5PhbPo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1172?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Switch test_ssl certificate from RSA 2048 to secp384r1<br><b=
r>This allow the unit test to also run in environments that have seclevel<b=
r>(SSL_CTX_set_security_level) set to 3.<br><br>Closes: openvpn/openvpn#830=
<br>Change-Id: I327ecc9a85dd906517c28e71fe500883bfa028a4<br>---<br>M tests/=
unit_tests/openvpn/test_ssl.c<br>1 file changed, 23 insertions(+), 46 delet=
ions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chan=
ges/72/1172/1</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/tests/unit_tests/openvpn/test_ssl.c b/te=
sts/unit_tests/openvpn/test_ssl.c</span><br><span>index 7bf5396..894d332 10=
0644</span><br><span>--- a/tests/unit_tests/openvpn/test_ssl.c</span><br><s=
pan>+++ b/tests/unit_tests/openvpn/test_ssl.c</span><br><span>@@ -83,58 +83=
,35 @@</span><br><span>     return;</span><br><span> }</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/* generated using</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * openssl req -x509 -n=
ewkey ec -pkeyopt ec_paramgen_curve:secp384r1 -keyout - \</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * -noenc -sha256 -days 3650 -subj &#=
39;/CN=3Dovpn-test-secp384r1&#39;  -nodes \</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * -addext &#39;subjectAltName=3DDNS:unittest.examp=
le.com&#39; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * -ad=
dext &#39;extendedKeyUsage=3DclientAuth&#39;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ */</span><br><span> static const char *const unit=
test_cert =3D</span><br><span>     &quot;-----BEGIN CERTIFICATE-----\n&quot=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;MIIDYzCCAk=
ugAwIBAgIRALrXTx4lqa8QgF7uGjISxmcwDQYJKoZIhvcNAQELBQAw\n&quot;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    &quot;GDEWMBQGA1UEAwwNT1ZQTiBU=
RVNUIENBMTAgFw0yMzAzMTMxNjA5MThaGA8yMTIz\n&quot;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    &quot;MDIxNzE2MDkxOFowGTEXMBUGA1UEAwwOb3Zwbi=
10ZXN0LXJzYTEwggEiMA0GCSqG\n&quot;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    &quot;SIb3DQEBAQUAA4IBDwAwggEKAoIBAQC7xFoR6fmoyfsJIQDKKgbY=
gFw0MzVuDAmp\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   &quot;Rx6KTEihgTchkQx9fHddWbKiOUbcEnQi3LNux7P4QVl/4dRR3skisBug6Vd5LXeB\n=
&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;GZqmp=
u5XZiF4DgLz1lX21G0aOogFWkie2qGEcso40159x9FBDl5A3sLP18ubeex0\n&quot;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;pd/BzDFv6SLOTyVWO/G=
CNc8IX/i0uN4mLvoVU00SeqwTPnS+CRXrSq4JjGDJLsXl\n&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    &quot;0/PlxkjsgU0yOOA0Z2d8Fzk3wClwP6Hc4=
9BOMWKstUIhLbG2DcIv8l29EuEj2w3j\n&quot;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    &quot;u/7gkewol96XQ2twpPvpoVAaiVh/m7hQUcQORQCD6eJcDjO=
ZVCArAgMBAAGjgaQw\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    &quot;gaEwCQYDVR0TBAIwADAdBgNVHQ4EFgQUqYnRaBHrZmKLtMZES5AuwqzJkGYwU=
wYD\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;=
VR0jBEwwSoAU3MLDNDOK13DqflQ8ra7FeGBXK06hHKQaMBgxFjAUBgNVBAMMDU9W\n&quot;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;UE4gVEVTVCBDQT=
GCFD55ErHXpK2JXS3WkfBm0NB1r3vKMBMGA1UdJQQMMAoGCCsG\n&quot;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    &quot;AQUFBwMCMAsGA1UdDwQEAwIHgDAN=
BgkqhkiG9w0BAQsFAAOCAQEAZVcXrezA9Aby\n&quot;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    &quot;sfUNHAsMxrex/EO0PrIPSrmSmc9sCiD8cCIeB6kL8c=
5iPPigoWW0uLA9zteDRFes\n&quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    &quot;ez+Z8wBY6g8VQ0tFPURDooUg5011GZPDcuw7/PsI4+I2J9q6LHEp+6Oo=
4faSn/kl\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &=
quot;yWYCLjM4FZdGXbOijDacQJiN6HcRv0UdodBrEVRf7YHJJmMCbCI7ZUGW2zef/+rO\n&quo=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;e4Lkxh0ML=
YqCkNKH5ZfoGTC4Oeb0xKykswAanqgR60r+upaLU8PFuI2L9M3vc6KU\n&quot;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    &quot;F6MgVGSxl6eylJgDYckvJiA=
bmcp2PD/LRQQOxQA0yqeAMg2cbdvclETuYD6zoFfu\n&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    &quot;Y8aO7dvDlw=3D=3D\n&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    &quot;MIICBjCCAYygAwIBAgIUFo=
XgpP4beykV7tpgrjHQTWPGi4cwCgYIKoZIzj0EAwIw\n&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    &quot;HjEcMBoGA1UEAwwTb3Zwbi10ZXN0LXNlY3=
AzODRyMTAeFw0yNTA5MDgxMzExNTBa\n&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    &quot;Fw0zNTA5MDYxMzExNTBaMB4xHDAaBgNVBAMME292cG4tdG=
VzdC1zZWNwMzg0cjEw\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    &quot;djAQBgcqhkjOPQIBBgUrgQQAIgNiAAQVDmf+TZB3rW6zqWFox606u/PhA9=
3ysX/h\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &=
quot;1s2xyq9+QGzIdE/hks6p/Yzyu7RLOUjxvO0J45RHcYmo67DlvSOi496T3zrgvp1H\n&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;KfHD5oh=
Myvzw0+e8lmjJqJjn+PegMkOjgYowgYcwHQYDVR0OBBYEFCH1eYnaV8fh\n&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;E3Bv7lyrlYu24eoVMB8=
GA1UdIwQYMBaAFCH1eYnaV8fhE3Bv7lyrlYu24eoVMA8G\n&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &quot;A1UdEwEB/wQFMAMBAf8wHwYDVR0RBBg=
wFoIUdW5pdHRlc3QuZXhhbXBsZS5jb20w\n&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    &quot;EwYDVR0lBAwwCgYIKwYBBQUHAwIwCgYIKoZIzj0EAwI=
DaAAwZQIxAL7q7jcwTOuq\n&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    &quot;5sp0Beq81Vnznd3gsDZYNs1OYRWH33xergDVKlBb6kCwus0dhghtVAI=
wIgT4ytkY\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  &quot;oAPx8LB3oP8ubEu1ue6V9jZln/cCiLyXDDtaiJOZHtDqHGfHqvc6rAok\n&quot;</s=
pan><br><span>     &quot;-----END CERTIFICATE-----\n&quot;;</span><br><span=
> </span><br><span> static const char *const unittest_key =3D</span><br><sp=
an>     &quot;-----BEGIN PRIVATE KEY-----\n&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    &quot;MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwg=
gSiAgEAAoIBAQC7xFoR6fmoyfsJ\n&quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    &quot;IQDKKgbYgFw0MzVuDAmpRx6KTEihgTchkQx9fHddWbKiOUbcEnQ=
i3LNux7P4QVl/\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    &quot;4dRR3skisBug6Vd5LXeBGZqmpu5XZiF4DgLz1lX21G0aOogFWkie2qGEcso40159\=
n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;x9FB=
Dl5A3sLP18ubeex0pd/BzDFv6SLOTyVWO/GCNc8IX/i0uN4mLvoVU00SeqwT\n&quot;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;PnS+CRXrSq4JjGDJLs=
Xl0/PlxkjsgU0yOOA0Z2d8Fzk3wClwP6Hc49BOMWKstUIh\n&quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    &quot;LbG2DcIv8l29EuEj2w3ju/7gkewol96X=
Q2twpPvpoVAaiVh/m7hQUcQORQCD6eJc\n&quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    &quot;DjOZVCArAgMBAAECggEACqkuWAAJ3cyCBVWrXs8eDmLTWV=
9i9DmYvtS75ixIn2rf\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    &quot;v3cl12YevN0f6FgKLuqZT3Vqdqq+DCVhuIIQ9QkKMH8BQpSdE9NCCsFyZ23o=
8Gtr\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot=
;EQ7ymfecb+RFwYx7NpqWrvZI32VJGArgPZH/zorLTTGYrAZbmBtHEqRsXOuEDw97\n&quot;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;slwwcWaa9ztaY=
C8/N/7fgsnydaCFSaOByRlWuyvSmHvn6ZwLv8ANOshY6fstC0Jb\n&quot;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    &quot;BW0GpSe9eZPjpl71VT2RtpghqLV=
5+iAoFDHoT+eZvBospcUGtfcZSU7RrBjKB8+a\n&quot;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    &quot;U1d6hwKhduVs2peIQzl+FiOSdWriLcsZv79q4sBhs=
QKBgQDUDVTf5BGJ8apOs/17\n&quot;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    &quot;YVk+Ad8Ey8sXvsfk49psmlCRa8Z4g0LVXfrP94qzhtl8U5kE9hs3nEF=
4j/kX1ZWG\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
&quot;k11tdsNTZN5x5bbAgEgPA6Ap6J/uto0HS8G0vSv0lyBymdKA3p/i5Dx+8Nc9cGns\n&qu=
ot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;LGI9Mvvi=
LX7pQFIkvbaCkdKwYwKBgQDirowjWZnm7BgVhF0G1m3DY9nQTYYU185W\n&quot;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    &quot;UESaO5/nVzwUrA+FypJamD=
+AvmlSuY8rJeQAGAS6nQr9G8/617r+GwJnzRtxC6Vl\n&quot;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    &quot;4OF5BJRsD70oX4CFOOlycMoJ8tzcYVH7NI8K=
Vocjxb+QW82hqSvEwSsvnwwn3eOW\n&quot;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    &quot;nr5u5vIHmQKBgCuc3lL6Dl1ntdZgEIdau0cUjXDoFUo589TwxB=
DIID/4gaZxoMJP\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    &quot;hPFXAVDxMDPw4azyjSB/47tPKTUsuYcnMfT8kynIujOEwnSPLcLgxQU5kgM/ynuw=
\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;qhN=
pQOwaVRMc7f2RTCMXPBYDpNE/GJn5eu8JWGLpZovEreBeoHX0VffvAoGAVrWn\n&quot;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;+3mxykhzaf+oyg3KD=
NysG+cbq+tlDVVE+K5oG0kePVYX1fjIBQmJ+QhdJ3y9jCbB\n&quot;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    &quot;UVveqzeZVXqHEw/kgoD4aZZmsdZfnVn=
pRa5/y9o1ZDUr50n+2nzUe/u/ijlb77iK\n&quot;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    &quot;Is04gnGJNoI3ZWhdyrSNfXjcYH+bKClu9OM4n7kCgYAor=
c3PAX7M0bsQrrqYxUS8\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    &quot;56UU0YdhAgYitjM7Fm/0iIm0vDpSevxL9js4HnnsSMVR77spCBAGOCCZrTc=
I3Ejg\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quo=
t;xKDYzh1xlfMRjJBuBu5Pd55ZAv9NXFGpsX5SO8fDZQJMwpcbQH36+UdqRRFDpjJ0\n&quot;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;ZbX6nKcJ7jci=
JVKJds59Jg=3D=3D\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    &quot;-----END PRIVATE KEY-----\n&quot;;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    &quot;MIG2AgEAMBAGByqGSM49AgEGBSuBBAAiBIGeM=
IGbAgEBBDAXBC7tpa9UepoMVZlM\n&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    &quot;    OxUubkECGK7aWFebxDc3UPoEQemEPMOCdkWBSU/t7Mm4R=
66hZANiAAQVDmf+TZB3\n&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    &quot;    rW6zqWFox606u/PhA93ysX/h1s2xyq9+QGzIdE/hks6p/Yzyu7RLO=
UjxvO0J45RH\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    &quot;    cYmo67DlvSOi496T3zrgvp1HKfHD5ohMyvzw0+e8lmjJqJjn+PegMkM=3D\n&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;----=
-END PRIVATE KEY-----&quot;;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> </span><br><span> static const char *</span><br>=
<span> get_tmp_dir(void)</span><br><span></span><br></pre><p>To view, visit=
 <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1172?usp=3Demail">change =
1172</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/1172?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I327ecc9a85dd906517c28e71fe5=
00883bfa028a4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1172 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--JcxZT5PhbPo=--

