From: David Sommerseth <davids@...1347...>
Date: Mon, 16 May 2011 13:10:15 +0200
Message-Id: <1305544215-12654-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH] Make '--comp-lzo no' the default behaviour
	if LZO is enabled
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
Cc: David Sommerseth <davids@...1347...>

This makes 'comp-lzo' pushable without requiring clients to have
--comp-lzo defined in the client configs.  To make 'comp-lzo' not
pushable on the client, a new 'disabled' argument have been added.

Trac-ticket: 128
Signed-off-by: David Sommerseth <davids@...1347...>
---
 openvpn.8 |   12 ++++++------
 options.c |   10 +++++++---
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/openvpn.8 b/openvpn.8
index 5cbf4c5..89759b6 100644
--- a/openvpn.8
+++ b/openvpn.8
@@ -2284,7 +2284,9 @@ limit repetitive logging of similar message types.
 Use fast LZO compression \-\- may add up to 1 byte per
 packet for incompressible data.
 .B mode
-may be "yes", "no", or "adaptive" (default).
+may be "yes", "adaptive" or "disabled".
+If  \-\-comp-lzo is used without an argument, it defaults to
+"adaptive".
 
 In a server mode setup, it is possible to selectively turn
 compression on or off for individual clients.
@@ -2293,11 +2295,9 @@ First, make sure the client-side config file enables selective
 compression by having at least one
 .B \-\-comp-lzo
 directive, such as
-.B \-\-comp-lzo no.
-This will turn off compression by default,
-but allow a future directive push from the server to
-dynamically change the
-on/off/adaptive setting.
+
+If the "disabled" argument is given, \-\-comp-lzo can not be pushed
+from the server to the client.
 
 Next in a
 .B \-\-client-config-dir
diff --git a/options.c b/options.c
index f643acc..dc45282 100644
--- a/options.c
+++ b/options.c
@@ -816,6 +816,10 @@ init_options (struct options *o, const bool init_gc)
           o->tmp_dir = "/tmp";
   }
 #endif /* WIN32 */
+
+#ifdef USE_LZO
+  o->lzo = LZO_SELECTED;
+#endif
 }
 
 void
@@ -5889,13 +5893,13 @@ add_option (struct options *options,
 	{
 	  if (streq (p[1], "yes"))
 	    options->lzo = LZO_SELECTED|LZO_ON;
-	  else if (streq (p[1], "no"))
-	    options->lzo = LZO_SELECTED;
 	  else if (streq (p[1], "adaptive"))
 	    options->lzo = LZO_SELECTED|LZO_ON|LZO_ADAPTIVE;
+	  else if (streq (p[1], "disabled"))
+	    options->lzo = 0;
 	  else
 	    {
-	      msg (msglevel, "bad comp-lzo option: %s -- must be 'yes', 'no', or 'adaptive'", p[1]);
+	      msg (msglevel, "bad comp-lzo option: %s -- must be 'yes', 'adaptive' or 'disabled", p[1]);
 	      goto err;
 	    }
 	}
-- 
1.7.4.4


