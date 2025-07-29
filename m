From: Gert Doering <gert@...1296...>
Date: Tue, 29 Jul 2025 12:40:39 +0200
Message-ID: <20250729104045.27582-1-gert@...1296...>
In-Reply-To: <gerrit.1732124549000.I6ecd4cb47571cc8c20e46de8595c742aeec6064a@...2715...>
References: <gerrit.1732124549000.I6ecd4cb47571cc8c20e46de8595c742aeec6064a@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v22] PUSH_UPDATE: Allow OpenVPN in client
 mode to receive and handle PUSH UPDATE control messages to allow options
 updating at runtime.
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

From: Marco Baffo <marco@...2726...>

* Added IV_PROTO_PUSH_UPDATE flag bit to support push-updates.
* Added process_incoming_push_update(), in a separate file to create tests more easily.
* Modified incoming_push_message(), process_incoming_push_msg(), apply_push_options(),
  apply_pull_filter() to process also push-update messages.
* Added the check_push_update_option_flags() function used in apply_pull_filter() to
  check options formatting inside push-update messages, if the options are updatables
  and to check for '?' and '-' flags that may be present in front of the options.
  The '-' flag is used to indicate that the option in question should be removed,
  while the '?' indicates that the option is optional and to do not generate
  errors if the client cannot update that option.
  For more info you can read the RFC at https://github.com/OpenVPN/openvpn-rfc .
* Created some unit tests for the push-update message handling in test_push_update_msg.c.

Change-Id: I6ecd4cb47571cc8c20e46de8595c742aeec6064a
Signed-off-by: Marco Baffo <marco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/808
This mail reflects revision 22 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index efb2d2d..3866e21 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -534,6 +534,7 @@
     src/openvpn/ps.c
     src/openvpn/ps.h
     src/openvpn/push.c
+    src/openvpn/push_util.c
     src/openvpn/push.h
     src/openvpn/pushlist.h
     src/openvpn/reflect_filter.c
@@ -652,6 +653,7 @@
         "test_provider"
         "test_ssl"
         "test_user_pass"
+        "test_push_update_msg"
         )
 
     if (WIN32)
@@ -854,6 +856,14 @@
         src/openvpn/run_command.c
         )
 
+    target_sources(test_push_update_msg PRIVATE
+        tests/unit_tests/openvpn/mock_msg.c
+        tests/unit_tests/openvpn/mock_get_random.c
+	    src/openvpn/push_util.c
+	    src/openvpn/options_util.c
+	    src/openvpn/otime.c
+        )
+
     if (TARGET test_argv)
         target_link_options(test_argv PRIVATE -Wl,--wrap=parse_line)
         target_sources(test_argv PRIVATE
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index a5d4cdc..1e17c3f 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -117,7 +117,7 @@
 	proto.c proto.h \
 	proxy.c proxy.h \
 	ps.c ps.h \
-	push.c push.h \
+	push.c push_util.c push.h \
 	pushlist.h \
 	reflect_filter.c reflect_filter.h \
 	reliable.c reliable.h \
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index dfc6708..475d142 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -2064,7 +2064,7 @@
     }
 
     /* check for incoming control messages on the control channel like
-     * push request/reply, or authentication failure and 2FA messages */
+     * push request/reply/update, or authentication failure and 2FA messages */
     if (tls_test_payload_len(c->c2.tls_multi) > 0)
     {
         check_incoming_control_channel(c);
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index aac8a6a..ba1dda4 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2051,8 +2051,8 @@
         /* possibly add routes */
         if ((route_order(c->c1.tuntap) == ROUTE_AFTER_TUN) && (!c->options.route_delay_defined))
         {
-            int status = do_route(&c->options, c->c1.route_list, c->c1.route_ipv6_list,
-                                  c->c1.tuntap, c->plugins, c->c2.es, &c->net_ctx);
+            bool status = do_route(&c->options, c->c1.route_list, c->c1.route_ipv6_list,
+                                   c->c1.tuntap, c->plugins, c->c2.es, &c->net_ctx);
             *error_flags |= (status ? 0 : ISC_ROUTE_ERRORS);
         }
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 0662b49..2083eae 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -66,6 +66,7 @@
 #include <ctype.h>
 
 #include "memdbg.h"
+#include "options_util.h"
 
 const char title_string[] =
     PACKAGE_STRING
@@ -948,24 +949,6 @@
     }
 }
 
