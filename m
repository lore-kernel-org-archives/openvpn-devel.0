From: Arne Schwabe <arne@...1227...>
Date: Fri, 17 Apr 2020 09:43:45 +0200
Message-Id: <20200417074345.5694-1-arne@...1227...>
In-Reply-To: <20200414185214.1863-1-juliusz@...2525...>
References: <20200414185214.1863-1-juliusz@...2525...>
Subject: [Openvpn-devel] [PATCH] Add README.wolfssl documentating the state
 of WolfSSL in OpenVPN
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

---
 README.wolfssl | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 README.wolfssl

diff --git a/README.wolfssl b/README.wolfssl
new file mode 100644
index 00000000..d417807b
--- /dev/null
+++ b/README.wolfssl
@@ -0,0 +1,29 @@
+Support for WolfSSL is implemented and maintained by WolfSSL Inc. The support is
+implemented using WolfSSL's compatiblity layer. The WolfSSL support in OpenVPN
+receives very limited testing/support from the OpenVPN community itself.
+
+If bugs in OpenVPN when using WolfSSL are encountered, the user should try to
+also compile OpenVPN with OpenSSL to determinate if these are bugs in the
+WolfSSL TLS implemenation or OpenVPN itself.
+
+To Build and Install,
+
+	./configure --with-crypto-library=wolfssl
+	make
+	make install
+
+
+The wolfSSL library will include the installed options.h file by default.
+To include a custom user_settings.h file for wolfSSL,
+
+./configure --with-crypto-library=wolfssl --disable-wolfssl-options-h
+make
+make install
+
+*************************************************************************
+Due to limitations in the wolfSSL TLS library or its compability layer, the
+following features are missing
+
+ * blowfish support (BF-CBC), you must use something like
+   cipher AES-128-CBC to avoid trying to use BF-CBC
+ * Windows CryptoAPI support
-- 
2.26.0


