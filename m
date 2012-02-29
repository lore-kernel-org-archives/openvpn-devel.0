From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 29 Feb 2012 22:12:11 +0200
Message-Id: <1330546342-17794-42-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 41/52] build: autoconf: update defaults for
	options
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
To: 
Cc: Alon Bar-Lev <alon.barlev@...277...>


Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 configure.ac |   56 ++++++++++++++++++++++++++++----------------------------
 1 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/configure.ac b/configure.ac
index 57d294d..9ffcc68 100644
--- a/configure.ac
+++ b/configure.ac
@@ -41,195 +41,195 @@ AC_USE_SYSTEM_EXTENSIONS
 
 AC_ARG_ENABLE(
 	[lzo],
-	[AS_HELP_STRING([--enable-lzo], [enable LZO compression support])],
+	[AS_HELP_STRING([--enable-lzo], [enable LZO compression support @<:@default=no@:>@])],
 	,
 	[enable_lzo="no"]
 )
 
 AC_ARG_ENABLE(
 	[lzo-stub],
-	[AS_HELP_STRING([--enable-lzo-stub], [don't compile LZO compression support but still allow limited interoperability with LZO-enabled peers])],
+	[AS_HELP_STRING([--enable-lzo-stub], [don't compile LZO compression support but still allow limited interoperability with LZO-enabled peers @<:@default=no@:>@])],
 	,
 	[enable_lzo_stub="no"]
 )
 
 AC_ARG_ENABLE(
 	[crypto],
-	[AS_HELP_STRING([--disable-crypto], [disable crypto support])],
+	[AS_HELP_STRING([--disable-crypto], [disable crypto support @<:@default=yes@:>@])],
 	,
 	[enable_crypto="yes"]
 )
 
 AC_ARG_ENABLE(
 	[ssl],
-	[AS_HELP_STRING([--disable-ssl], [disable SSL support for TLS-based key exchange])],
+	[AS_HELP_STRING([--disable-ssl], [disable SSL support for TLS-based key exchange @<:@default=yes@:>@])],
 	,
 	[enable_ssl="yes"]
 )
 
 AC_ARG_ENABLE(
 	[x509-alt-username],
-	[AS_HELP_STRING([--enable-x509-alt-username], [enable the --x509-username-field feature])],
+	[AS_HELP_STRING([--enable-x509-alt-username], [enable the --x509-username-field feature @<:@default=no@:>@])],
 	,
 	[enable_x509_alt_username="no"]
 )
 
 AC_ARG_ENABLE(
 	[multi],
-	[AS_HELP_STRING([--disable-multi], [disable client/server support (--mode server + client mode)])],
+	[AS_HELP_STRING([--disable-multi], [disable client/server support (--mode server + client mode) @<:@default=yes@:>@])],
 	,
 	[enable_multi="yes"]
 )
 
 AC_ARG_ENABLE(
 	[server],
-	[AS_HELP_STRING([--disable-server], [disable server support only (but retain client support)])],
+	[AS_HELP_STRING([--disable-server], [disable server support only (but retain client support) @<:@default=yes@:>@])],
 	,
 	[enable_server="yes"]
 )
 
 AC_ARG_ENABLE(
 	[plugins],
-	[AS_HELP_STRING([--disable-plugins], [disable plug-in support])],
+	[AS_HELP_STRING([--disable-plugins], [disable plug-in support @<:@default=yes@:>@])],
 	,
 	[enable_plugins="yes"]
 )
 
 AC_ARG_ENABLE(
 	[eurephia],
-	[AS_HELP_STRING([--disable-eurephia], [disable support for the eurephia plug-in])],
+	[AS_HELP_STRING([--disable-eurephia], [disable support for the eurephia plug-in @<:@default=yes@:>@])],
 	,
 	[enable_eurephia="yes"]
 )
 
 AC_ARG_ENABLE(
 	[management],
-	[AS_HELP_STRING([--disable-management], [disable management server support])],
+	[AS_HELP_STRING([--disable-management], [disable management server support @<:@default=yes@:>@])],
 	,
 	[enable_management="yes"]
 )
 
 AC_ARG_ENABLE(
 	[pkcs11],
-	[AS_HELP_STRING([--enable-pkcs11], [enable pkcs11 support])],
+	[AS_HELP_STRING([--enable-pkcs11], [enable pkcs11 support @<:@default=no@:>@])],
 	,
 	[enable_pkcs11="no"]
 )
 
 AC_ARG_ENABLE(
 	[socks],
-	[AS_HELP_STRING([--disable-socks], [disable Socks support])],
+	[AS_HELP_STRING([--disable-socks], [disable Socks support @<:@default=yes@:>@])],
 	,
 	[enable_socks="yes"]
 )
 
 AC_ARG_ENABLE(
 	[http-proxy],
-	[AS_HELP_STRING([--disable-http-proxy], [disable HTTP proxy support])],
+	[AS_HELP_STRING([--disable-http-proxy], [disable HTTP proxy support @<:@default=yes@:>@])],
 	,
 	[enable_http_proxy="yes"]
 )
 
 AC_ARG_ENABLE(
 	[fragment],
-	[AS_HELP_STRING([--disable-fragment], [disable internal fragmentation support (--fragment)])],
+	[AS_HELP_STRING([--disable-fragment], [disable internal fragmentation support (--fragment) @<:@default=yes@:>@])],
 	,
 	[enable_fragment="yes"]
 )
 
 AC_ARG_ENABLE(
 	[multihome],
-	[AS_HELP_STRING([--disable-multihome], [disable multi-homed UDP server support (--multihome)])],
+	[AS_HELP_STRING([--disable-multihome], [disable multi-homed UDP server support (--multihome) @<:@default=yes@:>@])],
 	,
 	[enable_multihome="yes"]
 )
 
 AC_ARG_ENABLE(
 	[port-share],
-	[AS_HELP_STRING([--disable-port-share], [disable TCP server port-share support (--port-share)])],
+	[AS_HELP_STRING([--disable-port-share], [disable TCP server port-share support (--port-share) @<:@default=yes@:>@])],
 	,
 	[enable_port_share="yes"]
 )
 
 AC_ARG_ENABLE(
 	[debug],
-	[AS_HELP_STRING([--disable-debug], [disable debugging support (disable gremlin and verb 7+ messages)])],
+	[AS_HELP_STRING([--disable-debug], [disable debugging support (disable gremlin and verb 7+ messages) @<:@default=yes@:>@])],
 	,
 	[enable_debug="yes"]
 )
 
 AC_ARG_ENABLE(
 	[small],
-	[AS_HELP_STRING([--enable-small], [enable smaller executable size (disable OCC, usage message, and verb 4 parm list)])],
+	[AS_HELP_STRING([--enable-small], [enable smaller executable size (disable OCC, usage message, and verb 4 parm list) @<:@default=yes@:>@])],
 	,
 	[enable_small="no"]
 )
 
 AC_ARG_ENABLE(
 	[password-save],
-	[AS_HELP_STRING([--enable-password-save], [allow --askpass and --auth-user-pass passwords to be read from a file])],
+	[AS_HELP_STRING([--enable-password-save], [allow --askpass and --auth-user-pass passwords to be read from a file @<:@default=yes@:>@])],
 	[enable_password_save="no"]
 )
 
 AC_ARG_ENABLE(
 	[iproute2],
-	[AS_HELP_STRING([--enable-iproute2], [enable support for iproute2])],
+	[AS_HELP_STRING([--enable-iproute2], [enable support for iproute2 @<:@default=no@:>@])],
 	,
 	[enable_iproute2="no"]
 )
 
 AC_ARG_ENABLE(
 	[def-auth],
-	[AS_HELP_STRING([--disable-def-auth], [disable deferred authentication])],
+	[AS_HELP_STRING([--disable-def-auth], [disable deferred authentication @<:@default=yes@:>@])],
 	,
 	[enable_def_auth="yes"]
 )
 
 AC_ARG_ENABLE(
 	[pf],
-	[AS_HELP_STRING([--disable-pf], [disable internal packet filter])],
+	[AS_HELP_STRING([--disable-pf], [disable internal packet filter @<:@default=yes@:>@])],
 	,
 	[enable_pf="yes"]
 )
 
 AC_ARG_ENABLE(
 	[strict],
-	[AS_HELP_STRING([--enable-strict], [enable strict compiler warnings (debugging option)])],
+	[AS_HELP_STRING([--enable-strict], [enable strict compiler warnings (debugging option) @<:@default=no@:>@])],
 	,
 	[enable_strict="no"]
 )
 
 AC_ARG_ENABLE(
 	[pedantic],
-	[AS_HELP_STRING([--enable-pedantic], [enable pedantic compiler warnings, will not generate a working executable (debugging option)])],
+	[AS_HELP_STRING([--enable-pedantic], [enable pedantic compiler warnings, will not generate a working executable (debugging option) @<:@default=no@:>@])],
 	,
 	[enable_pedantic="no"]
 )
 
 AC_ARG_ENABLE(
 	[strict-options],
-	[AS_HELP_STRING([--enable-strict-options], [enable strict options check between peers (debugging option)])],
+	[AS_HELP_STRING([--enable-strict-options], [enable strict options check between peers (debugging option) @<:@default=no@:>@])],
 	,
 	[enable_strict_options="no"]
 )
 
 AC_ARG_ENABLE(
 	[selinux],
-	[AS_HELP_STRING([--enable-selinux], [enable SELinux support])],
+	[AS_HELP_STRING([--enable-selinux], [enable SELinux support @<:@default=no@:>@])],
 	,
 	[enable_selinux="no"]
 )
 
 AC_ARG_ENABLE(
 	[systemd],
-	[AS_HELP_STRING([--enable-systemd], [enable systemd suppport])],
+	[AS_HELP_STRING([--enable-systemd], [enable systemd suppport @<:@default=no@:>@])],
 	,
 	[enable_systemd="no"]
 )
 
 AC_ARG_WITH(
 	[mem-check],
-	[AS_HELP_STRING([--with-mem-check=TYPE], [build with debug memory checking, TYPE=dmalloc|valgrind|ssl])],
+	[AS_HELP_STRING([--with-mem-check=TYPE], [build with debug memory checking, TYPE=no|dmalloc|valgrind|ssl @<:@default=no@:>@])],
 	[
 		case "${withval}" in
 			dmalloc|valgrind|ssl|no) ;;
-- 
1.7.3.4


