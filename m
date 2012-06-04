From: Alon Bar-Lev <alon.barlev@...277...>
Date: Mon,  4 Jun 2012 07:45:07 +0300
Message-Id: <1338785107-592-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <CAOazyz10-qHBsw=NyXhAwYDyf8yKRpLG2QJCYfTt=C9URdWT=A@...278...>
References: <CAOazyz10-qHBsw=NyXhAwYDyf8yKRpLG2QJCYfTt=C9URdWT=A@...278...>
Subject: [Openvpn-devel] [PATCH] build: update INSTALL to recent changes
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
Cc: Alon Bar-Lev <alon.barlev@...277...>

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 INSTALL |  150 +++++++++++++++++++++++++++++++++++++--------------------------
 1 files changed, 88 insertions(+), 62 deletions(-)

diff --git a/INSTALL b/INSTALL
index ab0d671..fd1fb80 100644
--- a/INSTALL
+++ b/INSTALL
@@ -60,28 +60,30 @@ OPTIONAL (but recommended):
   (2) LZO real-time compression library, required for link compression,
       available from http://www.oberhumer.com/opensource/lzo/
       OpenBSD users can use ports or packages to install lzo, but remember
-      to add "--with-lzo-headers" and "--with-lzo-lib" directives to
-      "configure", pointing to /usr/local/include and /usr/local/lib
-      respectively since gcc will not find them otherwise.
+      to add CFLAGS="-I/usr/local/include" LDFLAGS="-L/usr/local/lib"
+      directives to "configure", since gcc will not find them otherwise.
   (3) Pthread library.
 
 OPTIONAL (for developers only):
-  (1) Autoconf 2.50 or higher + Automake 1.5 or higher
+  (1) Autoconf 2.59 or higher + Automake 1.9 or higher
       -- available from http://www.gnu.org/software/software.html
   (2) Dmalloc library
       -- available from http://dmalloc.com/
 
 *************************************************************************
 
-CHECK OUT SOURCE FROM SUBVERSION REPOSITORY:
+CHECK OUT SOURCE FROM SOURCE REPOSITORY:
+
+  git clone https://github.com/OpenVPN/openvpn 
 
   Check out stable version:
 
-    svn checkout http://svn.openvpn.net/projects/openvpn/trunk/openvpn openvpn
+  git checkout -b 2.2 remotes/origin/release/2.2
+
+  Check out master (unstable) branch:
 
-  Check out beta21 branch:
+  git checkout master
 
-    svn checkout http://svn.openvpn.net/projects/openvpn/branches/BETA21/openvpn openvpn
 
 *************************************************************************
 
@@ -93,18 +95,18 @@ BUILD COMMANDS FROM TARBALL:
 
 *************************************************************************
 
-BUILD COMMANDS FROM SUBVERSION REPOSITORY CHECKOUT:
+BUILD COMMANDS FROM SOURCE REPOSITORY CHECKOUT:
 
-	autoreconf -i -v
+	autoreconf -i -v -f
 	./configure
 	make
 	make install
 
 *************************************************************************
 
-BUILD A TARBALL FROM SUBVERSION REPOSITORY CHECKOUT:
+BUILD A TARBALL FROM SOURCE REPOSITORY CHECKOUT:
 
-	autoreconf -i -v
+	autoreconf -i -v -f
 	./configure
 	make dist
 
@@ -121,36 +123,85 @@ Test Crypto:
 
 Test SSL/TLS negotiations (runs for 2 minutes):
 
-./openvpn --config sample-config-files/loopback-client  (In one window) 
-./openvpn --config sample-config-files/loopback-server  (Simultaneously in another window) 
+./openvpn --config sample/sample-config-files/loopback-client (In one window) 
+./openvpn --config sample/sample-config-files/loopback-server (Simultaneously in another window) 
 
 *************************************************************************
 
 OPTIONS for ./configure:
 
