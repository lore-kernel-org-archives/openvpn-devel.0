From: Arne Schwabe <arne@...1227...>
Date: Mon, 18 Jun 2012 20:39:05 +0200
Message-Id: <1340044749-10694-3-git-send-email-arne@...1227...>
In-Reply-To: <1340044749-10694-1-git-send-email-arne@...1227...>
References: <1340044749-10694-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 2/6] Completely remove ancient IANA port
	warning.
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


Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/init.c    |    6 ------
 src/openvpn/options.c |    3 ---
 src/openvpn/options.h |    1 -
 3 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 61fd2a6..eacb67d 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2462,12 +2462,6 @@ do_option_warnings (struct context *c)
 {
   const struct options *o = &c->options;
 
-#if 1 /* JYFIXME -- port warning */
-  if (!o->ce.port_option_used && (o->ce.local_port == OPENVPN_PORT && o->ce.remote_port == OPENVPN_PORT))
-    msg (M_WARN, "IMPORTANT: OpenVPN's default port number is now %d, based on an official port number assignment by IANA.  OpenVPN 2.0-beta16 and earlier used 5000 as the default port.",
-	 OPENVPN_PORT);
-#endif
-
   if (o->ping_send_timeout && !o->ping_rec_timeout)
     msg (M_WARN, "WARNING: --ping should normally be used with --ping-restart or --ping-exit");
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 5d6ff85..566268e 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4921,7 +4921,6 @@ add_option (struct options *options,
 	  msg (msglevel, "Bad port number: %s", p[1]);
 	  goto err;
 	}
-      options->ce.port_option_used = true;
       options->ce.local_port = options->ce.remote_port = port;
     }
   else if (streq (p[0], "lport") && p[1])
@@ -4936,7 +4935,6 @@ add_option (struct options *options,
 	  goto err;
 	}
       options->ce.local_port_defined = true;
-      options->ce.port_option_used = true;
       options->ce.local_port = port;
     }
   else if (streq (p[0], "rport") && p[1])
@@ -4950,7 +4948,6 @@ add_option (struct options *options,
 	  msg (msglevel, "Bad remote port number: %s", p[1]);
 	  goto err;
 	}
-      options->ce.port_option_used = true;
       options->ce.remote_port = port;
     }
   else if (streq (p[0], "bind"))
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index ee0c69d..caa31b2 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -90,7 +90,6 @@ struct connection_entry
   int local_port;
   bool local_port_defined;
   int remote_port;
-  bool port_option_used;
   const char *local;
   const char *remote;
   bool remote_float;
-- 
1.7.7.5 (Apple Git-26)


