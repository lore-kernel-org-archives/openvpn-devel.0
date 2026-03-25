From: Frank Lichtenheld <frank@...2641...>
Date: Wed, 25 Mar 2026 13:43:38 +0100
Message-ID: <20260325124338.123477-1-frank@...2641...>
In-Reply-To: <gerrit.1774014824000.I8ca07e2bbb5de229204191d61e90f084a58969af@...2715...>
References: <gerrit.1774014824000.I8ca07e2bbb5de229204191d61e90f084a58969af@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Change type of option flag from unsigned
 int to uint64_t
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

From: Arne Schwabe <arne@...1227...>

We currently use all 32 bits of the unsigned int for option classes.
While we can probably can retire 2-3 of the existing options, at some
point we will hit the limit again.

Instead of fully rewriting this logic to use a different approach or
structure, changing the type from unsigned int to uint64_t seem to be
a lot less intrusive approach.

Change-Id: I8ca07e2bbb5de229204191d61e90f084a58969af
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1583
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1583
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 34ed4eb..9b7bd42 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2339,7 +2339,7 @@
 }
 
 bool
-do_up(struct context *c, bool pulled_options, unsigned int option_types_found)
+do_up(struct context *c, bool pulled_options, uint64_t option_types_found)
 {
     int error_flags = 0;
     if (!c->c2.do_up_ran)
@@ -2474,7 +2474,7 @@
 }
 
 bool
