From: "mrbff (Code Review)" <gerrit@...515...>
Date: Wed, 8 Jan 2025 11:51:08 +0000
In-Reply-To: <gerrit.1732124549000.I507180d7397b6959844a30908010132bc3411067@...2715...>
References: <gerrit.1732124549000.I507180d7397b6959844a30908010132bc3411067@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <678425ded4b15b00a667768007c67348c2fd89b5-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="y+3dA8u4ETw="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: PUSH_UPDATE: Added
 remove_option() and do_update().
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--y+3dA8u4ETw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, mrbff, plaisthos.

Hello flichtenheld, plaisthos, stipa,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/809?usp=3Demail

to look at the new patch set (#10).


Change subject: PUSH_UPDATE: Added remove_option() and do_update().
......................................................................

PUSH_UPDATE: Added remove_option() and do_update().

* Added remove_option() function and some utility functions to remove optio=
ns at
  runtime following the push-update logic.
* Added do_update() function to close and reopen the tun and apply option u=
pdates.

Change-Id: I507180d7397b6959844a30908010132bc3411067
Signed-off-by: Marco Baffo <marco@...2726...>
---
M src/openvpn/init.c
M src/openvpn/init.h
M src/openvpn/multi.c
M src/openvpn/options.c
M src/openvpn/push.c
M src/openvpn/route.c
M src/openvpn/route.h
7 files changed, 400 insertions(+), 40 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/09/809/10

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index f8d9d06..9738d3b 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2445,7 +2445,7 @@

         if (pulled_options)
         {
-            if (!do_deferred_options(c, option_types_found))
+            if (!do_deferred_options(c, option_types_found, false))
             {
                 msg(D_PUSH_ERRORS, "ERROR: Failed to apply push options");
                 return false;
@@ -2567,6 +2567,55 @@
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
+    bool tt_dco_win =3D tuntap_is_dco_win(c->c1.tuntap);
+    if (tt_dco_win)
+    {
+        msg(M_NONFATAL, "dco-win doesn't yet support reopening TUN device"=
);
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
+    int error_flags =3D 0;
+    c->c2.did_open_tun =3D do_open_tun(c, &error_flags);
+    update_time();
+
+    if (c->c2.did_open_tun)
+    {
+        /* if --route-delay was specified, start timer */
+        if ((route_order(c->c1.tuntap) =3D=3D ROUTE_AFTER_TUN) && c->optio=
ns.route_delay_defined)
+        {
+            event_timeout_init(&c->c2.route_wakeup, c->options.route_delay=
, now);
+            event_timeout_init(&c->c2.route_wakeup_expire, c->options.rout=
e_delay + c->options.route_delay_window, now);
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
@@ -2645,11 +2694,8 @@
     return true;
 }

-/*
- * Handle non-tun-related pulled options.
- */
 bool
-do_deferred_options(struct context *c, const unsigned int found)
+do_deferred_options(struct context *c, const unsigned int found, const boo=
l is_update)
 {
     if (found & OPT_P_MESSAGES)
     {
@@ -2745,7 +2791,7 @@
     /* process (potentially) pushed options */
     if (c->options.pull)
     {
-        if (!check_pull_client_ncp(c, found))
+        if (!is_update && !check_pull_client_ncp(c, found))
         {
             return false;
         }
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index ea7eb30..100f112 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -86,13 +86,29 @@
            bool pulled_options,
            unsigned int option_types_found);

+/**
+ * @brief A simplified version of the do_up() function. This function is c=
alled
+ *        after receiving a successful PUSH_UPDATE message. It closes and =
reopens
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
+bool do_deferred_options(struct context *c, const unsigned int found, cons=
t bool is_update);

 void inherit_context_child(struct context *dest,
                            const struct context *src);
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 45b3cfa..a9040a6 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2409,7 +2409,7 @@
     /*
      * Process sourced options.
      */
-    do_deferred_options(&mi->context, option_types_found);
+    do_deferred_options(&mi->context, option_types_found, false);

     /*
      * make sure we got ifconfig settings from somewhere
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e417a99..bd00f65 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1055,6 +1055,40 @@
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
+    for (current =3D *list, prev =3D NULL; current !=3D NULL; current =3D =
current->next)
+    {
+        char *tmp_value =3D NULL;
+        if (!strncmp(current->string, "foreign_option_", sizeof("foreign_o=
ption_")-1))
+        {
+            tmp_value =3D strchr(current->string, '=3D');
+            if (tmp_value && ++tmp_value)
+            {
+                if (!strncmp(tmp_value, "dhcp-option ", sizeof("dhcp-optio=
n ")-1))
+                {
+                    if (prev)
+                    {
+                        prev->next =3D current->next;
+                    }
+                    else
+                    {
+                        *list =3D current->next;
+                    }
+                    o->foreign_option_index--;
+                }
+            }
+        }
+        prev =3D current;
+    }
+}
+
 #endif /* ifndef _WIN32 */
=20
 static in_addr_t
@@ -3260,8 +3294,16 @@
         msg(M_INFO, "Flag 'def1' added to --redirect-gateway (iservice is =
in use)");
         opt->routes->flags |=3D RG_DEF1;
     }
+    else if (opt->routes
+             && ((opt->route_method !=3D ROUTE_METHOD_SERVICE)
+                 || !(opt->routes->flags & RG_REROUTE_GW))
+             && (opt->routes->flags & RG_DEF1))
+    {
+        msg(M_INFO, "Flag 'def1' removed from --redirect-gateway");
+        opt->routes->flags &=3D ~RG_DEF1;
+    }
 }
-#endif
+#endif /* ifdef _WIN32 */

 /*
  * Save/Restore certain option defaults before --pull is applied.
@@ -5452,37 +5494,6 @@
     }
 }

-void
-options_server_import(struct options *o,
-                      const char *filename,
-                      int msglevel,
-                      unsigned int permission_mask,
-                      unsigned int *option_types_found,
-                      struct env_set *es)
-{
-    msg(D_PUSH, "OPTIONS IMPORT: reading client specific options from: %s"=
, filename);
-    read_config_file(o,
-                     filename,
-                     0,
-                     filename,
-                     0,
-                     msglevel,
-                     permission_mask,
-                     option_types_found,
-                     es);
-}
-
-void
-options_string_import(struct options *options,
-                      const char *config,
-                      const int msglevel,
-                      const unsigned int permission_mask,
-                      unsigned int *option_types_found,
-                      struct env_set *es)
-{
-    read_config_string("[CONFIG-STRING]", options, config, msglevel, permi=
ssion_mask, option_types_found, es);
-}
-
 #define VERIFY_PERMISSION(mask) {                                         =
   \
         if (!verify_permission(p[0], file, line, (mask), permission_mask, =
       \
                                option_types_found, msglevel, options, is_i=
nline)) \
@@ -5585,6 +5596,188 @@
     return options->forward_compatible ? M_WARN : msglevel;
 }

+/**
+ * @brief Resets options found in the PUSH_UPDATE message that are precede=
d by the `-` flag.
+ *        This function is used in push-updates to reset specified options.
+ *        The number of parameters `p` must always be 1. If the permission=
 is verified,
+ *        all related options are erased or reset to their default values.
+ *        Upon successful permission verification (by VERIFY_PERMISSION()),
+ *        `option_types_found` is filled with the flag corresponding to th=
e option.
+ *
+ * @param c The context structure.
+ * @param options A pointer to the options structure.
+ * @param p An array of strings containing the options and their parameter=
s.
+ * @param is_inline A boolean indicating if the option is inline.
+ * @param file The file where the function is called.
+ * @param line The line number where the function is called.
+ * @param msglevel The message level.
+ * @param permission_mask The permission mask used by VERIFY_PERMISSION().
+ * @param option_types_found A pointer to the variable where the flags cor=
responding to the options found are stored.
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
+    int msglevel_fc =3D msglevel_forward_compatible(options, msglevel);
+
+    if (streq(p[0], "ifconfig") && !p[1])
+    {
+        VERIFY_PERMISSION(OPT_P_UP);
+        options->ifconfig_local =3D NULL;
+        options->ifconfig_remote_netmask =3D NULL;
+    }
+    else if (streq(p[0], "ifconfig-ipv6") && !p[1])
+    {
+        VERIFY_PERMISSION(OPT_P_UP);
+        options->ifconfig_ipv6_local =3D NULL;
+        options->ifconfig_ipv6_netbits =3D 0;
+        options->ifconfig_ipv6_remote =3D NULL;
+    }
+    else if (streq(p[0], "route") && !p[1])
+    {
+        VERIFY_PERMISSION(OPT_P_ROUTE);
+        if (c->c1.route_list)
+        {
+            destroy_routes_v4(c->c1.route_list, c->c1.tuntap,
+                              ROUTE_OPTION_FLAGS(&c->options),
+                              es, &c->net_ctx, options);
+        }
+    }
+    else if (streq(p[0], "route-ipv6") && !p[1])
+    {
+        VERIFY_PERMISSION(OPT_P_ROUTE);
+        if (c->c1.route_ipv6_list)
+        {
+            destroy_routes_v6(c->c1.route_ipv6_list, c->c1.tuntap,
+                              ROUTE_OPTION_FLAGS(&c->options),
+                              es, &c->net_ctx, options);
+        }
+    }
+    else if (streq(p[0], "route-gateway") && !p[1])
+    {
+        VERIFY_PERMISSION(OPT_P_ROUTE_EXTRAS);
+        options->route_gateway_via_dhcp =3D false;
+        options->route_default_gateway =3D NULL;
+    }
+    else if (streq(p[0], "route-metric") && !p[1])
+    {
+        VERIFY_PERMISSION(OPT_P_ROUTE);
+        options->route_default_metric =3D 0;
+    }
+    else if (streq(p[0], "push-continuation") && !p[1])
+    {
+        VERIFY_PERMISSION(OPT_P_PULL_MODE);
+        options->push_continuation =3D 0;
+    }
+    else if ((streq(p[0], "redirect-gateway") || streq(p[0], "redirect-pri=
vate")) && !p[1])
+    {
+        VERIFY_PERMISSION(OPT_P_ROUTE);
+        if (options->routes)
+        {
+            options->routes->flags =3D 0;
+        }
+        if (options->routes_ipv6)
+        {
+            options->routes_ipv6->flags =3D 0;
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
+        options->topology =3D TOP_UNDEF;
+        helper_setdefault_topology(options);
+    }
+    else if (streq(p[0], "tun-mtu") && !p[1])
+    {
+        VERIFY_PERMISSION(OPT_P_PUSH_MTU|OPT_P_CONNECTION);
+        options->ce.tun_mtu =3D TUN_MTU_DEFAULT;
+        options->ce.tun_mtu_defined =3D false;
+        options->ce.occ_mtu =3D 0;
+    }
+    else if (streq(p[0], "block-ipv6") && !p[1])
+    {
+        VERIFY_PERMISSION(OPT_P_ROUTE);
+        options->block_ipv6 =3D false;
+    }
+#if defined(_WIN32) || defined(TARGET_ANDROID)
+    else if (streq(p[0], "dhcp-option") && !p[1])
+    {
+        struct tuntap_options *o =3D &options->tuntap_options;
+        VERIFY_PERMISSION(OPT_P_DHCPDNS);
+
+        o->domain =3D NULL;
+        o->netbios_scope =3D NULL;
+        o->netbios_node_type =3D 0;
+        o->dns6_len =3D 0;
+        memset(o->dns6, 0, sizeof(o->dns6));
+        o->dns_len =3D 0;
+        memset(o->dns, 0, sizeof(o->dns));
+        o->wins_len =3D 0;
+        memset(o->wins, 0, sizeof(o->wins));
+        o->ntp_len =3D 0;
+        memset(o->ntp, 0, sizeof(o->ntp));
+        o->nbdd_len =3D 0;
+        memset(o->nbdd, 0, sizeof(o->nbdd));
+        while (o->domain_search_list_len-- > 0)
+        {
+            o->domain_search_list[o->domain_search_list_len] =3D NULL;
+        }
+        o->disable_nbt =3D 0;
+        o->dhcp_options =3D 0;
+#if defined(TARGET_ANDROID)
+        o->http_proxy_port =3D 0;
+        o->http_proxy =3D NULL;
+#endif
+    }
+#endif /* if defined(_WIN32) || defined(TARGET_ANDROID) */
+#ifdef _WIN32
+    else if (streq(p[0], "block-outside-dns") && !p[1])
+    {
+        VERIFY_PERMISSION(OPT_P_DHCPDNS);
+        options->block_outside_dns =3D false;
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
+        int msglevel_unknown =3D msglevel_fc;
+        /* Check if an option is in --ignore-unknown-option and
+         * set warning level to non fatal */
+        for (i =3D 0; options->ignore_unknown_option && options->ignore_un=
known_option[i]; i++)
+        {
+            if (streq(p[0], options->ignore_unknown_option[i]))
+            {
+                msglevel_unknown =3D M_WARN;
+                break;
+            }
+        }
+        msg(msglevel_unknown, "Unrecognized option or missing or extra par=
ameter(s) in %s:%d: -%s (%s)", file, line, p[0], PACKAGE_VERSION);
+    }
+    return;
+err:
+    msg(msglevel, "Error occurred trying to remove %s option", p[0]);
+}
 bool
 apply_push_options(struct context *c,
                    struct options *options,
@@ -5618,11 +5811,47 @@
                 add_option(options, p, false, file, line_num, 0, msglevel,
                            permission_mask, option_types_found, es);
             }
+            else if (push_update_option_flags & PUSH_OPT_TO_REMOVE)
+            {
+                remove_option(c, options, p, false, file, line_num, msglev=
el,
+                              permission_mask, option_types_found, es);
+            }
         }
     }
     return true;
 }

+void
+options_server_import(struct options *o,
+                      const char *filename,
+                      int msglevel,
+                      unsigned int permission_mask,
+                      unsigned int *option_types_found,
+                      struct env_set *es)
+{
+    msg(D_PUSH, "OPTIONS IMPORT: reading client specific options from: %s"=
, filename);
+    read_config_file(o,
+                     filename,
+                     0,
+                     filename,
+                     0,
+                     msglevel,
+                     permission_mask,
+                     option_types_found,
+                     es);
+}
+
+void
+options_string_import(struct options *options,
+                      const char *config,
+                      const int msglevel,
+                      const unsigned int permission_mask,
+                      unsigned int *option_types_found,
+                      struct env_set *es)
+{
+    read_config_string("[CONFIG-STRING]", options, config, msglevel, permi=
ssion_mask, option_types_found, es);
+}
+
 static void
 set_user_script(struct options *options,
                 const char **script,
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 2afd539..9d9f055 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -542,6 +542,11 @@
                 {
                     msg(M_WARN, "No updatable options found in incoming PU=
SH_UPDATE message");
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
index d17b285..5358e3a 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1291,6 +1291,60 @@
     }
 }

+void
+destroy_routes_v4(struct route_list *rl, const struct tuntap *tt,
+                  unsigned int flags, const struct env_set *es,
+                  openvpn_net_ctx_t *ctx, struct options *options)
+{
+    if (rl && (rl->iflags & RL_ROUTES_ADDED))
+    {
+        struct route_ipv4 *r;
+        for (r =3D rl->routes; r; r =3D r->next)
+        {
+            delete_route(r, tt, flags, &rl->rgi, es, ctx);
+        }
+        rl->iflags &=3D ~RL_ROUTES_ADDED;
+    }
+
+    undo_redirect_default_route_to_vpn(rl, tt, flags, es, ctx);
+
+    if (rl)
+    {
+        clear_route_list(rl);
+    }
+    if (options->routes)
+    {
+        options->routes->routes =3D NULL;
+        options->routes->flags =3D 0;
+    }
+}
+
+void
+destroy_routes_v6(struct route_ipv6_list *rl6, const struct tuntap *tt,
+                  unsigned int flags, const struct env_set *es,
+                  openvpn_net_ctx_t *ctx, struct options *options)
+{
+    if (rl6 && (rl6->iflags & RL_ROUTES_ADDED))
+    {
+        struct route_ipv6 *r6;
+        for (r6 =3D rl6->routes_ipv6; r6; r6 =3D r6->next)
+        {
+            delete_route_ipv6(r6, tt, flags, es, ctx);
+        }
+        rl6->iflags &=3D ~RL_ROUTES_ADDED;
+    }
+
+    if (rl6)
+    {
+        clear_route_ipv6_list(rl6);
+    }
+    if (options->routes_ipv6)
+    {
+        options->routes_ipv6->routes_ipv6 =3D NULL;
+        options->routes_ipv6->flags =3D 0;
+    }
+}
+
 #ifndef ENABLE_SMALL

 static const char *
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 421e7d2..b798c9d 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -321,6 +321,16 @@
                    const struct env_set *es,
                    openvpn_net_ctx_t *ctx);

+void
+destroy_routes_v4(struct route_list *rl, const struct tuntap *tt,
+                  unsigned int flags, const struct env_set *es,
+                  openvpn_net_ctx_t *ctx, struct options *options);
+
+void
+destroy_routes_v6(struct route_ipv6_list *rl6, const struct tuntap *tt,
+                  unsigned int flags, const struct env_set *es,
+                  openvpn_net_ctx_t *ctx, struct options *options);
+
 void setenv_routes(struct env_set *es, const struct route_list *rl);

 void setenv_routes_ipv6(struct env_set *es, const struct route_ipv6_list *=
rl6);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/809?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I507180d7397b6959844a30908010132bc3411067
Gerrit-Change-Number: 809
Gerrit-PatchSet: 10
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mrbff <marco@...2726...>
Gerrit-MessageType: newpatchset

--y+3dA8u4ETw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, mrbff, plaisthos. <=
/p>
<p>mrbff <strong>uploaded patch set #10</strong> to this change.</p><p><a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/809?usp=3Demail">View Change</=
a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;">PUSH_UPDATE: Added remove_option() and do_update().<br><br>* Added remov=
e_option() function and some utility functions to remove options at<br>  ru=
ntime following the push-update logic.<br>* Added do_update() function to c=
lose and reopen the tun and apply option updates.<br><br>Change-Id: I507180=
d7397b6959844a30908010132bc3411067<br>Signed-off-by: Marco Baffo &lt;marco@=
...2726...&gt;<br>---<br>M src/openvpn/init.c<br>M src/openvpn/init.h<br>M =
src/openvpn/multi.c<br>M src/openvpn/options.c<br>M src/openvpn/push.c<br>M=
 src/openvpn/route.c<br>M src/openvpn/route.h<br>7 files changed, 400 inser=
tions(+), 40 deletions(-)<br><br></pre><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418=
/openvpn refs/changes/09/809/10</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/init.c b/s=
rc/openvpn/init.c</span><br><span>index f8d9d06..9738d3b 100644</span><br><=
span>--- a/src/openvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</spa=
n><br><span>@@ -2445,7 +2445,7 @@</span><br><span> </span><br><span>       =
  if (pulled_options)</span><br><span>         {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            if (!do_deferred_options(c, option_t=
ypes_found))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     if (!do_deferred_options(c, option_types_found, false))</span><br><spa=
n>             {</span><br><span>                 msg(D_PUSH_ERRORS, &quot;=
ERROR: Failed to apply push options&quot;);</span><br><span>               =
  return false;</span><br><span>@@ -2567,6 +2567,55 @@</span><br><span>    =
 return true;</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+do_update(struct context *c, unsigned int option_types_foun=
d)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* Not necessary since to recei=
ve the update the openvpn</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * instance must be up and running but just in case</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (!c-&gt;c2.do_up_ran)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bo=
ol tt_dco_win =3D tuntap_is_dco_win(c-&gt;c1.tuntap);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (tt_dco_win)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        msg(M_NONFATAL, &quot;dco-win doesn&#39;t yet s=
upport reopening TUN device&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        return false;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!do_def=
erred_options(c, option_types_found, true))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        msg(D_PUSH_ERRORS, &quot;ERROR: Failed to apply push opti=
ons&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    do_close_tun(c, true);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    management_sleep(1);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    int error_flags =3D 0;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2.did_open_tun =3D do_open_t=
un(c, &amp;error_flags);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    update_time();</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;c=
2.did_open_tun)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* if --ro=
ute-delay was specified, start timer */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if ((route_order(c-&gt;c1.tuntap) =3D=3D ROUTE_=
AFTER_TUN) &amp;&amp; c-&gt;options.route_delay_defined)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            event_timeout_init(&amp;c-&gt;c2.rou=
te_wakeup, c-&gt;options.route_delay, now);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            event_timeout_init(&amp;c-&gt;c2.route_=
wakeup_expire, c-&gt;options.route_delay + c-&gt;options.route_delay_window=
, now);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
tun_standby_init(c-&gt;c1.tuntap);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        initia=
lization_sequence_completed(c, error_flags);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEA=
R(c-&gt;c1.pulled_options_digest_save);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*=
</span><br><span>  * These are the option categories which will be accepted=
 by pull.</span><br><span>  */</span><br><span>@@ -2645,11 +2694,8 @@</span=
><br><span>     return true;</span><br><span> }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * Handle non-tun-related pulled options.</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span> bool</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-do_deferred_options(struct=
 context *c, const unsigned int found)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+do_deferred_options(struct context *c, const unsigned in=
t found, const bool is_update)</span><br><span> {</span><br><span>     if (=
found &amp; OPT_P_MESSAGES)</span><br><span>     {</span><br><span>@@ -2745=
,7 +2791,7 @@</span><br><span>     /* process (potentially) pushed options =
*/</span><br><span>     if (c-&gt;options.pull)</span><br><span>     {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!check_pull_cl=
ient_ncp(c, found))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (!is_update &amp;&amp; !check_pull_client_ncp(c, found))</span><=
br><span>         {</span><br><span>             return false;</span><br><s=
pan>         }</span><br><span>diff --git a/src/openvpn/init.h b/src/openvp=
n/init.h</span><br><span>index ea7eb30..100f112 100644</span><br><span>--- =
a/src/openvpn/init.h</span><br><span>+++ b/src/openvpn/init.h</span><br><sp=
an>@@ -86,13 +86,29 @@</span><br><span>            bool pulled_options,</sp=
an><br><span>            unsigned int option_types_found);</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @brief A simplified version of =
the do_up() function. This function is called</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *        after receiving a successful PUSH_UPDAT=
E message. It closes and reopens</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *        the TUN device to apply the updated options.</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @param c The context structure.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param option_types_found =
The options found in the PUSH_UPDATE message.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @return true on success.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @return false on error.</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+bool do_update(struct context *c, unsigned int opt=
ion_types_found);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span> unsigned int pull_permission_mask(const struct context *c);=
</span><br><span> </span><br><span> const char *format_common_name(struct c=
ontext *c, struct gc_arena *gc);</span><br><span> </span><br><span> void re=
set_coarse_timers(struct context *c);</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-bool do_deferred_options(struct context *=
c, const unsigned int found);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Hand=
le non-tun-related pulled options.</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * Set `is_update` param to true to skip NCP check.</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+bool do_deferred_options(struct context *c, =
const unsigned int found, const bool is_update);</span><br><span> </span><b=
r><span> void inherit_context_child(struct context *dest,</span><br><span> =
                           const struct context *src);</span><br><span>diff=
 --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>index 45=
b3cfa..a9040a6 100644</span><br><span>--- a/src/openvpn/multi.c</span><br><=
span>+++ b/src/openvpn/multi.c</span><br><span>@@ -2409,7 +2409,7 @@</span>=
<br><span>     /*</span><br><span>      * Process sourced options.</span><b=
r><span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    d=
o_deferred_options(&amp;mi-&gt;context, option_types_found);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    do_deferred_options(&amp;mi-&g=
t;context, option_types_found, false);</span><br><span> </span><br><span>  =
   /*</span><br><span>      * make sure we got ifconfig settings from somew=
here</span><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/optio=
ns.c</span><br><span>index e417a99..bd00f65 100644</span><br><span>--- a/sr=
c/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br><=
span>@@ -1055,6 +1055,40 @@</span><br><span>         gc_free(&amp;gc);</spa=
n><br><span>     }</span><br><span> }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+delete_al=
l_dhcp_fo(struct options *o, struct env_item **list)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct env_item *current, *prev;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    ASSERT(list);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fo=
r (current =3D *list, prev =3D NULL; current !=3D NULL; current =3D current=
-&gt;next)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        char *tmp_value=
 =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (!strncmp(current-&gt;string, &quot;foreign_option_&quot;, sizeof(&quot;f=
oreign_option_&quot;)-1))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        tmp_value =3D strchr(current-&gt;string, &#39;=3D&#39;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            if (tmp_value &amp=
;&amp; ++tmp_value)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          if (!strncmp(tmp_value, &quot;dhcp-option &quot;, sizeof(&quot;dh=
cp-option &quot;)-1))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                    if (prev)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                        prev-&gt;next =3D current-&gt;next;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    e=
lse</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
          *list =3D current-&gt;next;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                    o-&gt;foreign_option_index--;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        prev =3D current;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> #endif /* ifndef _WIN32 */</span><br><span> </spa=
n><br><span> static in_addr_t</span><br><span>@@ -3260,8 +3294,16 @@</span>=
<br><span>         msg(M_INFO, &quot;Flag &#39;def1&#39; added to --redirec=
t-gateway (iservice is in use)&quot;);</span><br><span>         opt-&gt;rou=
tes-&gt;flags |=3D RG_DEF1;</span><br><span>     }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    else if (opt-&gt;routes</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+             &amp;&amp; ((opt-&gt;ro=
ute_method !=3D ROUTE_METHOD_SERVICE)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                 || !(opt-&gt;routes-&gt;flags &amp; RG_R=
EROUTE_GW))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
     &amp;&amp; (opt-&gt;routes-&gt;flags &amp; RG_DEF1))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        msg(M_INFO, &quot;Flag &#39;def1&#39; remov=
ed from --redirect-gateway&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        opt-&gt;routes-&gt;flags &amp;=3D ~RG_DEF1;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#endif /* ifdef _WIN32 */</span><br><s=
pan> </span><br><span> /*</span><br><span>  * Save/Restore certain option d=
efaults before --pull is applied.</span><br><span>@@ -5452,37 +5494,6 @@</s=
pan><br><span>     }</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-options_server_import(struct options *o,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                      const char *fil=
ename,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
       int msglevel,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                     unsigned int permission_mask,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                      unsigned int *option_typ=
es_found,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
          struct env_set *es)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_PU=
SH, &quot;OPTIONS IMPORT: reading client specific options from: %s&quot;, f=
ilename);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    read_con=
fig_file(o,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
           filename,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                    0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                     filename,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                     0,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                     msglevel,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                     permission_mask,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                     option_types_foun=
d,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
  es);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-options_string_import(struct options *options,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                      const char *config,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                      const =
int msglevel,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
              const unsigned int permission_mask,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                      unsigned int *option_type=
s_found,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
         struct env_set *es)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    read_conf=
ig_string(&quot;[CONFIG-STRING]&quot;, options, config, msglevel, permissio=
n_mask, option_types_found, es);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span> #define VERIFY_PERMISSION(mask) {                                 =
           \</span><br><span>         if (!verify_permission(p[0], file, li=
ne, (mask), permission_mask,        \</span><br><span>                     =
           option_types_found, msglevel, options, is_inline)) \</span><br><=
span>@@ -5585,6 +5596,188 @@</span><br><span>     return options-&gt;forwar=
d_compatible ? M_WARN : msglevel;</span><br><span> }</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @brief Resets options found in the PU=
SH_UPDATE message that are preceded by the `-` flag.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *        This function is used in push-u=
pdates to reset specified options.</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *        The number of parameters `p` must always be 1. If =
the permission is verified,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *        all related options are erased or reset to their default =
values.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *        Up=
on successful permission verification (by VERIFY_PERMISSION()),</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *        `option_types_found` =
is filled with the flag corresponding to the option.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param c The context structure.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param options A pointer to the option=
s structure.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am p An array of strings containing the options and their parameters.</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param is_inline A boo=
lean indicating if the option is inline.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param file The file where the function is called.<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param line The l=
ine number where the function is called.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param msglevel The message level.</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @param permission_mask The permis=
sion mask used by VERIFY_PERMISSION().</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * @param option_types_found A pointer to the variable w=
here the flags corresponding to the options found are stored.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param es The environment set =
structure.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+remove_option(struct context *c,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+              struct=
 options *options,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
             char *p[],</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+              bool is_inline,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+              const char *file,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+              int line,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+              const int msglevel,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+              const unsigned in=
t permission_mask,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
             unsigned int *option_types_found,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+              struct env_set *es)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    int msglevel_fc =3D msglevel_forward_compatible(=
options, msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (streq(p[0],=
 &quot;ifconfig&quot;) &amp;&amp; !p[1])</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        VERIFY_PERMISSION(OPT_P_UP);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        options-&gt;ifconfig_local =3D NULL;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;ifconf=
ig_remote_netmask =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    el=
se if (streq(p[0], &quot;ifconfig-ipv6&quot;) &amp;&amp; !p[1])</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_UP);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;ifconfig=
_ipv6_local =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        options-&gt;ifconfig_ipv6_netbits =3D 0;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        options-&gt;ifconfig_ipv6_remote =3D=
 NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &q=
uot;route&quot;) &amp;&amp; !p[1])</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        VERIFY_PERMISSION(OPT_P_ROUTE);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (c-&gt;c1.route_list)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            destroy_routes_v4(c-&gt;c1.route_list, =
c-&gt;c1.tuntap,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                           ROUTE_OPTION_FLAGS(&amp;c-&gt;options),</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
  es, &amp;c-&gt;net_ctx, options);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else=
 if (streq(p[0], &quot;route-ipv6&quot;) &amp;&amp; !p[1])</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_ROUTE);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (c-&gt;c1.route_ipv=
6_list)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            destroy_ro=
utes_v6(c-&gt;c1.route_ipv6_list, c-&gt;c1.tuntap,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                              ROUTE_OPTION_F=
LAGS(&amp;c-&gt;options),</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                              es, &amp;c-&gt;net_ctx, options);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;route-gateway&quot=
;) &amp;&amp; !p[1])</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        VERIF=
Y_PERMISSION(OPT_P_ROUTE_EXTRAS);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        options-&gt;route_gateway_via_dhcp =3D false;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;route_d=
efault_gateway =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else =
if (streq(p[0], &quot;route-metric&quot;) &amp;&amp; !p[1])</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_ROUTE);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;route_def=
ault_metric =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (st=
req(p[0], &quot;push-continuation&quot;) &amp;&amp; !p[1])</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_PULL_MODE);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;push_c=
ontinuation =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if ((s=
treq(p[0], &quot;redirect-gateway&quot;) || streq(p[0], &quot;redirect-priv=
ate&quot;)) &amp;&amp; !p[1])</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    VERIFY_PERMISSION(OPT_P_ROUTE);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (options-&gt;routes)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            options-&gt;routes-&gt;flags =3D 0;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if (options-&gt;routes_ipv6)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            options-&gt;routes_i=
pv6-&gt;flags =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0]=
, &quot;dns&quot;) &amp;&amp; !p[1])</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        VERIFY_PERMISSION(OPT_P_DHCPDNS);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        gc_free(&amp;options-&gt;dns_options.gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        CLEAR(option=
s-&gt;dns_options);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (s=
treq(p[0], &quot;topology&quot;) &amp;&amp; !p[1])</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_UP);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        options-&gt;topology =3D TOP_UNDE=
F;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        helper_se=
tdefault_topology(options);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    el=
se if (streq(p[0], &quot;tun-mtu&quot;) &amp;&amp; !p[1])</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_PUSH_MTU|OPT_P_CONN=
ECTION);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        opt=
ions-&gt;ce.tun_mtu =3D TUN_MTU_DEFAULT;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        options-&gt;ce.tun_mtu_defined =3D false;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;ce.o=
cc_mtu =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p=
[0], &quot;block-ipv6&quot;) &amp;&amp; !p[1])</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        VERIFY_PERMISSION(OPT_P_ROUTE);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        options-&gt;block_ipv6 =3D false;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#if defined(_WIN32) || defined(TA=
RGET_ANDROID)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    el=
se if (streq(p[0], &quot;dhcp-option&quot;) &amp;&amp; !p[1])</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        struct tuntap_options *o =3D &amp;optio=
ns-&gt;tuntap_options;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        VERIFY_PERMISSION(OPT_P_DHCPDNS);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        o-&gt;domain =3D NULL;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        o-&gt;netbios_scope =3D NULL;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        o-&gt;netbios_node_type =3D 0;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        o-&gt;dns6_le=
n =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mem=
set(o-&gt;dns6, 0, sizeof(o-&gt;dns6));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        o-&gt;dns_len =3D 0;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        memset(o-&gt;dns, 0, sizeof(o-&gt;dns)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        o-&gt;win=
s_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 memset(o-&gt;wins, 0, sizeof(o-&gt;wins));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        o-&gt;ntp_len =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        memset(o-&gt;ntp, 0, sizeof(o-&gt=
;ntp));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        o-&g=
t;nbdd_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      memset(o-&gt;nbdd, 0, sizeof(o-&gt;nbdd));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        while (o-&gt;domain_search_list_len-- =
&gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            o-&gt;doma=
in_search_list[o-&gt;domain_search_list_len] =3D NULL;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        o-&gt;disable_nbt =3D 0;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        o-&gt;dhcp_options =3D 0;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_ANDR=
OID)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        o-&gt;h=
ttp_proxy_port =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        o-&gt;http_proxy =3D NULL;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* =
if defined(_WIN32) || defined(TARGET_ANDROID) */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#ifdef _WIN32</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;block-outside-dns&quo=
t;) &amp;&amp; !p[1])</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        VERI=
FY_PERMISSION(OPT_P_DHCPDNS);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        options-&gt;block_outside_dns =3D false;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#else /* ifdef _WIN32 */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;dhcp-option&qu=
ot;) &amp;&amp; !p[1])</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        VER=
IFY_PERMISSION(OPT_P_DHCPDNS);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        delete_all_dhcp_fo(options, &amp;es-&gt;list);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    int i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
nt msglevel_unknown =3D msglevel_fc;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        /* Check if an option is in --ignore-unknown-optio=
n and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * set=
 warning level to non fatal */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        for (i =3D 0; options-&gt;ignore_unknown_option &amp;&am=
p; options-&gt;ignore_unknown_option[i]; i++)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            if (streq(p[0], options-&gt;ignore_unknown_opti=
on[i]))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                ms=
glevel_unknown =3D M_WARN;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                break;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  msg(msglevel_unknown, &quot;Unrecognized option or missing or extra param=
eter(s) in %s:%d: -%s (%s)&quot;, file, line, p[0], PACKAGE_VERSION);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+err:</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    msg(msglevel, &quot;Error occurred trying to remove %s opt=
ion&quot;, p[0]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span> bool</span><br><span> apply_push_options(struct context *c=
,</span><br><span>                    struct options *options,</span><br><s=
pan>@@ -5618,11 +5811,47 @@</span><br><span>                 add_option(opt=
ions, p, false, file, line_num, 0, msglevel,</span><br><span>              =
              permission_mask, option_types_found, es);</span><br><span>   =
          }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    else if (push_update_option_flags &amp; PUSH_OPT_TO_REMOVE)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                remove_option(c, opti=
ons, p, false, file, line_num, msglevel,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                              permission_mask, option_=
types_found, es);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          }</span><br><span>         }</span><br><span>     }</span><br><sp=
an>     return true;</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+options_server_import(struct options *o,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                      const cha=
r *filename,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
               int msglevel,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                      unsigned int permission_mask,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                      unsigned int=
 *option_types_found,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                      struct env_set *es)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    msg(D_PUSH, &quot;OPTIONS IMPORT: reading client specific options=
 from: %s&quot;, filename);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    read_config_file(o,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                     filename,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                     0,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                     filename,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                     0,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                     msglevel,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                     p=
ermission_mask,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                 option_types_found,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                     es);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+options_string_import(struct =
options *options,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                    const char *config,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                      const int msglevel,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                      const unsig=
ned int permission_mask,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                      unsigned int *option_types_found,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                      struct env_s=
et *es)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    read_config_string(&quot;[=
CONFIG-STRING]&quot;, options, config, msglevel, permission_mask, option_ty=
pes_found, es);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> stat=
ic void</span><br><span> set_user_script(struct options *options,</span><br=
><span>                 const char **script,</span><br><span>diff --git a/s=
rc/openvpn/push.c b/src/openvpn/push.c</span><br><span>index 2afd539..9d9f0=
55 100644</span><br><span>--- a/src/openvpn/push.c</span><br><span>+++ b/sr=
c/openvpn/push.c</span><br><span>@@ -542,6 +542,11 @@</span><br><span>     =
            {</span><br><span>                     msg(M_WARN, &quot;No upd=
atable options found in incoming PUSH_UPDATE message&quot;);</span><br><spa=
n>                 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                else if (!do_update(c, option_types_found))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                    msg(D_PUSH_ERROR=
S, &quot;Failed to update options&quot;);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    goto error;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span>       =
      }</span><br><span>         }</span><br><span>         event_timeout_c=
