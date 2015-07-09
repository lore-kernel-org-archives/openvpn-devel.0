From: Steffan Karger <steffan@...1856...>
Date: Thu,  9 Jul 2015 23:35:59 +0200
Message-Id: <1436477759-5884-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] fix regression: query password before
	becoming daemon
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

The init sequence was changed to daemonize before the crypto init to fix
issues on FreeBSD some commits ago.  This introduced a regression where
we would no longer query for passwords before daemonizing, as described
in trac #574 and #576.

This commit restores the correct order, and adds a bit of const
correctness since we're touching this now code anyway.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/init.c    | 6 ++----
 src/openvpn/init.h    | 5 +++++
 src/openvpn/openvpn.c | 5 ++++-
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 13f5612..c24a646 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -407,8 +407,8 @@ next_connection_entry (struct context *c)
 /*
  * Query for private key and auth-user-pass username/passwords
  */
-static void
-init_query_passwords (struct context *c)
+void
+init_query_passwords (const struct context *c)
 {
 #ifdef ENABLE_CRYPTO
   /* Certificate password input */
@@ -502,8 +502,6 @@ context_init_1 (struct context *c)
 
   init_connection_list (c);
 
-  init_query_passwords (c);
-
 #if defined(ENABLE_PKCS11)
   if (c->first_time) {
     int i;
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index d1908ed..a819bd2 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -63,6 +63,11 @@ void init_instance_handle_signals (struct context *c, const struct env_set *env,
 
 void init_instance (struct context *c, const struct env_set *env, const unsigned int flags);
 
+/**
+ * Query for private key and auth-user-pass username/passwords.
+ */
+void init_query_passwords (const struct context *c);
+
 void do_route (const struct options *options,
 	       struct route_list *route_list,
 	       struct route_ipv6_list *route_ipv6_list,
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index 00bd570..d05acde 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -228,7 +228,10 @@ openvpn_main (int argc, char *argv[])
 	  /* test crypto? */
 	  if (do_test_crypto (&c.options))
 	    break;
-	  
+
+	  /* Query passwords before becoming a daemon */
+	  init_query_passwords (&c);
+
 	  /* become a daemon if --daemon */
 	  if (c.first_time)
 	    {
-- 
2.1.4


