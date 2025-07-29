From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 29 Jul 2025 13:34:37 +0000
In-Reply-To: <gerrit.1732124549000.I507180d7397b6959844a30908010132bc3411067@...2715...>
References: <gerrit.1732124549000.I507180d7397b6959844a30908010132bc3411067@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., marco@...2726...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <4f23b4e64e5c4a334f10fa25770009e1f8e04a4c-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VqP1cWTrP1g="; charset=UTF-8
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
To: mrbff <marco@...2726...>
Cc: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--VqP1cWTrP1g=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/80=
9?usp=3Demail )

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
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250729104056.27634-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
407.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/init.c
M src/openvpn/init.h
M src/openvpn/multi.c
M src/openvpn/options.c
M src/openvpn/push.c
M src/openvpn/route.c
M src/openvpn/route.h
7 files changed, 350 insertions(+), 11 deletions(-)




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
@@ -2672,11 +2721,8 @@
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
@@ -2784,7 +2830,10 @@
     /* process (potentially) pushed options */
     if (c->options.pull)
     {
-        if (!check_pull_client_ncp(c, found))
+        /* On PUSH_UPDATE, NCP related flags are never updated, and so the=
 code
+         * would assume "no cipher pushed =3D NCP failed" - so, don't call=
 it on
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
index eb53a60..469360d 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1077,6 +1077,40 @@
     }
     gc_free(&gc);
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

 static in_addr_t
@@ -3082,7 +3116,7 @@
         opt->routes->flags |=3D RG_DEF1;
     }
 }
-#endif
+#endif /* ifdef _WIN32 */

 /*
  * Save/Restore certain option defaults before --pull is applied.
@@ -5314,6 +5348,18 @@
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
@@ -5539,6 +5585,11 @@
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
@@ -5677,6 +5728,199 @@
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
+            delete_routes_v4(c->c1.route_list, c->c1.tuntap,
+                             ROUTE_OPTION_FLAGS(&c->options),
+                             es, &c->net_ctx);
+            if (options->routes)
+            {
+                options->routes->routes =3D NULL;
+                options->routes->flags =3D 0;
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
+                options->routes_ipv6->routes_ipv6 =3D NULL;
+                options->routes_ipv6->flags =3D 0;
+            }
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
         for (r =3D rl->routes; r; r =3D r->next)
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
         for (r6 =3D rl6->routes_ipv6; r6; r6 =3D r6->next)
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
Gerrit-PatchSet: 24
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--VqP1cWTrP1g=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/809?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">PUSH_UPDATE: Added remove_option() and do_upda=
te().<br><br>* Added remove_option() function and some utility functions to=
 remove options at<br>  runtime following the push-update logic.<br>* Added=
 do_update() function to close and reopen the tun and apply option updates.=
<br><br>Change-Id: I507180d7397b6959844a30908010132bc3411067<br>Signed-off-=
by: Marco Baffo &lt;marco@...2726...&gt;<br>Acked-by: Gert Doering &lt;gert=
@...1296...&gt;<br>Message-Id: &lt;20250729104056.27634-1-gert@...1296...&g=
t;<br>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net=
/msg32407.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>--=
-<br>M src/openvpn/init.c<br>M src/openvpn/init.h<br>M src/openvpn/multi.c<=
br>M src/openvpn/options.c<br>M src/openvpn/push.c<br>M src/openvpn/route.c=
<br>M src/openvpn/route.h<br>7 files changed, 350 insertions(+), 11 deletio=
ns(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>ind=
ex ba1dda4..3254cc6 100644</span><br><span>--- a/src/openvpn/init.c</span><=
br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -2470,7 +2470,7 @@</sp=
an><br><span> </span><br><span>         if (pulled_options)</span><br><span=
>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  if (!do_deferred_options(c, option_types_found))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            if (!do_deferred_options(c, opti=
on_types_found, false))</span><br><span>             {</span><br><span>    =
             msg(D_PUSH_ERRORS, &quot;ERROR: Failed to apply push options&q=
uot;);</span><br><span>                 return false;</span><br><span>@@ -2=
594,6 +2594,55 @@</span><br><span>     return true;</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+do_update(struct cont=
ext *c, unsigned int option_types_found)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* Not necessary since to receive the update the openvpn</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * instance must be up and =
running but just in case</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(!c-&gt;c2.do_up_ran)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bool tt_dco_win =3D tuntap_is_dco_win=
(c-&gt;c1.tuntap);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (tt_dco_win)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_N=
ONFATAL, &quot;dco-win doesn&#39;t yet support reopening TUN device&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return fals=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (!do_deferred_options(c, option_types_found=
, true))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_PUSH_ERRORS=
, &quot;ERROR: Failed to apply push options&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    do_close_tun(c, true);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    manag=
ement_sleep(1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
int error_flags =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    c-&gt;c2.did_open_tun =3D do_open_tun(c, &amp;error_flags);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    update_time();</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (c-&gt;c2.did_open_tun)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        /* if --route-delay was specified, start ti=
mer */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if ((=
route_order(c-&gt;c1.tuntap) =3D=3D ROUTE_AFTER_TUN) &amp;&amp; c-&gt;optio=
ns.route_delay_defined)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      event_timeout_init(&amp;c-&gt;c2.route_wakeup, c-&gt;options.route_de=
lay, now);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   event_timeout_init(&amp;c-&gt;c2.route_wakeup_expire, c-&gt;options.rout=
e_delay + c-&gt;options.route_delay_window, now);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            tun_standby_init(c-&gt;c1.tuntap)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        initialization_sequence_completed(c, er=
ror_flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    CLEAR(c-&gt;c1.pulled_options_digest_=
save);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * These are th=
e option categories which will be accepted by pull.</span><br><span>  */</s=
pan><br><span>@@ -2672,11 +2721,8 @@</span><br><span>     return true;</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Handl=
e non-tun-related pulled options.</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- */</span><br><span> bool</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-do_deferred_options(struct context *c, const unsigned int f=
ound)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+do_deferred_op=
tions(struct context *c, const unsigned int found, const bool is_update)</s=
pan><br><span> {</span><br><span>     if (found &amp; OPT_P_MESSAGES)</span=
><br><span>     {</span><br><span>@@ -2784,7 +2830,10 @@</span><br><span>  =
   /* process (potentially) pushed options */</span><br><span>     if (c-&g=
t;options.pull)</span><br><span>     {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        if (!check_pull_client_ncp(c, found))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        /* On PUSH_UPDATE, NCP r=
elated flags are never updated, and so the code</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+         * would assume &quot;no cipher pushed =
=3D NCP failed&quot; - so, don&#39;t call it on</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+         * updates */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (!is_update &amp;&amp; !check_pull=
_client_ncp(c, found))</span><br><span>         {</span><br><span>         =
    return false;</span><br><span>         }</span><br><span>diff --git a/s=
rc/openvpn/init.h b/src/openvpn/init.h</span><br><span>index 5c6b9c1..25078=
a6 100644</span><br><span>--- a/src/openvpn/init.h</span><br><span>+++ b/sr=
c/openvpn/init.h</span><br><span>@@ -86,13 +86,29 @@</span><br><span>      =
      bool pulled_options,</span><br><span>            unsigned int option_=
types_found);</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
brief A simplified version of the do_up() function. This function is called=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *        after rec=
eiving a successful PUSH_UPDATE message. It closes and reopens</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *        the TUN device to appl=
y the updated options.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param c Th=
e context structure.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @param option_types_found The options found in the PUSH_UPDATE message.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true on =
success.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return =
false on error.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool do_update(struc=
t context *c, unsigned int option_types_found);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> unsigned int pull_permission_=
mask(const struct context *c);</span><br><span> </span><br><span> const cha=
r *format_common_name(struct context *c, struct gc_arena *gc);</span><br><s=
pan> </span><br><span> void reset_coarse_timers(struct context *c);</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool do_def=
erred_options(struct context *c, const unsigned int found);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * Handle non-tun-related pulled options.</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * Set `is_update` param to tr=
ue to skip NCP check.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool do_deferr=
ed_options(struct context *c, const unsigned int found, const bool is_updat=
e);</span><br><span> </span><br><span> void inherit_context_child(struct co=
ntext *dest,</span><br><span>                            const struct conte=
xt *src,</span><br><span>diff --git a/src/openvpn/multi.c b/src/openvpn/mul=
ti.c</span><br><span>index b2d2b6c..68b4da6 100644</span><br><span>--- a/sr=
c/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><br><span=
>@@ -2424,7 +2424,7 @@</span><br><span>     /*</span><br><span>      * Proc=
ess sourced options.</span><br><span>      */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    do_deferred_options(&amp;mi-&gt;context, option=
_types_found);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    d=
o_deferred_options(&amp;mi-&gt;context, option_types_found, false);</span><=
br><span> </span><br><span>     /*</span><br><span>      * make sure we got=
 ifconfig settings from somewhere</span><br><span>diff --git a/src/openvpn/=
options.c b/src/openvpn/options.c</span><br><span>index eb53a60..469360d 10=
0644</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/=
openvpn/options.c</span><br><span>@@ -1077,6 +1077,40 @@</span><br><span>  =
   }</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+delete_all_dhcp_fo(struct options *o, struct env_item **lis=
t)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct env_item *current, *prev=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    ASSERT(list);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    for (current =3D *list, prev =3D NULL; current !=3D NU=
LL; current =3D current-&gt;next)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        char *tmp_value =3D NULL;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        if (!strncmp(current-&gt;string, &quot;foreign_option=
_&quot;, sizeof(&quot;foreign_option_&quot;)-1))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            tmp_value =3D strchr(current-&gt;string, &#3=
9;=3D&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     if (tmp_value &amp;&amp; ++tmp_value)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                if (!strncmp(tmp_value, &quot;dhcp-option =
&quot;, sizeof(&quot;dhcp-option &quot;)-1))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                    if (prev)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                        prev-&gt;next =
=3D current-&gt;next;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                    else</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                        *list =3D current-&gt;next;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                    o-&gt;fore=
ign_option_index--;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        prev =3D c=
urrent;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* ifndef _WIN32 */=
</span><br><span> </span><br><span> static in_addr_t</span><br><span>@@ -30=
82,7 +3116,7 @@</span><br><span>         opt-&gt;routes-&gt;flags |=3D RG_D=
EF1;</span><br><span>     }</span><br><span> }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif /* ifdef _WIN32 */</span><br><span> </span><br><span> /*=
</span><br><span>  * Save/Restore certain option defaults before --pull is =
applied.</span><br><span>@@ -5314,6 +5348,18 @@</span><br><span>           =
 struct env_set *es);</span><br><span> </span><br><span> static void</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+remove_option(struct conte=
xt *c,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
 struct options *options,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+              char *p[],</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+              bool is_inline,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+              const char *file,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+              int line,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+              const int msglevel,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+              const uns=
igned int permission_mask,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+              unsigned int *option_types_found,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+              struct env_set *es);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static void</span><br><span> read_config_fil=
e(struct options *options,</span><br><span>                  const char *fi=
le,</span><br><span>                  int level,</span><br><span>@@ -5539,6=
 +5585,11 @@</span><br><span>                 add_option(options, p, false,=
 file, line_num, 0, msglevel,</span><br><span>                            p=
ermission_mask, option_types_found, es);</span><br><span>             }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            else if (pu=
sh_update_option_flags &amp; PUSH_OPT_TO_REMOVE)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                remove_option(c, options, p, false, =
file, line_num, msglevel,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                              permission_mask, option_types_found, es=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</sp=
an><br><span>         }</span><br><span>     }</span><br><span>     return =
true;</span><br><span>@@ -5677,6 +5728,199 @@</span><br><span>     return o=
ptions-&gt;forward_compatible ? M_WARN : msglevel;</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @brief Resets option=
s found in the PUSH_UPDATE message that are preceded by the `-` flag.</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *        This function i=
s used in push-updates to reset specified options.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *        The number of parameters `p` must =
always be 1. If the permission is verified,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *        all related options are erased or reset t=
o their default values.</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *        Upon successful permission verification (by VERIFY_PERMISSION=
()),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *        `opti=
on_types_found` is filled with the flag corresponding to the option.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param c The context structure.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param options A pointe=
r to the options structure.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param p An array of strings containing the options and their pa=
rameters.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param =
is_inline A boolean indicating if the option is inline.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @param file The file where the funct=
ion is called.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram line The line number where the function is called.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @param msglevel The message level.</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param permission_=
mask The permission mask used by VERIFY_PERMISSION().</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param option_types_found A pointer to=
 the variable where the flags corresponding to the options found are stored=
.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param es The e=
nvironment set structure.</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static voi=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+remove_option(stru=
ct context *c,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
         struct options *options,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+              char *p[],</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+              bool is_inline,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+              const char *file,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+              int line,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+              const int msglev=
el,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              co=
nst unsigned int permission_mask,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+              unsigned int *option_types_found,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+              struct env_set *es)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    int msglevel_fc =3D msglevel_forw=
ard_compatible(options, msglevel);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (streq(p[0], &quot;ifconfig&quot;) &amp;&amp; !p[1])</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_UP);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;ifconfig_local =
=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        op=
tions-&gt;ifconfig_remote_netmask =3D NULL;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    else if (streq(p[0], &quot;ifconfig-ipv6&quot;) &amp;&amp; !p=
[1])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT=
_P_UP);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        opti=
ons-&gt;ifconfig_ipv6_local =3D NULL;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        options-&gt;ifconfig_ipv6_netbits =3D 0;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;ifconfig=
_ipv6_remote =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if=
 (streq(p[0], &quot;route&quot;) &amp;&amp; !p[1])</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_ROUTE);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if (c-&gt;c1.route_list)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            delete_routes_v4(c-&gt;=
c1.route_list, c-&gt;c1.tuntap,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                             ROUTE_OPTION_FLAGS(&amp;c-&gt;opti=
ons),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
               es, &amp;c-&gt;net_ctx);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            if (options-&gt;routes)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                options-&gt;routes-&gt;routes=
 =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       options-&gt;routes-&gt;flags =3D 0;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    els=
e if (streq(p[0], &quot;route-ipv6&quot;) &amp;&amp; !p[1])</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_ROUTE);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (c-&gt;c1.route_ip=
v6_list)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            delete_ro=
utes_v6(c-&gt;c1.route_ipv6_list, c-&gt;c1.tuntap,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                             ROUTE_OPTION_FL=
AGS(&amp;c-&gt;options),</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                             es, &amp;c-&gt;net_ctx);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            if (options-&gt;routes_i=
pv6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                optio=
ns-&gt;routes_ipv6-&gt;routes_ipv6 =3D NULL;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                options-&gt;routes_ipv6-&gt;flags =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;route-gate=
way&quot;) &amp;&amp; !p[1])</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   VERIFY_PERMISSION(OPT_P_ROUTE_EXTRAS);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        options-&gt;route_gateway_via_dhcp =3D false;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt=
;route_default_gateway =3D NULL;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   else if (streq(p[0], &quot;route-metric&quot;) &amp;&amp; !p[1])</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_ROUTE);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;r=
oute_default_metric =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    els=
e if (streq(p[0], &quot;push-continuation&quot;) &amp;&amp; !p[1])</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_PULL_MODE=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&=
gt;push_continuation =3D 0;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    el=
se if ((streq(p[0], &quot;redirect-gateway&quot;) || streq(p[0], &quot;redi=
rect-private&quot;)) &amp;&amp; !p[1])</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        VERIFY_PERMISSION(OPT_P_ROUTE);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (options-&gt;routes)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            options-&gt;routes-&gt;flags =3D 0;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (options-&gt;routes=
_ipv6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            options-&gt=
;routes_ipv6-&gt;flags =3D 0;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (s=
treq(p[0], &quot;dns&quot;) &amp;&amp; !p[1])</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        VERIFY_PERMISSION(OPT_P_DHCPDNS);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;options-&gt;dns_opti=
ons.gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        CLE=
AR(options-&gt;dns_options);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    e=
lse if (streq(p[0], &quot;topology&quot;) &amp;&amp; !p[1])</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_UP);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;topology =3D=
 TOP_UNDEF;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
helper_setdefault_topology(options);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    else if (streq(p[0], &quot;tun-mtu&quot;) &amp;&amp; !p[1])</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_PUSH_MTU|=
OPT_P_CONNECTION);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       options-&gt;ce.tun_mtu =3D TUN_MTU_DEFAULT;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        options-&gt;ce.tun_mtu_defined =3D f=
alse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        option=
s-&gt;ce.occ_mtu =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else i=
f (streq(p[0], &quot;block-ipv6&quot;) &amp;&amp; !p[1])</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_ROUTE);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;block_ipv6 =
=3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(_WIN32) || =
defined(TARGET_ANDROID)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    else if (streq(p[0], &quot;dhcp-option&quot;) &amp;&amp; !p[1])</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        struct tuntap_options *o =3D =
&amp;options-&gt;tuntap_options;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        VERIFY_PERMISSION(OPT_P_DHCPDNS);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        o-&gt;domain =3D NULL;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        o-&gt;netbios_scope =3D NULL;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        o-&gt;netbios_node_typ=
e =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        o-&=
gt;dns6_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       memset(o-&gt;dns6, 0, sizeof(o-&gt;dns6));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        o-&gt;dns_len =3D 0;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        memset(o-&gt;dns, 0, sizeof(=
o-&gt;dns));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 o-&gt;wins_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        memset(o-&gt;wins, 0, sizeof(o-&gt;wins));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        o-&gt;ntp_len =3D 0;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        memset(o-&gt;ntp, 0, siz=
eof(o-&gt;ntp));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     o-&gt;nbdd_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        memset(o-&gt;nbdd, 0, sizeof(o-&gt;nbdd));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        while (o-&gt;domain_search_li=
st_len-- &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            o=
-&gt;domain_search_list[o-&gt;domain_search_list_len] =3D NULL;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        o-&gt;disable_nbt =3D 0;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        o-&gt;dhcp_options =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(T=
ARGET_ANDROID)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   o-&gt;http_proxy_port =3D 0;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        o-&gt;http_proxy =3D NULL;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif /* if defined(_WIN32) || defined(TARGET_ANDROID) */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#ifdef _WIN32</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;block-outs=
ide-dns&quot;) &amp;&amp; !p[1])</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       VERIFY_PERMISSION(OPT_P_DHCPDNS);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        options-&gt;block_outside_dns =3D false;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#else /* ifdef _WIN32 */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;dhc=
p-option&quot;) &amp;&amp; !p[1])</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        VERIFY_PERMISSION(OPT_P_DHCPDNS);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        delete_all_dhcp_fo(options, &amp;es-&gt;list)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        int i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        int msglevel_unknown =3D msglevel_fc;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        /* Check if an option is in --ignore-unkn=
own-option and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
    * set warning level to non fatal */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        for (i =3D 0; options-&gt;ignore_unknown_option=
 &amp;&amp; options-&gt;ignore_unknown_option[i]; i++)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            if (streq(p[0], options-&gt;ignore_unk=
nown_option[i]))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       msglevel_unknown =3D M_WARN;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                break;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        msg(msglevel_unknown, &quot;Unrecognized option or missing or ex=
tra parameter(s) in %s:%d: -%s (%s)&quot;, file, line, p[0], PACKAGE_VERSIO=
N);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+err:</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    msg(msglevel, &quot;Error occurred trying to remo=
ve %s option&quot;, p[0]);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span> static void</span><br><span> set_user_script(struct options *options=
,</span><br><span>                 const char **script,</span><br><span>dif=
f --git a/src/openvpn/push.c b/src/openvpn/push.c</span><br><span>index 858=
b821..22082a9 100644</span><br><span>--- a/src/openvpn/push.c</span><br><sp=
an>+++ b/src/openvpn/push.c</span><br><span>@@ -542,6 +542,11 @@</span><br>=
<span>                 {</span><br><span>                     msg(M_WARN, &=
quot;No updatable options found in incoming PUSH_UPDATE message&quot;);</sp=
an><br><span>                 }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                else if (!do_update(c, option_types_found))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                    msg(D=
_PUSH_ERRORS, &quot;Failed to update options&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    goto error;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                }</span><br><=
span>             }</span><br><span>         }</span><br><span>         eve=
nt_timeout_clear(&amp;c-&gt;c2.push_request_interval);</span><br><span>diff=
 --git a/src/openvpn/route.c b/src/openvpn/route.c</span><br><span>index 15=
