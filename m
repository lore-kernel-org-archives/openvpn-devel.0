From: Arne Schwabe <arne@...1227...>
Date: Mon,  8 Oct 2018 20:16:16 +0200
Message-Id: <20181008181618.8976-2-arne@...1227...>
In-Reply-To: <20181008181618.8976-1-arne@...1227...>
References: <20181008181618.8976-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 2/4] Remove AUTO_USERID feature
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

There is no user facing way to enable this feature and way that feature
works (username build from MAC of primary net device) is questionable.

It also does not compile anymore.
---
 src/openvpn/errlevel.h |  1 -
 src/openvpn/misc.c     | 45 ------------------------------------------
 src/openvpn/misc.h     |  5 -----
 src/openvpn/ssl.c      |  4 ----
 src/openvpn/syshead.h  |  9 ---------
 5 files changed, 64 deletions(-)

diff --git a/src/openvpn/errlevel.h b/src/openvpn/errlevel.h
index 5ca4fa8f..c30284fc 100644
--- a/src/openvpn/errlevel.h
+++ b/src/openvpn/errlevel.h
@@ -139,7 +139,6 @@
 #define D_PACKET_TRUNC_DEBUG LOGLEV(7, 70, M_DEBUG)  /* PACKET_TRUNCATION_CHECK verbose */
 #define D_PING               LOGLEV(7, 70, M_DEBUG)  /* PING send/receive messages */
 #define D_PS_PROXY_DEBUG     LOGLEV(7, 70, M_DEBUG)  /* port share proxy debug */
-#define D_AUTO_USERID        LOGLEV(7, 70, M_DEBUG)  /* AUTO_USERID debugging */
 #define D_TLS_KEYSELECT      LOGLEV(7, 70, M_DEBUG)  /* show information on key selection for data channel */
 #define D_ARGV_PARSE_CMD     LOGLEV(7, 70, M_DEBUG)  /* show parse_line() errors in argv_parse_cmd */
 #define D_CRYPTO_DEBUG       LOGLEV(7, 70, M_DEBUG)  /* show detailed info from crypto.c routines */
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 51d539d2..75f4ff47 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -455,51 +455,6 @@ get_auth_challenge(const char *auth_challenge, struct gc_arena *gc)
 
 #endif /* ifdef ENABLE_MANAGEMENT */
 
-#if AUTO_USERID
-
-void
-get_user_pass_auto_userid(struct user_pass *up, const char *tag)
-{
-    struct gc_arena gc = gc_new();
-    struct buffer buf;
-    uint8_t macaddr[6];
-    static uint8_t digest [MD5_DIGEST_LENGTH];
-    static const uint8_t hashprefix[] = "AUTO_USERID_DIGEST";
-
-    const md_kt_t *md5_kt = md_kt_get("MD5");
-    md_ctx_t *ctx;
-
-    CLEAR(*up);
-    buf_set_write(&buf, (uint8_t *)up->username, USER_PASS_LEN);
-    buf_printf(&buf, "%s", TARGET_PREFIX);
-    if (get_default_gateway_mac_addr(macaddr))
-    {
-        dmsg(D_AUTO_USERID, "GUPAU: macaddr=%s", format_hex_ex(macaddr, sizeof(macaddr), 0, 1, ":", &gc));
-        ctx = md_ctx_new();
-        md_ctx_init(ctx, md5_kt);
-        md_ctx_update(ctx, hashprefix, sizeof(hashprefix) - 1);
-        md_ctx_update(ctx, macaddr, sizeof(macaddr));
-        md_ctx_final(ctx, digest);
-        md_ctx_cleanup(ctx);
-        md_ctx_free(ctx);
-        buf_printf(&buf, "%s", format_hex_ex(digest, sizeof(digest), 0, 256, " ", &gc));
-    }
-    else
-    {
-        buf_printf(&buf, "UNKNOWN");
-    }
-    if (tag && strcmp(tag, "stdin"))
-    {
-        buf_printf(&buf, "-%s", tag);
-    }
-    up->defined = true;
-    gc_free(&gc);
-
-    dmsg(D_AUTO_USERID, "GUPAU: AUTO_USERID: '%s'", up->username);
-}
-
-#endif /* if AUTO_USERID */
-
 void
 purge_user_pass(struct user_pass *up, const bool force)
 {
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index 7092685f..fad53de8 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -158,11 +158,6 @@ void configure_path(void);
 
 const char *sanitize_control_message(const char *str, struct gc_arena *gc);
 
-#if AUTO_USERID
-void get_user_pass_auto_userid(struct user_pass *up, const char *tag);
-
-#endif
-
 /*
  * /sbin/ip path, may be overridden
  */
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 0a947c6e..5a136d69 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -410,9 +410,6 @@ auth_user_pass_setup(const char *auth_file, const struct static_challenge_info *
     auth_user_pass_enabled = true;
     if (!auth_user_pass.defined && !auth_token.defined)
     {
-#if AUTO_USERID
-        get_user_pass_auto_userid(&auth_user_pass, auth_file);
-#else
 #ifdef ENABLE_MANAGEMENT
         if (auth_challenge) /* dynamic challenge/response */
         {
@@ -438,7 +435,6 @@ auth_user_pass_setup(const char *auth_file, const struct static_challenge_info *
         else
 #endif /* ifdef ENABLE_MANAGEMENT */
         get_user_pass(&auth_user_pass, auth_file, UP_TYPE_AUTH, GET_USER_PASS_MANAGEMENT);
-#endif /* if AUTO_USERID */
     }
 }
 
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 807f7b9b..d2a50341 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -643,15 +643,6 @@ socket_defined(const socket_descriptor_t sd)
 #define CONNECT_NONBLOCK
 #endif
 
-/*
- * Do we have the capability to support the AUTO_USERID feature?
- */
-#if defined(ENABLE_AUTO_USERID)
-#define AUTO_USERID 1
-#else
-#define AUTO_USERID 0
-#endif
-
 /*
  * Compression support
  */
-- 
2.19.0


