From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 31 Mar 2026 16:52:36 +0000
In-Reply-To: <gerrit.1774974242000.Id8680e6555a66024417d6eb9322d4fde79922453@...2715...>
References: <gerrit.1774974242000.Id8680e6555a66024417d6eb9322d4fde79922453@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <7e5b16f5e3b629d8537c8b532f1a1c6474edc3eb-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/Hn1UOCcBXc="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Rename key* to
 privkey* in cert_data.h
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--/Hn1UOCcBXc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has uploaded a new patch set (#2). ( http://gerrit.openvpn.net/c/=
openvpn/+/1597?usp=3Demail )


Change subject: Rename key* to privkey* in cert_data.h
......................................................................

Rename key* to privkey* in cert_data.h

The name key2 conflicts with our struct key2 and prevents these
test keys from being used in test_ssl.c

Change-Id: Id8680e6555a66024417d6eb9322d4fde79922453
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M tests/unit_tests/openvpn/cert_data.h
M tests/unit_tests/openvpn/test_cryptoapi.c
M tests/unit_tests/openvpn/test_pkcs11.c
3 files changed, 43 insertions(+), 43 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/97/1597/2

diff --git a/tests/unit_tests/openvpn/cert_data.h b/tests/unit_tests/openvp=
n/cert_data.h
index c5d897e..9c16929 100644
--- a/tests/unit_tests/openvpn/cert_data.h
+++ b/tests/unit_tests/openvpn/cert_data.h
@@ -52,11 +52,11 @@
     "srXMaPe0lAea4etMSZsjIRPwGRMXBrwbRmb6iN2Cq40867HdaJoAryYig7IiDwSX\n"
     "htCbOA6sX+60+FEOYDEx5cmkogl633Pw7LJ3ICkyzIrUSEt6BOT1Gsc1eQ=3D=3D\n"
     "-----END CERTIFICATE-----\n";
-static const char *const key1 =3D "-----BEGIN PRIVATE KEY-----\n"
-                                "MIGHAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBG0wa=
wIBAQQg5Xpw/lLvBrWjAWDq\n"
-                                "L6dm/4a1or6AQ6O3yXYgw78B23ihRANCAAR4SRvnS=
uGdJmPitKbqcFbcgyzsMBlh\n"
-                                "4wWOrty4I0ZlIXxY2qEnyb3YKz4OdMGzpK7FLfQZe=
hHg6LGblcLs4EW7\n"
-                                "-----END PRIVATE KEY-----\n";
+static const char *const privkey1 =3D "-----BEGIN PRIVATE KEY-----\n"
+                                    "MIGHAgEAMBMGByqGSM49AgEGCCqGSM49AwEHB=
G0wawIBAQQg5Xpw/lLvBrWjAWDq\n"
+                                    "L6dm/4a1or6AQ6O3yXYgw78B23ihRANCAAR4S=
RvnSuGdJmPitKbqcFbcgyzsMBlh\n"
+                                    "4wWOrty4I0ZlIXxY2qEnyb3YKz4OdMGzpK7FL=
fQZehHg6LGblcLs4EW7\n"
+                                    "-----END PRIVATE KEY-----\n";
 static const char *const hash1 =3D "A4B74F1D68AF50691F62CBD675E24C86553695=
67";
 static const char *const cname1 =3D "ovpn-test-ec1";

@@ -77,7 +77,7 @@
     "HeTsAlHjfFEReVDiNCI9vMQLKFKKWnAorT2+iyRueA3bt2gchf863BBhZvJddL7Q\n"
     "KBa0osXw+eGBRAwsm7m1qCho3b3fN2nFAa+k07ptRkOeablmFdXE81nVlA=3D=3D\n"
     "-----END CERTIFICATE-----\n";
-#define key2 key1
+#define privkey2 privkey1
 static const char *const hash2 =3D "FA18FD34BAABE47D6E2910E080F421C109CA97=
F5";
 static const char *const cname2 =3D "ovpn-test-ec2";

@@ -103,34 +103,34 @@
     "F6MgVGSxl6eylJgDYckvJiAbmcp2PD/LRQQOxQA0yqeAMg2cbdvclETuYD6zoFfu\n"
     "Y8aO7dvDlw=3D=3D\n"
     "-----END CERTIFICATE-----\n";
