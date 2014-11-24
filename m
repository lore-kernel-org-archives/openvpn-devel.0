From: David Sommerseth <openvpn.list@...1114...>
Date: Mon, 24 Nov 2014 19:09:38 +0100
Message-Id: <1416852578-7581-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCH] autotools: Fix wrong ./configure help
	screen default values
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

From: David Sommerseth <davids@...1347...>

enable_crypto_ofb_cfb is "yes" by default, so the --help screen
should show --disable-ofb-cfb and not --enable-ofb-cfb.

enable_small and enable_password_save are both "no" by default, so
the --help screen should state "default: no".  Now it says "yes" as
default, but is really disabled in the reality.

Signed-off-by: David Sommerseth <davids@...1347...>
---
 configure.ac | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index 608ab6d..ddaa2b2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -73,7 +73,7 @@ AC_ARG_ENABLE(
 
 AC_ARG_ENABLE(
 	[ofb-cfb],
-	[AS_HELP_STRING([--enable-ofb-cfb], [enable support for OFB and CFB cipher modes @<:@default=yes@:>@])],
+	[AS_HELP_STRING([--disable-ofb-cfb], [disable support for OFB and CFB cipher modes @<:@default=yes@:>@])],
 	,
 	[enable_crypto_ofb_cfb="yes"]
 )
@@ -157,14 +157,14 @@ AC_ARG_ENABLE(
 
 AC_ARG_ENABLE(
 	[small],
-	[AS_HELP_STRING([--enable-small], [enable smaller executable size (disable OCC, usage message, and verb 4 parm list) @<:@default=yes@:>@])],
+	[AS_HELP_STRING([--enable-small], [enable smaller executable size (disable OCC, usage message, and verb 4 parm list) @<:@default=no@:>@])],
 	,
 	[enable_small="no"]
 )
 
 AC_ARG_ENABLE(
 	[password-save],
-	[AS_HELP_STRING([--enable-password-save], [allow --askpass and --auth-user-pass passwords to be read from a file @<:@default=yes@:>@])],
+	[AS_HELP_STRING([--enable-password-save], [allow --askpass and --auth-user-pass passwords to be read from a file @<:@default=no@:>@])],
 	,
 	[enable_password_save="no"]
 )
-- 
1.8.3.1