-struct pull_filter
-{
-#define PUF_TYPE_UNDEF  0    /**< undefined filter type */
-#define PUF_TYPE_ACCEPT 1    /**< filter type to accept a matching option */
-#define PUF_TYPE_IGNORE 2    /**< filter type to ignore a matching option */
-#define PUF_TYPE_REJECT 3    /**< filter type to reject and trigger SIGUSR1 */
-    int type;
-    int size;
-    char *pattern;
-    struct pull_filter *next;
-};
-
-struct pull_filter_list
-{
-    struct pull_filter *head;
-    struct pull_filter *tail;
-};
-
 #ifndef ENABLE_SMALL
 
 static const char *
@@ -5515,60 +5498,14 @@
     }
 }
 
-/**
- * Filter an option line by all pull filters.
- *
- * If a match is found, the line is modified depending on
- * the filter type, and returns true. If the filter type is
- * reject, SIGUSR1 is triggered and the return value is false.
- * In that case the caller must end the push processing.
- */
-static bool
-apply_pull_filter(const struct options *o, char *line)
-{
-    struct pull_filter *f;
-
-    if (!o->pull_filter_list)
-    {
-        return true;
-    }
-
-    /* skip leading spaces matching the behaviour of parse_line */
-    while (isspace(*line))
-    {
-        line++;
-    }
-
-    for (f = o->pull_filter_list->head; f; f = f->next)
-    {
-        if (f->type == PUF_TYPE_ACCEPT && strncmp(line, f->pattern, f->size) == 0)
-        {
-            msg(D_LOW, "Pushed option accepted by filter: '%s'", line);
-            return true;
-        }
-        else if (f->type == PUF_TYPE_IGNORE && strncmp(line, f->pattern, f->size) == 0)
-        {
-            msg(D_PUSH, "Pushed option removed by filter: '%s'", line);
-            *line = '\0';
-            return true;
-        }
-        else if (f->type == PUF_TYPE_REJECT && strncmp(line, f->pattern, f->size) == 0)
-        {
-            msg(M_WARN, "Pushed option rejected by filter: '%s'. Restarting.", line);
-            *line = '\0';
-            throw_signal_soft(SIGUSR1, "Offending option received from server");
-            return false;
-        }
-    }
-    return true;
-}
-
 bool
-apply_push_options(struct options *options,
+apply_push_options(struct context *c,
+                   struct options *options,
                    struct buffer *buf,
                    unsigned int permission_mask,
                    unsigned int *option_types_found,
-                   struct env_set *es)
+                   struct env_set *es,
+                   bool is_update)
 {
     char line[OPTION_PARM_SIZE];
     int line_num = 0;
@@ -5580,14 +5517,40 @@
         char *p[MAX_PARMS+1];
         CLEAR(p);
         ++line_num;
-        if (!apply_pull_filter(options, line))
+        unsigned int push_update_option_flags = 0;
+        int i = 0;
+
+        /* skip leading spaces matching the behaviour of parse_line */
+        while (isspace(line[i]))
         {
+            i++;
+        }
+
+        /* If we are not in a 'PUSH_UPDATE' we just check `apply_pull_filter()`
+         * otherwise we must call `check_push_update_option_flags()` first
+         */
+        if ((is_update && !check_push_update_option_flags(line, &i, &push_update_option_flags))
+            || !apply_pull_filter(options, &line[i]))
+        {
+            /* In case we are in a `PUSH_UPDATE` and `check_push_update_option_flags()`
+             * or `apply_pull_filter()` fail but the option is flagged by `PUSH_OPT_OPTIONAL`,
+             * instead of restarting, we just ignore the option and we process the next one
+             */
+            if (push_update_option_flags & PUSH_OPT_OPTIONAL)
+            {
+                continue; /* Ignoring this option */
+            }
+            throw_signal_soft(SIGUSR1, "Offending option received from server");
             return false; /* Cause push/pull error and stop push processing */
         }
-        if (parse_line(line, p, SIZE(p)-1, file, line_num, msglevel, &options->gc))
+
+        if (parse_line(&line[i], p, SIZE(p)-1, file, line_num, msglevel, &options->gc))
         {
-            add_option(options, p, false, file, line_num, 0, msglevel,
-                       permission_mask, option_types_found, es);
+            if (!is_update)
+            {
+                add_option(options, p, false, file, line_num, 0, msglevel,
+                           permission_mask, option_types_found, es);
+            }
         }
     }
     return true;
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 56e85d7..0544ca9 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -794,6 +794,33 @@
 #define MAN_CLIENT_AUTH_ENABLED(opt) (false)
 #endif
 
