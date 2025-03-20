From: "d12fk (Code Review)" <gerrit@...515...>
Date: Thu, 20 Mar 2025 02:51:34 +0000
In-Reply-To: <gerrit.1741299308000.I635c4018fb43b5976a39b6a90cb2e9cb2570cd6a@...2715...>
References: <gerrit.1741299308000.I635c4018fb43b5976a39b6a90cb2e9cb2570cd6a@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <c706c56d1226640c0e83bf9995374d044d1ac392-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zvOU3wwFghI="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dns: deal with
 --dhcp-options when --dns is active
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--zvOU3wwFghI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/904?usp=3Demail

to look at the new patch set (#8).


Change subject: dns: deal with --dhcp-options when --dns is active
......................................................................

dns: deal with --dhcp-options when --dns is active

Since --dns settings overrule DNS related --dhcp-options,
remove the latter when values were defined via --dns.

To stay as backward compatible as possible, we add foreign_options to
the script hook environment from the --dns values when a --up script
is defined. In that case the default --dns-updown is not run, even
when --dns values are present, to prevent double DNS configuration.
This way an existing --up script that deals with DNS can run, without
the immediate need to change after an openvpn upgrade and a server
pushing --dns options.

If you specify a custom --dns-updown, or force running the default
dns-updown that comes with openvpn, those compat env vars are not set
for --up scripts and the dns-updown command is run, even when there's
an --up script present.

Since Android uses the DNS values from tuntap_options, we always
override those with --dns stuff unconditionally.

Change-Id: I635c4018fb43b5976a39b6a90cb2e9cb2570cd6a
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M doc/man-sections/script-options.rst
M src/openvpn/dns.c
M src/openvpn/options.c
3 files changed, 231 insertions(+), 158 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/04/904/8

diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/script-=
options.rst
index 8285122..765518a 100644
--- a/doc/man-sections/script-options.rst
+++ b/doc/man-sections/script-options.rst
@@ -258,9 +258,11 @@
   Note that DNS-related ``--dhcp-option``\ s will not be handled by this h=
ook.
   If any ``--dns server`` option is present, DNS-related ``--dhcp-option``=
\ s will
   be ignored. If an ``--up`` script is defined, foreign_option env vars wi=
ll be
-  generated from ``--dns`` options and passed to the script. The ``--dns-u=
pdown``
-  command is not run if a ``--up`` script is defined. Both is done for bac=
kward
-  compatibility.
+  generated from ``--dns`` options and passed to the script for backward c=
ompatibility.
+
+  Also for backward compatibility, the ``--dns-updown`` command is not run=
 if a
+  ``--up`` script is defined, unless a user-defined ``dns-updown`` was spe=
cified,
+  or running the default updown is forced via the ``--dns-updown force`` o=
ption.

 --down cmd
   Run command ``cmd`` after TUN/TAP device close (post ``--user`` UID
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 0ad8e44..c654d78 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -703,7 +703,8 @@
 static void
 run_up_down_command(bool up, struct options *o, const struct tuntap *tt, s=
truct dns_updown_runner_info *updown_runner)
 {
-    if (!o->dns_options.updown)
+    struct dns_options *dns =3D &o->dns_options;
+    if (!dns->updown || (o->up_script && !dns->user_defined_updown))
     {
         return;
     }
@@ -713,7 +714,7 @@
     if (!updown_runner->required)
     {
         /* Run dns updown directly */
-        status =3D do_run_up_down_command(up, NULL, &o->dns_options, tt);
+        status =3D do_run_up_down_command(up, NULL, dns, tt);
     }
     else
     {
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 1a9c337..22c882b 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -530,7 +530,9 @@
     "                  sni <domain> : DNS server name indication\n"
     "--dns search-domains <domain> [domain ...]:\n"
     "                  Add domains to DNS domain search list\n"
-    "--dns-updown cmd|disable : Run cmd as user defined dns config command=
 or disable it\n"
+    "--dns-updown cmd|force|disable :\n"
+    "                  Run cmd as user defined dns config command, force r=
unning the\n"
+    "                  default one even when --up exists, or disable runni=
ng it.\n"
     "--auth-retry t  : How to handle auth failures.  Set t to\n"
     "                  none (default), interact, or nointeract.\n"
     "--static-challenge t e [<scrv1|concat>]: Enable static challenge/resp=
onse protocol using\n"
@@ -1374,149 +1376,6 @@
         }
     }
 }
-
-/*
- * If DNS options are set use these for TUN/TAP options as well.
- * Applies to DNS, DNS6 and DOMAIN-SEARCH.
- * Existing options will be discarded.
- */
-static void
-tuntap_options_copy_dns(struct options *o)
-{
-    struct tuntap_options *tt =3D &o->tuntap_options;
-    struct dns_options *dns =3D &o->dns_options;
-
-    if (dns->search_domains)
-    {
-        tt->domain_search_list_len =3D 0;
-        const struct dns_domain *domain =3D dns->search_domains;
-        while (domain && tt->domain_search_list_len < N_SEARCH_LIST_LEN)
-        {
-            tt->domain_search_list[tt->domain_search_list_len++] =3D domai=
n->name;
-            domain =3D domain->next;
-        }
-        if (domain)
-        {
-            msg(M_WARN, "WARNING: couldn't copy all --dns search-domains t=
o --dhcp-option");
-        }
-        tt->dhcp_options |=3D DHCP_OPTIONS_DHCP_REQUIRED;
-    }
-
-    if (dns->servers)
-    {
-        tt->dns_len =3D 0;
-        tt->dns6_len =3D 0;
-        bool overflow =3D false;
-        const struct dns_server *server =3D dns->servers;
-        while (server)
-        {
-            for (int i =3D 0; i < server->addr_count; ++i)
-            {
-                if (server->addr[i].family =3D=3D AF_INET)
-                {
-                    if (tt->dns_len >=3D N_DHCP_ADDR)
-                    {
-                        overflow =3D true;
-                        continue;
-                    }
-                    tt->dns[tt->dns_len++] =3D ntohl(server->addr[i].in.a4=
.s_addr);
-                }
-                else
-                {
-                    if (tt->dns6_len >=3D N_DHCP_ADDR)
-                    {
-                        overflow =3D true;
-                        continue;
-                    }
-                    tt->dns6[tt->dns6_len++] =3D server->addr[i].in.a6;
-                }
-            }
-            server =3D server->next;
-        }
-        if (overflow)
-        {
-            msg(M_WARN, "WARNING: couldn't copy all --dns server addresses=
 to --dhcp-option");
-        }
-        tt->dhcp_options |=3D DHCP_OPTIONS_DHCP_OPTIONAL;
-    }
-}
-#else /* if defined(_WIN32) || defined(TARGET_ANDROID) */
-static void
-foreign_options_copy_dns(struct options *o, struct env_set *es)
-{
-    const struct dns_domain *domain =3D o->dns_options.search_domains;
-    const struct dns_server *server =3D o->dns_options.servers;
-    if (!domain && !server)
-    {
-        return;
-    }
-
-    /* reset the index since we're starting all over again */
-    int opt_max =3D o->foreign_option_index;
-    o->foreign_option_index =3D 0;
-
-    for (int i =3D 1; i <=3D opt_max; ++i)
-    {
-        char name[32];
-        snprintf(name, sizeof(name), "foreign_option_%d", i);
-
-        const char *env_str =3D env_set_get(es, name);
-        const char *value =3D strchr(env_str, '=3D') + 1;
-        if ((domain && strstr(value, "dhcp-option DOMAIN-SEARCH") =3D=3D v=
alue)
-            || (server && strstr(value, "dhcp-option DNS") =3D=3D value))
-        {
-            setenv_del(es, name);
-        }
-        else
-        {
-            setenv_foreign_option(o, &value, 1, es);
-        }
-    }
-
-    struct gc_arena gc =3D gc_new();
-
-    while (server)
-    {
-        for (size_t i =3D 0; i < server->addr_count; ++i)
-        {
-            if (server->addr[i].family =3D=3D AF_INET)
-            {
-                const char *argv[] =3D {
-                    "dhcp-option",
-                    "DNS",
-                    print_in_addr_t(server->addr[i].in.a4.s_addr, 0, &gc)
-                };
-                setenv_foreign_option(o, argv, 3, es);
-            }
-            else
-            {
-                const char *argv[] =3D {
-                    "dhcp-option",
-                    "DNS6",
-                    print_in6_addr(server->addr[i].in.a6, 0, &gc)
-                };
-                setenv_foreign_option(o, argv, 3, es);
-            }
-        }
-        server =3D server->next;
-    }
-    while (domain)
-    {
-        const char *argv[] =3D { "dhcp-option", "DOMAIN-SEARCH", domain->n=
ame };
-        setenv_foreign_option(o, argv, 3, es);
-        domain =3D domain->next;
-    }
-
-    gc_free(&gc);
-
-    /* remove old leftover entries */
-    while (o->foreign_option_index < opt_max)
-    {
-        char name[32];
-        snprintf(name, sizeof(name), "foreign_option_%d", opt_max--);
-        setenv_del(es, name);
-    }
-}
 #endif /* if defined(_WIN32) || defined(TARGET_ANDROID) */

 #ifndef ENABLE_SMALL
@@ -3616,6 +3475,207 @@
     }
 }

+#if defined(_WIN32) || defined(TARGET_ANDROID)
+/**
+ * @brief Postprocess DNS related settings
+ *
+ * Discard existing TUN/TAP DNS options and override them with --dns
+ * values for Android. If there are no --dns servers leave things alone.
+ *
+ * @param o     pointer to the options struct
+ */
+static void
+tuntap_options_postprocess_dns(struct options *o)
+{
+    struct dns_options *dns =3D &o->dns_options;
+    if (!dns->servers)
+    {
+        return;
+    }
+
+    /* Remove DNS related --dhcp-options */
+    struct tuntap_options *tt =3D &o->tuntap_options;
+    tt->dns_len =3D 0;
+    tt->dns6_len =3D 0;
+    tt->domain =3D NULL;
+    tt->domain_search_list_len =3D 0;
+
+#if defined(TARGET_ANDROID)
+    /* Set options from --dns config */
+    const struct dns_domain *d =3D dns->search_domains;
+    while (d && tt->domain_search_list_len + 1 < N_SEARCH_LIST_LEN)
+    {
+        tt->domain_search_list[tt->domain_search_list_len++] =3D d->name;
+        d =3D d->next;
+    }
+    if (domain)
+    {
+        msg(M_WARN, "WARNING: couldn't copy all --dns search-domains to TU=
N/TAP");
+    }
+
+    const struct dns_server *s =3D dns->servers;
+    while (s)
+    {
+        bool non_standard_server_port =3D false;
+        for (int i =3D 0; i < s->addr_count; ++i)
+        {
+            if (s->addr[i].port && s->addr[i].port !=3D 53)
+            {
+                non_standard_server_port =3D true;
+                break;
+            }
+        }
+        if ((s->transport && s->transport !=3D DNS_TRANSPORT_PLAIN)
+            || (s->dnssec && s->dnssec !=3D DNS_SECURITY_NO)
+            || non_standard_server_port)
+        {
+            /* Skip servers requiring unsupported config to be set */
+            s =3D s->next;
+        }
+        else
+        {
+            bool overflow =3D false;
+            for (int i =3D 0; i < s->addr_count; ++i)
+            {
+                if (s->addr[i].family =3D=3D AF_INET && tt->dns_len + 1 < =
N_DHCP_ADDR)
+                {
+                    tt->dns[tt->dns_len++] =3D s->addr[i].in.a4.s_addr;
+                }
+                else if (tt->dns6_len + 1 < N_DHCP_ADDR)
+                {
+                    tt->dns6[tt->dns6_len] =3D s->addr[i].in.a6;
+                }
+                else
+                {
+                    overflow =3D true;
+                }
+            }
+            if (overflow)
+            {
+                msg(M_WARN, "WARNING: couldn't copy all --dns server addre=
sses to TUN/TAP");
+            }
+            return;
+        }
+    }
+#endif /* if defined(TARGET_ANDROID) */
+}
+
+#else /* if defined(_WIN32) || defined(TARGET_ANDROID) */
+
+/**
+ * @brief Postprocess DNS related settings in the env_set
+ *
+ * Discard existing --dhcp-options and set values from --dns
+ * instead. If there are no --dns servers leave things alone.
+ *
+ * @param o     pointer to the options struct
+ * @param es    env set to modify potentially
+ */
+static void
+foreign_options_postprocess_dns(struct options *o, struct env_set *es)
+{
+    struct dns_options *dns =3D &o->dns_options;
+    if (!dns->servers)
+    {
+        return;
+    }
+
+    /* Clean up env from --dhcp-option DNS config */
+    struct gc_arena gc =3D gc_new();
+    struct buffer name =3D alloc_buf_gc(OPTION_PARM_SIZE, &gc);
+    struct buffer value =3D alloc_buf_gc(OPTION_PARM_SIZE, &gc);
+
+    const int fo_count =3D o->foreign_option_index;
+    o->foreign_option_index =3D 0;
+
+    for (int i =3D 1; i <=3D fo_count; ++i)
+    {
+        buf_clear(&name);
+        buf_printf(&name, "foreign_option_%d", i);
+        const char *env_str =3D env_set_get(es, BSTR(&name));
+        const char *item_val =3D strchr(env_str, '=3D') + 1;
+        buf_clear(&value);
+        buf_printf(&value, "%s", item_val);
+
+        /* Remove foreign option item from env set */
+        env_set_del(es, BSTR(&name));
+
+        item_val =3D BSTR(&value);
+        if (strncmp(item_val, "dhcp-option ", 12) !=3D 0
+            || (strncmp(item_val + 12, "ADAPTER-DOMAIN-SUFFIX ", 22) !=3D 0
+                && strncmp(item_val + 12, "DOMAIN-SEARCH ", 14) !=3D 0
+                && strncmp(item_val + 12, "DOMAIN ", 7) !=3D 0
+                && strncmp(item_val + 12, "DNS6 ", 5) !=3D 0
+                && strncmp(item_val + 12, "DNS ", 4) !=3D 0))
+        {
+            /* Re-set the item with potentially updated name */
+            buf_clear(&name);
+            buf_printf(&name, "foreign_option_%d", ++o->foreign_option_ind=
ex);
+            setenv_str(es, BSTR(&name), BSTR(&value));
+        }
+    }
+
+    /* Set foreign option env vars from --dns config */
+    if (!o->up_script || dns->user_defined_updown)
+    {
+        /* No need to, when there is no --up script or a custom updown */
+        return;
+    }
+
+    const char *p[] =3D { "dhcp-option", NULL, NULL };
+    size_t p_len =3D sizeof(p) / sizeof(p[0]);
+
+    p[1] =3D "DOMAIN";
+    const struct dns_domain *d =3D dns->search_domains;
+    while (d)
+    {
+        p[2] =3D d->name;
+        setenv_foreign_option(o, (const char **)p, p_len, es);
+        d =3D d->next;
+    }
+
+    const struct dns_server *s =3D dns->servers;
+    while (s)
+    {
+        bool non_standard_server_port =3D false;
+        for (int i =3D 0; i < s->addr_count; ++i)
+        {
+            if (s->addr[i].port && s->addr[i].port !=3D 53)
+            {
+                non_standard_server_port =3D true;
+                break;
+            }
+        }
+        if ((s->transport && s->transport !=3D DNS_TRANSPORT_PLAIN)
+            || (s->dnssec && s->dnssec !=3D DNS_SECURITY_NO)
+            || non_standard_server_port)
+        {
+            /* Skip servers requiring unsupported config to be set */
+            s =3D s->next;
+        }
+        else
+        {
+            for (int i =3D 0; i < s->addr_count; ++i)
+            {
+                if (s->addr[i].family =3D=3D AF_INET)
+                {
+                    p[1] =3D "DNS";
+                    p[2] =3D print_in_addr_t(s->addr[i].in.a4.s_addr, IA_N=
ET_ORDER, &gc);
+                }
+                else
+                {
+                    p[1] =3D "DNS6";
+                    p[2] =3D print_in6_addr(s->addr[i].in.a6, 0, &gc);
+                }
+                setenv_foreign_option(o, (const char **)p, p_len, es);
+            }
+            break;
+        }
+    }
+    gc_free(&gc);
+}
+#endif /* if defined(_WIN32) || defined(TARGET_ANDROID) */
+
 static void
 options_postprocess_mutate(struct options *o, struct env_set *es)
 {
@@ -3801,9 +3861,9 @@
     else
     {
 #if defined(_WIN32) || defined(TARGET_ANDROID)
-        tuntap_options_copy_dns(o);
+        tuntap_options_postprocess_dns(o);
 #else
-        foreign_options_copy_dns(o, es);
+        foreign_options_postprocess_dns(o, es);
 #endif
     }
     if (o->auth_token_generate && !o->auth_token_renewal)
@@ -4186,9 +4246,9 @@
     {
         dns_options_postprocess_pull(&o->dns_options);
 #if defined(_WIN32) || defined(TARGET_ANDROID)
-        tuntap_options_copy_dns(o);
+        tuntap_options_postprocess_dns(o);
 #else
-        foreign_options_copy_dns(o, es);
+        foreign_options_postprocess_dns(o, es);
 #endif
     }
     return success;
@@ -8089,19 +8149,29 @@
             goto err;
         }
 #ifdef ENABLE_DNS_UPDOWN
+        struct dns_options *dns =3D &options->dns_options;
         if (streq(p[1], "disable"))
         {
-            options->dns_options.updown =3D NULL;
+            dns->updown =3D NULL;
+            dns->user_defined_updown =3D false;
+        }
+        else if (streq(p[1], "force"))
+        {
+            /* force dns-updown run, even if a --up script is defined */
+            if (dns->updown)
+            {
+                dns->user_defined_updown =3D true;
+            }
         }
         else
         {
-            if (options->dns_options.user_defined_updown =3D=3D false)
+            if (dns->user_defined_updown =3D=3D false)
             {
                 /* Unset the default command to prevent warnings */
-                options->dns_options.updown =3D NULL;
+                dns->updown =3D NULL;
             }
-            set_user_script(options, &options->dns_options.updown, p[1], p=
[0], false);
-            options->dns_options.user_defined_updown =3D true;
+            set_user_script(options, &dns->updown, p[1], p[0], false);
+            dns->user_defined_updown =3D true;
         }
 #endif /* ENABLE_DNS_UPDOWN */
     }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/904?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I635c4018fb43b5976a39b6a90cb2e9cb2570cd6a
Gerrit-Change-Number: 904
Gerrit-PatchSet: 8
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-MessageType: newpatchset

--zvOU3wwFghI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: d12fk, flichtenheld, plaisthos. <=
/p>
<p>d12fk <strong>uploaded patch set #8</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/904?usp=3Demail">View Change</a=
></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
">dns: deal with --dhcp-options when --dns is active<br><br>Since --dns set=
tings overrule DNS related --dhcp-options,<br>remove the latter when values=
 were defined via --dns.<br><br>To stay as backward compatible as possible,=
 we add foreign_options to<br>the script hook environment from the --dns va=
lues when a --up script<br>is defined. In that case the default --dns-updow=
n is not run, even<br>when --dns values are present, to prevent double DNS =
configuration.<br>This way an existing --up script that deals with DNS can =
run, without<br>the immediate need to change after an openvpn upgrade and a=
 server<br>pushing --dns options.<br><br>If you specify a custom --dns-updo=
wn, or force running the default<br>dns-updown that comes with openvpn, tho=
se compat env vars are not set<br>for --up scripts and the dns-updown comma=
nd is run, even when there&#39;s<br>an --up script present.<br><br>Since An=
droid uses the DNS values from tuntap_options, we always<br>override those =
with --dns stuff unconditionally.<br><br>Change-Id: I635c4018fb43b5976a39b6=
a90cb2e9cb2570cd6a<br>Signed-off-by: Heiko Hund &lt;heiko@...2662...&gt;<br=
>---<br>M doc/man-sections/script-options.rst<br>M src/openvpn/dns.c<br>M s=
rc/openvpn/options.c<br>3 files changed, 231 insertions(+), 158 deletions(-=
)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/04=
/904/8</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/doc/man-sections/script-options.rst b/doc/man-s=
ections/script-options.rst</span><br><span>index 8285122..765518a 100644</s=
pan><br><span>--- a/doc/man-sections/script-options.rst</span><br><span>+++=
 b/doc/man-sections/script-options.rst</span><br><span>@@ -258,9 +258,11 @@=
</span><br><span>   Note that DNS-related ``--dhcp-option``\ s will not be =
handled by this hook.</span><br><span>   If any ``--dns server`` option is =
present, DNS-related ``--dhcp-option``\ s will</span><br><span>   be ignore=
d. If an ``--up`` script is defined, foreign_option env vars will be</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-  generated from ``--dns`` o=
ptions and passed to the script. The ``--dns-updown``</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  command is not run if a ``--up`` script i=
s defined. Both is done for backward</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-  compatibility.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  generated from ``--dns`` options and passed to the script for=
 backward compatibility.</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Also for bac=
kward compatibility, the ``--dns-updown`` command is not run if a</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  ``--up`` script is defined,=
 unless a user-defined ``dns-updown`` was specified,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  or running the default updown is forced=
 via the ``--dns-updown force`` option.</span><br><span> </span><br><span> =
--down cmd</span><br><span>   Run command ``cmd`` after TUN/TAP device clos=
e (post ``--user`` UID</span><br><span>diff --git a/src/openvpn/dns.c b/src=
/openvpn/dns.c</span><br><span>index 0ad8e44..c654d78 100644</span><br><spa=
n>--- a/src/openvpn/dns.c</span><br><span>+++ b/src/openvpn/dns.c</span><br=
><span>@@ -703,7 +703,8 @@</span><br><span> static void</span><br><span> ru=
n_up_down_command(bool up, struct options *o, const struct tuntap *tt, stru=
ct dns_updown_runner_info *updown_runner)</span><br><span> {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (!o-&gt;dns_options.updown)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct dns_option=
s *dns =3D &amp;o-&gt;dns_options;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!dns-&gt;updown || (o-&gt;up_script &amp;&amp; !dns-=
&gt;user_defined_updown))</span><br><span>     {</span><br><span>         r=
eturn;</span><br><span>     }</span><br><span>@@ -713,7 +714,7 @@</span><br=
><span>     if (!updown_runner-&gt;required)</span><br><span>     {</span><=
br><span>         /* Run dns updown directly */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        status =3D do_run_up_down_command(up, NUL=
L, &amp;o-&gt;dns_options, tt);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        status =3D do_run_up_down_command(up, NULL, dns, tt);</=
span><br><span>     }</span><br><span>     else</span><br><span>     {</spa=
n><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</spa=
n><br><span>index 1a9c337..22c882b 100644</span><br><span>--- a/src/openvpn=
/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -=
530,7 +530,9 @@</span><br><span>     &quot;                  sni &lt;domain=
&gt; : DNS server name indication\n&quot;</span><br><span>     &quot;--dns =
search-domains &lt;domain&gt; [domain ...]:\n&quot;</span><br><span>     &q=
uot;                  Add domains to DNS domain search list\n&quot;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;--dns-updown cmd|di=
sable : Run cmd as user defined dns config command or disable it\n&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;--dns-updown=
 cmd|force|disable :\n&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    &quot;                  Run cmd as user defined dns config com=
mand, force running the\n&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    &quot;                  default one even when --up exists, =
or disable running it.\n&quot;</span><br><span>     &quot;--auth-retry t  :=
 How to handle auth failures.  Set t to\n&quot;</span><br><span>     &quot;=
                  none (default), interact, or nointeract.\n&quot;</span><b=
r><span>     &quot;--static-challenge t e [&lt;scrv1|concat&gt;]: Enable st=
atic challenge/response protocol using\n&quot;</span><br><span>@@ -1374,149=
 +1376,6 @@</span><br><span>         }</span><br><span>     }</span><br><sp=
an> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * If DNS options are set use these for TUN/TAP options =
as well.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Applies to=
 DNS, DNS6 and DOMAIN-SEARCH.</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * Existing options will be discarded.</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tun=
tap_options_copy_dns(struct options *o)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  struct tuntap_options *tt =3D &amp;o-&gt;tuntap_options;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    struct dns_options *dns =3D &amp;o=
-&gt;dns_options;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (dns-&gt;search_do=
mains)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        tt-&gt;domain_search_li=
st_len =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
const struct dns_domain *domain =3D dns-&gt;search_domains;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        while (domain &amp;&amp; tt-&=
gt;domain_search_list_len &lt; N_SEARCH_LIST_LEN)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            tt-&gt;domain_search_list[tt-&gt;domain_search_=
list_len++] =3D domain-&gt;name;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            domain =3D domain-&gt;next;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        if (domain)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            msg(M_WARN, &quot;WARNING: couldn&#39;t copy all --dns searc=
h-domains to --dhcp-option&quot;);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        tt-&gt;dhcp_options |=3D DHCP_OPTIONS_DHCP_REQUIRED;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if (dns-&gt;servers)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        tt=
-&gt;dns_len =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      tt-&gt;dns6_len =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        bool overflow =3D false;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        const struct dns_server *server =3D dns-&gt;serve=
rs;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        while (ser=
ver)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            for (int i =3D 0;=
 i &lt; server-&gt;addr_count; ++i)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                if (server-&gt;addr[i].family =3D=3D AF_INET)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                    if (tt-&gt;dn=
s_len &gt;=3D N_DHCP_ADDR)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                    {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                        overflow =3D true;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                        continue;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                    }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                    tt-&gt;dns[tt-&gt=
;dns_len++] =3D ntohl(server-&gt;addr[i].in.a4.s_addr);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                else</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                    if (tt-&gt;dns6_len &gt;=3D=
 N_DHCP_ADDR)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
                overflow =3D true;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                        continue;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                    }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                    tt-&gt;dns6[tt-&gt;dns6_len++]=
 =3D server-&gt;addr[i].in.a6;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         server =3D server-&gt;next;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        if (overflow)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   msg(M_WARN, &quot;WARNING: couldn&#39;t copy all --dns server addresses =
to --dhcp-option&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        t=
t-&gt;dhcp_options |=3D DHCP_OPTIONS_DHCP_OPTIONAL;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#els=
e /* if defined(_WIN32) || defined(TARGET_ANDROID) */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-foreign_options_copy_dns(struct options *o, struct en=
v_set *es)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    const struct dns_domain *do=
main =3D o-&gt;dns_options.search_domains;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    const struct dns_server *server =3D o-&gt;dns_opti=
ons.servers;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!=
domain &amp;&amp; !server)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ret=
urn;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    /* reset the index since we&#39;re starting all ov=
er again */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int op=
t_max =3D o-&gt;foreign_option_index;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    o-&gt;foreign_option_index =3D 0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    for (int i =3D 1; i &lt;=3D opt_max; ++i)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        char name[32];</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        snprintf(name, sizeof(name), &quot;foreign_opti=
on_%d&quot;, i);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        const char *env_st=
r =3D env_set_get(es, name);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        const char *value =3D strchr(env_str, &#39;=3D&#39;) + 1;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        if ((domain &amp=
;&amp; strstr(value, &quot;dhcp-option DOMAIN-SEARCH&quot;) =3D=3D value)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            || (server =
&amp;&amp; strstr(value, &quot;dhcp-option DNS&quot;) =3D=3D value))</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            setenv_del(es, name);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            setenv_foreign_option(o, &amp;value, 1, es);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    wh=
ile (server)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        for (size_t i =3D=
 0; i &lt; server-&gt;addr_count; ++i)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            if (server-&gt;addr[i].family =3D=3D AF_INET)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                const char *argv[] =3D {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    &qu=
ot;dhcp-option&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                    &quot;DNS&quot;,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                    print_in_addr_t(server-&gt;addr[i].in.a4=
.s_addr, 0, &amp;gc)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            setenv_foreign_option(o, argv, 3, es);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            else</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                const char *argv[] =3D {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                    &quot;dhcp-option&quot;,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                    &quot=
;DNS6&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
           print_in6_addr(server-&gt;addr[i].in.a6, 0, &amp;gc)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                };</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                setenv_foreign_optio=
n(o, argv, 3, es);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        server =3D serv=
er-&gt;next;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    while (domain)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        const char *argv[] =3D { &quot;dhcp=
-option&quot;, &quot;DOMAIN-SEARCH&quot;, domain-&gt;name };</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        setenv_foreign_option(o, arg=
v, 3, es);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        dom=
ain =3D domain-&gt;next;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    /* remove old leftover entries */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    while (o-&gt;foreign_option_index &=
lt; opt_max)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        char name[32];</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        snprintf(name, s=
izeof(name), &quot;foreign_option_%d&quot;, opt_max--);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        setenv_del(es, name);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-}</span><br><span> #endif /* if defined(_WIN32) |=
| defined(TARGET_ANDROID) */</span><br><span> </span><br><span> #ifndef ENA=
BLE_SMALL</span><br><span>@@ -3616,6 +3475,207 @@</span><br><span>     }</s=
pan><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#if defined(_WIN32) || defined(TARGET_ANDROID)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @brief Postprocess DNS related settings</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Discard existing TUN/TAP DNS options a=
nd override them with --dns</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * values for Android. If there are no --dns servers leave things a=
lone.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @param o     pointer to the =
options struct</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+tuntap_options_postprocess_dn=
s(struct options *o)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct dns_op=
tions *dns =3D &amp;o-&gt;dns_options;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (!dns-&gt;servers)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Remove DNS related =
--dhcp-options */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct tuntap_options *tt =3D &amp;o-&gt;tuntap_options;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    tt-&gt;dns_len =3D 0;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    tt-&gt;dns6_len =3D 0;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    tt-&gt;domain =3D N=
ULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tt-&gt;doma=
in_search_list_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(T=
ARGET_ANDROID)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* Set options from --dns config */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const struct dns_domain *d =3D dns-&gt;search_domains;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    while (d &amp;&am=
p; tt-&gt;domain_search_list_len + 1 &lt; N_SEARCH_LIST_LEN)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        tt-&gt;domain_search_list[tt-&gt;domain_=
search_list_len++] =3D d-&gt;name;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        d =3D d-&gt;next;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (domain)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg=
(M_WARN, &quot;WARNING: couldn&#39;t copy all --dns search-domains to TUN/T=
AP&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const struct dns_server *s =3D dns-&g=
t;servers;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    while=
 (s)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        bool non_standard_ser=
ver_port =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        for (int i =3D 0; i &lt; s-&gt;addr_count; ++i)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            if (s-&gt;addr[i].port &amp;&amp; s-&=
gt;addr[i].port !=3D 53)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               non_standard_server_port =3D true;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                break;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if ((s-&gt;transport &amp;&amp; s-&gt;transport !=
=3D DNS_TRANSPORT_PLAIN)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            || (s-&gt;dnssec &amp;&amp; s-&gt;dnssec !=3D DNS_SECURITY=
_NO)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            || =
non_standard_server_port)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        /* Skip servers requiring unsupported config to be set */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            s =3D s-&gt;next;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            bool overflow =3D false;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            for (int i =3D 0;=
 i &lt; s-&gt;addr_count; ++i)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                if (s-&gt;addr[i].family =3D=3D AF_INET &amp;&amp; tt-=
&gt;dns_len + 1 &lt; N_DHCP_ADDR)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                    tt-&gt;dns[tt-&gt;dns_len++] =3D s-&gt;addr=
[i].in.a4.s_addr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            else if (tt-&gt;dns6_len + 1 &lt; N_DHCP_ADDR)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                    tt-&gt;dns6[tt-&gt=
;dns6_len] =3D s-&gt;addr[i].in.a6;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                else</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                    overflow =3D true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            if (overflow)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                msg(M_WARN, &quot;WARNING: coul=
dn&#39;t copy all --dns server addresses to TUN/TAP&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            return;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#endif /* if defined(TARGET_ANDROID) */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else /=
* if defined(_WIN32) || defined(TARGET_ANDROID) */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
brief Postprocess DNS related settings in the env_set</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * Discard existing --dhcp-options and set values from --d=
ns</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * instead. If th=
ere are no --dns servers leave things alone.</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param o     pointer to the options struct</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param es    env set to modify potenti=
ally</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+foreign_options_postprocess_dns(struct =
options *o, struct env_set *es)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct dns_options *dns =3D &amp;o-&gt;dns_options;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (!dns-&gt;servers)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Clean up=
 env from --dhcp-option DNS config */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct buffer name =3D alloc_buf_gc(=
OPTION_PARM_SIZE, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct buffer value =3D alloc_buf_gc(OPTION_PARM_SIZE, &amp;gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    const int fo_count =3D o-&gt;fore=
ign_option_index;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  o-&gt;foreign_option_index =3D 0;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 for (int i =3D 1; i &lt;=3D fo_count; ++i)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        buf_clear(&amp;name);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        buf_printf(&amp;name, &quot;foreign_option_%d&q=
uot;, i);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        co=
nst char *env_str =3D env_set_get(es, BSTR(&amp;name));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        const char *item_val =3D strchr=
(env_str, &#39;=3D&#39;) + 1;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        buf_clear(&amp;value);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        buf_printf(&amp;value, &quot;%s&quot;, item_va=
l);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        /* Remove foreign option it=
em from env set */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       env_set_del(es, BSTR(&amp;name));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        item_val =3D BSTR(&amp;value);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (strncmp(item_val, &quot;dhcp-option &quot;=
, 12) !=3D 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     || (strncmp(item_val + 12, &quot;ADAPTER-DOMAIN-SUFFIX &quot;, 22) !=
=3D 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  &amp;&amp; strncmp(item_val + 12, &quot;DOMAIN-SEARCH &quot;, 14) !=3D 0<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                &amp=
;&amp; strncmp(item_val + 12, &quot;DOMAIN &quot;, 7) !=3D 0</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                &amp;&amp; strncmp=
(item_val + 12, &quot;DNS6 &quot;, 5) !=3D 0</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                &amp;&amp; strncmp(item_val + 12, =
&quot;DNS &quot;, 4) !=3D 0))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            /* Re-set the item with potentially updated name */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            buf_clear(&amp;name=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            buf_p=
rintf(&amp;name, &quot;foreign_option_%d&quot;, ++o-&gt;foreign_option_inde=
x);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            sete=
nv_str(es, BSTR(&amp;name), BSTR(&amp;value));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Set forei=
gn option env vars from --dns config */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (!o-&gt;up_script || dns-&gt;user_defined_updown=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        /* No need to, when ther=
e is no --up script or a custom updown */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char =
*p[] =3D { &quot;dhcp-option&quot;, NULL, NULL };</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    size_t p_len =3D sizeof(p) / sizeof(p[0])=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    p[1] =3D &quot;DOMAIN&quot;;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct dns_dom=
ain *d =3D dns-&gt;search_domains;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    while (d)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   p[2] =3D d-&gt;name;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        setenv_foreign_option(o, (const char **)p, p_len, es);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        d =3D d-&gt;next;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    const struct dns_server *s =3D dns-&gt;servers;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    while (s)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        bool non_standard_server_port =3D=
 false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for =
(int i =3D 0; i &lt; s-&gt;addr_count; ++i)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            if (s-&gt;addr[i].port &amp;&amp; s-&gt;addr[i].p=
ort !=3D 53)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   non_standard_server_port =3D true;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                break;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if ((s-&gt;transport &amp;&amp; s-&gt;transport !=3D DNS_TRANS=
PORT_PLAIN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    || (s-&gt;dnssec &amp;&amp; s-&gt;dnssec !=3D DNS_SECURITY_NO)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            || non_standard_=
server_port)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* Sk=
ip servers requiring unsupported config to be set */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            s =3D s-&gt;next;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            for (int i =3D 0; i &lt; s-&gt;addr_count; ++i=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                if (s-&g=
t;addr[i].family =3D=3D AF_INET)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                    p[1] =3D &quot;DNS&quot;;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                    p[2] =3D print_in_=
addr_t(s-&gt;addr[i].in.a4.s_addr, IA_NET_ORDER, &amp;gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                else</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                    p[1] =3D &quot;DNS6=
&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        p[2] =3D print_in6_addr(s-&gt;addr[i].in.a6, 0, &amp;gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                setenv_foreign_=
option(o, (const char **)p, p_len, es);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            break;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free=
(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* if defined(_WIN32=
) || defined(TARGET_ANDROID) */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span> static void</span><br><span> options_postproc=
ess_mutate(struct options *o, struct env_set *es)</span><br><span> {</span>=
<br><span>@@ -3801,9 +3861,9 @@</span><br><span>     else</span><br><span> =
    {</span><br><span> #if defined(_WIN32) || defined(TARGET_ANDROID)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        tuntap_options_copy=
_dns(o);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tun=
tap_options_postprocess_dns(o);</span><br><span> #else</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        foreign_options_copy_dns(o, es);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        foreign_optio=
ns_postprocess_dns(o, es);</span><br><span> #endif</span><br><span>     }</=
span><br><span>     if (o-&gt;auth_token_generate &amp;&amp; !o-&gt;auth_to=
ken_renewal)</span><br><span>@@ -4186,9 +4246,9 @@</span><br><span>     {</=
span><br><span>         dns_options_postprocess_pull(&amp;o-&gt;dns_options=
);</span><br><span> #if defined(_WIN32) || defined(TARGET_ANDROID)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        tuntap_options_copy_dn=
s(o);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tuntap=
_options_postprocess_dns(o);</span><br><span> #else</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        foreign_options_copy_dns(o, es);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        foreign_option=
s_postprocess_dns(o, es);</span><br><span> #endif</span><br><span>     }</s=
pan><br><span>     return success;</span><br><span>@@ -8089,19 +8149,29 @@<=
/span><br><span>             goto err;</span><br><span>         }</span><br=
><span> #ifdef ENABLE_DNS_UPDOWN</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        struct dns_options *dns =3D &amp;options-&gt;dns_optio=
ns;</span><br><span>         if (streq(p[1], &quot;disable&quot;))</span><b=
r><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         options-&gt;dns_options.updown =3D NULL;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            dns-&gt;updown =3D NULL;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            dns-&gt;user_def=
ined_updown =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 else if (streq(p[1], &quot;force&quot;))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            /* force dns-updown run, even if a --up script is d=
efined */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  if (dns-&gt;updown)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            dns-&gt;user_defined_updown =3D true;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            }</span><br><span>         }</spa=
n><br><span>         else</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            if (options-&gt;dns_options.use=
r_defined_updown =3D=3D false)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            if (dns-&gt;user_defined_updown =3D=3D false)</span>=
<br><span>             {</span><br><span>                 /* Unset the defa=
ult command to prevent warnings */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                options-&gt;dns_options.updown =3D NULL;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                dns-&gt;u=
pdown =3D NULL;</span><br><span>             }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            set_user_script(options, &amp;options-=
&gt;dns_options.updown, p[1], p[0], false);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            options-&gt;dns_options.user_defined_updo=
wn =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     set_user_script(options, &amp;dns-&gt;updown, p[1], p[0], false);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            dns-&gt;user=
_defined_updown =3D true;</span><br><span>         }</span><br><span> #endi=
f /* ENABLE_DNS_UPDOWN */</span><br><span>     }</span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/9=
04?usp=3Demail">change 904</a>. To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</=
p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempr=
op=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/904?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I635c4018fb43b5976a39b6a90cb=
2e9cb2570cd6a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 904 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--zvOU3wwFghI=--

