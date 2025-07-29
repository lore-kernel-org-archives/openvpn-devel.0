From: Gert Doering <gert@...1296...>
Date: Tue, 29 Jul 2025 12:40:50 +0200
Message-ID: <20250729104056.27634-1-gert@...1296...>
In-Reply-To: <gerrit.1732124549000.I507180d7397b6959844a30908010132bc3411067@...2715...>
References: <gerrit.1732124549000.I507180d7397b6959844a30908010132bc3411067@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v23] PUSH_UPDATE: Added remove_option() and
 do_update().
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

* Added remove_option() function and some utility functions to remove options at
  runtime following the push-update logic.
* Added do_update() function to close and reopen the tun and apply option updates.

Change-Id: I507180d7397b6959844a30908010132bc3411067
Signed-off-by: Marco Baffo <marco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/809
This mail reflects revision 23 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index ba1dda4..3254cc6 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2470,7 +2470,7 @@
 
         if (pulled_options)
         {
-            if (!do_deferred_options(c, option_types_found))
+            if (!do_deferred_options(c, option_types_found, false))
             {
                 msg(D_PUSH_ERRORS, "ERROR: Failed to apply push options");
                 return false;
@@ -2594,6 +2594,55 @@
     return true;
 }
 
+bool
+do_update(struct context *c, unsigned int option_types_found)
+{
+    /* Not necessary since to receive the update the openvpn
+     * instance must be up and running but just in case
+     */
+    if (!c->c2.do_up_ran)
+    {
+        return false;
+    }
+
+    bool tt_dco_win = tuntap_is_dco_win(c->c1.tuntap);
+    if (tt_dco_win)
+    {
+        msg(M_NONFATAL, "dco-win doesn't yet support reopening TUN device");
+        return false;
+    }
+
+    if (!do_deferred_options(c, option_types_found, true))
+    {
+        msg(D_PUSH_ERRORS, "ERROR: Failed to apply push options");
+        return false;
+    }
+
+    do_close_tun(c, true);
+
+    management_sleep(1);
+    int error_flags = 0;
+    c->c2.did_open_tun = do_open_tun(c, &error_flags);
+    update_time();
+
+    if (c->c2.did_open_tun)
+    {
+        /* if --route-delay was specified, start timer */
+        if ((route_order(c->c1.tuntap) == ROUTE_AFTER_TUN) && c->options.route_delay_defined)
+        {
+            event_timeout_init(&c->c2.route_wakeup, c->options.route_delay, now);
+            event_timeout_init(&c->c2.route_wakeup_expire, c->options.route_delay + c->options.route_delay_window, now);
+            tun_standby_init(c->c1.tuntap);
+        }
+
+        initialization_sequence_completed(c, error_flags);
+    }
+
+    CLEAR(c->c1.pulled_options_digest_save);
+
+    return true;
+}
+
 /*
  * These are the option categories which will be accepted by pull.
  */
@@ -2672,11 +2721,8 @@
     return true;
 }
 
-/*
- * Handle non-tun-related pulled options.
- */
 bool