-  --enable-pthread          Compile pthread support for
-                            improved latency during SSL/TLS key
-                            negotiations (Linux or Solaris only)
-
-  --disable-lzo             Do not compile LZO compression support
-  --disable-crypto          Do not compile OpenSSL crypto support
-  --disable-ssl             Do not compile OpenSSL SSL support for
-                            TLS-based key exchange
-
-  --with-ssl-headers=DIR    Crypto/SSL Include files location
-  --with-ssl-lib=DIR        Crypto/SSL Library location
-  --with-lzo-headers=DIR    LZO Include files location
-  --with-lzo-lib=DIR        LZO Library location
-
-  --with-ifconfig-path=PATH   Path to ifconfig tool (only need to
-                              specify if in a non-standard location)
-
-  --with-leak-check=TYPE    Build with memory leak checking
-                            TYPE = dmalloc or ssl
-
-  --enable-strict           Enable strict compiler warnings
-
-  --enable-strict-options   Enable strict options check between peers
+  --disable-lzo           disable LZO compression support [default=yes]
+  --enable-lzo-stub       don't compile LZO compression support but still
+                          allow limited interoperability with LZO-enabled
+                          peers [default=no]
+  --disable-crypto        disable crypto support [default=yes]
+  --disable-ssl           disable SSL support for TLS-based key exchange
+                          [default=yes]
+  --enable-x509-alt-username
+                          enable the --x509-username-field feature
+                          [default=no]
+  --disable-multi         disable client/server support (--mode server +
+                          client mode) [default=yes]
+  --disable-server        disable server support only (but retain client
+                          support) [default=yes]
+  --disable-plugins       disable plug-in support [default=yes]
+  --disable-eurephia      disable support for the eurephia plug-in
+                          [default=yes]
+  --disable-management    disable management server support [default=yes]
+  --enable-pkcs11         enable pkcs11 support [default=no]
+  --disable-socks         disable Socks support [default=yes]
+  --disable-http-proxy    disable HTTP proxy support [default=yes]
+  --disable-fragment      disable internal fragmentation support (--fragment)
+                          [default=yes]
+  --disable-multihome     disable multi-homed UDP server support (--multihome)
+                          [default=yes]
+  --disable-port-share    disable TCP server port-share support (--port-share)
+                          [default=yes]
+  --disable-debug         disable debugging support (disable gremlin and verb
+                          7+ messages) [default=yes]
+  --enable-small          enable smaller executable size (disable OCC, usage
+                          message, and verb 4 parm list) [default=yes]
+  --enable-password-save  allow --askpass and --auth-user-pass passwords to be
+                          read from a file [default=yes]
+  --enable-iproute2       enable support for iproute2 [default=no]
+  --disable-def-auth      disable deferred authentication [default=yes]
+  --disable-pf            disable internal packet filter [default=yes]
+  --enable-strict         enable strict compiler warnings (debugging option)
+                          [default=no]
+  --enable-pedantic       enable pedantic compiler warnings, will not generate
+                          a working executable (debugging option) [default=no]
+  --enable-strict-options enable strict options check between peers (debugging
+                          option) [default=no]
+  --enable-selinux        enable SELinux support [default=no]
+  --enable-systemd        enable systemd suppport [default=no]
+
+ENVIRONMENT for ./configure:
+
+  IFCONFIG    full path to ipconfig utility
+  ROUTE       full path to route utility
+  IPROUTE     full path to ip utility
+  NETSTAT     path to netstat utility
+  MAN2HTML    path to man2html utility
+  GIT         path to git utility
+  TAP_CFLAGS  C compiler flags for tap
+  OPENSSL_CRYPTO_CFLAGS
+              C compiler flags for OPENSSL_CRYPTO, overriding pkg-config
+  OPENSSL_CRYPTO_LIBS
+              linker flags for OPENSSL_CRYPTO, overriding pkg-config
+  OPENSSL_SSL_CFLAGS
+              C compiler flags for OPENSSL_SSL, overriding pkg-config
+  OPENSSL_SSL_LIBS
+              linker flags for OPENSSL_SSL, overriding pkg-config
+  POLARSSL_CFLAGS
+              C compiler flags for polarssl
+  POLARSSL_LIBS
+              linker flags for polarssl
+  LZO_CFLAGS  C compiler flags for lzo
+  LZO_LIBS    linker flags for lzo
+  PKCS11_HELPER_CFLAGS
+              C compiler flags for PKCS11_HELPER, overriding pkg-config
+  PKCS11_HELPER_LIBS
+              linker flags for PKCS11_HELPER, overriding pkg-config
 
 *************************************************************************
 
@@ -316,28 +367,3 @@ CAVEATS & BUGS:
   IV for OFB and CFB modes.  This is not an issue if you are
   using CBC cipher mode (the default), or if you are using OFB or CFB
   cipher mode with SSL/TLS authentication.
-
-******************************************************************************
-
-Subject: [Openvpn-users] Re: Windows XP 64 bit
-From: Hypherion
-Date: Thu, 14 Apr 2005 07:01:17 +0000 (UTC)
-
-Well I managed to build a Windows XP 64 bit driver myself and it's working
-great, I can connect to my server again :)
-
-I had to use the WinDDK for Windows 2003 Service Pack 1 and just built the
-driver in the Windows 2003 AMD64 environment.  I had to comment out the
-MAPINFO:FIXUPS directive in the SOURCES file. 
- 
-Then I copied and renamed (devcon.exe/tapinstall.exe) from
-C:\WINDDK\3790.1830\tools\devcon\amd64. 
- 
-I had to edit the file OemWin2k.inf and change the Manufactured + Product
-Section to:
-
-[Manufacturer]
-   %Provider% = tap0901, NTamd64
-
-[tap0901.NTamd64]
-   %DeviceDescription% = tap0901.ndi, tap0901
-- 
1.7.3.4


