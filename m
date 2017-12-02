From: Antonio Quartulli <a@...2181...>
Date: Sat,  2 Dec 2017 21:45:37 +0800
Message-Id: <20171202134541.7688-3-a@...2181...>
In-Reply-To: <20171202134541.7688-1-a@...2181...>
References: <20171202134541.7688-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH 3/7] Remove ENABLE_PUSH_PEER_INFO
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

ENABLE_PUSH_PEER_INFO depended on ENABLE_CRYPTO that now does
not exist anymore.
Get rid of ENABLE_PUSH_PEER_INFO by assuming that it is always
enabled and simplify the code.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/init.c       |  2 --
 src/openvpn/options.c    | 10 ----------
 src/openvpn/options.h    |  2 --
 src/openvpn/ssl.c        |  2 --
 src/openvpn/ssl_common.h |  2 --
 src/openvpn/syshead.h    |  5 -----
 6 files changed, 23 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index bfc80ebf..e013e9ca 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2686,7 +2686,6 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
     to.single_session = options->single_session;
     to.mode = options->mode;
     to.pull = options->pull;
-#ifdef ENABLE_PUSH_PEER_INFO
     if (options->push_peer_info)        /* all there is */
     {
         to.push_peer_info_detail = 2;
@@ -2699,7 +2698,6 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
     {
         to.push_peer_info_detail = 0;
     }
-#endif
 
     /* should we not xmit any packets until we get an initial
      * response from client? */
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 49afb4e4..9d9798f7 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -225,9 +225,7 @@ static const char usage_message[] =
     "--redirect-private [flags]: Like --redirect-gateway, but omit actually changing\n"
     "                  the default gateway.  Useful when pushing private subnets.\n"
     "--client-nat snat|dnat network netmask alias : on client add 1-to-1 NAT rule.\n"
-#ifdef ENABLE_PUSH_PEER_INFO
     "--push-peer-info : (client only) push client info to server.\n"
-#endif
     "--setenv name value : Set a custom environmental variable to pass to script.\n"
     "--setenv FORWARD_COMPATIBLE 1 : Relax config file syntax checking to allow\n"
     "                  directives for future OpenVPN versions to be ignored.\n"
@@ -1772,9 +1770,7 @@ show_settings(const struct options *o)
     SHOW_INT(transition_window);
 
     SHOW_BOOL(single_session);
-#ifdef ENABLE_PUSH_PEER_INFO
     SHOW_BOOL(push_peer_info);
-#endif
     SHOW_BOOL(tls_exit);
 
     SHOW_STR(tls_auth_file);
@@ -2732,9 +2728,7 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
         MUST_BE_UNDEF(tls_auth_file);
         MUST_BE_UNDEF(tls_crypt_file);
         MUST_BE_UNDEF(single_session);
-#ifdef ENABLE_PUSH_PEER_INFO
         MUST_BE_UNDEF(push_peer_info);
-#endif
         MUST_BE_UNDEF(tls_exit);
         MUST_BE_UNDEF(crl_file);
         MUST_BE_UNDEF(key_method);
@@ -6344,12 +6338,10 @@ add_option(struct options *options,
             msg(msglevel, "this is a generic configuration and cannot directly be used");
             goto err;
         }
-#ifdef ENABLE_PUSH_PEER_INFO
         else if (streq(p[1], "PUSH_PEER_INFO") && !p[2])
         {
             options->push_peer_info = true;
         }
-#endif
         else if (streq(p[1], "SERVER_POLL_TIMEOUT") && p[2])
         {
             options->ce.connect_timeout = positive_atoi(p[2]);
@@ -7778,13 +7770,11 @@ add_option(struct options *options,
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->single_session = true;
     }
-#ifdef ENABLE_PUSH_PEER_INFO
     else if (streq(p[0], "push-peer-info") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->push_peer_info = true;
     }
-#endif
     else if (streq(p[0], "tls-exit") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index d7b46219..6d7fcc08 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -569,9 +569,7 @@ struct options
     /* Allow only one session */
     bool single_session;
 
-#ifdef ENABLE_PUSH_PEER_INFO
     bool push_peer_info;
-#endif
 
     bool tls_exit;
 
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index d9439062..a95ef7e2 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2235,7 +2235,6 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
     struct gc_arena gc = gc_new();
     bool ret = false;
 
-#ifdef ENABLE_PUSH_PEER_INFO
     if (session->opt->push_peer_info_detail > 0)
     {
         struct env_set *es = session->opt->es;
@@ -2316,7 +2315,6 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
         }
     }
     else
-#endif /* ifdef ENABLE_PUSH_PEER_INFO */
     {
         if (!write_empty_string(buf)) /* no peer info */
         {
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 25bffd5b..60ed5f8a 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -249,9 +249,7 @@ struct tls_options
 #endif
     int mode;
     bool pull;
-#ifdef ENABLE_PUSH_PEER_INFO
     int push_peer_info_detail;
-#endif
     int transition_window;
     int handshake_window;
     interval_t packet_timeout;
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 594ddf17..83904af9 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -673,11 +673,6 @@ socket_defined(const socket_descriptor_t sd)
 #define ENABLE_CLIENT_CR
 #endif
 
-/*
- * Do we support pushing peer info?
- */
-#define ENABLE_PUSH_PEER_INFO
-
 /*
  * Compression support
  */
-- 
2.15.1