lear(&amp;c-&gt;c2.push_request_interval);</span><br><span>diff --git a/src=
/openvpn/route.c b/src/openvpn/route.c</span><br><span>index d17b285..5358e=
3a 100644</span><br><span>--- a/src/openvpn/route.c</span><br><span>+++ b/s=
rc/openvpn/route.c</span><br><span>@@ -1291,6 +1291,60 @@</span><br><span> =
    }</span><br><span> }</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+destroy_routes_v4(struct route_list *rl, const struct tuntap *tt,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  uns=
igned int flags, const struct env_set *es,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                  openvpn_net_ctx_t *ctx, struct opt=
ions *options)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (rl &amp;&amp; (=
rl-&gt;iflags &amp; RL_ROUTES_ADDED))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        struct route_ipv4 *r;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        for (r =3D rl-&gt;routes; r; r =3D r-&gt;next)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            delete_route(r, tt, flag=
s, &amp;rl-&gt;rgi, es, ctx);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        rl-&gt;iflags &amp;=3D ~RL_ROUTES_ADDED;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
undo_redirect_default_route_to_vpn(rl, tt, flags, es, ctx);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (rl)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       clear_route_list(rl);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (options-&gt;routes)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        opt=
ions-&gt;routes-&gt;routes =3D NULL;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        options-&gt;routes-&gt;flags =3D 0;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+destroy_routes_v6(struct =
route_ipv6_list *rl6, const struct tuntap *tt,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                  unsigned int flags, const stru=
ct env_set *es,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
              openvpn_net_ctx_t *ctx, struct options *options)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (rl6 &amp;&amp; (rl6-&gt;iflags &amp; RL_RO=
UTES_ADDED))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct route_=
ipv6 *r6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fo=
r (r6 =3D rl6-&gt;routes_ipv6; r6; r6 =3D r6-&gt;next)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            delete_route_ipv6(r6, tt, flags, es, c=
tx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        rl6-&gt;iflags &a=
mp;=3D ~RL_ROUTES_ADDED;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (rl6)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        clear_route_ipv6_list(rl6);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (options-&gt;routes_ipv6)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        options-&gt;routes_ipv6-&gt;routes_ipv6 =
=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        op=
tions-&gt;routes_ipv6-&gt;flags =3D 0;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan> #ifndef ENABLE_SMALL</span><br><span> </span><br><span> static const c=
har *</span><br><span>diff --git a/src/openvpn/route.h b/src/openvpn/route.=
h</span><br><span>index 421e7d2..b798c9d 100644</span><br><span>--- a/src/o=
penvpn/route.h</span><br><span>+++ b/src/openvpn/route.h</span><br><span>@@=
 -321,6 +321,16 @@</span><br><span>                    const struct env_set=
 *es,</span><br><span>                    openvpn_net_ctx_t *ctx);</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+destroy_routes_v4(struct =
route_list *rl, const struct tuntap *tt,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                  unsigned int flags, const struct env=
_set *es,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
        openvpn_net_ctx_t *ctx, struct options *options);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+destroy_routes_v6(struct route_ipv6_list *rl6, const struct tuntap *tt,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  u=
nsigned int flags, const struct env_set *es,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                  openvpn_net_ctx_t *ctx, struct o=
ptions *options);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span> void setenv_routes(struct env_set *es, const struct route_l=
ist *rl);</span><br><span> </span><br><span> void setenv_routes_ipv6(struct=
 env_set *es, const struct route_ipv6_list *rl6);</span><br><span></span><b=
r></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
809?usp=3Demail">change 809</a>. To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.<=
/p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemp=
rop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/809?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I507180d7397b6959844a3090801=
0132bc3411067 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 809 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: mrbff &lt;marco@...2726...&g=
t; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--y+3dA8u4ETw=--