+/*
+ * some PUSH_UPDATE options
+ */
+#define OPT_P_U_ROUTE           (1<<0)
+#define OPT_P_U_ROUTE6          (1<<1)
+#define OPT_P_U_DNS             (1<<2)
+#define OPT_P_U_DHCP            (1<<3)
+#define OPT_P_U_REDIR_GATEWAY   (1<<4)
+
+struct pull_filter
+{
+#define PUF_TYPE_UNDEF  0    /**< undefined filter type */
+#define PUF_TYPE_ACCEPT 1    /**< filter type to accept a matching option */
+#define PUF_TYPE_IGNORE 2    /**< filter type to ignore a matching option */
+#define PUF_TYPE_REJECT 3    /**< filter type to reject and trigger SIGUSR1 */
+    int type;
+    int size;
+    char *pattern;
+    struct pull_filter *next;
+};
+
+struct pull_filter_list
+{
+    struct pull_filter *head;
+    struct pull_filter *tail;
+};
+
 void parse_argv(struct options *options,
                 const int argc,
                 char *argv[],
@@ -862,11 +889,13 @@
 
 void pre_connect_restore(struct options *o, struct gc_arena *gc);
 
-bool apply_push_options(struct options *options,
+bool apply_push_options(struct context *c,
+                        struct options *options,
                         struct buffer *buf,
                         unsigned int permission_mask,
                         unsigned int *option_types_found,
-                        struct env_set *es);
+                        struct env_set *es,
+                        bool is_update);
 
 void options_detach(struct options *o);
 
diff --git a/src/openvpn/options_util.c b/src/openvpn/options_util.c
index 80d0c08..d317c1a 100644
--- a/src/openvpn/options_util.c
+++ b/src/openvpn/options_util.c
@@ -30,6 +30,8 @@
 
 #include "options_util.h"
 
+#include "push.h"
+
 const char *
 parse_auth_failed_temp(struct options *o, const char *reason)
 {
@@ -145,3 +147,116 @@
 
     return (int) i;
 }
+
+static const char *updatable_options[] = {
+    "block-ipv6",
+    "block-outside-dns",
+    "dhcp-option",
+    "dns",
+    "ifconfig",
+    "ifconfig-ipv6",
+    "push-continuation",
+    "redirect-gateway",
+    "redirect-private",
+    "route",
+    "route-gateway",
+    "route-ipv6",
+    "route-metric",
+    "topology",
+    "tun-mtu",
+    "keepalive"
+};
+
+bool
+check_push_update_option_flags(char *line, int *i, unsigned int *flags)
+{
+    *flags = 0;
+    bool opt_is_updatable = false;
+    char c = line[*i];
+
+    /* We check for '?' and '-' and
+     * if they are present we skip them.
+     */
+    if (c == '-')
+    {
+        if (!(line)[*i + 1])
+        {
+            return false;
+        }
+        *flags |= PUSH_OPT_TO_REMOVE;
+        c = (line)[++(*i)];
+    }
+    if (c == '?')
+    {
+        if (!(line)[*i + 1] || (line)[*i + 1] == '-')
+        {
+            return false;
+        }
+        *flags |= PUSH_OPT_OPTIONAL;
+        c = (line)[++(*i)];
+    }
+
+    size_t len = strlen(&line[*i]);
+    int count = sizeof(updatable_options)/sizeof(char *);
+    for (int j = 0; j < count; ++j)
+    {
+        size_t opt_len = strlen(updatable_options[j]);
+        if (len < opt_len)
+        {
+            continue;
+        }
+        if (!strncmp(&line[*i], updatable_options[j], opt_len)
+            && (!line[*i + opt_len] || line[*i + opt_len] == ' '))
+        {
+            opt_is_updatable = true;
+            break;
+        }
+    }
+
+    if (!opt_is_updatable)
+    {
+        if (*flags & PUSH_OPT_OPTIONAL)
+        {
+            msg(D_PUSH, "Pushed option is not updatable: '%s'. Ignoring.", line);
+        }
+        else
+        {
+            msg(M_WARN, "Pushed option is not updatable: '%s'. Restarting.", line);
+            return false;
+        }
+    }
+
+    return true;
+}
+
+bool
+apply_pull_filter(const struct options *o, char *line)
+{
+    if (!o->pull_filter_list)
+    {
+        return true;
+    }
+
+    struct pull_filter *f;
+
+    for (f = o->pull_filter_list->head; f; f = f->next)
+    {
+        if (f->type == PUF_TYPE_ACCEPT && strncmp(line, f->pattern, f->size) == 0)
+        {
+            msg(D_LOW, "Pushed option accepted by filter: '%s'", line);
+            return true;
+        }
+        else if (f->type == PUF_TYPE_IGNORE && strncmp(line, f->pattern, f->size) == 0)
+        {
+            msg(D_PUSH, "Pushed option removed by filter: '%s'", line);
+            *line = '\0';
+            return true;
+        }
+        else if (f->type == PUF_TYPE_REJECT && strncmp(line, f->pattern, f->size) == 0)
+        {
+            msg(M_WARN, "Pushed option rejected by filter: '%s'.", line);
+            return false;
+        }
+    }
+    return true;
+}
diff --git a/src/openvpn/options_util.h b/src/openvpn/options_util.h
index 2474e7f..71d51d6 100644
--- a/src/openvpn/options_util.h
+++ b/src/openvpn/options_util.h
@@ -50,4 +50,47 @@
 int
 atoi_warn(const char *str, int msglevel);
 
+/**
+ * Filter an option line by all pull filters.
+ *
+ * If a match is found, the line is modified depending on
+ * the filter type, and returns true. If the filter type is
+ * reject, SIGUSR1 is triggered and the return value is false.
+ * In that case the caller must end the push processing.
+ */
+bool
+apply_pull_filter(const struct options *o,
+                  char *line);
+
+/**
+ * @brief Checks the formatting and validity of options inside push-update messages.
+ *
+ * This function is used to validate and process options
+ * in push-update messages. It performs the following checks:
+ * - Determines if the options are updatable.
+ * - Checks for the presence of the `-` flag, which indicates that the option
+ *   should be removed.
+ * - Checks for the `?` flag, which marks the option as optional and suppresses
+ *   errors if the client cannot update it.
+ * - Increase the value pointed by 'i' when we encounter the `'-'` and `'?'` flags
+ *   after validating them and updating the appropriate flags in the `flags` variable.
+ * - `-?option`, `-option`, `?option` are valid formats, `?-option` is not a valid format.
+ * - If the flags and the option are not consecutive, the option is invalid:
+ *   `- ?option`, `-? option`, `- option` are invalid formats.
+ *
+ * @param line A pointer to an option string. This string is the option being validated.
+ * @param i A pointer to an integer that represents the current index in the `line` string.
+ * @param flags A pointer where flags will be stored:
+ *              - `PUSH_OPT_TO_REMOVE`: Set if the `-` flag is present.
+ *              - `PUSH_OPT_OPTIONAL`: Set if the `?` flag is present.
+ *
+ * @return true if the flags and option combination are valid.
+ * @return false if:
+ *         - The `-` and `?` flags are not formatted correctly.
+ *         - The `line` parameter is empty or `NULL`.
+ *         - The `?` flag is absent and the option is not updatable.
+ */
+bool
+check_push_update_option_flags(char *line, int *i, unsigned int *flags);
+
 #endif /* ifndef OPTIONS_UTIL_H_ */
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index ad8fa3d7..858b821 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -39,8 +39,6 @@
 #include "ssl_util.h"
 #include "options_util.h"
 
-static char push_reply_cmd[] = "PUSH_REPLY";
-
 /*
  * Auth username/password
  *
@@ -519,21 +517,31 @@
     {
         msg(D_PUSH_ERRORS, "WARNING: Received bad push/pull message: %s", sanitize_control_message(BSTR(buffer), &gc));
     }
-    else if (status == PUSH_MSG_REPLY || status == PUSH_MSG_CONTINUATION)
+    else if (status == PUSH_MSG_REPLY || status == PUSH_MSG_UPDATE || status == PUSH_MSG_CONTINUATION)
     {
         c->options.push_option_types_found |= option_types_found;
 
         /* delay bringing tun/tap up until --push parms received from remote */
-        if (status == PUSH_MSG_REPLY)
+        if (status == PUSH_MSG_REPLY || status == PUSH_MSG_UPDATE)
         {
             if (!options_postprocess_pull(&c->options, c->c2.es))
             {
                 goto error;
             }
-            if (!do_up(c, true, c->options.push_option_types_found))
+            if (status == PUSH_MSG_REPLY)
             {
-                msg(D_PUSH_ERRORS, "Failed to open tun/tap interface");
-                goto error;
+                if (!do_up(c, true, c->options.push_option_types_found))
+                {
+                    msg(D_PUSH_ERRORS, "Failed to open tun/tap interface");
+                    goto error;
+                }
+            }
+            else
+            {
+                if (!option_types_found)
+                {
+                    msg(M_WARN, "No updatable options found in incoming PUSH_UPDATE message");
+                }
             }
         }
         event_timeout_clear(&c->c2.push_request_interval);
@@ -1056,11 +1064,13 @@
             md_ctx_init(c->c2.pulled_options_state, "SHA256");
             c->c2.pulled_options_digest_init_done = true;
         }
