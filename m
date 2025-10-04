From: Christian Kujau <lists@...2941...>
Date: Sat,  4 Oct 2025 22:31:21 +0200
Message-ID: <20251004203121.83428-2-lists@...2941...>
In-Reply-To: <20251004203121.83428-1-lists@...2941...>
References: <20251004203121.83428-1-lists@...2941...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] doc: HTTPS upgrades and URL fixes
 throughout the tree
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
Cc: Christian Kujau <github@...2941...>

From: Christian Kujau <github@...2941...>

* HTTPS upgrades
* 404 fixes, with hopefully better helpful links to the relevant documentation
* some trailing white space fixes

Signed-off-by: Christian Kujau <github@...2941...>
---
 CONTRIBUTING.rst                       |  2 +-
 COPYING                                | 28 +++++++++++++-------------
 INSTALL                                |  8 ++++----
 PORTS                                  |  2 +-
 README                                 |  9 +++------
 dev-tools/git-pre-commit-format.sh     |  2 +-
 doc/android.txt                        |  2 +-
 doc/doxygen/doc_compression.h          |  2 +-
 doc/doxygen/doc_mainpage.h             |  2 +-
 doc/doxygen/openvpn.doxyfile.in        | 16 +++++++--------
 doc/keying-material-exporter.txt       | 10 ++++-----
 m4/pkg.m4                              |  2 +-
 sample/sample-config-files/README      |  2 +-
 sample/sample-config-files/client.conf |  2 +-
 sample/sample-config-files/server.conf |  2 +-
 src/openvpn/init.c                     |  4 ++--
 src/openvpn/list.c                     |  2 +-
 src/openvpn/memdbg.h                   |  2 +-
 src/openvpn/ntlm.c                     |  4 ++--
 src/openvpn/options.c                  |  2 +-
 src/openvpn/options.h                  |  2 +-
 src/openvpn/route.c                    |  4 ++--
 src/openvpn/socks.c                    |  2 +-
 src/openvpn/socks.h                    |  2 +-
 src/openvpn/tun.c                      |  4 ++--
 src/openvpn/win32-util.c               |  3 +--
 26 files changed, 59 insertions(+), 63 deletions(-)

diff --git a/CONTRIBUTING.rst b/CONTRIBUTING.rst
index a848f899..67baa4ec 100644
--- a/CONTRIBUTING.rst
+++ b/CONTRIBUTING.rst
@@ -20,7 +20,7 @@ small, atomic pieces to make reviews easier.
 
 Please make sure that the source code formatting follows the guidelines at
 https://community.openvpn.net/openvpn/wiki/CodeStyle. Automated checking can be