6262a..89ebaee 100644</span><br><span>--- a/src/openvpn/route.c</span><br><=
span>+++ b/src/openvpn/route.c</span><br><span>@@ -1265,7 +1265,16 @@</span=
><br><span>               const struct tuntap *tt, unsigned int flags,</spa=
n><br><span>               const struct env_set *es, openvpn_net_ctx_t *ctx=
)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (rl &amp;&amp; rl-&gt;iflags &amp; RL_ROUTES_ADDED)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    delete_routes_v4(rl, tt, flags, e=
s, ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    delete_=
routes_v6(rl6, tt, flags, es, ctx);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+delete_routes_v4(struct route_list *=
rl, const struct tuntap *tt,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                 unsigned int flags, const struct env_set *es,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                 openvp=
n_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (rl &amp;&amp=
; (rl-&gt;iflags &amp; RL_ROUTES_ADDED))</span><br><span>     {</span><br><=
span>         struct route_ipv4 *r;</span><br><span>         for (r =3D rl-=
&gt;routes; r; r =3D r-&gt;next)</span><br><span>@@ -1281,8 +1290,14 @@</sp=
an><br><span>     {</span><br><span>         clear_route_list(rl);</span><b=
r><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if =
(rl6 &amp;&amp; (rl6-&gt;iflags &amp; RL_ROUTES_ADDED) )</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+delete_routes_v6(struct route_ipv6_list *rl6, const s=
truct tuntap *tt,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
               unsigned int flags, const struct env_set *es,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                 openvpn_net_ctx_t=
 *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (rl6 &amp;&amp; (rl6-&gt=
;iflags &amp; RL_ROUTES_ADDED))</span><br><span>     {</span><br><span>    =
     struct route_ipv6 *r6;</span><br><span>         for (r6 =3D rl6-&gt;ro=
utes_ipv6; r6; r6 =3D r6-&gt;next)</span><br><span>diff --git a/src/openvpn=
/route.h b/src/openvpn/route.h</span><br><span>index 237375c..b89ec9f 10064=
4</span><br><span>--- a/src/openvpn/route.h</span><br><span>+++ b/src/openv=
pn/route.h</span><br><span>@@ -335,6 +335,16 @@</span><br><span>           =
         const struct env_set *es,</span><br><span>                    open=
vpn_net_ctx_t *ctx);</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+delete_routes_v4(struct route_list *rl, const struct tuntap *tt,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                 unsigned =
int flags, const struct env_set *es,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                 openvpn_net_ctx_t *ctx);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+delete_routes_v6(struct route_ipv6_list *rl6, const struct tuntap *tt,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 un=
signed int flags, const struct env_set *es,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                 openvpn_net_ctx_t *ctx);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void setenv=
_routes(struct env_set *es, const struct route_list *rl);</span><br><span> =
</span><br><span> void setenv_routes_ipv6(struct env_set *es, const struct =
route_ipv6_list *rl6);</span><br><span></span><br></pre><p>To view, visit <=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/809?usp=3Demail">change 809=
</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tp://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/809?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I507180d7397b6959844a3090801=
0132bc3411067 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 809 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 24 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--VqP1cWTrP1g=--

