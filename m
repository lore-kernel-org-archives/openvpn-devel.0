From: Steffan Karger <steffan@...1856...>
Date: Thu, 24 Apr 2014 00:43:38 +0200
Message-Id: <1398293018-8581-3-git-send-email-steffan@...1856...>
In-Reply-To: <1398293018-8581-1-git-send-email-steffan@...1856...>
References: <1398293018-8581-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 2/2] Add an elliptic curve testing cert
	chain to the sample keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 sample/sample-keys/README        |  6 ++--
 sample/sample-keys/ec-ca.crt     | 13 +++++++++
 sample/sample-keys/ec-ca.key     |  6 ++++
 sample/sample-keys/ec-client.crt | 61 ++++++++++++++++++++++++++++++++++++++++
 sample/sample-keys/ec-client.key |  6 ++++
 sample/sample-keys/ec-server.crt | 61 ++++++++++++++++++++++++++++++++++++++++
 sample/sample-keys/ec-server.key |  6 ++++
 7 files changed, 156 insertions(+), 3 deletions(-)
 create mode 100644 sample/sample-keys/ec-ca.crt
 create mode 100644 sample/sample-keys/ec-ca.key
 create mode 100644 sample/sample-keys/ec-client.crt
 create mode 100644 sample/sample-keys/ec-client.key
 create mode 100644 sample/sample-keys/ec-server.crt
 create mode 100644 sample/sample-keys/ec-server.key

diff --git a/sample/sample-keys/README b/sample/sample-keys/README
index 1cd473a..9f4f918 100644
--- a/sample/sample-keys/README
+++ b/sample/sample-keys/README
@@ -1,7 +1,6 @@
-Sample RSA keys.
+Sample RSA and EC keys.
 
-See the examples section of the man page
-for usage examples.
+See the examples section of the man page for usage examples.
 
 NOTE: THESE KEYS ARE FOR TESTING PURPOSES ONLY.
       DON'T USE THEM FOR ANY REAL WORK BECAUSE
@@ -12,3 +11,4 @@ client.{crt,key} -- sample client key/cert
 server.{crt,key} -- sample server key/cert (nsCertType=server)
 pass.{crt,key}   -- sample client key/cert with password-encrypted key
                     password = "password"
