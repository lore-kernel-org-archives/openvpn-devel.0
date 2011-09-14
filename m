From: Davide Guerri <d.guerri@...1502...>
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: multipart/mixed;
	boundary="Apple-Mail=_E9AA986F-CCE5-4D06-A5BB-55E8AF72468E"
Date: Wed, 14 Sep 2011 16:58:45 +0200
In-Reply-To: <C8EBC1CC-8304-4A97-A2C6-DE114CB05EFF@...1502...>
References: <C8EBC1CC-8304-4A97-A2C6-DE114CB05EFF@...1502...>
Message-Id: <B96E3F2E-F1EF-41B4-9342-16AE68F53A8D@...1502...>
Subject: Re: [Openvpn-devel] Info on internal routes aging and
	MULTI_ROUTE_AGEABLE
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--Apple-Mail=_E9AA986F-CCE5-4D06-A5BB-55E8AF72468E
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,
please find attached the patch Matteo is referring to.

Since we're not expert of the openvpn source code, we think it should be co=
nsidered as a starting point for a discussion.

Basically this patch adds a stale-routes-check option that takes 2 paramete=
rs: a ageing time (in seconds) and a check interval (in seconds). The latte=
r defaults to the former if it's not present.
Internally, a new "check" is added in multi_process_per_second_timers_dowor=
k(). This check deletes stale routes and it is inspired to the function mul=
ti_reap_range().

We're running a very large connectivity infrastructure based on openVPN (mo=
re than 4000 different clients connected per day per server), so we can thr=
oughly check this patch (or, of course, any variant of it).

Regards,
  Matteo and Davide.


--Apple-Mail=_E9AA986F-CCE5-4D06-A5BB-55E8AF72468E
Content-Disposition: attachment;
	filename=openvpn-2.0.1-aged-routes.patch
Content-Type: application/octet-stream; x-unix-mode=0644;
	name="openvpn-2.0.1-aged-routes.patch"
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
 
+void
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
@@ -1,4 +1,4 @@
-.\"  OpenVPN -- An application to securely tunnel IP networks
+f.\"  OpenVPN -- An application to securely tunnel IP networks
 .\"             over a single TCP/UDP port, with support for SSL/TLS-based
 .\"             session authentication and key exchange,
 .\"             packet encryption, packet authentication, and
@@ -2976,6 +2976,25 @@
 kernel routing table.
 .\"*********************************************************
 .TP
+.B ----stale-routes-check n [t]
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
+.B --max-routes-per-client
+.\"*********************************************************
+.TP
 .B --connect-freq n sec
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
-
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
+        msg (msglevel, "--stale-routes-check ageing time and check interval must be >= 1");
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

--Apple-Mail=_E9AA986F-CCE5-4D06-A5BB-55E8AF72468E
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable



--
dott. Davide Guerri - C.A.S.P.U.R. Interuniversity Consortium
Lead R&D Eng. OpenWISP (http://openwisp.caspur.it)
CTO CASPUR per Provinciawifi, Pratowifi, FreeWiFiGenova, Maremmawifi, Provi=
nciaGoriziaWiFi, IX-WiFi

e-mail: d.guerri@...1502...
phone: +39 06.44486.404
www: http://openwisp.caspur.it/projects/ow/wiki/Davide_Guerri



On 14/set/2011, at 15:42, Matteo Latini wrote:

> Hi,
> we (openwisp.it) are an open source wireless ISP using openvpn's tap devi=
ces=20
> to bridge access points with our main servers.
>=20
> We recently ran into a problem with openvpn's internal routing table gett=
ing filled up by "old and stale" routes.
> Some routes are kept for months (till the vpn gets restarted). This and t=
he --max-routes-per-client option makes
> the internal routing table fill up and never let newer clients add new in=
ternal routes.
>=20
> Since we were unable to find a way to clean stale routes by reading the m=
anpages, we began exploring openvpn's
> code to create a patch that would clean old and inactive routes. The patc=
h is working but, by looking through code,
> we found some reference to MULTI_ROUTE_AGEABLE and ageable_ttl_secs in th=
e multi_route_defined method (multi.h).
>=20
> Are those in any way meant to clean, in any way (maybe yet to implement),=
 aged routes?
> We tried using multi_route_defined to keep track of such routes without s=
uccess.
>=20
> Should we keep trying with MULTI_ROUTE_AGEABLE or find other ways (we imp=
lemented the patch by using a dedicated
> timer that triggers a function that does something similar to what happen=
s on teardown)?
>=20
> We are currently patching OpenVPN 2.1.0
>=20
>=20
> Regards,
> Matteo Latini



--Apple-Mail=_E9AA986F-CCE5-4D06-A5BB-55E8AF72468E--

