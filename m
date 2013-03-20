From: Josh Cepek <josh.cepek@...1085...>
Date: Wed, 20 Mar 2013 13:22:25 -0500
Message-ID: <kicup2$gfv$1@...1062...>
References: <kicobf$9m7$1@...1062...> <5149E6F3.8020807@...1227...>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000102070105080705000804"
In-Reply-To: <5149E6F3.8020807@...1227...>
Subject: Re: [Openvpn-devel] (updated) [PATCH] Warn when using verb levels
	>=7 without debug
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------000102070105080705000804
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 3/20/2013 11:42, Arne Schwabe wrote:

> ACK. But I would change "debug verb" to "debug verbosity" and I think
> there should be no comma before "but"

This text change makes sense: I've adjusted it to read "NOTE: debug
verbosity..." and saved another byte removing the comma.

Updated patch attached.

--
Josh

--------------000102070105080705000804
Content-Type: text/plain; charset=windows-1252;
	name="0001-Warn-when-using-verb-levels-7-without-debug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-Warn-when-using-verb-levels-7-without-debug.patch"

From d41a0237220f2fea6647a508a2ab07263e0f160b Mon Sep 17 00:00:00 2001
From: Josh Cepek <josh.cepek@...1085...>
Date: Tue, 19 Mar 2013 22:52:12 -0500
Subject: [PATCH] Warn when using verb levels >=7 without debug

This patch adds a log warning when using --verb levels at 7 or higher
when running on builds lacking debug support. Since official builds are
now built with enable_debug=no, this warning will help developers
identify why expected debug messages may not be present in log output.

The test and message output code is omitted when built with
enable_debug=yes or enable_small=yes.

Signed-off-by: Josh Cepek <josh.cepek@...1085...>
---
 src/openvpn/options.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2eb4f91..ec39212 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4672,6 +4672,12 @@ add_option (struct options *options,
     {
       VERIFY_PERMISSION (OPT_P_MESSAGES);
       options->verbosity = positive_atoi (p[1]);
+#if !defined(ENABLE_DEBUG) && !defined(ENABLE_SMALL)
+      /* Warn when a debug verbosity is supplied when built without debug support */
+      if (options->verbosity >= 7)
+        msg (M_WARN, "NOTE: debug verbosity (--verb %d) is enabled but this build lacks debug support.",
+	    options->verbosity);
+#endif
     }
   else if (streq (p[0], "mute") && p[1])
     {
-- 
1.7.12.4


--------------000102070105080705000804--