-do_deferred_options(struct context *c, const unsigned int found)
+do_deferred_options(struct context *c, const unsigned int found, const bool is_update)
 {
     if (found & OPT_P_MESSAGES)
     {
@@ -2784,7 +2830,10 @@
     /* process (potentially) pushed options */
     if (c->options.pull)
     {
-        if (!check_pull_client_ncp(c, found))
+        /* On PUSH_UPDATE, NCP related flags are never updated, and so the code
+         * would assume "no cipher pushed = NCP failed" - so, don't call it on
+         * updates */
+        if (!is_update && !check_pull_client_ncp(c, found))
         {
             return false;
         }
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index 5c6b9c1..25078a6 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -86,13 +86,29 @@
            bool pulled_options,
            unsigned int option_types_found);
 
+/**
+ * @brief A simplified version of the do_up() function. This function is called
+ *        after receiving a successful PUSH_UPDATE message. It closes and reopens
+ *        the TUN device to apply the updated options.
+ *
+ * @param c The context structure.
+ * @param option_types_found The options found in the PUSH_UPDATE message.
+ * @return true on success.
+ * @return false on error.
+ */
+bool do_update(struct context *c, unsigned int option_types_found);
+
 unsigned int pull_permission_mask(const struct context *c);
 
 const char *format_common_name(struct context *c, struct gc_arena *gc);
 
 void reset_coarse_timers(struct context *c);
 
-bool do_deferred_options(struct context *c, const unsigned int found);
+/*
+ * Handle non-tun-related pulled options.
+ * Set `is_update` param to true to skip NCP check.
+ */
+bool do_deferred_options(struct context *c, const unsigned int found, const bool is_update);
 
 void inherit_context_child(struct context *dest,
                            const struct context *src,
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index b2d2b6c..68b4da6 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2424,7 +2424,7 @@
     /*
      * Process sourced options.
      */
-    do_deferred_options(&mi->context, option_types_found);
+    do_deferred_options(&mi->context, option_types_found, false);
 
     /*
      * make sure we got ifconfig settings from somewhere
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2083eae..3a8ce86 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1086,6 +1086,40 @@
         gc_free(&gc);
     }
 }
+
+static void
+delete_all_dhcp_fo(struct options *o, struct env_item **list)
+{
+    struct env_item *current, *prev;
+
+    ASSERT(list);
+
+    for (current = *list, prev = NULL; current != NULL; current = current->next)
+    {
+        char *tmp_value = NULL;
+        if (!strncmp(current->string, "foreign_option_", sizeof("foreign_option_")-1))
+        {
+            tmp_value = strchr(current->string, '=');
+            if (tmp_value && ++tmp_value)
+            {
+                if (!strncmp(tmp_value, "dhcp-option ", sizeof("dhcp-option ")-1))
+                {
+                    if (prev)
+                    {
+                        prev->next = current->next;
+                    }
+                    else
+                    {
+                        *list = current->next;
+                    }
+                    o->foreign_option_index--;
+                }
+            }
+        }
+        prev = current;
+    }
+}
+
 #endif /* ifndef _WIN32 */
 
 static in_addr_t
@@ -3091,7 +3125,7 @@
         opt->routes->flags |= RG_DEF1;
     }
 }
-#endif
+#endif /* ifdef _WIN32 */
 
 /*
  * Save/Restore certain option defaults before --pull is applied.
@@ -5326,6 +5360,18 @@
            struct env_set *es);
 
 static void
+remove_option(struct context *c,
+              struct options *options,
+              char *p[],
+              bool is_inline,
+              const char *file,
+              int line,
+              const int msglevel,
+              const unsigned int permission_mask,
+              unsigned int *option_types_found,
+              struct env_set *es);
+
+static void
 read_config_file(struct options *options,
                  const char *file,
                  int level,
@@ -5551,6 +5597,11 @@
                 add_option(options, p, false, file, line_num, 0, msglevel,
                            permission_mask, option_types_found, es);
             }
+            else if (push_update_option_flags & PUSH_OPT_TO_REMOVE)
+            {
+                remove_option(c, options, p, false, file, line_num, msglevel,
+                              permission_mask, option_types_found, es);
+            }
         }
     }
     return true;
@@ -5689,6 +5740,199 @@
     return options->forward_compatible ? M_WARN : msglevel;
 }
 
+/**
+ * @brief Resets options found in the PUSH_UPDATE message that are preceded by the `-` flag.
+ *        This function is used in push-updates to reset specified options.
+ *        The number of parameters `p` must always be 1. If the permission is verified,
+ *        all related options are erased or reset to their default values.
+ *        Upon successful permission verification (by VERIFY_PERMISSION()),
+ *        `option_types_found` is filled with the flag corresponding to the option.
+ *
+ * @param c The context structure.
+ * @param options A pointer to the options structure.
+ * @param p An array of strings containing the options and their parameters.
+ * @param is_inline A boolean indicating if the option is inline.
+ * @param file The file where the function is called.
+ * @param line The line number where the function is called.
+ * @param msglevel The message level.
+ * @param permission_mask The permission mask used by VERIFY_PERMISSION().
+ * @param option_types_found A pointer to the variable where the flags corresponding to the options found are stored.
+ * @param es The environment set structure.
+ */
+static void
+remove_option(struct context *c,
+              struct options *options,
+              char *p[],
+              bool is_inline,
+              const char *file,
+              int line,
+              const int msglevel,
+              const unsigned int permission_mask,
+              unsigned int *option_types_found,
+              struct env_set *es)
+{
+    int msglevel_fc = msglevel_forward_compatible(options, msglevel);
+
+    if (streq(p[0], "ifconfig") && !p[1])
+    {
+        VERIFY_PERMISSION(OPT_P_UP);
+        options->ifconfig_local = NULL;
+        options->ifconfig_remote_netmask = NULL;
+    }
+    else if (streq(p[0], "ifconfig-ipv6") && !p[1])
+    {
+        VERIFY_PERMISSION(OPT_P_UP);
+        options->ifconfig_ipv6_local = NULL;
+        options->ifconfig_ipv6_netbits = 0;
+        options->ifconfig_ipv6_remote = NULL;
+    }
+    else if (streq(p[0], "route") && !p[1])
+    {
+        VERIFY_PERMISSION(OPT_P_ROUTE);
+        if (c->c1.route_list)
+        {
+            delete_routes_v4(c->c1.route_list, c->c1.tuntap,
+                             ROUTE_OPTION_FLAGS(&c->options),
+                             es, &c->net_ctx);
+            if (options->routes)
+            {
+                options->routes->routes = NULL;
+                options->routes->flags = 0;
+            }
+        }
+    }
+    else if (streq(p[0], "route-ipv6") && !p[1])
+    {
+        VERIFY_PERMISSION(OPT_P_ROUTE);
+        if (c->c1.route_ipv6_list)
+        {
+            delete_routes_v6(c->c1.route_ipv6_list, c->c1.tuntap,
+                             ROUTE_OPTION_FLAGS(&c->options),
+                             es, &c->net_ctx);
+            if (options->routes_ipv6)
+            {
+                options->routes_ipv6->routes_ipv6 = NULL;
+                options->routes_ipv6->flags = 0;
+            }
+        }
+    }
+    else if (streq(p[0], "route-gateway") && !p[1])
+    {
+        VERIFY_PERMISSION(OPT_P_ROUTE_EXTRAS);
+        options->route_gateway_via_dhcp = false;
+        options->route_default_gateway = NULL;
+    }
+    else if (streq(p[0], "route-metric") && !p[1])
+    {
+        VERIFY_PERMISSION(OPT_P_ROUTE);
+        options->route_default_metric = 0;
+    }
+    else if (streq(p[0], "push-continuation") && !p[1])
+    {
+        VERIFY_PERMISSION(OPT_P_PULL_MODE);
+        options->push_continuation = 0;
+    }
+    else if ((streq(p[0], "redirect-gateway") || streq(p[0], "redirect-private")) && !p[1])
+    {
+        VERIFY_PERMISSION(OPT_P_ROUTE);
+        if (options->routes)
+        {
+            options->routes->flags = 0;
+        }
+        if (options->routes_ipv6)
+        {
+            options->routes_ipv6->flags = 0;
+        }
+    }
+    else if (streq(p[0], "dns") && !p[1])
+    {
+        VERIFY_PERMISSION(OPT_P_DHCPDNS);
+        gc_free(&options->dns_options.gc);
+        CLEAR(options->dns_options);
+    }
+    else if (streq(p[0], "topology") && !p[1])
+    {
+        VERIFY_PERMISSION(OPT_P_UP);
+        options->topology = TOP_UNDEF;
+        helper_setdefault_topology(options);
+    }
+    else if (streq(p[0], "tun-mtu") && !p[1])
+    {
+        VERIFY_PERMISSION(OPT_P_PUSH_MTU|OPT_P_CONNECTION);
+        options->ce.tun_mtu = TUN_MTU_DEFAULT;
+        options->ce.tun_mtu_defined = false;
+        options->ce.occ_mtu = 0;
+    }
+    else if (streq(p[0], "block-ipv6") && !p[1])
+    {
+        VERIFY_PERMISSION(OPT_P_ROUTE);
+        options->block_ipv6 = false;
+    }
+#if defined(_WIN32) || defined(TARGET_ANDROID)
+    else if (streq(p[0], "dhcp-option") && !p[1])
+    {
+        struct tuntap_options *o = &options->tuntap_options;
+        VERIFY_PERMISSION(OPT_P_DHCPDNS);
+
+        o->domain = NULL;
+        o->netbios_scope = NULL;
+        o->netbios_node_type = 0;
+        o->dns6_len = 0;
+        memset(o->dns6, 0, sizeof(o->dns6));
+        o->dns_len = 0;
+        memset(o->dns, 0, sizeof(o->dns));
+        o->wins_len = 0;
+        memset(o->wins, 0, sizeof(o->wins));
+        o->ntp_len = 0;
+        memset(o->ntp, 0, sizeof(o->ntp));
+        o->nbdd_len = 0;
+        memset(o->nbdd, 0, sizeof(o->nbdd));
+        while (o->domain_search_list_len-- > 0)
+        {
+            o->domain_search_list[o->domain_search_list_len] = NULL;
+        }
+        o->disable_nbt = 0;
+        o->dhcp_options = 0;
+#if defined(TARGET_ANDROID)
+        o->http_proxy_port = 0;
+        o->http_proxy = NULL;
+#endif
+    }
+#endif /* if defined(_WIN32) || defined(TARGET_ANDROID) */
+#ifdef _WIN32
+    else if (streq(p[0], "block-outside-dns") && !p[1])
+    {
+        VERIFY_PERMISSION(OPT_P_DHCPDNS);
+        options->block_outside_dns = false;
+    }
+#else /* ifdef _WIN32 */
+    else if (streq(p[0], "dhcp-option") && !p[1])
+    {
+        VERIFY_PERMISSION(OPT_P_DHCPDNS);
+        delete_all_dhcp_fo(options, &es->list);
+    }
+#endif
+    else
+    {
+        int i;
+        int msglevel_unknown = msglevel_fc;
+        /* Check if an option is in --ignore-unknown-option and
+         * set warning level to non fatal */
+        for (i = 0; options->ignore_unknown_option && options->ignore_unknown_option[i]; i++)
+        {
+            if (streq(p[0], options->ignore_unknown_option[i]))
+            {
+                msglevel_unknown = M_WARN;
+                break;
+            }
+        }
+        msg(msglevel_unknown, "Unrecognized option or missing or extra parameter(s) in %s:%d: -%s (%s)", file, line, p[0], PACKAGE_VERSION);
+    }
+    return;
+err:
+    msg(msglevel, "Error occurred trying to remove %s option", p[0]);
+}
+
 static void
 set_user_script(struct options *options,
                 const char **script,
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 858b821..22082a9 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -542,6 +542,11 @@
                 {
                     msg(M_WARN, "No updatable options found in incoming PUSH_UPDATE message");
                 }
+                else if (!do_update(c, option_types_found))
+                {
+                    msg(D_PUSH_ERRORS, "Failed to update options");
+                    goto error;
+                }
             }
         }
         event_timeout_clear(&c->c2.push_request_interval);
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 156262a..89ebaee 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1265,7 +1265,16 @@
               const struct tuntap *tt, unsigned int flags,
               const struct env_set *es, openvpn_net_ctx_t *ctx)
 {
-    if (rl && rl->iflags & RL_ROUTES_ADDED)
+    delete_routes_v4(rl, tt, flags, es, ctx);
+    delete_routes_v6(rl6, tt, flags, es, ctx);
+}
+
+void
+delete_routes_v4(struct route_list *rl, const struct tuntap *tt,
+                 unsigned int flags, const struct env_set *es,
+                 openvpn_net_ctx_t *ctx)
+{
+    if (rl && (rl->iflags & RL_ROUTES_ADDED))
     {
         struct route_ipv4 *r;
         for (r = rl->routes; r; r = r->next)
@@ -1281,8 +1290,14 @@
     {
         clear_route_list(rl);
     }
+}
 
-    if (rl6 && (rl6->iflags & RL_ROUTES_ADDED) )
+void
+delete_routes_v6(struct route_ipv6_list *rl6, const struct tuntap *tt,
+                 unsigned int flags, const struct env_set *es,
+                 openvpn_net_ctx_t *ctx)
+{
+    if (rl6 && (rl6->iflags & RL_ROUTES_ADDED))
     {
         struct route_ipv6 *r6;
         for (r6 = rl6->routes_ipv6; r6; r6 = r6->next)
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 237375c..b89ec9f 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -335,6 +335,16 @@
                    const struct env_set *es,
                    openvpn_net_ctx_t *ctx);
 
+void
+delete_routes_v4(struct route_list *rl, const struct tuntap *tt,
+                 unsigned int flags, const struct env_set *es,
+                 openvpn_net_ctx_t *ctx);
+
+void
+delete_routes_v6(struct route_ipv6_list *rl6, const struct tuntap *tt,
+                 unsigned int flags, const struct env_set *es,
+                 openvpn_net_ctx_t *ctx);
+
 void setenv_routes(struct env_set *es, const struct route_list *rl);
 
 void setenv_routes_ipv6(struct env_set *es, const struct route_ipv6_list *rl6);