+ec-*.{crt,key}   -- sample elliptic curve variants of the above
diff --git a/sample/sample-keys/ec-ca.crt b/sample/sample-keys/ec-ca.crt
new file mode 100644
index 0000000..e190801
--- /dev/null
+++ b/sample/sample-keys/ec-ca.crt
@@ -0,0 +1,13 @@
+-----BEGIN CERTIFICATE-----
+MIIB4jCCAWmgAwIBAgIJALGEGB2g6cAXMAoGCCqGSM49BAMCMBUxEzARBgNVBAMT
+CkVDLVRlc3QgQ0EwHhcNMTQwMTE4MTYwMTUzWhcNMjQwMTE2MTYwMTUzWjAVMRMw
+EQYDVQQDEwpFQy1UZXN0IENBMHYwEAYHKoZIzj0CAQYFK4EEACIDYgAE2S4AZT7j
+ZlPG/CXpT12CzCNSySyKmJt+fWyW/wzbRulVJpGHXRHpZZj2VNOUE72kqGUeshh6
+Um1o7lHGDSAkHOJpeW5FtryiKhwFc+4dsOCLTNLVFXQsEtY3gY14Uquio4GEMIGB
+MB0GA1UdDgQWBBS0mkFcuCZ8SLWZRAD/8LpBQcgGPDBFBgNVHSMEPjA8gBS0mkFc
+uCZ8SLWZRAD/8LpBQcgGPKEZpBcwFTETMBEGA1UEAxMKRUMtVGVzdCBDQYIJALGE
+GB2g6cAXMAwGA1UdEwQFMAMBAf8wCwYDVR0PBAQDAgEGMAoGCCqGSM49BAMCA2cA
+MGQCMHWlVTi0xNZstR8ZNH+7z0WlyIXyZe23ne3EXkO0thZLdv86kpxFMPW/llB+
+RMRKuQIweN97n7FQy5DTenr91U98KDFJ5Av4mDFRL1mkXiu3W1//4XD8yEYDQTRz
+/GARuOLL
+-----END CERTIFICATE-----
diff --git a/sample/sample-keys/ec-ca.key b/sample/sample-keys/ec-ca.key
new file mode 100644
index 0000000..51a72e1
--- /dev/null
+++ b/sample/sample-keys/ec-ca.key
@@ -0,0 +1,6 @@
+-----BEGIN PRIVATE KEY-----
+MIG2AgEAMBAGByqGSM49AgEGBSuBBAAiBIGeMIGbAgEBBDASU6X/mh2m2PayviL3
+teoml5soyIUcZfwZpVn6oNtnrLcAbIRsAJbM4xyGVp77G/6hZANiAATZLgBlPuNm
+U8b8JelPXYLMI1LJLIqYm359bJb/DNtG6VUmkYddEellmPZU05QTvaSoZR6yGHpS
+bWjuUcYNICQc4ml5bkW2vKIqHAVz7h2w4ItM0tUVdCwS1jeBjXhSq6I=
+-----END PRIVATE KEY-----
diff --git a/sample/sample-keys/ec-client.crt b/sample/sample-keys/ec-client.crt
new file mode 100644
index 0000000..9372800
--- /dev/null
+++ b/sample/sample-keys/ec-client.crt
@@ -0,0 +1,61 @@
+Certificate:
+    Data:
+        Version: 3 (0x2)
+        Serial Number: 2 (0x2)
+    Signature Algorithm: ecdsa-with-SHA256
+        Issuer: CN=EC-Test CA
+        Validity
+            Not Before: Jan 18 16:02:37 2014 GMT
+            Not After : Jan 16 16:02:37 2024 GMT
+        Subject: CN=ec-client
+        Subject Public Key Info:
+            Public Key Algorithm: id-ecPublicKey
+                Public-Key: (384 bit)
+                pub: 
+                    04:40:d9:b9:a2:44:1b:01:39:2c:14:ee:aa:70:6b:
+                    31:98:28:44:c9:61:bc:b7:0b:b5:53:49:c2:c0:0a:
+                    43:b0:08:50:cd:80:2f:5d:a4:89:f1:ff:7d:11:78:
+                    f5:0c:b2:86:e2:59:f8:17:76:1b:22:f2:23:67:e7:
+                    55:90:ea:ce:0a:aa:da:05:f4:85:19:c9:ed:ae:6d:
+                    a3:ad:56:7a:f6:33:c6:cf:bb:c7:39:fa:e4:d3:67:
+                    df:f0:b8:4a:88:57:98
+                ASN1 OID: secp384r1
+        X509v3 extensions:
+            X509v3 Basic Constraints: 
+                CA:FALSE
+            X509v3 Subject Key Identifier: 
+                D8:E2:35:7B:CA:66:71:6B:D8:5B:F5:12:13:82:2D:ED:CD:E5:ED:7F
+            X509v3 Authority Key Identifier: 
+                keyid:B4:9A:41:5C:B8:26:7C:48:B5:99:44:00:FF:F0:BA:41:41:C8:06:3C
+                DirName:/CN=EC-Test CA
+                serial:B1:84:18:1D:A0:E9:C0:17
+
+            X509v3 Extended Key Usage: 
+                TLS Web Client Authentication
+            X509v3 Key Usage: 
+                Digital Signature
+            Netscape Comment: 
+                Easy-RSA Generated Certificate
+            Netscape Cert Type: 
+                SSL Client
+    Signature Algorithm: ecdsa-with-SHA256
+         30:64:02:30:41:8b:1a:fd:97:a8:bb:7c:d0:eb:1c:a2:ba:c0:
+         ac:2f:6d:80:07:5b:5c:ef:55:59:1a:92:56:66:94:ce:49:6a:
+         a9:57:49:b2:41:73:64:7e:01:ac:31:3a:7c:2a:bf:a5:02:30:
+         2b:c4:a6:b1:0c:03:82:e3:e4:03:39:fb:19:d7:76:21:1b:7e:
+         7f:aa:22:5d:90:a4:e1:2e:cd:ca:92:0f:b6:3f:80:dc:26:d2:
+         09:34:8c:d1:61:bb:9d:ac:6d:8f:68:f0
+-----BEGIN CERTIFICATE-----
+MIICLTCCAbSgAwIBAgIBAjAKBggqhkjOPQQDAjAVMRMwEQYDVQQDEwpFQy1UZXN0
+IENBMB4XDTE0MDExODE2MDIzN1oXDTI0MDExNjE2MDIzN1owFDESMBAGA1UEAxMJ
+ZWMtY2xpZW50MHYwEAYHKoZIzj0CAQYFK4EEACIDYgAEQNm5okQbATksFO6qcGsx
+mChEyWG8twu1U0nCwApDsAhQzYAvXaSJ8f99EXj1DLKG4ln4F3YbIvIjZ+dVkOrO
+CqraBfSFGcntrm2jrVZ69jPGz7vHOfrk02ff8LhKiFeYo4HYMIHVMAkGA1UdEwQC
+MAAwHQYDVR0OBBYEFNjiNXvKZnFr2Fv1EhOCLe3N5e1/MEUGA1UdIwQ+MDyAFLSa
+QVy4JnxItZlEAP/wukFByAY8oRmkFzAVMRMwEQYDVQQDEwpFQy1UZXN0IENBggkA
+sYQYHaDpwBcwEwYDVR0lBAwwCgYIKwYBBQUHAwIwCwYDVR0PBAQDAgeAMC0GCWCG
+SAGG+EIBDQQgFh5FYXN5LVJTQSBHZW5lcmF0ZWQgQ2VydGlmaWNhdGUwEQYJYIZI
+AYb4QgEBBAQDAgeAMAoGCCqGSM49BAMCA2cAMGQCMEGLGv2XqLt80OscorrArC9t
+gAdbXO9VWRqSVmaUzklqqVdJskFzZH4BrDE6fCq/pQIwK8SmsQwDguPkAzn7Gdd2
+IRt+f6oiXZCk4S7NypIPtj+A3CbSCTSM0WG7naxtj2jw
+-----END CERTIFICATE-----
diff --git a/sample/sample-keys/ec-client.key b/sample/sample-keys/ec-client.key
new file mode 100644
index 0000000..60636ed
--- /dev/null
+++ b/sample/sample-keys/ec-client.key
@@ -0,0 +1,6 @@
+-----BEGIN PRIVATE KEY-----
+MIG2AgEAMBAGByqGSM49AgEGBSuBBAAiBIGeMIGbAgEBBDD9Agj8nr/8sIr0XHky
+mcn1oMb3vqOh2axFBaIvmOHYmqs11SIH1tKYelkNYy9zHTChZANiAARA2bmiRBsB
+OSwU7qpwazGYKETJYby3C7VTScLACkOwCFDNgC9dpInx/30RePUMsobiWfgXdhsi
+8iNn51WQ6s4KqtoF9IUZye2ubaOtVnr2M8bPu8c5+uTTZ9/wuEqIV5g=
+-----END PRIVATE KEY-----
diff --git a/sample/sample-keys/ec-server.crt b/sample/sample-keys/ec-server.crt
new file mode 100644
index 0000000..f255aeb
--- /dev/null
+++ b/sample/sample-keys/ec-server.crt
@@ -0,0 +1,61 @@
+Certificate:
+    Data:
+        Version: 3 (0x2)
+        Serial Number: 1 (0x1)
+    Signature Algorithm: ecdsa-with-SHA256
+        Issuer: CN=EC-Test CA
+        Validity
+            Not Before: Jan 18 16:02:31 2014 GMT
+            Not After : Jan 16 16:02:31 2024 GMT
+        Subject: CN=ec-server
+        Subject Public Key Info:
+            Public Key Algorithm: id-ecPublicKey
+                Public-Key: (384 bit)
+                pub: 
+                    04:bd:8c:3a:af:2e:2f:2e:de:cf:d2:39:8d:b9:a6:
+                    13:96:80:6d:b5:b2:ee:97:62:3b:a2:32:38:77:1e:
+                    fb:2a:ef:86:4b:d0:9e:4b:55:e0:9b:07:f9:64:2f:
+                    6b:a7:17:fd:65:dd:50:3f:1c:fa:fa:2f:39:2e:97:
+                    d4:86:e5:4e:5a:d2:50:0b:f4:d7:08:62:67:53:44:
+                    62:e3:25:f2:fa:36:84:87:1d:03:e3:e9:9d:d9:66:
+                    51:dd:b4:c4:db:0b:05
+                ASN1 OID: secp384r1
+        X509v3 extensions:
+            X509v3 Basic Constraints: 
+                CA:FALSE
+            X509v3 Subject Key Identifier: 
+                EA:DF:7E:A3:D4:61:73:D7:01:AF:6E:0A:38:8D:33:D0:BD:24:4B:E1
+            X509v3 Authority Key Identifier: 
+                keyid:B4:9A:41:5C:B8:26:7C:48:B5:99:44:00:FF:F0:BA:41:41:C8:06:3C
+                DirName:/CN=EC-Test CA
+                serial:B1:84:18:1D:A0:E9:C0:17
+
+            X509v3 Extended Key Usage: 
+                TLS Web Server Authentication
+            X509v3 Key Usage: 
+                Digital Signature, Key Encipherment
+            Netscape Comment: 
+                Easy-RSA Generated Certificate
+            Netscape Cert Type: 
+                SSL Server
+    Signature Algorithm: ecdsa-with-SHA256
+         30:64:02:30:20:39:12:92:cc:a2:ca:45:b9:1a:8f:e0:c1:e7:
+         b7:4a:79:4d:07:07:81:72:08:b4:d4:7b:46:53:d7:72:32:d0:
+         d7:3e:e8:88:2b:c9:ba:8b:d5:94:4f:41:6c:d0:2e:a4:02:30:
+         75:ff:c3:8a:c1:f5:79:1c:1a:08:16:31:c2:c1:6e:d4:33:dc:
+         9f:04:0f:90:94:d9:75:c1:6d:71:28:62:cc:f6:89:7c:91:86:
+         a4:96:45:34:a0:8d:92:7e:dd:e3:da:4d
+-----BEGIN CERTIFICATE-----
+MIICLTCCAbSgAwIBAgIBATAKBggqhkjOPQQDAjAVMRMwEQYDVQQDEwpFQy1UZXN0
+IENBMB4XDTE0MDExODE2MDIzMVoXDTI0MDExNjE2MDIzMVowFDESMBAGA1UEAxMJ
+ZWMtc2VydmVyMHYwEAYHKoZIzj0CAQYFK4EEACIDYgAEvYw6ry4vLt7P0jmNuaYT
+loBttbLul2I7ojI4dx77Ku+GS9CeS1Xgmwf5ZC9rpxf9Zd1QPxz6+i85LpfUhuVO
+WtJQC/TXCGJnU0Ri4yXy+jaEhx0D4+md2WZR3bTE2wsFo4HYMIHVMAkGA1UdEwQC
+MAAwHQYDVR0OBBYEFOrffqPUYXPXAa9uCjiNM9C9JEvhMEUGA1UdIwQ+MDyAFLSa
+QVy4JnxItZlEAP/wukFByAY8oRmkFzAVMRMwEQYDVQQDEwpFQy1UZXN0IENBggkA
+sYQYHaDpwBcwEwYDVR0lBAwwCgYIKwYBBQUHAwEwCwYDVR0PBAQDAgWgMC0GCWCG
+SAGG+EIBDQQgFh5FYXN5LVJTQSBHZW5lcmF0ZWQgQ2VydGlmaWNhdGUwEQYJYIZI
+AYb4QgEBBAQDAgZAMAoGCCqGSM49BAMCA2cAMGQCMCA5EpLMospFuRqP4MHnt0p5
+TQcHgXIItNR7RlPXcjLQ1z7oiCvJuovVlE9BbNAupAIwdf/DisH1eRwaCBYxwsFu
+1DPcnwQPkJTZdcFtcShizPaJfJGGpJZFNKCNkn7d49pN
+-----END CERTIFICATE-----
diff --git a/sample/sample-keys/ec-server.key b/sample/sample-keys/ec-server.key
new file mode 100644
index 0000000..bb3cdf1
--- /dev/null
+++ b/sample/sample-keys/ec-server.key
@@ -0,0 +1,6 @@
+-----BEGIN PRIVATE KEY-----
+MIG2AgEAMBAGByqGSM49AgEGBSuBBAAiBIGeMIGbAgEBBDD8bQlwrFrXHPmem0bt
+cBcU6nYfaZQbPdIDAB7edOOyevvzYH0qMtbaW95iSZLMRVWhZANiAAS9jDqvLi8u
+3s/SOY25phOWgG21su6XYjuiMjh3Hvsq74ZL0J5LVeCbB/lkL2unF/1l3VA/HPr6
+Lzkul9SG5U5a0lAL9NcIYmdTRGLjJfL6NoSHHQPj6Z3ZZlHdtMTbCwU=
+-----END PRIVATE KEY-----
-- 
1.8.3.2