-static const char *const key3 =3D "-----BEGIN PRIVATE KEY-----\n"
-                                "MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiA=
gEAAoIBAQC7xFoR6fmoyfsJ\n"
-                                "IQDKKgbYgFw0MzVuDAmpRx6KTEihgTchkQx9fHddW=
bKiOUbcEnQi3LNux7P4QVl/\n"
-                                "4dRR3skisBug6Vd5LXeBGZqmpu5XZiF4DgLz1lX21=
G0aOogFWkie2qGEcso40159\n"
-                                "x9FBDl5A3sLP18ubeex0pd/BzDFv6SLOTyVWO/GCN=
c8IX/i0uN4mLvoVU00SeqwT\n"
-                                "PnS+CRXrSq4JjGDJLsXl0/PlxkjsgU0yOOA0Z2d8F=
zk3wClwP6Hc49BOMWKstUIh\n"
-                                "LbG2DcIv8l29EuEj2w3ju/7gkewol96XQ2twpPvpo=
VAaiVh/m7hQUcQORQCD6eJc\n"
-                                "DjOZVCArAgMBAAECggEACqkuWAAJ3cyCBVWrXs8eD=
mLTWV9i9DmYvtS75ixIn2rf\n"
-                                "v3cl12YevN0f6FgKLuqZT3Vqdqq+DCVhuIIQ9QkKM=
H8BQpSdE9NCCsFyZ23o8Gtr\n"
-                                "EQ7ymfecb+RFwYx7NpqWrvZI32VJGArgPZH/zorLT=
TGYrAZbmBtHEqRsXOuEDw97\n"
-                                "slwwcWaa9ztaYC8/N/7fgsnydaCFSaOByRlWuyvSm=
Hvn6ZwLv8ANOshY6fstC0Jb\n"
-                                "BW0GpSe9eZPjpl71VT2RtpghqLV5+iAoFDHoT+eZv=
BospcUGtfcZSU7RrBjKB8+a\n"
-                                "U1d6hwKhduVs2peIQzl+FiOSdWriLcsZv79q4sBhs=
QKBgQDUDVTf5BGJ8apOs/17\n"
-                                "YVk+Ad8Ey8sXvsfk49psmlCRa8Z4g0LVXfrP94qzh=
tl8U5kE9hs3nEF4j/kX1ZWG\n"
-                                "k11tdsNTZN5x5bbAgEgPA6Ap6J/uto0HS8G0vSv0l=
yBymdKA3p/i5Dx+8Nc9cGns\n"
-                                "LGI9MvviLX7pQFIkvbaCkdKwYwKBgQDirowjWZnm7=
BgVhF0G1m3DY9nQTYYU185W\n"
-                                "UESaO5/nVzwUrA+FypJamD+AvmlSuY8rJeQAGAS6n=
Qr9G8/617r+GwJnzRtxC6Vl\n"
-                                "4OF5BJRsD70oX4CFOOlycMoJ8tzcYVH7NI8KVocjx=
b+QW82hqSvEwSsvnwwn3eOW\n"
-                                "nr5u5vIHmQKBgCuc3lL6Dl1ntdZgEIdau0cUjXDoF=
Uo589TwxBDIID/4gaZxoMJP\n"
-                                "hPFXAVDxMDPw4azyjSB/47tPKTUsuYcnMfT8kynIu=
jOEwnSPLcLgxQU5kgM/ynuw\n"
-                                "qhNpQOwaVRMc7f2RTCMXPBYDpNE/GJn5eu8JWGLpZ=
ovEreBeoHX0VffvAoGAVrWn\n"
-                                "+3mxykhzaf+oyg3KDNysG+cbq+tlDVVE+K5oG0keP=
VYX1fjIBQmJ+QhdJ3y9jCbB\n"
-                                "UVveqzeZVXqHEw/kgoD4aZZmsdZfnVnpRa5/y9o1Z=
DUr50n+2nzUe/u/ijlb77iK\n"
-                                "Is04gnGJNoI3ZWhdyrSNfXjcYH+bKClu9OM4n7kCg=
YAorc3PAX7M0bsQrrqYxUS8\n"
-                                "56UU0YdhAgYitjM7Fm/0iIm0vDpSevxL9js4HnnsS=
MVR77spCBAGOCCZrTcI3Ejg\n"
-                                "xKDYzh1xlfMRjJBuBu5Pd55ZAv9NXFGpsX5SO8fDZ=
QJMwpcbQH36+UdqRRFDpjJ0\n"
-                                "ZbX6nKcJ7jciJVKJds59Jg=3D=3D\n"
-                                "-----END PRIVATE KEY-----\n";
+static const char *const privkey3 =3D "-----BEGIN PRIVATE KEY-----\n"
+                                    "MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwg=
gSiAgEAAoIBAQC7xFoR6fmoyfsJ\n"
+                                    "IQDKKgbYgFw0MzVuDAmpRx6KTEihgTchkQx9f=
HddWbKiOUbcEnQi3LNux7P4QVl/\n"
+                                    "4dRR3skisBug6Vd5LXeBGZqmpu5XZiF4DgLz1=
lX21G0aOogFWkie2qGEcso40159\n"
+                                    "x9FBDl5A3sLP18ubeex0pd/BzDFv6SLOTyVWO=
/GCNc8IX/i0uN4mLvoVU00SeqwT\n"
+                                    "PnS+CRXrSq4JjGDJLsXl0/PlxkjsgU0yOOA0Z=
2d8Fzk3wClwP6Hc49BOMWKstUIh\n"
+                                    "LbG2DcIv8l29EuEj2w3ju/7gkewol96XQ2twp=
PvpoVAaiVh/m7hQUcQORQCD6eJc\n"
+                                    "DjOZVCArAgMBAAECggEACqkuWAAJ3cyCBVWrX=
s8eDmLTWV9i9DmYvtS75ixIn2rf\n"
+                                    "v3cl12YevN0f6FgKLuqZT3Vqdqq+DCVhuIIQ9=
QkKMH8BQpSdE9NCCsFyZ23o8Gtr\n"
+                                    "EQ7ymfecb+RFwYx7NpqWrvZI32VJGArgPZH/z=
orLTTGYrAZbmBtHEqRsXOuEDw97\n"
+                                    "slwwcWaa9ztaYC8/N/7fgsnydaCFSaOByRlWu=
yvSmHvn6ZwLv8ANOshY6fstC0Jb\n"
+                                    "BW0GpSe9eZPjpl71VT2RtpghqLV5+iAoFDHoT=
+eZvBospcUGtfcZSU7RrBjKB8+a\n"
+                                    "U1d6hwKhduVs2peIQzl+FiOSdWriLcsZv79q4=
sBhsQKBgQDUDVTf5BGJ8apOs/17\n"
+                                    "YVk+Ad8Ey8sXvsfk49psmlCRa8Z4g0LVXfrP9=
4qzhtl8U5kE9hs3nEF4j/kX1ZWG\n"
+                                    "k11tdsNTZN5x5bbAgEgPA6Ap6J/uto0HS8G0v=
Sv0lyBymdKA3p/i5Dx+8Nc9cGns\n"
+                                    "LGI9MvviLX7pQFIkvbaCkdKwYwKBgQDirowjW=
Znm7BgVhF0G1m3DY9nQTYYU185W\n"
+                                    "UESaO5/nVzwUrA+FypJamD+AvmlSuY8rJeQAG=
AS6nQr9G8/617r+GwJnzRtxC6Vl\n"
+                                    "4OF5BJRsD70oX4CFOOlycMoJ8tzcYVH7NI8KV=
ocjxb+QW82hqSvEwSsvnwwn3eOW\n"
+                                    "nr5u5vIHmQKBgCuc3lL6Dl1ntdZgEIdau0cUj=
XDoFUo589TwxBDIID/4gaZxoMJP\n"
+                                    "hPFXAVDxMDPw4azyjSB/47tPKTUsuYcnMfT8k=
ynIujOEwnSPLcLgxQU5kgM/ynuw\n"
+                                    "qhNpQOwaVRMc7f2RTCMXPBYDpNE/GJn5eu8JW=
GLpZovEreBeoHX0VffvAoGAVrWn\n"
+                                    "+3mxykhzaf+oyg3KDNysG+cbq+tlDVVE+K5oG=
0kePVYX1fjIBQmJ+QhdJ3y9jCbB\n"
+                                    "UVveqzeZVXqHEw/kgoD4aZZmsdZfnVnpRa5/y=
9o1ZDUr50n+2nzUe/u/ijlb77iK\n"
+                                    "Is04gnGJNoI3ZWhdyrSNfXjcYH+bKClu9OM4n=
7kCgYAorc3PAX7M0bsQrrqYxUS8\n"
+                                    "56UU0YdhAgYitjM7Fm/0iIm0vDpSevxL9js4H=
nnsSMVR77spCBAGOCCZrTcI3Ejg\n"
+                                    "xKDYzh1xlfMRjJBuBu5Pd55ZAv9NXFGpsX5SO=
8fDZQJMwpcbQH36+UdqRRFDpjJ0\n"
+                                    "ZbX6nKcJ7jciJVKJds59Jg=3D=3D\n"
+                                    "-----END PRIVATE KEY-----\n";
 static const char *const hash3 =3D "2463628674E362578113F508BA05F29EF142E9=