-do_update(struct context *c, unsigned int option_types_found)
+do_update(struct context *c, uint64_t option_types_found)
 {
     /* Not necessary since to receive the update the openvpn
      * instance must be up and running but just in case
@@ -2588,7 +2588,7 @@
 }
 
 bool
-do_deferred_options(struct context *c, const unsigned int found, const bool is_update)
+do_deferred_options(struct context *c, const uint64_t found, const bool is_update)
 {
     if (found & OPT_P_MESSAGES)
     {
@@ -4209,7 +4209,7 @@
                 int i;
                 for (i = 0; i < config.n; ++i)
                 {
-                    unsigned int option_types_found = 0;
+                    uint64_t option_types_found = 0;
                     if (config.list[i] && config.list[i]->value)
                     {
                         options_string_import(
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index 9c4cf71..9d5050d 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -75,7 +75,7 @@
 
 void context_gc_free(struct context *c);
 
-bool do_up(struct context *c, bool pulled_options, unsigned int option_types_found);
+bool do_up(struct context *c, bool pulled_options, uint64_t option_types_found);
 
 /**
  * @brief A simplified version of the do_up() function. This function is called
@@ -87,7 +87,7 @@
  * @return true on success.
  * @return false on error.
  */
-bool do_update(struct context *c, unsigned int option_types_found);
+bool do_update(struct context *c, uint64_t option_types_found);
 
 unsigned int pull_permission_mask(const struct context *c);
 
@@ -99,7 +99,7 @@
  * Handle non-tun-related pulled options.
  * Set `is_update` param to true to skip NCP check.
  */
-bool do_deferred_options(struct context *c, const unsigned int found, const bool is_update);
+bool do_deferred_options(struct context *c, const uint64_t found, const bool is_update);
 
 void inherit_context_child(struct context *dest, const struct context *src,
                            struct link_socket *sock);
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 1625fd0..22f8b54 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1619,7 +1619,7 @@
  */
 static void
 multi_client_connect_post(struct multi_context *m, struct multi_instance *mi, const char *dc_file,
-                          unsigned int *option_types_found)
+                          uint64_t *option_types_found)
 {
     /* Did script generate a dynamic config file? */
     if (platform_test_file(dc_file))
@@ -1645,7 +1645,7 @@
  */
 static void
 multi_client_connect_post_plugin(struct multi_context *m, struct multi_instance *mi,
-                                 const struct plugin_return *pr, unsigned int *option_types_found)
+                                 const struct plugin_return *pr, uint64_t *option_types_found)
 {
     struct plugin_return config;
 
@@ -1684,7 +1684,7 @@
  */
 enum client_connect_return
 multi_client_connect_mda(struct multi_context *m, struct multi_instance *mi, bool deferred,
-                         unsigned int *option_types_found)
+                         uint64_t *option_types_found)
 {
     /* We never return CC_RET_DEFERRED */
     ASSERT(!deferred);
@@ -2055,7 +2055,7 @@
 
 static enum client_connect_return
 multi_client_connect_call_plugin_v1(struct multi_context *m, struct multi_instance *mi,
-                                    bool deferred, unsigned int *option_types_found)
+                                    bool deferred, uint64_t *option_types_found)
 {
     enum client_connect_return ret = CC_RET_SKIPPED;
 #ifdef ENABLE_PLUGIN
@@ -2145,7 +2145,7 @@
 
 static enum client_connect_return
 multi_client_connect_call_plugin_v2(struct multi_context *m, struct multi_instance *mi,
-                                    bool deferred, unsigned int *option_types_found)
+                                    bool deferred, uint64_t *option_types_found)
 {
     enum client_connect_return ret = CC_RET_SKIPPED;
 #ifdef ENABLE_PLUGIN
@@ -2194,7 +2194,7 @@
 
 static enum client_connect_return
 multi_client_connect_script_deferred(struct multi_context *m, struct multi_instance *mi,
-                                     unsigned int *option_types_found)
+                                     uint64_t *option_types_found)
 {
     ASSERT(mi);
     ASSERT(option_types_found);
@@ -2235,7 +2235,7 @@
  */
 static enum client_connect_return
 multi_client_connect_call_script(struct multi_context *m, struct multi_instance *mi, bool deferred,
-                                 unsigned int *option_types_found)
+                                 uint64_t *option_types_found)
 {
     if (deferred)
     {
@@ -2339,7 +2339,7 @@
 
 static void
 multi_client_connect_late_setup(struct multi_context *m, struct multi_instance *mi,
-                                const unsigned int option_types_found)
+                                const uint64_t option_types_found)
 {
     ASSERT(m);
     ASSERT(mi);
@@ -2497,7 +2497,7 @@
  */
 static enum client_connect_return
 multi_client_connect_compress_migrate(struct multi_context *m, struct multi_instance *mi,
-                                      bool deferred, unsigned int *option_types_found)
+                                      bool deferred, uint64_t *option_types_found)
 {
 #ifdef USE_COMP
     struct options *o = &mi->context.options;
@@ -2529,7 +2529,7 @@
  */
 static enum client_connect_return
 multi_client_connect_source_ccd(struct multi_context *m, struct multi_instance *mi, bool deferred,
-                                unsigned int *option_types_found)
+                                uint64_t *option_types_found)
 {
     /* Since we never return a CC_RET_DEFERRED, this indicates a serious
      * problem */
@@ -2580,7 +2580,7 @@
 
 typedef enum client_connect_return (*multi_client_connect_handler)(
     struct multi_context *m, struct multi_instance *mi, bool from_deferred,
-    unsigned int *option_types_found);
+    uint64_t *option_types_found);
 
 static const multi_client_connect_handler client_connect_handlers[] = {
     multi_client_connect_compress_migrate,
@@ -2678,7 +2678,7 @@
     bool from_deferred = (mi->context.c2.tls_multi->multi_state != CAS_PENDING);
 
     int *cur_handler_index = &mi->client_connect_defer_state.cur_handler_index;
-    unsigned int *option_types_found = &mi->client_connect_defer_state.option_types_found;
+    uint64_t *option_types_found = &mi->client_connect_defer_state.option_types_found;
 
     /* We are called for the first time */
     if (!from_deferred)
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index c686e47..7e2a77d 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -73,7 +73,7 @@
     int cur_handler_index;
     /* Remember which option classes where processed for delayed option
      * handling. */
-    unsigned int option_types_found;
+    uint64_t option_types_found;
 
     /**
      * The temporary file name that contains the return status of the
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 1db781d..46d9251 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4953,8 +4953,8 @@
     }
 
 static bool
-verify_permission(const char *name, const char *file, int line, const unsigned int type,
-                  const unsigned int allowed, unsigned int *found, const msglvl_t msglevel,
+verify_permission(const char *name, const char *file, int line, const uint64_t type,
+                  const uint64_t allowed, uint64_t *found, const msglvl_t msglevel,
                   struct options *options, bool is_inline)
 {
     if (!(type & allowed))
@@ -5046,7 +5046,7 @@
 void
 remove_option(struct context *c, struct options *options, char *p[], bool is_inline,
               const char *file, int line, const msglvl_t msglevel,
-              const unsigned int permission_mask, unsigned int *option_types_found,
+              const uint64_t permission_mask, uint64_t *option_types_found,
               struct env_set *es)
 {
     msglvl_t msglevel_fc = msglevel_forward_compatible(options, msglevel);
@@ -5366,7 +5366,7 @@
 void
 update_option(struct context *c, struct options *options, char *p[], bool is_inline,
               const char *file, int line, const int level, const msglvl_t msglevel,
-              const unsigned int permission_mask, unsigned int *option_types_found,
+              const uint64_t permission_mask, uint64_t *option_types_found,
               struct env_set *es)
 {
     const bool pull_mode = BOOL_CAST(permission_mask & OPT_P_PULL_MODE);
@@ -5555,8 +5555,8 @@
 
 void
 add_option(struct options *options, char *p[], bool is_inline, const char *file, int line,
-           const int level, const msglvl_t msglevel, const unsigned int permission_mask,
-           unsigned int *option_types_found, struct env_set *es)
+           const int level, const msglvl_t msglevel, const uint64_t permission_mask,
+           uint64_t *option_types_found, struct env_set *es)
 {
     struct gc_arena gc = gc_new();
     const bool pull_mode = BOOL_CAST(permission_mask & OPT_P_PULL_MODE);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 3d8b505..ae3156a 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -553,8 +553,8 @@
     bool client;
     bool pull; /* client pull of config options from server */
     int push_continuation;
-    unsigned int push_option_types_found;
-    unsigned int push_update_options_found; /* tracks which option types have been reset in current PUSH_UPDATE sequence */
+    uint64_t push_option_types_found;
+    uint64_t push_update_options_found; /* tracks which option types have been reset in current PUSH_UPDATE sequence */
     const char *auth_user_pass_file;
     bool auth_user_pass_file_inline;
     struct options_pre_connect *pre_connect;
@@ -808,7 +808,7 @@
 
 void add_option(struct options *options, char *p[], bool is_inline, const char *file,
                 int line, const int level, const msglvl_t msglevel,
-                const unsigned int permission_mask, unsigned int *option_types_found,
+                const uint64_t permission_mask, uint64_t *option_types_found,
                 struct env_set *es);
 
 /**
@@ -833,7 +833,7 @@
  */
 void remove_option(struct context *c, struct options *options, char *p[], bool is_inline,
                    const char *file, int line, const msglvl_t msglevel,
-                   const unsigned int permission_mask, unsigned int *option_types_found,
+                   const uint64_t permission_mask, uint64_t *option_types_found,
                    struct env_set *es);
 
 /**
@@ -858,21 +858,21 @@
  */
 void update_option(struct context *c, struct options *options, char *p[], bool is_inline,
                    const char *file, int line, const int level, const msglvl_t msglevel,
-                   const unsigned int permission_mask, unsigned int *option_types_found,
+                   const uint64_t permission_mask, uint64_t *option_types_found,
                    struct env_set *es);
 
 void parse_argv(struct options *options, const int argc, char *argv[], const msglvl_t msglevel,
-                const unsigned int permission_mask, unsigned int *option_types_found,
+                const uint64_t permission_mask, uint64_t *option_types_found,
                 struct env_set *es);
 
 void read_config_file(struct options *options, const char *file, int level, const char *top_file,
                       const int top_line, const msglvl_t msglevel,
-                      const unsigned int permission_mask, unsigned int *option_types_found,
+                      const uint64_t permission_mask, uint64_t *option_types_found,
                       struct env_set *es);
 
 void read_config_string(const char *prefix, struct options *options, const char *config,
-                        const msglvl_t msglevel, const unsigned int permission_mask,
-                        unsigned int *option_types_found, struct env_set *es);
+                        const msglvl_t msglevel, const uint64_t permission_mask,
+                        uint64_t *option_types_found, struct env_set *es);
 
 void notnull(const char *arg, const char *description);
 
@@ -933,13 +933,13 @@
 void pre_connect_restore(struct options *o, struct gc_arena *gc);
 
 bool apply_push_options(struct context *c, struct options *options, struct buffer *buf,
-                        unsigned int permission_mask, unsigned int *option_types_found,
+                        uint64_t permission_mask, uint64_t *option_types_found,
                         struct env_set *es, bool is_update);
 
 void options_detach(struct options *o);
 
 void options_server_import(struct options *o, const char *filename, msglvl_t msglevel,
-                           unsigned int permission_mask, unsigned int *option_types_found,
+                           uint64_t permission_mask, uint64_t *option_types_found,
                            struct env_set *es);
 
 void pre_pull_default(struct options *o);
@@ -972,7 +972,7 @@
 const char *auth_retry_print(void);
 
 void options_string_import(struct options *options, const char *config, const msglvl_t msglevel,
-                           const unsigned int permission_mask, unsigned int *option_types_found,
+                           const uint64_t permission_mask, uint64_t *option_types_found,
                            struct env_set *es);
 
 bool key_is_external(const struct options *options);
diff --git a/src/openvpn/options_parse.c b/src/openvpn/options_parse.c
index cb51ad2..a8c4aee 100644
--- a/src/openvpn/options_parse.c
+++ b/src/openvpn/options_parse.c
@@ -346,7 +346,7 @@
 void
 read_config_file(struct options *options, const char *file, int level, const char *top_file,
                  const int top_line, const msglvl_t msglevel,
-                 const unsigned int permission_mask, unsigned int *option_types_found,
+                 const uint64_t permission_mask, uint64_t *option_types_found,
                  struct env_set *es)
 {
     const int max_recursive_levels = 10;
@@ -419,8 +419,8 @@
 
 void
 read_config_string(const char *prefix, struct options *options, const char *config,
-                   const msglvl_t msglevel, const unsigned int permission_mask,
-                   unsigned int *option_types_found, struct env_set *es)
+                   const msglvl_t msglevel, const uint64_t permission_mask,
+                   uint64_t *option_types_found, struct env_set *es)
 {
     char line[OPTION_LINE_SIZE];
     struct buffer multiline;
@@ -448,7 +448,7 @@
 
 void
 parse_argv(struct options *options, const int argc, char *argv[], const msglvl_t msglevel,
-           const unsigned int permission_mask, unsigned int *option_types_found, struct env_set *es)
+           const uint64_t permission_mask, uint64_t *option_types_found, struct env_set *es)
 {
     /* usage message */
     if (argc <= 1)
@@ -510,7 +510,7 @@
 
 bool
 apply_push_options(struct context *c, struct options *options, struct buffer *buf,
-                   unsigned int permission_mask, unsigned int *option_types_found,
+                   uint64_t permission_mask, uint64_t *option_types_found,
                    struct env_set *es, bool is_update)
 {
     char line[OPTION_PARM_SIZE];
@@ -523,7 +523,7 @@
         char *p[MAX_PARMS + 1];
         CLEAR(p);
         ++line_num;
-        unsigned int push_update_option_flags = 0;
+        uint64_t push_update_option_flags = 0;
         int i = 0;
 
         /* skip leading spaces matching the behaviour of parse_line */
@@ -578,7 +578,7 @@
 
 void
 options_server_import(struct options *o, const char *filename, msglvl_t msglevel,
-                      unsigned int permission_mask, unsigned int *option_types_found,
+                      const uint64_t permission_mask, uint64_t *option_types_found,
                       struct env_set *es)
 {
     msg(D_PUSH, "OPTIONS IMPORT: reading client specific options from: %s", filename);
@@ -588,7 +588,7 @@
 
 void
 options_string_import(struct options *options, const char *config, const msglvl_t msglevel,
-                      const unsigned int permission_mask, unsigned int *option_types_found,
+                      const uint64_t permission_mask, uint64_t *option_types_found,
                       struct env_set *es)
 {
     read_config_string("[CONFIG-STRING]", options, config, msglevel, permission_mask,
diff --git a/src/openvpn/options_util.c b/src/openvpn/options_util.c
index 8d0a143..47fe0bc 100644
--- a/src/openvpn/options_util.c
+++ b/src/openvpn/options_util.c
@@ -203,7 +203,7 @@
                                            "tun-mtu", "keepalive" };
 
 bool
-check_push_update_option_flags(char *line, int *i, unsigned int *flags)
+check_push_update_option_flags(char *line, int *i, uint64_t *flags)
 {
     *flags = 0;
     bool opt_is_updatable = false;
diff --git a/src/openvpn/options_util.h b/src/openvpn/options_util.h
index 511d189..1d4ea9b 100644
--- a/src/openvpn/options_util.h
+++ b/src/openvpn/options_util.h
@@ -106,6 +106,6 @@
  *         - The `line` parameter is empty or `NULL`.
  *         - The `?` flag is absent and the option is not updatable.
  */
-bool check_push_update_option_flags(char *line, int *i, unsigned int *flags);
+bool check_push_update_option_flags(char *line, int *i, uint64_t *flags);
 
 #endif /* ifndef OPTIONS_UTIL_H_ */
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 93c5558..835c433 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -505,7 +505,7 @@
 incoming_push_message(struct context *c, const struct buffer *buffer)
 {
     struct gc_arena gc = gc_new();
-    unsigned int option_types_found = 0;
+    uint64_t option_types_found = 0;
 
     msg(D_PUSH, "PUSH: Received control message: '%s'",
         sanitize_control_message(BSTR(buffer), &gc));
@@ -1060,8 +1060,8 @@
 }
 
 static int
-process_incoming_push_reply(struct context *c, unsigned int permission_mask,
-                            unsigned int *option_types_found, struct buffer *buf)
+process_incoming_push_reply(struct context *c, uint64_t permission_mask,
+                            uint64_t *option_types_found, struct buffer *buf)
 {
     int ret = PUSH_MSG_ERROR;
     const int ch = buf_read_u8(buf);
@@ -1110,8 +1110,8 @@
 
 int
 process_incoming_push_msg(struct context *c, const struct buffer *buffer,
-                          bool honor_received_options, unsigned int permission_mask,
-                          unsigned int *option_types_found)
+                          bool honor_received_options, uint64_t permission_mask,
+                          uint64_t *option_types_found)
 {
     struct buffer buf = *buffer;
 
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index d18d058..dff945f 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -76,12 +76,12 @@
  * - `PUSH_MSG_ERROR`: An error occurred during message processing, or the message is invalid.
  */
 
-int process_push_update(struct context *c, struct options *o, unsigned int permission_mask,
-                        unsigned int *option_types_found, struct buffer *buf, bool msg_sender);
+int process_push_update(struct context *c, struct options *o, uint64_t permission_mask,
+                        uint64_t *option_types_found, struct buffer *buf, bool msg_sender);
 
 int process_incoming_push_msg(struct context *c, const struct buffer *buffer,
-                              bool honor_received_options, unsigned int permission_mask,
-                              unsigned int *option_types_found);
+                              bool honor_received_options, uint64_t permission_mask,
+                              uint64_t *option_types_found);
 
 bool send_push_request(struct context *c);
 
diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index 51c7b5f..e129403 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -11,8 +11,8 @@
 #endif
 
 int
-process_push_update(struct context *c, struct options *o, unsigned int permission_mask,
-                    unsigned int *option_types_found, struct buffer *buf, bool msg_sender)
+process_push_update(struct context *c, struct options *o, uint64_t permission_mask,
+                    uint64_t *option_types_found, struct buffer *buf, bool msg_sender)
 {
     int ret = PUSH_MSG_ERROR;
     const int ch = buf_read_u8(buf);
@@ -146,7 +146,7 @@
         return false;
     }
 
-    unsigned int option_types_found = 0;
+    uint64_t option_types_found = 0;
     struct context *c = &mi->context;
     struct options o;
     CLEAR(o);
diff --git a/tests/unit_tests/openvpn/test_options_parse.c b/tests/unit_tests/openvpn/test_options_parse.c
index 0b3d7fe..e67eae8 100644
--- a/tests/unit_tests/openvpn/test_options_parse.c
+++ b/tests/unit_tests/openvpn/test_options_parse.c
@@ -40,7 +40,7 @@
 void
 add_option(struct options *options, char *p[], bool is_inline, const char *file,
            int line, const int level, const msglvl_t msglevel,
-           const unsigned int permission_mask, unsigned int *option_types_found,
+           const uint64_t permission_mask, uint64_t *option_types_found,
            struct env_set *es)
 {
     function_called();
@@ -51,7 +51,7 @@
 void
 remove_option(struct context *c, struct options *options, char *p[], bool is_inline,
               const char *file, int line, const msglvl_t msglevel,
-              const unsigned int permission_mask, unsigned int *option_types_found,
+              const uint64_t permission_mask, uint64_t *option_types_found,
               struct env_set *es)
 {
 }
@@ -59,7 +59,7 @@
 void
 update_option(struct context *c, struct options *options, char *p[], bool is_inline,
               const char *file, int line, const int level, const msglvl_t msglevel,
-              const unsigned int permission_mask, unsigned int *option_types_found,
+              const uint64_t permission_mask, uint64_t *option_types_found,
               struct env_set *es)
 {
 }
@@ -191,7 +191,7 @@
 static void
 read_single_config(struct options *options, const char *config)
 {
-    unsigned int option_types_found = 0;
+    uint64_t option_types_found = 0;
     struct env_set es;
     CLEAR(es);
     read_config_string("test_options_parse", options, config, M_INFO, OPT_P_DEFAULT,
diff --git a/tests/unit_tests/openvpn/test_push_update_msg.c b/tests/unit_tests/openvpn/test_push_update_msg.c
index 9b7978e..219b476 100644
--- a/tests/unit_tests/openvpn/test_push_update_msg.c
+++ b/tests/unit_tests/openvpn/test_push_update_msg.c
@@ -70,7 +70,7 @@
 
 bool
 apply_push_options(struct context *c, struct options *options, struct buffer *buf,
-                   unsigned int permission_mask, unsigned int *option_types_found,
+                   uint64_t permission_mask, uint64_t *option_types_found,
                    struct env_set *es, bool is_update)
 {
     char line[OPTION_PARM_SIZE];
@@ -83,7 +83,7 @@
 
     while (buf_parse(buf, ',', line, sizeof(line)))
     {
-        unsigned int push_update_option_flags = 0;
+        uint64_t push_update_option_flags = 0;
         int i = 0;
 
         if (is_update || options->pull_filter_list)
@@ -131,8 +131,8 @@
 
 int
 process_incoming_push_msg(struct context *c, const struct buffer *buffer,
-                          bool honor_received_options, unsigned int permission_mask,
-                          unsigned int *option_types_found)
+                          bool honor_received_options, uint64_t permission_mask,
+                          uint64_t *option_types_found)
 {
     struct buffer buf = *buffer;
 
@@ -206,7 +206,7 @@
     const char *update_msg =
         "PUSH_UPDATE,dhcp-option DNS 8.8.8.8, route 0.0.0.0 0.0.0.0 10.10.10.1";
     buf_write(&buf, update_msg, strlen(update_msg));
-    unsigned int option_types_found = 0;
+    uint64_t option_types_found = 0;
 
     assert_int_equal(process_incoming_push_msg(c, &buf, c->options.pull, pull_permission_mask(c),
                                                &option_types_found),
@@ -222,7 +222,7 @@
     struct buffer buf = alloc_buf(256);
     const char *update_msg = "PUSH_UPDATEerr,dhcp-option DNS 8.8.8.8";
     buf_write(&buf, update_msg, strlen(update_msg));
-    unsigned int option_types_found = 0;
+    uint64_t option_types_found = 0;
 
     assert_int_equal(process_incoming_push_msg(c, &buf, c->options.pull, pull_permission_mask(c),
                                                &option_types_found),
@@ -238,7 +238,7 @@
     struct buffer buf = alloc_buf(256);
     const char *update_msg = "PUSH_UPDATE ,dhcp-option DNS 8.8.8.8";
     buf_write(&buf, update_msg, strlen(update_msg));
-    unsigned int option_types_found = 0;
+    uint64_t option_types_found = 0;
 
     assert_int_equal(process_incoming_push_msg(c, &buf, c->options.pull, pull_permission_mask(c),
                                                &option_types_found),
@@ -254,7 +254,7 @@
     struct buffer buf = alloc_buf(256);
     const char *update_msg = "PUSH_UPDATE, -?dns, route something, ?dhcp-option DNS 8.8.8.8";
     buf_write(&buf, update_msg, strlen(update_msg));
-    unsigned int option_types_found = 0;
+    uint64_t option_types_found = 0;
 
     assert_int_equal(process_incoming_push_msg(c, &buf, c->options.pull, pull_permission_mask(c),
                                                &option_types_found),
@@ -270,7 +270,7 @@
     struct buffer buf = alloc_buf(256);
     const char *update_msg = "PUSH_UPDATE, -dhcp-option, ?-dns";
     buf_write(&buf, update_msg, strlen(update_msg));
-    unsigned int option_types_found = 0;
+    uint64_t option_types_found = 0;
 
     assert_int_equal(process_incoming_push_msg(c, &buf, c->options.pull, pull_permission_mask(c),
                                                &option_types_found),
@@ -286,7 +286,7 @@
     struct buffer buf = alloc_buf(256);
     const char *update_msg = "PUSH_UPDATE, dev tun";
     buf_write(&buf, update_msg, strlen(update_msg));
-    unsigned int option_types_found = 0;
+    uint64_t option_types_found = 0;
 
     assert_int_equal(process_incoming_push_msg(c, &buf, c->options.pull, pull_permission_mask(c),
                                                &option_types_found),
@@ -303,7 +303,7 @@
     const char *update_msg =
         "PUSH_UPDATE,-dhcp-option, route 10.10.10.0, dhcp-option DNS 1.1.1.1, route 10.11.12.0, dhcp-option DOMAIN corp.local, keepalive 10 60";
     buf_write(&buf, update_msg, strlen(update_msg));
-    unsigned int option_types_found = 0;
+    uint64_t option_types_found = 0;
 
     assert_int_equal(process_incoming_push_msg(c, &buf, c->options.pull, pull_permission_mask(c),
                                                &option_types_found),
@@ -320,7 +320,7 @@
     const char *update_msg =
         "PUSH_UPDATE,-dhcp-option,dhcp-option DNS 8.8.8.8,redirect-gateway local,route 192.168.1.0 255.255.255.0";
     buf_write(&buf, update_msg, strlen(update_msg));
-    unsigned int option_types_found = 0;
+    uint64_t option_types_found = 0;
 
     assert_int_equal(process_incoming_push_msg(c, &buf, c->options.pull, pull_permission_mask(c),
                                                &option_types_found),
@@ -344,7 +344,7 @@
 test_incoming_push_continuation_route_accumulation(void **state)
 {
     struct context *c = *state;
-    unsigned int option_types_found = 0;
+    uint64_t option_types_found = 0;
 
     reset_route_counters();
 

