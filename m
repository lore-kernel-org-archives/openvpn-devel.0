From: Davide Guerri <d.guerri@...1502...>
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: multipart/mixed;
	boundary="Apple-Mail=_ECF275DD-ED5A-47CB-AB61-2DB7CFA9E04D"
Date: Thu, 15 Sep 2011 23:42:22 +0200
In-Reply-To: <B96E3F2E-F1EF-41B4-9342-16AE68F53A8D@...1502...>
References: <C8EBC1CC-8304-4A97-A2C6-DE114CB05EFF@...1502...>
	<B96E3F2E-F1EF-41B4-9342-16AE68F53A8D@...1502...>
Message-Id: <49806E1A-9928-4272-8EF5-55943866941D@...1502...>
Subject: [Openvpn-devel] [PATCH] Client's routes ageing timer
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--Apple-Mail=_ECF275DD-ED5A-47CB-AB61-2DB7CFA9E04D
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Please find attached a patch for a new stale-routes-check (and remove) opti=
on.

As requested on IRC #openvpn-devel channel, I've fixed my previously submit=
ted patch against version 2.1.0 (i.e. the version currently used by ubuntu =
10.04.3 LTS) and I'm also submitting a patch against the latest master bran=
ch.

I've been testing both versions for a while with no issues so far.=20



--Apple-Mail=_ECF275DD-ED5A-47CB-AB61-2DB7CFA9E04D
Content-Disposition: attachment;
	filename=openvpn-2.1.0-aged-routes.patch
Content-Type: application/octet-stream; name="openvpn-2.1.0-aged-routes.patch"
Content-Transfer-Encoding: 7bit

diff -ruN openvpn-2.1.0-orig/multi.c openvpn-2.1.0/multi.c
--- openvpn-2.1.0-orig/multi.c	2009-10-25 01:17:29.000000000 +0200
+++ openvpn-2.1.0/multi.c	2011-09-14 16:21:57.000000000 +0200
@@ -375,6 +375,14 @@
    * tun/tap interface and network stack?
    */
   m->enable_c2c = t->options.enable_c2c;
+  
+  /* initialize stale routes check timer */
+  if (t->options.stale_routes_check_interval > 0)
+    {
+      msg (M_INFO, "Initializing stale route check timer to run every %i seconds and to removing routes with activity timeout older than %i seconds", 
+        t->options.stale_routes_check_interval, t->options.stale_routes_ageing_time);
+      event_timeout_init (&m->stale_routes_check_et, t->options.stale_routes_check_interval, 0);
+    }
 }
 
 const char *
@@ -1159,6 +1167,32 @@
     }
 }
 
+static void
+check_stale_routes (struct multi_context *m)
+{
+
+  struct gc_arena gc = gc_new ();
+  struct hash_iterator hi;
+  struct hash_element *he;
+
+  dmsg (D_MULTI_DEBUG, "MULTI: Checking stale routes");
+  hash_iterator_init_range (m->vhash, &hi, true, 0, hash_n_buckets (m->vhash));
+  while ((he = hash_iterator_next (&hi)) != NULL)
+    {
+      struct multi_route *r = (struct multi_route *) he->value;
+      if (multi_route_defined (m, r) && difftime(now, r->last_reference) >= m->top.options.stale_routes_ageing_time)
+        {
+          dmsg (D_MULTI_DEBUG, "MULTI: Deleting stale route for address '%s'",
+               mroute_addr_print (&r->addr, &gc));
+          learn_address_script (m, NULL, "delete", &r->addr);
+          multi_route_del (r);
+          hash_iterator_delete_element (&hi);
+        }
+    }
+  hash_iterator_free (&hi);
+  gc_free (&gc);
+}
+
 /*
  * Ensure that endpoint to be pushed to client
  * complies with --ifconfig-push-constraint directive.
@@ -2349,6 +2383,14 @@
 }
 #endif
 
+bool
+stale_route_check_trigger (struct multi_context *m)
+{
+  struct timeval null;
+  CLEAR (null);
+  return event_timeout_trigger (&m->stale_routes_check_et, &null, ETT_DEFAULT);
+}
+
 /*
  * Process timers in the top-level context
  */
@@ -2371,6 +2413,10 @@
 #ifdef ENABLE_DEBUG
   gremlin_flood_clients (m);
 #endif
+  
+  /* Should we check for stale routes? */
+  if (m->top.options.stale_routes_check_interval && stale_route_check_trigger (m))
+    check_stale_routes (m);
 }
 
 void