79";
 static const char *const cname3 =3D "ovpn-test-rsa1";

@@ -156,7 +156,7 @@
     "353PpJJ9s2b/Fqoc4d7udqhQogA7jqbayTKhJxbT134l2NzqDROzuS0kXbX8bXCi\n"
     "mXSa4c8=3D\n"
     "-----END CERTIFICATE-----\n";
-#define key4 key3
+#define privkey4 privkey3
 static const char *const hash4 =3D "E1401D4497C944783E3D62CDBD2A1F69F5E507=
1E";
 #define cname4 cname3 /* same CN as that of cert3 */

diff --git a/tests/unit_tests/openvpn/test_cryptoapi.c b/tests/unit_tests/o=
penvpn/test_cryptoapi.c
index 59a356d..508afc9 100644
--- a/tests/unit_tests/openvpn/test_cryptoapi.c
+++ b/tests/unit_tests/openvpn/test_cryptoapi.c
@@ -115,10 +115,10 @@
 init_cert_data(void)
 {
     struct test_cert certs_local[] =3D {
-        { cert1, key1, cname1, "OVPN TEST CA1", "OVPN Test Cert 1", hash1,=
 1 },
-        { cert2, key2, cname2, "OVPN TEST CA2", "OVPN Test Cert 2", hash2,=
 1 },
-        { cert3, key3, cname3, "OVPN TEST CA1", "OVPN Test Cert 3", hash3,=
 1 },
-        { cert4, key4, cname4, "OVPN TEST CA2", "OVPN Test Cert 4", hash4,=
 0 },
+        { cert1, privkey1, cname1, "OVPN TEST CA1", "OVPN Test Cert 1", ha=
sh1, 1 },
+        { cert2, privkey2, cname2, "OVPN TEST CA2", "OVPN Test Cert 2", ha=
sh2, 1 },
+        { cert3, privkey3, cname3, "OVPN TEST CA1", "OVPN Test Cert 3", ha=
sh3, 1 },
+        { cert4, privkey4, cname4, "OVPN TEST CA2", "OVPN Test Cert 4", ha=
sh4, 0 },
         { 0 }
     };
     assert_int_equal(sizeof(certs_local), sizeof(certs));
diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/open=
vpn/test_pkcs11.c
index 722f9b1..8b6e594 100644
--- a/tests/unit_tests/openvpn/test_pkcs11.c
+++ b/tests/unit_tests/openvpn/test_pkcs11.c
@@ -142,10 +142,10 @@
 init_cert_data(void)
 {
     struct test_cert certs_local[] =3D {
-        { cert1, key1, cname1, "OVPN TEST CA1", "OVPN Test Cert 1", { 0 },=
 NULL },
-        { cert2, key2, cname2, "OVPN TEST CA2", "OVPN Test Cert 2", { 0 },=
 NULL },
-        { cert3, key3, cname3, "OVPN TEST CA1", "OVPN Test Cert 3", { 0 },=
 NULL },
-        { cert4, key4, cname4, "OVPN TEST CA2", "OVPN Test Cert 4", { 0 },=
 NULL },
+        { cert1, privkey1, cname1, "OVPN TEST CA1", "OVPN Test Cert 1", { =
0 }, NULL },
+        { cert2, privkey2, cname2, "OVPN TEST CA2", "OVPN Test Cert 2", { =
0 }, NULL },
+        { cert3, privkey3, cname3, "OVPN TEST CA1", "OVPN Test Cert 3", { =
0 }, NULL },
+        { cert4, privkey4, cname4, "OVPN TEST CA2", "OVPN Test Cert 4", { =
0 }, NULL },
         { 0 }
     };
     assert_int_equal(sizeof(certs_local), sizeof(certs));

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1597?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id8680e6555a66024417d6eb9322d4fde79922453
Gerrit-Change-Number: 1597
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>

--/Hn1UOCcBXc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1597?usp=3Demail">View Chan=
ge</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">Rename key* to privkey* in cert_data.h<br><br>The n=
ame key2 conflicts with our struct key2 and prevents these<br>test keys fro=
m being used in test_ssl.c<br><br>Change-Id: Id8680e6555a66024417d6eb9322d4=
fde79922453<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<b=
r>M tests/unit_tests/openvpn/cert_data.h<br>M tests/unit_tests/openvpn/test=
_cryptoapi.c<br>M tests/unit_tests/openvpn/test_pkcs11.c<br>3 files changed=
, 43 insertions(+), 43 deletions(-)<br><br></pre><pre class=3D"blocks" styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh=
://gerrit.openvpn.net:29418/openvpn refs/changes/97/1597/2</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/tests/unit_tests/openvpn/cert_data.h b/tests/unit_tests/openvpn/cert_=
data.h</span><br><span>index c5d897e..9c16929 100644</span><br><span>--- a/=
tests/unit_tests/openvpn/cert_data.h</span><br><span>+++ b/tests/unit_tests=
/openvpn/cert_data.h</span><br><span>@@ -52,11 +52,11 @@</span><br><span>  =
   &quot;srXMaPe0lAea4etMSZsjIRPwGRMXBrwbRmb6iN2Cq40867HdaJoAryYig7IiDwSX\n=
&quot;</span><br><span>     &quot;htCbOA6sX+60+FEOYDEx5cmkogl633Pw7LJ3ICkyz=
IrUSEt6BOT1Gsc1eQ=3D=3D\n&quot;</span><br><span>     &quot;-----END CERTIFI=
CATE-----\n&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sta=
tic const char *const key1 =3D &quot;-----BEGIN PRIVATE KEY-----\n&quot;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                        =
        &quot;MIGHAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBG0wawIBAQQg5Xpw/lLvBrWjA=
WDq\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
                      &quot;L6dm/4a1or6AQ6O3yXYgw78B23ihRANCAAR4SRvnSuGdJmP=
itKbqcFbcgyzsMBlh\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                                &quot;4wWOrty4I0ZlIXxY2qEnyb3YKz4OdMGzp=
K7FLfQZehHg6LGblcLs4EW7\n&quot;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                                &quot;-----END PRIVATE KEY-----\n=
&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static const=
 char *const privkey1 =3D &quot;-----BEGIN PRIVATE KEY-----\n&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
         &quot;MIGHAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBG0wawIBAQQg5Xpw/lLvBrWj=
AWDq\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                             &quot;L6dm/4a1or6AQ6O3yXYgw78B23ihRANCAAR4SRvn=
SuGdJmPitKbqcFbcgyzsMBlh\n&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                                    &quot;4wWOrty4I0ZlIXxY2qEn=
yb3YKz4OdMGzpK7FLfQZehHg6LGblcLs4EW7\n&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                    &quot;-----END=
 PRIVATE KEY-----\n&quot;;</span><br><span> static const char *const hash1 =
=3D &quot;A4B74F1D68AF50691F62CBD675E24C8655369567&quot;;</span><br><span> =
static const char *const cname1 =3D &quot;ovpn-test-ec1&quot;;</span><br><s=
pan> </span><br><span>@@ -77,7 +77,7 @@</span><br><span>     &quot;HeTsAlHj=
fFEReVDiNCI9vMQLKFKKWnAorT2+iyRueA3bt2gchf863BBhZvJddL7Q\n&quot;</span><br>=
<span>     &quot;KBa0osXw+eGBRAwsm7m1qCho3b3fN2nFAa+k07ptRkOeablmFdXE81nVlA=
=3D=3D\n&quot;</span><br><span>     &quot;-----END CERTIFICATE-----\n&quot;=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define key2 key1</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#define privkey2 privk=
ey1</span><br><span> static const char *const hash2 =3D &quot;FA18FD34BAABE=
47D6E2910E080F421C109CA97F5&quot;;</span><br><span> static const char *cons=
t cname2 =3D &quot;ovpn-test-ec2&quot;;</span><br><span> </span><br><span>@=
@ -103,34 +103,34 @@</span><br><span>     &quot;F6MgVGSxl6eylJgDYckvJiAbmcp=
2PD/LRQQOxQA0yqeAMg2cbdvclETuYD6zoFfu\n&quot;</span><br><span>     &quot;Y8=
aO7dvDlw=3D=3D\n&quot;</span><br><span>     &quot;-----END CERTIFICATE-----=
\n&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static const=
 char *const key3 =3D &quot;-----BEGIN PRIVATE KEY-----\n&quot;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                                &=
quot;MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC7xFoR6fmoyfsJ\n&quo=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
             &quot;IQDKKgbYgFw0MzVuDAmpRx6KTEihgTchkQx9fHddWbKiOUbcEnQi3LNu=
x7P4QVl/\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                           &quot;4dRR3skisBug6Vd5LXeBGZqmpu5XZiF4DgLz1lX21G=
0aOogFWkie2qGEcso40159\n&quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                                &quot;x9FBDl5A3sLP18ubeex0pd/BzDFv=
6SLOTyVWO/GCNc8IX/i0uN4mLvoVU00SeqwT\n&quot;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                                &quot;PnS+CRXrSq4JjG=
DJLsXl0/PlxkjsgU0yOOA0Z2d8Fzk3wClwP6Hc49BOMWKstUIh\n&quot;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                                &quot;=
LbG2DcIv8l29EuEj2w3ju/7gkewol96XQ2twpPvpoVAaiVh/m7hQUcQORQCD6eJc\n&quot;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                        =
        &quot;DjOZVCArAgMBAAECggEACqkuWAAJ3cyCBVWrXs8eDmLTWV9i9DmYvtS75ixIn=
2rf\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
                      &quot;v3cl12YevN0f6FgKLuqZT3Vqdqq+DCVhuIIQ9QkKMH8BQpS=
dE9NCCsFyZ23o8Gtr\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                                &quot;EQ7ymfecb+RFwYx7NpqWrvZI32VJGArgP=
ZH/zorLTTGYrAZbmBtHEqRsXOuEDw97\n&quot;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                                &quot;slwwcWaa9ztaYC8/N/7=
fgsnydaCFSaOByRlWuyvSmHvn6ZwLv8ANOshY6fstC0Jb\n&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                &quot;BW0Gp=
Se9eZPjpl71VT2RtpghqLV5+iAoFDHoT+eZvBospcUGtfcZSU7RrBjKB8+a\n&quot;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                             =
   &quot;U1d6hwKhduVs2peIQzl+FiOSdWriLcsZv79q4sBhsQKBgQDUDVTf5BGJ8apOs/17\n=
&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
                 &quot;YVk+Ad8Ey8sXvsfk49psmlCRa8Z4g0LVXfrP94qzhtl8U5kE9hs3=
nEF4j/kX1ZWG\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                               &quot;k11tdsNTZN5x5bbAgEgPA6Ap6J/uto0HS8G0vS=
v0lyBymdKA3p/i5Dx+8Nc9cGns\n&quot;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                                &quot;LGI9MvviLX7pQFIkvbaCkdKw=
YwKBgQDirowjWZnm7BgVhF0G1m3DY9nQTYYU185W\n&quot;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                                &quot;UESaO5/nVz=
wUrA+FypJamD+AvmlSuY8rJeQAGAS6nQr9G8/617r+GwJnzRtxC6Vl\n&quot;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                                &q=
uot;4OF5BJRsD70oX4CFOOlycMoJ8tzcYVH7NI8KVocjxb+QW82hqSvEwSsvnwwn3eOW\n&quot=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
            &quot;nr5u5vIHmQKBgCuc3lL6Dl1ntdZgEIdau0cUjXDoFUo589TwxBDIID/4g=
aZxoMJP\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                          &quot;hPFXAVDxMDPw4azyjSB/47tPKTUsuYcnMfT8kynIujO=
EwnSPLcLgxQU5kgM/ynuw\n&quot;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                                &quot;qhNpQOwaVRMc7f2RTCMXPBYDpNE/G=
Jn5eu8JWGLpZovEreBeoHX0VffvAoGAVrWn\n&quot;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                                &quot;+3mxykhzaf+oyg3=
KDNysG+cbq+tlDVVE+K5oG0kePVYX1fjIBQmJ+QhdJ3y9jCbB\n&quot;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                                &quot;U=
VveqzeZVXqHEw/kgoD4aZZmsdZfnVnpRa5/y9o1ZDUr50n+2nzUe/u/ijlb77iK\n&quot;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                         =
       &quot;Is04gnGJNoI3ZWhdyrSNfXjcYH+bKClu9OM4n7kCgYAorc3PAX7M0bsQrrqYxU=
S8\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
                     &quot;56UU0YdhAgYitjM7Fm/0iIm0vDpSevxL9js4HnnsSMVR77sp=
CBAGOCCZrTcI3Ejg\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                                &quot;xKDYzh1xlfMRjJBuBu5Pd55ZAv9NXFGpsX=
5SO8fDZQJMwpcbQH36+UdqRRFDpjJ0\n&quot;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                                &quot;ZbX6nKcJ7jciJVKJds59=
Jg=3D=3D\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                           &quot;-----END PRIVATE KEY-----\n&quot;;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static const char *const pr=
ivkey3 =3D &quot;-----BEGIN PRIVATE KEY-----\n&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                    &quot=
;MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC7xFoR6fmoyfsJ\n&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
               &quot;IQDKKgbYgFw0MzVuDAmpRx6KTEihgTchkQx9fHddWbKiOUbcEnQi3L=
Nux7P4QVl/\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                                   &quot;4dRR3skisBug6Vd5LXeBGZqmpu5XZiF4Dg=
Lz1lX21G0aOogFWkie2qGEcso40159\n&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                                    &quot;x9FBDl5A3sLP18=
ubeex0pd/BzDFv6SLOTyVWO/GCNc8IX/i0uN4mLvoVU00SeqwT\n&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                                    =
&quot;PnS+CRXrSq4JjGDJLsXl0/PlxkjsgU0yOOA0Z2d8Fzk3wClwP6Hc49BOMWKstUIh\n&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
                    &quot;LbG2DcIv8l29EuEj2w3ju/7gkewol96XQ2twpPvpoVAaiVh/m=
7hQUcQORQCD6eJc\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                                    &quot;DjOZVCArAgMBAAECggEACqkuWAAJ3=
cyCBVWrXs8eDmLTWV9i9DmYvtS75ixIn2rf\n&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                                    &quot;v3cl12Yev=
N0f6FgKLuqZT3Vqdqq+DCVhuIIQ9QkKMH8BQpSdE9NCCsFyZ23o8Gtr\n&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
     &quot;EQ7ymfecb+RFwYx7NpqWrvZI32VJGArgPZH/zorLTTGYrAZbmBtHEqRsXOuEDw97=
\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                         &quot;slwwcWaa9ztaYC8/N/7fgsnydaCFSaOByRlWuyvSmHvn=
6ZwLv8ANOshY6fstC0Jb\n&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                    &quot;BW0GpSe9eZPjpl71VT2Rtpgh=
qLV5+iAoFDHoT+eZvBospcUGtfcZSU7RrBjKB8+a\n&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                                    &quot;U1d6=
hwKhduVs2peIQzl+FiOSdWriLcsZv79q4sBhsQKBgQDUDVTf5BGJ8apOs/17\n&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
          &quot;YVk+Ad8Ey8sXvsfk49psmlCRa8Z4g0LVXfrP94qzhtl8U5kE9hs3nEF4j/k=
X1ZWG\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                              &quot;k11tdsNTZN5x5bbAgEgPA6Ap6J/uto0HS8G0vSv=
0lyBymdKA3p/i5Dx+8Nc9cGns\n&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                                    &quot;LGI9MvviLX7pQFIkvba=
CkdKwYwKBgQDirowjWZnm7BgVhF0G1m3DY9nQTYYU185W\n&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                    &quot=
;UESaO5/nVzwUrA+FypJamD+AvmlSuY8rJeQAGAS6nQr9G8/617r+GwJnzRtxC6Vl\n&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
               &quot;4OF5BJRsD70oX4CFOOlycMoJ8tzcYVH7NI8KVocjxb+QW82hqSvEwS=
svnwwn3eOW\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                                   &quot;nr5u5vIHmQKBgCuc3lL6Dl1ntdZgEIdau0=
cUjXDoFUo589TwxBDIID/4gaZxoMJP\n&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                                    &quot;hPFXAVDxMDPw4a=
zyjSB/47tPKTUsuYcnMfT8kynIujOEwnSPLcLgxQU5kgM/ynuw\n&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                                    =
&quot;qhNpQOwaVRMc7f2RTCMXPBYDpNE/GJn5eu8JWGLpZovEreBeoHX0VffvAoGAVrWn\n&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
                    &quot;+3mxykhzaf+oyg3KDNysG+cbq+tlDVVE+K5oG0kePVYX1fjIB=
QmJ+QhdJ3y9jCbB\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                                    &quot;UVveqzeZVXqHEw/kgoD4aZZmsdZfn=
VnpRa5/y9o1ZDUr50n+2nzUe/u/ijlb77iK\n&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                                    &quot;Is04gnGJN=
oI3ZWhdyrSNfXjcYH+bKClu9OM4n7kCgYAorc3PAX7M0bsQrrqYxUS8\n&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
     &quot;56UU0YdhAgYitjM7Fm/0iIm0vDpSevxL9js4HnnsSMVR77spCBAGOCCZrTcI3Ejg=
\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                         &quot;xKDYzh1xlfMRjJBuBu5Pd55ZAv9NXFGpsX5SO8fDZQJM=
wpcbQH36+UdqRRFDpjJ0\n&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                    &quot;ZbX6nKcJ7jciJVKJds59Jg=
=3D=3D\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                               &quot;-----END PRIVATE KEY-----\n&quot;;</sp=
an><br><span> static const char *const hash3 =3D &quot;2463628674E362578113=
F508BA05F29EF142E979&quot;;</span><br><span> static const char *const cname=
3 =3D &quot;ovpn-test-rsa1&quot;;</span><br><span> </span><br><span>@@ -156=
,7 +156,7 @@</span><br><span>     &quot;353PpJJ9s2b/Fqoc4d7udqhQogA7jqbayTK=
hJxbT134l2NzqDROzuS0kXbX8bXCi\n&quot;</span><br><span>     &quot;mXSa4c8=3D=
\n&quot;</span><br><span>     &quot;-----END CERTIFICATE-----\n&quot;;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#define key4 key3</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#define privkey4 privkey3</s=
pan><br><span> static const char *const hash4 =3D &quot;E1401D4497C944783E3=
D62CDBD2A1F69F5E5071E&quot;;</span><br><span> #define cname4 cname3 /* same=
 CN as that of cert3 */</span><br><span> </span><br><span>diff --git a/test=
s/unit_tests/openvpn/test_cryptoapi.c b/tests/unit_tests/openvpn/test_crypt=
oapi.c</span><br><span>index 59a356d..508afc9 100644</span><br><span>--- a/=
tests/unit_tests/openvpn/test_cryptoapi.c</span><br><span>+++ b/tests/unit_=
tests/openvpn/test_cryptoapi.c</span><br><span>@@ -115,10 +115,10 @@</span>=
<br><span> init_cert_data(void)</span><br><span> {</span><br><span>     str=
uct test_cert certs_local[] =3D {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        { cert1, key1, cname1, &quot;OVPN TEST CA1&quot;, &quot=
;OVPN Test Cert 1&quot;, hash1, 1 },</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        { cert2, key2, cname2, &quot;OVPN TEST CA2&quot;, &q=
uot;OVPN Test Cert 2&quot;, hash2, 1 },</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        { cert3, key3, cname3, &quot;OVPN TEST CA1&quot;,=
 &quot;OVPN Test Cert 3&quot;, hash3, 1 },</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        { cert4, key4, cname4, &quot;OVPN TEST CA2&quo=
t;, &quot;OVPN Test Cert 4&quot;, hash4, 0 },</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        { cert1, privkey1, cname1, &quot;OVPN TES=
T CA1&quot;, &quot;OVPN Test Cert 1&quot;, hash1, 1 },</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        { cert2, privkey2, cname2, &quot=
;OVPN TEST CA2&quot;, &quot;OVPN Test Cert 2&quot;, hash2, 1 },</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        { cert3, privkey3, cnam=
e3, &quot;OVPN TEST CA1&quot;, &quot;OVPN Test Cert 3&quot;, hash3, 1 },</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        { cert4, privk=
ey4, cname4, &quot;OVPN TEST CA2&quot;, &quot;OVPN Test Cert 4&quot;, hash4=
, 0 },</span><br><span>         { 0 }</span><br><span>     };</span><br><sp=
an>     assert_int_equal(sizeof(certs_local), sizeof(certs));</span><br><sp=
an>diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/o=
penvpn/test_pkcs11.c</span><br><span>index 722f9b1..8b6e594 100644</span><b=
r><span>--- a/tests/unit_tests/openvpn/test_pkcs11.c</span><br><span>+++ b/=
tests/unit_tests/openvpn/test_pkcs11.c</span><br><span>@@ -142,10 +142,10 @=
@</span><br><span> init_cert_data(void)</span><br><span> {</span><br><span>=
     struct test_cert certs_local[] =3D {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        { cert1, key1, cname1, &quot;OVPN TEST CA1&quot=
;, &quot;OVPN Test Cert 1&quot;, { 0 }, NULL },</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        { cert2, key2, cname2, &quot;OVPN TEST CA=
2&quot;, &quot;OVPN Test Cert 2&quot;, { 0 }, NULL },</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        { cert3, key3, cname3, &quot;OVPN T=
EST CA1&quot;, &quot;OVPN Test Cert 3&quot;, { 0 }, NULL },</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        { cert4, key4, cname4, &quot;=
OVPN TEST CA2&quot;, &quot;OVPN Test Cert 4&quot;, { 0 }, NULL },</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        { cert1, privkey1, cn=
ame1, &quot;OVPN TEST CA1&quot;, &quot;OVPN Test Cert 1&quot;, { 0 }, NULL =
},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        { cert2, =
privkey2, cname2, &quot;OVPN TEST CA2&quot;, &quot;OVPN Test Cert 2&quot;, =
{ 0 }, NULL },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   { cert3, privkey3, cname3, &quot;OVPN TEST CA1&quot;, &quot;OVPN Test Ce=
rt 3&quot;, { 0 }, NULL },</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        { cert4, privkey4, cname4, &quot;OVPN TEST CA2&quot;, &quot;=
OVPN Test Cert 4&quot;, { 0 }, NULL },</span><br><span>         { 0 }</span=
><br><span>     };</span><br><span>     assert_int_equal(sizeof(certs_local=
), sizeof(certs));</span><br><span></span><br></pre><p>To view, visit <a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1597?usp=3Demail">change 1597</=
a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope=
 itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1597?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id8680e6555a66024417d6eb9322=
d4fde79922453 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1597 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: flichtenheld &lt;frank@...2641...&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--/Hn1UOCcBXc=--

