From: Antonio Quartulli <a@...2181...>
Date: Sun,  1 Apr 2018 21:16:12 +0800
Message-Id: <20180401131615.12567-2-a@...2181...>
In-Reply-To: <20180401131615.12567-1-a@...2181...>
References: <20180401131615.12567-1-a@...2181...>
Subject: [Openvpn-devel] [RFC 1/4] configure: add LINUX conditional variable
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
Cc: Antonio Quartulli <a@...2181...>

This variable is helpful when the configure script
has to take actions that are strictly limited to
the LINUX platform, as required by the introduction
of netlink support.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 configure.ac | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configure.ac b/configure.ac
index 626b4dd4..f2e4aa47 100644
--- a/configure.ac
+++ b/configure.ac
@@ -298,6 +298,7 @@ case "$host" in
 	*-*-linux*)
 		AC_DEFINE([TARGET_LINUX], [1], [Are we running on Linux?])
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["L"], [Target prefix])
+		LINUX=yes
 		;;
 	*-*-solaris*)
 		AC_DEFINE([TARGET_SOLARIS], [1], [Are we running on Solaris?])
@@ -1367,6 +1368,7 @@ AC_SUBST([OPTIONAL_PKCS11_HELPER_LIBS])
 AC_SUBST([PLUGIN_AUTH_PAM_CFLAGS])
 AC_SUBST([PLUGIN_AUTH_PAM_LIBS])
 
+AM_CONDITIONAL([LINUX], [test "${LINUX}" = "yes"])
 AM_CONDITIONAL([WIN32], [test "${WIN32}" = "yes"])
 AM_CONDITIONAL([GIT_CHECKOUT], [test "${GIT_CHECKOUT}" = "yes"])
 AM_CONDITIONAL([ENABLE_PLUGIN_AUTH_PAM], [test "${enable_plugin_auth_pam}" = "yes"])
-- 
2.16.3