diff -ruN openvpn-2.1.0-orig/multi.h openvpn-2.1.0/multi.h
--- openvpn-2.1.0-orig/multi.h	2009-10-01 20:02:18.000000000 +0200
+++ openvpn-2.1.0/multi.h	2011-09-14 12:06:41.000000000 +0200
@@ -129,6 +129,11 @@
   time_t per_second_trigger;
 
   struct context top;
+  
+  /*
+   * Timer object for stale route check
+   */
+  struct event_timeout stale_routes_check_et;
 };
 
 /*
diff -ruN openvpn-2.1.0-orig/openvpn.8 openvpn-2.1.0/openvpn.8
--- openvpn-2.1.0-orig/openvpn.8	2009-12-11 09:04:24.000000000 +0100
+++ openvpn-2.1.0/openvpn.8	2011-09-14 14:45:18.000000000 +0200
@@ -2976,6 +2976,25 @@
 kernel routing table.
 .\"*********************************************************
 .TP
+.B \-\-stale-routes-check n [t]
+Remove routes older than
+.B n
+seconds (i.e. the ageing time).
+
+This check is ran every
+.B t
+seconds (i.e. check interval).
+
+If
+.B t
+is not present it defaults to
+.B n
+
+This option helps to keep the dynamic routing table small.
+See also
+.B \-\-max-routes-per-client
+.\"*********************************************************
+.TP
 .B \-\-connect-freq n sec
 Allow a maximum of
 .B n
diff -ruN openvpn-2.1.0-orig/options.c openvpn-2.1.0/options.c
--- openvpn-2.1.0-orig/options.c	2009-12-11 09:09:39.000000000 +0100
+++ openvpn-2.1.0/options.c	2011-09-14 16:12:17.000000000 +0200
@@ -416,6 +416,9 @@
   "--connect-freq n s : Allow a maximum of n new connections per s seconds.\n"
   "--max-clients n : Allow a maximum of n simultaneously connected clients.\n"
   "--max-routes-per-client n : Allow a maximum of n internal routes per client.\n"
+  "--stale-routes-check n [t] : Remove routes with a last activity timestamp\n"
+  "                             older than n seconds. Run this check every t\n"
+  "                             seconds (defaults to n).\n"
 #if PORT_SHARE
   "--port-share host port : When run in TCP mode, proxy incoming HTTPS sessions\n"
   "                  to a web server at host:port.\n"
@@ -725,6 +728,7 @@
   o->tcp_queue_limit = 64;
   o->max_clients = 1024;
   o->max_routes_per_client = 256;
+  o->stale_routes_check_interval = 0;
   o->ifconfig_pool_persist_refresh_freq = 600;
 #endif
 #if P2MP
@@ -1788,7 +1792,8 @@
       if (options->port_share_host || options->port_share_port)
 	msg (M_USAGE, "--port-share requires TCP server mode (--mode server --proto tcp-server)");
 #endif

+      if (options->stale_routes_check_interval)
+        msg (M_USAGE, "--stale-routes-check requires --mode server");
     }
 #endif /* P2MP_SERVER */
 
@@ -4373,6 +4378,25 @@
 	}
       options->max_routes = max_routes;
     }
+  else if (streq (p[0], "stale-routes-check") && p[1])
+    {
+      int ageing_time, check_interval;
+
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      ageing_time = atoi (p[1]);
+      if (p[2])
+        check_interval = atoi (p[2]);
+      else
+        check_interval = ageing_time;
+
+      if (ageing_time < 1 || check_interval < 1)
+        {
+        msg (msglevel, "--stale-routes-check aging time and check interval must be >= 1");
+        goto err;
+        }
+      options->stale_routes_ageing_time  = ageing_time;
+      options->stale_routes_check_interval = check_interval;
+    }
   else if (streq (p[0], "route-gateway") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_ROUTE_EXTRAS);
diff -ruN openvpn-2.1.0-orig/options.h openvpn-2.1.0/options.h
--- openvpn-2.1.0-orig/options.h	2009-10-01 20:02:18.000000000 +0200
+++ openvpn-2.1.0/options.h	2011-09-14 14:45:18.000000000 +0200
@@ -383,6 +383,8 @@
   int cf_per;
   int max_clients;
   int max_routes_per_client;
+  int stale_routes_check_interval;
+  int stale_routes_ageing_time;
 
   const char *auth_user_pass_verify_script;
   bool auth_user_pass_verify_script_via_file;

--Apple-Mail=_ECF275DD-ED5A-47CB-AB61-2DB7CFA9E04D
Content-Disposition: attachment;
	filename=openvpn-master-aged-routes.patch
Content-Type: application/octet-stream; name="openvpn-master-aged-routes.patch"
Content-Transfer-Encoding: 7bit