-done with uncrustify (http://uncrustify.sourceforge.net/) and the configuration
+done with uncrustify (https://uncrustify.sourceforge.net/) and the configuration
 file which can be found in the git repository at dev-tools/uncrustify.conf.
 There is also a git pre-commit hook script, which runs uncrustify automatically
 each time you commit and lets you format your code conveniently, if needed.
diff --git a/COPYING b/COPYING
index 3eb94689..c79e88ee 100644
--- a/COPYING
+++ b/COPYING
@@ -81,10 +81,10 @@ LZO license:
 
   Special exception for linking OpenVPN with both OpenSSL and LZO:
 
-  Hereby I grant a special exception to the OpenVPN project 
-  (http://openvpn.net/) to link the LZO library with 
-  the OpenSSL library (http://www.openssl.org).
- 
+  Hereby I grant a special exception to the OpenVPN project
+  (https://openvpn.net/) to link the LZO library with
+  the OpenSSL library (https://www.openssl.org).
+
   Markus F.X.J. Oberhumer
 
 TAP-Win32/TAP-Win64 Driver license:
@@ -117,7 +117,7 @@ NSIS License:
   including commercial applications, and to alter it and redistribute
   it freely, subject to the following restrictions:
 
-  1. The origin of this software must not be misrepresented; 
+  1. The origin of this software must not be misrepresented;
      you must not claim that you wrote the original software.
      If you use this software in a product, an acknowledgment in the
      product documentation would be appreciated but is not required.
@@ -142,7 +142,7 @@ OpenSSL License:
  * are met:
  *
  * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer. 
+ *    notice, this list of conditions and the following disclaimer.
  *
  * 2. Redistributions in binary form must reproduce the above copyright
  *    notice, this list of conditions and the following disclaimer in
@@ -152,7 +152,7 @@ OpenSSL License:
  * 3. All advertising materials mentioning features or use of this
  *    software must display the following acknowledgment:
  *    "This product includes software developed by the OpenSSL Project
- *    for use in the OpenSSL Toolkit. (http://www.openssl.org/)"
+ *    for use in the OpenSSL Toolkit. (https://www.openssl.org/)"
  *
  * 4. The names "OpenSSL Toolkit" and "OpenSSL Project" must not be used to
  *    endorse or promote products derived from this software without
@@ -166,7 +166,7 @@ OpenSSL License:
  * 6. Redistributions of any form whatsoever must retain the following
  *    acknowledgment:
  *    "This product includes software developed by the OpenSSL Project
- *    for use in the OpenSSL Toolkit (http://www.openssl.org/)"
+ *    for use in the OpenSSL Toolkit (https://www.openssl.org/)"
  *
  * THIS SOFTWARE IS PROVIDED BY THE OpenSSL PROJECT ``AS IS'' AND ANY
  * EXPRESSED OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
@@ -197,21 +197,21 @@ OpenSSL License:
  * This package is an SSL implementation written
  * by Eric Young (eay@...2490...).
  * The implementation was written so as to conform with Netscapes SSL.
- * 
+ *
  * This library is free for commercial and non-commercial use as long as
  * the following conditions are aheared to.  The following conditions
  * apply to all code found in this distribution, be it the RC4, RSA,
  * lhash, DES, etc., code; not just the SSL code.  The SSL documentation
  * included with this distribution is covered by the same copyright terms
  * except that the holder is Tim Hudson (tjh@...2490...).
- * 
+ *
  * Copyright remains Eric Young's, and as such any Copyright notices in
  * the code are not to be removed.
  * If this package is used in a product, Eric Young should be given attribution
  * as the author of the parts of the library used.
  * This can be in the form of a textual message at program startup or
  * in documentation (online or textual) provided with the package.
- * 
+ *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions
  * are met:
@@ -226,10 +226,10 @@ OpenSSL License:
  *     Eric Young (eay@...2490...)"
  *    The word 'cryptographic' can be left out if the rouines from the library
  *    being used are not cryptographic related :-).
- * 4. If you include any Windows specific code (or a derivative thereof) from 
+ * 4. If you include any Windows specific code (or a derivative thereof) from
  *    the apps directory (application code) you must include an acknowledgement:
  *    "This product includes software written by Tim Hudson (tjh@...2490...)"
- * 
+ *
  * THIS SOFTWARE IS PROVIDED BY ERIC YOUNG ``AS IS'' AND
  * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
  * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
@@ -241,7 +241,7 @@ OpenSSL License:
  * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
  * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
  * SUCH DAMAGE.
- * 
+ *
  * The licence and distribution terms for any publically available version or
  * derivative of this code cannot be changed.  i.e. this code cannot simply be
  * copied and put under another distribution licence
diff --git a/INSTALL b/INSTALL
index 97392722..77656b2c 100644
--- a/INSTALL
+++ b/INSTALL
@@ -67,7 +67,7 @@ SYSTEM REQUIREMENTS:
       a virtual point-to-point IP or Ethernet device.
       See TUN/TAP Driver References section below for more info.
   (2a) OpenSSL library, necessary for encryption, version 1.1.0 or higher
-      required, available from http://www.openssl.org/
+      required, available from https://www.openssl.org/
       or
   (2b) mbed TLS library, an alternative for encryption, version 2.0 or higher
       required, available from https://tls.mbed.org/
@@ -76,7 +76,7 @@ SYSTEM REQUIREMENTS:
 
 OPTIONAL:
   (5) LZO real-time compression library, required for link compression,
-      available from http://www.oberhumer.com/opensource/lzo/
+      available from https://www.oberhumer.com/opensource/lzo/
       (most supported operating systems have LZO in their installable
       packages repository.  It might be necessary to add LZO_CFLAGS=
       and LZO_LIBS= to the configure call to make it find the LZO pieces)
@@ -87,7 +87,7 @@ OPTIONAL (for developers only):
       Automake 1.9 or higher
       Libtool
       Git
-  (2) cmocka test framework (http://cmocka.org)
+  (2) cmocka test framework (https://cmocka.org)
   (3) If using t_client.sh test framework, fping/fping6 is needed
       Note: t_client.sh needs an external configured OpenVPN server.
       See t_client.rc-sample for more info.
@@ -261,7 +261,7 @@ TUN/TAP Driver References:
 
   You need a TUN/TAP kernel driver for OpenVPN to work:
 
-    http://www.whiteboard.ne.jp/~admin2/tuntap/
+    https://web.archive.org/web/20250504214754/http://www.whiteboard.ne.jp/~admin2/tuntap/
 
 * Haiku:
 
diff --git a/PORTS b/PORTS
index 6e682968..099ea1a5 100644
--- a/PORTS
+++ b/PORTS
@@ -41,7 +41,7 @@ PORTING GUIDELINE TO A NEW PLATFORM:
     platform.
   * Make sure that a tun or tap virtual device
     driver exists for your platform.  See
-    http://vtun.sourceforge.net/tun/ for examples
+    https://vtun.sourceforge.net/tun/ for examples
     of tun and tap drivers that have been written
     for Linux, Solaris, and FreeBSD.
   * Make sure you have autoconf 2.50+ and
diff --git a/README b/README
index 8576dbaa..04a243aa 100644
--- a/README
+++ b/README
@@ -27,16 +27,13 @@ or MSVC see README.cmake.md.
 *************************************************************************
 
 For detailed information on OpenVPN, including examples, see the man page
-  http://openvpn.net/man.html
+  https://openvpn.net/community-docs/community-articles/openvpn-2-6-manual.html
 
 For a sample VPN configuration, see
-  http://openvpn.net/howto.html
+  https://openvpn.net/community-docs/how-to.html
 
 To report an issue, see
   https://github.com/OpenVPN/openvpn/issues/new
-  (Note: We recently switched to GitHub for reporting new issues,
-   old issues can be found at:
-   https://community.openvpn.net/openvpn/report)
 
 For a description of OpenVPN's underlying protocol,
   see the file ssl.h included in the source distribution.
@@ -62,7 +59,7 @@ Other Files & Directories:
 * sample/sample-config-files/
 
   A collection of OpenVPN config files and scripts from
-  the HOWTO at http://openvpn.net/howto.html
+  the HOWTO at https://openvpn.net/community-docs/how-to.html
 
 *************************************************************************
 
diff --git a/dev-tools/git-pre-commit-format.sh b/dev-tools/git-pre-commit-format.sh
index 6e1ac718..9b2ecaf4 100755
--- a/dev-tools/git-pre-commit-format.sh
+++ b/dev-tools/git-pre-commit-format.sh
@@ -34,7 +34,7 @@
 #  - use clang-format or uncrustify depending on presence of .clang-format
 #    config file
 #
-# More info on Uncrustify: http://uncrustify.sourceforge.net/
+# More info on Uncrustify: https://uncrustify.sourceforge.net/
 
 # This file was taken from a set of unofficial pre-commit hooks available
 # at https://github.com/ddddavidmartin/Pre-commit-hooks and modified to
diff --git a/doc/android.txt b/doc/android.txt
index 394baf44..b78987db 100644
--- a/doc/android.txt
+++ b/doc/android.txt
@@ -7,7 +7,7 @@ This support is primarily used in the "OpenVPN for Android" app
 README: https://github.com/schwabe/ics-openvpn/blob/master/doc/README.txt
 
 Android provides the VPNService API
-(http://developer.android.com/reference/android/net/VpnService.html)
+(https://developer.android.com/reference/android/net/VpnService)
 which allows establishing VPN connections without rooting the device.
 
 Unlike on other platforms, the tun device is openend by UI instead of
diff --git a/doc/doxygen/doc_compression.h b/doc/doxygen/doc_compression.h
index 51ad7c07..cc04ae6b 100644
--- a/doc/doxygen/doc_compression.h
+++ b/doc/doxygen/doc_compression.h
@@ -87,5 +87,5 @@
  *
  * @par
  * For more information on the LZO library, see:\n
- * http://www.oberhumer.com/opensource/lzo/
+ * https://www.oberhumer.com/opensource/lzo/
  */
diff --git a/doc/doxygen/doc_mainpage.h b/doc/doxygen/doc_mainpage.h
index 1ff8f7a1..a78d31b3 100644
--- a/doc/doxygen/doc_mainpage.h
+++ b/doc/doxygen/doc_mainpage.h
@@ -32,7 +32,7 @@
  * This documentation describes the internal structure of OpenVPN.  It was
  * automatically generated from specially formatted comment blocks in
  * OpenVPN's source code using Doxygen.  (See
- * http://www.stack.nl/~dimitri/doxygen/ for more information on Doxygen)
+ * https://www.doxygen.nl/ for more information on Doxygen)
  *
  * The \ref mainpage_modules "Modules section" below gives an introduction
  * into the high-level module concepts used throughout this documentation.
diff --git a/doc/doxygen/openvpn.doxyfile.in b/doc/doxygen/openvpn.doxyfile.in
index bdbc6089..048350af 100644
--- a/doc/doxygen/openvpn.doxyfile.in
+++ b/doc/doxygen/openvpn.doxyfile.in
@@ -1108,7 +1108,7 @@ VERBATIM_HEADERS       = YES
 
 # If the CLANG_ASSISTED_PARSING tag is set to YES then doxygen will use the
 # clang parser (see:
-# http://clang.llvm.org/) for more accurate parsing at the cost of reduced
+# https://clang.llvm.org/) for more accurate parsing at the cost of reduced
 # performance. This can be particularly helpful with template rich C++ code for
 # which doxygen's built-in parser lacks the necessary type information.
 # Note: The availability of this option depends on whether or not doxygen was
@@ -1134,7 +1134,7 @@ CLANG_OPTIONS          =
 # If clang assisted parsing is enabled you can provide the clang parser with the
 # path to the directory containing a file called compile_commands.json. This
 # file is the compilation database (see:
-# http://clang.llvm.org/docs/HowToSetupToolingForLLVM.html) containing the
+# https://clang.llvm.org/docs/HowToSetupToolingForLLVM.html) containing the
 # options used when the source files were built. This is equivalent to
 # specifying the -p option to a clang tool, such as clang-check. These options
 # will then be passed to the parser. Any options specified with CLANG_OPTIONS
@@ -1615,7 +1615,7 @@ USE_MATHJAX            = NO
 
 # When MathJax is enabled you can set the default output format to be used for
 # the MathJax output. See the MathJax site (see:
-# http://docs.mathjax.org/en/v2.7-latest/output.html) for more details.
+# https://docs.mathjax.org/en/v2.7/output.html) for more details.
 # Possible values are: HTML-CSS (which is slower, but has the best
 # compatibility), NativeMML (i.e. MathML) and SVG.
 # The default value is: HTML-CSS.
@@ -1646,7 +1646,7 @@ MATHJAX_EXTENSIONS     =
 # The MATHJAX_CODEFILE tag can be used to specify a file with javascript pieces
 # of code that will be used on startup of the MathJax code. See the MathJax site
 # (see:
-# http://docs.mathjax.org/en/v2.7-latest/output.html) for more details. For an
+# https://docs.mathjax.org/en/v2.7/output.html) for more details. For an
 # example see the documentation.
 # This tag requires that the tag USE_MATHJAX is set to YES.
 
@@ -2109,7 +2109,7 @@ DOCBOOK_PROGRAMLISTING = NO
 #---------------------------------------------------------------------------
 
 # If the GENERATE_AUTOGEN_DEF tag is set to YES, doxygen will generate an
-# AutoGen Definitions (see http://autogen.sourceforge.net/) file that captures
+# AutoGen Definitions (see https://autogen.sourceforge.net/) file that captures
 # the structure of the code including all documentation. Note that this feature
 # is still experimental and incomplete at the moment.
 # The default value is: NO.
@@ -2315,7 +2315,7 @@ HIDE_UNDOC_RELATIONS   = YES
 
 # If you set the HAVE_DOT tag to YES then doxygen will assume the dot tool is
 # available from the path. This tool is part of Graphviz (see:
-# http://www.graphviz.org/), a graph visualization toolkit from AT&T and Lucent
+# https://www.graphviz.org/), a graph visualization toolkit from AT&T and Lucent
 # Bell Labs. The other options in this section have no effect if this option is
 # set to NO
 # The default value is: YES.
@@ -2491,8 +2491,8 @@ DIRECTORY_GRAPH        = YES
 
 # The DOT_IMAGE_FORMAT tag can be used to set the image format of the images
 # generated by dot. For an explanation of the image formats see the section
-# output formats in the documentation of the dot tool (Graphviz (see:
-# http://www.graphviz.org/)).
+# output formats in the documentation of the dot tool (Graphviz, see:
+# https://www.graphviz.org/).
 # Note: If you choose svg you need to set HTML_FILE_EXTENSION to xhtml in order
 # to make the SVG files visible in IE 9+ (other browsers do not have this
 # requirement).
diff --git a/doc/keying-material-exporter.txt b/doc/keying-material-exporter.txt
index 4c1addc8..b158fbc1 100644
--- a/doc/keying-material-exporter.txt
+++ b/doc/keying-material-exporter.txt
@@ -117,21 +117,21 @@ Reference
 
    [RFC5705]               "Keying Material Exporters for TLS"
                            E. Rescorla, RFC 5705 March 2010
-                           http://tools.ietf.org/html/rfc5705
+                           https://tools.ietf.org/html/rfc5705
 
    [RFC5929]               "Channel Bindings for TLS"
                            J. Altman, N. Williams, L. Zhu, RFC 5929, July 2010
-                           http://tools.ietf.org/html/rfc5929
+                           https://tools.ietf.org/html/rfc5929
 
    [RFC4680]               "TLS Handshake Message for Supplemental Data"
                            S. Santesson, RFC 4680, September 2006
-                           http://tools.ietf.org/html/rfc4680
+                           https://tools.ietf.org/html/rfc4680
 
    [RFC5878]               "TLS Authorization Extension"
                            M. Brown, R. Housley, RFC 5878, May 2010
-                           http://tools.ietf.org/html/rfc5878
+                           https://tools.ietf.org/html/rfc5878
 
    [RFC5746]               "TLS Renegotiation Indication Extension"
                            E. Rescorla, M. Raym, S. Dispensa, N. Oskov
                            RFC 5746, February 2010
-                           http://tools.ietf.org/html/rfc5746
+                           https://tools.ietf.org/html/rfc5746
diff --git a/m4/pkg.m4 b/m4/pkg.m4
index 13a88901..01628d8a 100644
--- a/m4/pkg.m4
+++ b/m4/pkg.m4
@@ -181,7 +181,7 @@ path to pkg-config.
 
 _PKG_TEXT
 
-To get pkg-config, see <http://pkg-config.freedesktop.org/>.])[]dnl
+To get pkg-config, see <https://www.freedesktop.org/wiki/Software/pkg-config/>.])[]dnl
         ])
 else
 	$1[]_CFLAGS=$pkg_cv_[]$1[]_CFLAGS
diff --git a/sample/sample-config-files/README b/sample/sample-config-files/README
index 1493dab6..eeb9dbc4 100644
--- a/sample/sample-config-files/README
+++ b/sample/sample-config-files/README
@@ -3,6 +3,6 @@ Sample OpenVPN Configuration Files.
 These files are part of the OpenVPN HOWTO
 which is located at:
 
-http://openvpn.net/howto.html
+https://openvpn.net/community-docs/how-to.html
 
 See also the openvpn-examples man page.
diff --git a/sample/sample-config-files/client.conf b/sample/sample-config-files/client.conf
index 53b8027d..475fd95c 100644
--- a/sample/sample-config-files/client.conf
+++ b/sample/sample-config-files/client.conf
@@ -92,7 +92,7 @@ key client.key
 # certificate has the correct key usage set.
 # This is an important precaution to protect against
 # a potential attack discussed here:
-#  http://openvpn.net/howto.html#mitm
+#  https://openvpn.net/community-docs/how-to.html
 #
 # To use this feature, you will need to generate
 # your server certificates with the keyUsage set to
diff --git a/sample/sample-config-files/server.conf b/sample/sample-config-files/server.conf
index 8943c34e..7717a50d 100644
--- a/sample/sample-config-files/server.conf
+++ b/sample/sample-config-files/server.conf
@@ -203,7 +203,7 @@ ifconfig-pool-persist ipp.txt
 # Certain Windows-specific network settings
 # can be pushed to clients, such as DNS
 # or WINS server addresses.  CAVEAT:
-# http://openvpn.net/faq.html#dhcpcaveats
+# https://openvpn.net/community-docs/pushing-dhcp-options-to-clients.html
 # The addresses below refer to the public
 # DNS servers provided by opendns.com.
 ;push "dhcp-option DNS 208.67.222.222"
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index f8a0fee6..6f58e14f 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1565,7 +1565,7 @@ initialization_sequence_completed(struct context *c, const unsigned int flags)
 #ifdef _WIN32
         show_routes(M_INFO | M_NOPREFIX);
         show_adapters(M_INFO | M_NOPREFIX);
-        msg(M_INFO, "%s With Errors ( see http://openvpn.net/faq.html#dhcpclientserv )", message);
+        msg(M_INFO, "%s With Errors ( see https://openvpn.net/faq.html#dhcpclientserv )", message);
 #else
 #ifdef ENABLE_SYSTEMD
         sd_notifyf(0, "STATUS=Failed to start up: %s With Errors\nERRNO=1", message);
@@ -3647,7 +3647,7 @@ do_option_warnings(struct context *c)
         && !(o->verify_hash_depth == 0 && o->verify_hash))
     {
         msg(M_WARN,
-            "WARNING: No server certificate verification method has been enabled.  See http://openvpn.net/howto.html#mitm for more info.");
+            "WARNING: No server certificate verification method has been enabled.  See https://openvpn.net/community-docs/how-to.html for more info.");
     }
     if (o->ns_cert_type)
     {
diff --git a/src/openvpn/list.c b/src/openvpn/list.c
index 1b90d821..00156745 100644
--- a/src/openvpn/list.c
+++ b/src/openvpn/list.c
@@ -338,7 +338,7 @@ hash_iterator_delete_element(struct hash_iterator *hi)
  * By Bob Jenkins, 1996.  bob_jenkins@...2942...  You may use this
  * code any way you wish, private, educational, or commercial.  It's free.
  *
- * See http://burlteburtle.net/bob/hash/evahash.html
+ * See https://burtleburtle.net/bob/hash/evahash.html
  * Use for hash table lookup, or anything where one collision in 2^32 is
  * acceptable.  Do NOT use for cryptographic purposes.
  *
diff --git a/src/openvpn/memdbg.h b/src/openvpn/memdbg.h
index 738a775d..b92b971e 100644
--- a/src/openvpn/memdbg.h
+++ b/src/openvpn/memdbg.h
@@ -62,7 +62,7 @@
  *
  * The dmalloc package can be downloaded from:
  *
- *     http://dmalloc.com/
+ *     https://dmalloc.com/
  *
  * When dmalloc is installed and enabled,
  * use this command prior to running openvpn:
diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index 521677b8..8e913dce 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -179,7 +179,7 @@ ntlm_phase_1(const struct http_proxy_info *p, struct gc_arena *gc)
     struct buffer out = alloc_buf_gc(96, gc);
     /* try a minimal NTLM handshake
      *
-     * http://davenport.sourceforge.net/ntlm.html
+     * https://davenport.sourceforge.net/ntlm.html
      *
      * This message contains only the NTLMSSP signature,
      * the NTLM message type,
@@ -195,7 +195,7 @@ ntlm_phase_3(const struct http_proxy_info *p, const char *phase_2, struct gc_are
 {
     /* NTLM handshake
      *
-     * http://davenport.sourceforge.net/ntlm.html
+     * https://davenport.sourceforge.net/ntlm.html
      *
      */
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index f35738d8..9a5e6231 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -23,7 +23,7 @@
 
 /*
  * 2004-01-28: Added Socks5 proxy support
- *   (Christof Meerwald, http://cmeerw.org)
+ *   (Christof Meerwald, https://cmeerw.org)
  */
 
 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index b0330681..d306bcfe 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -22,7 +22,7 @@
 
 /*
  * 2004-01-28: Added Socks5 proxy support
- *   (Christof Meerwald, http://cmeerw.org)
+ *   (Christof Meerwald, https://cmeerw.org)
  */
 
 #ifndef OPTIONS_H
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 05a0c8f4..c8f28add 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -3259,9 +3259,9 @@ done:
 }
 
 /* IPv6 implementation using netlink
- * http://www.linuxjournal.com/article/7356
+ * https://www.linuxjournal.com/article/7356 - "Kernel Korner - Why and How to Use Netlink Socket"
  * netlink(3), netlink(7), rtnetlink(7)
- * http://www.virtualbox.org/svn/vbox/trunk/src/VBox/NetworkServices/NAT/rtmon_linux.c
+ * https://www.virtualbox.org/svn/vbox/trunk/src/VBox/NetworkServices/NAT/
  */
 struct rtreq
 {
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index 85bbde5e..2c3a1f92 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -22,7 +22,7 @@
 
 /*
  * 2004-01-30: Added Socks5 proxy support, see RFC 1928
- *   (Christof Meerwald, http://cmeerw.org)
+ *   (Christof Meerwald, https://cmeerw.org)
  *
  * 2010-10-10: Added Socks5 plain text authentication support (RFC 1929)
  *   (Pierre Bourdon <delroth@...277...>)
diff --git a/src/openvpn/socks.h b/src/openvpn/socks.h
index b5a69b9e..4f1f0940 100644
--- a/src/openvpn/socks.h
+++ b/src/openvpn/socks.h
@@ -22,7 +22,7 @@
 
 /*
  * 2004-01-30: Added Socks5 proxy support
- *   (Christof Meerwald, http://cmeerw.org)
+ *   (Christof Meerwald, https://cmeerw.org)
  */
 
 #ifndef SOCKS_H
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index e35f8893..1a91a7f0 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -2294,7 +2294,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
     struct strioctl strioc_if, strioc_ppa;
 
     /* improved generic TUN/TAP driver from
-     * http://www.whiteboard.ne.jp/~admin2/tuntap/
+     * https://web.archive.org/web/20250504214754/http://www.whiteboard.ne.jp/~admin2/tuntap/
      * has IPv6 support
      */
     CLEAR(ifr);
@@ -3125,7 +3125,7 @@ read_tun(struct tuntap *tt, uint8_t *buf, int len)
 /*
  * utun is the native Darwin tun driver present since at least 10.7
  * Thanks goes to Jonathan Levin for providing an example how to utun
- * (http://newosxbook.com/src.jl?tree=listings&file=17-15-utun.c)
+ * (https://newosxbook.com/Finder/src.jl?tree=listings&file=17-15-utun.c)
  */
 
 /* Helper functions that tries to open utun device
diff --git a/src/openvpn/win32-util.c b/src/openvpn/win32-util.c
index 0d6d0290..305a4dc5 100644
--- a/src/openvpn/win32-util.c
+++ b/src/openvpn/win32-util.c
@@ -68,8 +68,7 @@ utf16to8(const wchar_t *utf16, struct gc_arena *gc)
  * CON, PRN, AUX, NUL, COM1, COM2, COM3, COM4, COM5, COM6, COM7, COM8, COM9,
  * LPT1, LPT2, LPT3, LPT4, LPT5, LPT6, LPT7, LPT8, LPT9, and CLOCK$
  *
- * See: http://msdn.microsoft.com/en-us/library/aa365247.aspx
- *  and http://msdn.microsoft.com/en-us/library/86k9f82k(VS.80).aspx
+ * See: https://learn.microsoft.com/en-us/windows/win32/fileio/naming-a-file
  */
 
 static bool
-- 
2.50.1 (Apple Git-155)