-        if (apply_push_options(&c->options,
+        if (apply_push_options(c,
+                               &c->options,
                                buf,
                                permission_mask,
                                option_types_found,
-                               c->c2.es))
+                               c->c2.es,
+                               false))
         {
             push_update_digest(c->c2.pulled_options_state, &buf_orig,
                                &c->options);
@@ -1111,6 +1121,12 @@
         return process_incoming_push_reply(c, permission_mask,
                                            option_types_found, &buf);
     }
+    else if (honor_received_options
+             && buf_string_compare_advance(&buf, push_update_cmd))
+    {
+        return process_incoming_push_update(c, permission_mask,
+                                            option_types_found, &buf);
+    }
     else
     {
         return PUSH_MSG_ERROR;
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index 048b4c4..18dfcd8 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -33,9 +33,42 @@
 #define PUSH_MSG_AUTH_FAILURE     4
 #define PUSH_MSG_CONTINUATION     5
 #define PUSH_MSG_ALREADY_REPLIED  6
+#define PUSH_MSG_UPDATE           7
+
+#define push_reply_cmd "PUSH_REPLY"
+#define push_update_cmd "PUSH_UPDATE"
+
+/* Push-update options flags */
+#define PUSH_OPT_TO_REMOVE (1<<0)
+#define PUSH_OPT_OPTIONAL (1<<1)
 
 int process_incoming_push_request(struct context *c);
 
+/**
+ * @brief Handles the receiving of a push-update message and applies updates to the specified options.
+ *
+ * This function processes a push-update message, validating its content and applying updates
+ * to the options specified in the message. It also handles split messages if the complete
+ * message has not yet been received.
+ *
+ * @param c The context for the operation.
+ * @param permission_mask The permission mask specifying which options are allowed to be pulled.
+ * @param option_types_found A pointer to a variable that will be filled with the types of options
+ *                           found in the message.
+ * @param buf A buffer containing the received message.
+ *
+ * @return
+ * - `PUSH_MSG_UPDATE`: The message was processed successfully, and the updates were applied.
+ * - `PUSH_MSG_CONTINUATION`: The message is a fragment of a larger message, and the program is
+ *                            waiting for the final part.
+ * - `PUSH_MSG_ERROR`: An error occurred during message processing, or the message is invalid.
+ */
+
+int process_incoming_push_update(struct context *c,
+                                 unsigned int permission_mask,
+                                 unsigned int *option_types_found,
+                                 struct buffer *buf);
+
 int process_incoming_push_msg(struct context *c,
                               const struct buffer *buffer,
                               bool honor_received_options,
diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
new file mode 100644
index 0000000..b4d1e8b
--- /dev/null
+++ b/src/openvpn/push_util.c
@@ -0,0 +1,44 @@
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#include "push.h"
+
+int
+process_incoming_push_update(struct context *c,
+                             unsigned int permission_mask,
+                             unsigned int *option_types_found,
+                             struct buffer *buf)
+{
+    int ret = PUSH_MSG_ERROR;
+    const uint8_t ch = buf_read_u8(buf);
+    if (ch == ',')
+    {
+        if (apply_push_options(c,
+                               &c->options,
+                               buf,
+                               permission_mask,
+                               option_types_found,
+                               c->c2.es,
+                               true))
+        {
+            switch (c->options.push_continuation)
+            {
+                case 0:
+                case 1:
+                    ret = PUSH_MSG_UPDATE;
+                    break;
+
+                case 2:
+                    ret = PUSH_MSG_CONTINUATION;
+                    break;
+            }
+        }
+    }
+    else if (ch == '\0')
+    {
+        ret = PUSH_MSG_UPDATE;
+    }
+
+    return ret;
+}
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 9c6616a..a7658dd 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1993,6 +1993,9 @@
         /* support for exit notify via control channel */
         iv_proto |= IV_PROTO_CC_EXIT_NOTIFY;
 
+        /* support push-updates */
+        iv_proto |= IV_PROTO_PUSH_UPDATE;
+
         if (session->opt->pull)
         {
             /* support for receiving push_reply before sending
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 000992d..0a43ea1 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -114,6 +114,9 @@
 /** Supports the --dns option after all the incompatible changes */
 #define IV_PROTO_DNS_OPTION_V2   (1<<11)
 
+/** Supports push-update */
+#define IV_PROTO_PUSH_UPDATE     (1<<12)
+
 /* Default field in X509 to be username */
 #define X509_USERNAME_FIELD_DEFAULT "CN"
 
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index b47b495..b24e03c 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -11,7 +11,7 @@
 endif
 
 test_binaries += crypto_testdriver packet_id_testdriver auth_token_testdriver ncp_testdriver misc_testdriver \
-	pkt_testdriver ssl_testdriver user_pass_testdriver
+	pkt_testdriver ssl_testdriver user_pass_testdriver push_update_msg_testdriver
 
 if HAVE_LD_WRAP_SUPPORT
 if !WIN32
@@ -326,3 +326,21 @@
 	$(top_srcdir)/src/openvpn/win32-util.c \
 	$(top_srcdir)/src/openvpn/platform.c \
 	$(top_srcdir)/src/openvpn/list.c
+
+push_update_msg_testdriver_CFLAGS = -I$(top_srcdir)/src/openvpn \
+	-I$(top_srcdir)/src/compat \
+	-I$(top_srcdir)/tests/unit_tests/openvpn \
+	@TEST_CFLAGS@
+
+push_update_msg_testdriver_LDFLAGS = \
+	@TEST_LDFLAGS@ \
+	-L$(top_srcdir)/src/openvpn
+
+push_update_msg_testdriver_SOURCES = test_push_update_msg.c \
+	mock_msg.c \
+	mock_get_random.c \
+	$(top_srcdir)/src/openvpn/buffer.c \
+	$(top_srcdir)/src/openvpn/platform.c \
+	$(top_srcdir)/src/openvpn/push_util.c \
+	$(top_srcdir)/src/openvpn/options_util.c \
+	$(top_srcdir)/src/openvpn/otime.c
\ No newline at end of file
diff --git a/tests/unit_tests/openvpn/test_push_update_msg.c b/tests/unit_tests/openvpn/test_push_update_msg.c
new file mode 100644
index 0000000..d47286a
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_push_update_msg.c
@@ -0,0 +1,260 @@
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#include <stdlib.h>
+#include <stdarg.h>
+#include <setjmp.h>
+#include <cmocka.h>
+#include "push.h"
+#include "options_util.h"
+
+/* mocks */
+
+unsigned int
+pull_permission_mask(const struct context *c)
+{
+    unsigned int flags =
+        OPT_P_UP
+        | OPT_P_ROUTE_EXTRAS
+        | OPT_P_SOCKBUF
+        | OPT_P_SOCKFLAGS
+        | OPT_P_SETENV
+        | OPT_P_SHAPER
+        | OPT_P_TIMER
+        | OPT_P_COMP
+        | OPT_P_PERSIST
+        | OPT_P_MESSAGES
+        | OPT_P_EXPLICIT_NOTIFY
+        | OPT_P_ECHO
+        | OPT_P_PULL_MODE
+        | OPT_P_PEER_ID
+        | OPT_P_NCP
+        | OPT_P_PUSH_MTU
+        | OPT_P_ROUTE
+        | OPT_P_DHCPDNS;
+    return flags;
+}
+
+bool
+apply_push_options(struct context *c,
+                   struct options *options,
+                   struct buffer *buf,
+                   unsigned int permission_mask,
+                   unsigned int *option_types_found,
+                   struct env_set *es,
+                   bool is_update)
+{
+    char line[OPTION_PARM_SIZE];
+
+    while (buf_parse(buf, ',', line, sizeof(line)))
+    {
+        unsigned int push_update_option_flags = 0;
+        int i = 0;
+
+        if (is_update || options->pull_filter_list)
+        {
+            /* skip leading spaces matching the behaviour of parse_line */
+            while (isspace(line[i]))
+            {
+                i++;
+            }
+
+            if ((is_update && !check_push_update_option_flags(line, &i, &push_update_option_flags))
+                || (options->pull_filter_list && !apply_pull_filter(options, &line[i])))
+            {
+                if (push_update_option_flags & PUSH_OPT_OPTIONAL)
+                {
+                    continue; /* Ignoring this option */
+                }
+                msg(M_WARN, "Offending option received from server");
+                return false; /* Cause push/pull error and stop push processing */
+            }
+        }
+        /*
+         * No need to test also the application part here
+         * (add_option/remove_option/update_option)
+         */
+    }
+    return true;
+}
+
+int
+process_incoming_push_msg(struct context *c,
+                          const struct buffer *buffer,
+                          bool honor_received_options,
+                          unsigned int permission_mask,
+                          unsigned int *option_types_found)
+{
+    struct buffer buf = *buffer;
+
+    if (buf_string_compare_advance(&buf, "PUSH_REQUEST"))
+    {
+        return PUSH_MSG_REQUEST;
+    }
+    else if (honor_received_options
+             && buf_string_compare_advance(&buf, push_reply_cmd))
+    {
+        return PUSH_MSG_REPLY;
+    }
+    else if (honor_received_options
+             && buf_string_compare_advance(&buf, push_update_cmd))
+    {
+        return process_incoming_push_update(c, permission_mask,
+                                            option_types_found, &buf);
+    }
+    else
+    {
+        return PUSH_MSG_ERROR;
+    }
+}
+
+/* tests */
+
+static void
+test_incoming_push_message_basic(void **state)
+{
+    struct context *c = *state;
+    struct buffer buf = alloc_buf(256);
+    const char *update_msg = "PUSH_UPDATE,dhcp-option DNS 8.8.8.8, route 0.0.0.0 0.0.0.0 10.10.10.1";
+    buf_write(&buf, update_msg, strlen(update_msg));
+    unsigned int option_types_found = 0;
+
+    assert_int_equal(process_incoming_push_msg(c, &buf, c->options.pull, pull_permission_mask(c), &option_types_found), PUSH_MSG_UPDATE);
+
+    free_buf(&buf);
+}
+
+static void
+test_incoming_push_message_error1(void **state)
+{
+    struct context *c = *state;
+    struct buffer buf = alloc_buf(256);
+    const char *update_msg = "PUSH_UPDATEerr,dhcp-option DNS 8.8.8.8";
+    buf_write(&buf, update_msg, strlen(update_msg));
+    unsigned int option_types_found = 0;
+
+    assert_int_equal(process_incoming_push_msg(c, &buf, c->options.pull, pull_permission_mask(c), &option_types_found), PUSH_MSG_ERROR);
+
+    free_buf(&buf);
+}
+
+
+static void
+test_incoming_push_message_error2(void **state)
+{
+    struct context *c = *state;
+    struct buffer buf = alloc_buf(256);
+    const char *update_msg = "PUSH_UPDATE ,dhcp-option DNS 8.8.8.8";
+    buf_write(&buf, update_msg, strlen(update_msg));
+    unsigned int option_types_found = 0;
+
+    assert_int_equal(process_incoming_push_msg(c, &buf, c->options.pull, pull_permission_mask(c), &option_types_found), PUSH_MSG_ERROR);
+
+    free_buf(&buf);
+}
+
+static void
+test_incoming_push_message_1(void **state)
+{
+    struct context *c = *state;
+    struct buffer buf = alloc_buf(256);
+    const char *update_msg = "PUSH_UPDATE, -?dns, route something, ?dhcp-option DNS 8.8.8.8";
+    buf_write(&buf, update_msg, strlen(update_msg));
+    unsigned int option_types_found = 0;
+
+    assert_int_equal(process_incoming_push_msg(c, &buf, c->options.pull, pull_permission_mask(c), &option_types_found), PUSH_MSG_UPDATE);
+
+    free_buf(&buf);
+}
+
+static void
+test_incoming_push_message_bad_format(void **state)
+{
+    struct context *c = *state;
+    struct buffer buf = alloc_buf(256);
+    const char *update_msg = "PUSH_UPDATE, -dhcp-option, ?-dns";
+    buf_write(&buf, update_msg, strlen(update_msg));
+    unsigned int option_types_found = 0;
+
+    assert_int_equal(process_incoming_push_msg(c, &buf, c->options.pull, pull_permission_mask(c), &option_types_found), PUSH_MSG_ERROR);
+
+    free_buf(&buf);
+}
+
+static void
+test_incoming_push_message_not_updatable_option(void **state)
+{
+    struct context *c = *state;
+    struct buffer buf = alloc_buf(256);
+    const char *update_msg = "PUSH_UPDATE, dev tun";
+    buf_write(&buf, update_msg, strlen(update_msg));
+    unsigned int option_types_found = 0;
+
+    assert_int_equal(process_incoming_push_msg(c, &buf, c->options.pull, pull_permission_mask(c), &option_types_found), PUSH_MSG_ERROR);
+
+    free_buf(&buf);
+}
+
+static void
+test_incoming_push_message_mix(void **state)
+{
+    struct context *c = *state;
+    struct buffer buf = alloc_buf(256);
+    const char *update_msg = "PUSH_UPDATE,-dhcp-option, route 10.10.10.0, dhcp-option DNS 1.1.1.1, route 10.11.12.0, dhcp-option DOMAIN corp.local, keepalive 10 60";
+    buf_write(&buf, update_msg, strlen(update_msg));
+    unsigned int option_types_found = 0;
+
+    assert_int_equal(process_incoming_push_msg(c, &buf, c->options.pull, pull_permission_mask(c), &option_types_found), PUSH_MSG_UPDATE);
+
+    free_buf(&buf);
+}
+
+static void
+test_incoming_push_message_mix2(void **state)
+{
+    struct context *c = *state;
+    struct buffer buf = alloc_buf(256);
+    const char *update_msg = "PUSH_UPDATE,-dhcp-option,dhcp-option DNS 8.8.8.8,redirect-gateway local,route 192.168.1.0 255.255.255.0";
+    buf_write(&buf, update_msg, strlen(update_msg));
+    unsigned int option_types_found = 0;
+
+    assert_int_equal(process_incoming_push_msg(c, &buf, c->options.pull, pull_permission_mask(c), &option_types_found), PUSH_MSG_UPDATE);
+
+    free_buf(&buf);
+}
+
+static int
+setup(void **state)
+{
+    struct context *c = calloc(1, sizeof(struct context));
+    c->options.pull = true;
+    c->options.route_nopull = false;
+    *state = c;
+    return 0;
+}
+
+static int
+teardown(void **state)
+{
+    struct context *c = *state;
+    free(c);
+    return 0;
+}
+
+int
+main(void)
+{
+    const struct CMUnitTest tests[] = {
+        cmocka_unit_test_setup_teardown(test_incoming_push_message_basic, setup, teardown),
+        cmocka_unit_test_setup_teardown(test_incoming_push_message_error1, setup, teardown),
+        cmocka_unit_test_setup_teardown(test_incoming_push_message_error2, setup, teardown),
+        cmocka_unit_test_setup_teardown(test_incoming_push_message_not_updatable_option, setup, teardown),
+        cmocka_unit_test_setup_teardown(test_incoming_push_message_1, setup, teardown),
+        cmocka_unit_test_setup_teardown(test_incoming_push_message_bad_format, setup, teardown),
+        cmocka_unit_test_setup_teardown(test_incoming_push_message_mix, setup, teardown),
+        cmocka_unit_test_setup_teardown(test_incoming_push_message_mix2, setup, teardown)
+    };
+
+    return cmocka_run_group_tests(tests, NULL, NULL);
+}

