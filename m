From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 17 Oct 2019 12:28:53 +0300
Message-Id: <1571304533-15614-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] msvc: OpenSSL 1.1.0 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Lev Stipakov <lev@...515...>

Since we release Windows client with OpenSSL 1.1.0,
it makes sense to switch to this version in VS build.

This patch adds msvc-specific defines which imply
that underlying OpenSSL is 1.1.0.

Also OpenSSL library names in project file are updated.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 config-msvc.h               | 37 +++++++++++++++++++++++++++++++++++++
 src/openvpn/openvpn.vcxproj |  8 ++++----
 2 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/config-msvc.h b/config-msvc.h
index 45fae8b..2f2d98f 100644
--- a/config-msvc.h
+++ b/config-msvc.h
@@ -76,6 +76,43 @@
 #define HAVE_POLL 1
 
 #define HAVE_OPENSSL_ENGINE 1
+/* hardcode OpenSSL 1.1.0 support */
+#define HAVE_EVP_MD_CTX_RESET 1
+#define HAVE_EVP_MD_CTX_FREE 1
+#define HAVE_EVP_MD_CTX_NEW 1
+#define HAVE_HMAC_CTX_RESET 1
+#define HAVE_HMAC_CTX_FREE 1
+#define HAVE_HMAC_CTX_NEW 1
+#define HAVE_SSL_CTX_GET_DEFAULT_PASSWD_CB_USERDATA 1
+#define HAVE_SSL_CTX_GET_DEFAULT_PASSWD_CB 1
+#define HAVE_X509_GET0_PUBKEY 1
+#define HAVE_X509_STORE_GET0_OBJECTS 1
+#define HAVE_X509_OBJECT_FREE 1
+#define HAVE_X509_OBJECT_GET_TYPE 1
+#define HAVE_EVP_PKEY_GET0_RSA 1
+#define HAVE_EVP_PKEY_GET0_EC_KEY 1
+#define HAVE_EVP_PKEY_ID 1
+#define HAVE_EVP_PKEY_GET0_DSA 1
+#define HAVE_RSA_SET_FLAGS 1
+#define HAVE_RSA_GET0_KEY 1
+#define HAVE_RSA_SET0_KEY 1
+#define HAVE_RSA_BITS 1
+#define HAVE_DSA_GET0_PQG 1
+#define HAVE_DSA_BITS 1
+#define HAVE_RSA_METH_NEW 1
+#define HAVE_RSA_METH_FREE 1
+#define HAVE_RSA_METH_SET_PUB_ENC 1
+#define HAVE_RSA_METH_SET_PUB_DEC 1
+#define HAVE_RSA_METH_SET_PRIV_ENC 1
+#define HAVE_RSA_METH_SET_PRIV_DEC 1
+#define HAVE_RSA_METH_SET_INIT 1
+#define HAVE_RSA_METH_SET_SIGN 1
+#define HAVE_RSA_METH_SET_FINISH 1
+#define HAVE_RSA_METH_SET0_APP_DATA 1
+#define HAVE_RSA_METH_GET0_APP_DATA 1
+#define HAVE_EC_GROUP_ORDER_BITS 1
+#define OPENSSL_NO_EC 1
+#define HAVE_EVP_CIPHER_CTX_RESET 1
 
 #define PATH_SEPARATOR     '\\'
 #define PATH_SEPARATOR_STR "\\"
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index 3b0ee60..4ffff2b 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -78,7 +78,7 @@
     </ClCompile>
     <ResourceCompile />
     <Link>
-      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;%(AdditionalDependencies)</AdditionalDependencies>
+      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libssl.lib;libcrypto.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;%(AdditionalDependencies)</AdditionalDependencies>
       <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
       <SubSystem>Console</SubSystem>
     </Link>
@@ -91,7 +91,7 @@
     </ClCompile>
     <ResourceCompile />
     <Link>
-      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;%(AdditionalDependencies)</AdditionalDependencies>
+      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libssl.lib;libcrypto.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;%(AdditionalDependencies)</AdditionalDependencies>
       <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
       <SubSystem>Console</SubSystem>
     </Link>
@@ -104,7 +104,7 @@
     </ClCompile>
     <ResourceCompile />
     <Link>
-      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;%(AdditionalDependencies)</AdditionalDependencies>
+      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libssl.lib;libcrypto.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;%(AdditionalDependencies)</AdditionalDependencies>
       <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
       <SubSystem>Console</SubSystem>
     </Link>
@@ -117,7 +117,7 @@
     </ClCompile>
     <ResourceCompile />
     <Link>
-      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;%(AdditionalDependencies)</AdditionalDependencies>
+      <AdditionalDependencies>legacy_stdio_definitions.lib;Ncrypt.lib;libssl.lib;libcrypto.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;%(AdditionalDependencies)</AdditionalDependencies>
       <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
       <SubSystem>Console</SubSystem>
     </Link>
-- 
2.7.4