diff --git a/multi.c b/multi.c
index 1a2f86a..f198e17 100644
--- a/multi.c
+++ b/multi.c
@@ -368,6 +368,14 @@ multi_init (struct multi_context *m, struct context *t, bool tcp_mode, int threa
    * tun/tap interface and network stack?
    */
   m->enable_c2c = t->options.enable_c2c;
+
+  /* initialize stale routes check timer */
+  if (t->options.stale_routes_check_interval > 0)
+    {
+      msg (M_INFO, "Initializing stale route check timer to run every %i seconds and to removing routes with activity timeout older than %i seconds", 
+        t->options.stale_routes_check_interval, t->options.stale_routes_ageing_time);
+      event_timeout_init (&m->stale_routes_check_et, t->options.stale_routes_check_interval, 0);
+    }
 }
 
 const char *
@@ -1197,6 +1205,32 @@ multi_delete_dup (struct multi_context *m, struct multi_instance *new_mi)
     }
 }
 
+static void
+check_stale_routes (struct multi_context *m)
+{
+
+  struct gc_arena gc = gc_new ();
+  struct hash_iterator hi;
+  struct hash_element *he;
+
+  dmsg (D_MULTI_DEBUG, "MULTI: Checking stale routes");
+  hash_iterator_init_range (m->vhash, &hi, 0, hash_n_buckets (m->vhash));
+  while ((he = hash_iterator_next (&hi)) != NULL)
+    {
+      struct multi_route *r = (struct multi_route *) he->value;
+      if (multi_route_defined (m, r) && difftime(now, r->last_reference) >= m->top.options.stale_routes_ageing_time)
+        {
+          dmsg (D_MULTI_DEBUG, "MULTI: Deleting stale route for address '%s'",
+               mroute_addr_print (&r->addr, &gc));
+          learn_address_script (m, NULL, "delete", &r->addr);
+          multi_route_del (r);
+          hash_iterator_delete_element (&hi);
+        }
+    }
+  hash_iterator_free (&hi);
+  gc_free (&gc);
+}
+
 /*
  * Ensure that endpoint to be pushed to client
  * complies with --ifconfig-push-constraint directive.
@@ -2469,6 +2503,14 @@ gremlin_flood_clients (struct multi_context *m)
 }
 #endif
 
+bool
+stale_route_check_trigger (struct multi_context *m)
+{
+  struct timeval null;
+  CLEAR (null);
+  return event_timeout_trigger (&m->stale_routes_check_et, &null, ETT_DEFAULT);
+}
+
 /*
  * Process timers in the top-level context
  */
@@ -2491,6 +2533,10 @@ multi_process_per_second_timers_dowork (struct multi_context *m)
 #ifdef ENABLE_DEBUG
   gremlin_flood_clients (m);
 #endif
+
+  /* Should we check for stale routes? */
+  if (m->top.options.stale_routes_check_interval && stale_route_check_trigger (m))
+    check_stale_routes (m);
 }
 
 void
diff --git a/multi.h b/multi.h
index 58e65a3..2bc0c8a 100644
--- a/multi.h
+++ b/multi.h
@@ -161,6 +161,11 @@ struct multi_context {
 
   struct context top;           /**< Storage structure for process-wide
                                  *   configuration. */
+
+  /*
+   * Timer object for stale route check
+   */
+  struct event_timeout stale_routes_check_et;
 };
 
 /*
diff --git a/openvpn.8 b/openvpn.8
index 55a9b80..c585da4 100644
--- a/openvpn.8
+++ b/openvpn.8
@@ -3118,6 +3118,25 @@ directive affects OpenVPN's internal routing table, not the
 kernel routing table.
 .\"*********************************************************
 .TP
+.B \-\-stale-routes-check n [t]
+Remove routes haven't had activity for
+.B n
+seconds (i.e. the ageing time).
+
+This check is ran every
+.B t
+seconds (i.e. check interval).
+
+If
+.B t
+is not present it defaults to
+.B n
+
+This option helps to keep the dynamic routing table small.
+See also
+.B \-\-max-routes-per-client
+.\"*********************************************************
+.TP
 .B \-\-connect-freq n sec
 Allow a maximum of
 .B n
diff --git a/options.c b/options.c
index d410782..68255a5 100644
--- a/options.c
+++ b/options.c
@@ -455,6 +455,9 @@ static const char usage_message[] =
   "--connect-freq n s : Allow a maximum of n new connections per s seconds.\n"
   "--max-clients n : Allow a maximum of n simultaneously connected clients.\n"
   "--max-routes-per-client n : Allow a maximum of n internal routes per client.\n"
+  "--stale-routes-check n [t] : Remove routes with a last activity timestamp\n"
+  "                             older than n seconds. Run this check every t\n"
+  "                             seconds (defaults to n).\n"
 #if PORT_SHARE
   "--port-share host port [dir] : When run in TCP mode, proxy incoming HTTPS\n"
   "                  sessions to a web server at host:port.  dir specifies an\n"
@@ -781,6 +784,7 @@ init_options (struct options *o, const bool init_gc)
   o->tcp_queue_limit = 64;
   o->max_clients = 1024;
   o->max_routes_per_client = 256;
+  o->stale_routes_check_interval = 0;
   o->ifconfig_pool_persist_refresh_freq = 600;
 #endif
 #if P2MP
@@ -2182,6 +2186,8 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 	msg (M_USAGE, "--port-share requires TCP server mode (--mode server --proto tcp-server)");
 #endif
 
+      if (options->stale_routes_check_interval)
+        msg (M_USAGE, "--stale-routes-check requires --mode server");
     }
 #endif /* P2MP_SERVER */
 
