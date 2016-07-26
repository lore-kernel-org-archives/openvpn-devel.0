From: Steffan Karger <steffan.karger@...1435...>
Date: Tue, 26 Jul 2016 15:57:13 +0200
Message-ID: <1469541433-1671-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1469477219-13937-1-git-send-email-steffan@...1856...>
References: <1469477219-13937-1-git-send-email-steffan@...1856...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2.3] Fix "--cipher none --cipher" crash
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

As reported in trac #699, OpenVPN crashes when an "--cipher none" option
is followed by "--cipher" (without arguments).  Fix the crash, and print a
warning to indicate that using --cipher of --auth without an argument is
deprecated.

This is a (partly) backport of the patch I sent for the master branch
yesterday.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/options.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index a49a4fb..1ef0299 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6446,7 +6446,7 @@ add_option (struct options *options,
   else if (streq (p[0], "auth"))
     {
       VERIFY_PERMISSION (OPT_P_CRYPTO);
-      options->authname_defined = true;
+      msg (M_WARN, "WARNING: Using --auth without alg is deprecated.");
     }
   else if (streq (p[0], "cipher") && p[1])
     {
@@ -6462,7 +6462,7 @@ add_option (struct options *options,
   else if (streq (p[0], "cipher"))
     {
       VERIFY_PERMISSION (OPT_P_CRYPTO);
-      options->ciphername_defined = true;
+      msg (M_WARN, "WARNING: Using --cipher without alg is deprecated.");
     }
   else if (streq (p[0], "prng") && p[1])
     {
-- 
2.7.4