@@ -4944,6 +4950,25 @@ add_option (struct options *options,
 	}
       options->max_routes = max_routes;
     }
+  else if (streq (p[0], "stale-routes-check") && p[1])
+    {
+      int ageing_time, check_interval;
+
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      ageing_time = atoi (p[1]);
+      if (p[2])
+        check_interval = atoi (p[2]);
+      else
+        check_interval = ageing_time;
+
+      if (ageing_time < 1 || check_interval < 1)
+        {
+        msg (msglevel, "--stale-routes-check aging time and check interval must be >= 1");
+        goto err;
+        }
+      options->stale_routes_ageing_time  = ageing_time;
+      options->stale_routes_check_interval = check_interval;
+    }
   else if (streq (p[0], "route-gateway") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_ROUTE_EXTRAS);
diff --git a/options.h b/options.h
index d792872..902fef4 100644
--- a/options.h
+++ b/options.h
@@ -460,6 +460,8 @@ struct options
   int cf_per;
   int max_clients;
   int max_routes_per_client;
+  int stale_routes_check_interval;
+  int stale_routes_ageing_time;
 
   const char *auth_user_pass_verify_script;
   bool auth_user_pass_verify_script_via_file;

--Apple-Mail=_ECF275DD-ED5A-47CB-AB61-2DB7CFA9E04D
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable



Signed-off-by: Davide Guerri <d.guerri@...1502...>




On 14/set/2011, at 16:58, Davide Guerri wrote:

> Hi all,
> please find attached the patch Matteo is referring to.
>=20
> Since we're not expert of the openvpn source code, we think it should be =
considered as a starting point for a discussion.
>=20
> Basically this patch adds a stale-routes-check option that takes 2 parame=
ters: a ageing time (in seconds) and a check interval (in seconds). The lat=
ter defaults to the former if it's not present.
> Internally, a new "check" is added in multi_process_per_second_timers_dow=
ork(). This check deletes stale routes and it is inspired to the function m=
ulti_reap_range().
>=20
> We're running a very large connectivity infrastructure based on openVPN (=
more than 4000 different clients connected per day per server), so we can t=
hroughly check this patch (or, of course, any variant of it).
>=20
> Regards,
> Matteo and Davide.
>=20
> On 14/set/2011, at 15:42, Matteo Latini wrote:
>=20
>> Hi,
>> we (openwisp.it) are an open source wireless ISP using openvpn's tap dev=
ices=20
>> to bridge access points with our main servers.
>>=20
>> We recently ran into a problem with openvpn's internal routing table get=
ting filled up by "old and stale" routes.
>> Some routes are kept for months (till the vpn gets restarted). This and =
the --max-routes-per-client option makes
>> the internal routing table fill up and never let newer clients add new i=
nternal routes.
>>=20
>> Since we were unable to find a way to clean stale routes by reading the =
manpages, we began exploring openvpn's
>> code to create a patch that would clean old and inactive routes. The pat=
ch is working but, by looking through code,
>> we found some reference to MULTI_ROUTE_AGEABLE and ageable_ttl_secs in t=
he multi_route_defined method (multi.h).
>>=20
>> Are those in any way meant to clean, in any way (maybe yet to implement)=
, aged routes?
>> We tried using multi_route_defined to keep track of such routes without =
success.
>>=20
>> Should we keep trying with MULTI_ROUTE_AGEABLE or find other ways (we im=
plemented the patch by using a dedicated
>> timer that triggers a function that does something similar to what happe=
ns on teardown)?
>>=20
>> We are currently patching OpenVPN 2.1.0
>>=20
>>=20
>> Regards,
>> Matteo Latini


--Apple-Mail=_ECF275DD-ED5A-47CB-AB61-2DB7CFA9E04D--

