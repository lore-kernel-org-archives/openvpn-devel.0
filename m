Date: Sun, 27 Dec 2015 21:58:03 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151227205803.GC24952@...1296...>
References: <1445277979-21591-1-git-send-email-gert@...1296...>
	<5625FF23.70203@...1400...>
	<20151020212827.GN22054@...1296...>
	<5626C540.2080907@...1114...> <56274788.6060801@...1227...>
	<5629EBF4.2060405@...2080...>
	<20151226221906.GY24952@...1296...>
	<f0248977-40a8-7e63-27b8-6c9134c090d5@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mw++YNDjOnI+tSxv"
Content-Disposition: inline
In-Reply-To: <f0248977-40a8-7e63-27b8-6c9134c090d5@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Add option --push-suppress-ipv6 to stop
 sending IPv6 info to clients.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--mw++YNDjOnI+tSxv
Content-Type: multipart/mixed; boundary="hGKBrX8jzeaj5K+o"
Content-Disposition: inline

--hGKBrX8jzeaj5K+o
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Dec 26, 2015 at 11:27:53PM +0100, Arne Schwabe wrote:
> > So, you asked for it, you or Arne get to review this :-) - it's current=
ly
> > missing a man page entry, but the commit message explains how it works -
> > just put
> and a changlog entry :)

Done!

> >   push-remove tun-ipv6
> >   push-remove route-ipv6
> >
> > into your ccd/ file, and all options strings starting with one of these
> > strings are removed.  Caveat: "push-remove route" will remove IPv4 and
> > IPv6 routes, so to remove only IPv4 routes, use
> >
> >   push-remove 'route '
>=20
> A sounds like more of a hack that anything.

A hack it is, but one that gives me the maximum flexibility with fairly
little code.  Being able to do

 push-remove 'route-ipv6 2001:'

*and*

 push-remove route

(and the latter only matching "push route" and not "push route-ipv6") is
more complicated...

[..]
> +void
> +push_remove_option (struct options *o, const char *p)
> +{
> +  msg( D_PUSH, "PUSH_REMOVE '%s'", p );
> +
> +  if (o && o->push_list.head )
> +    {
> +      struct gc_arena gc =3D gc_new ();
>=20
> That gc is never gc'ed and is alos not used :)

Well spotted.  That's what you get for starting with a copy of another
function... :)

v2 attached.

Being able to remove "ifconfig-ipv6" from the to-be-pushed option list
was much less fun (due to the way pool and "ifconfig-ipv6-push" interact)
- but it is one of the important parts here.  Like, when we release a=20
2.3.9 version which blows up when using IPv6 on XP...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--hGKBrX8jzeaj5K+o
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Implement-push-remove-option-to-selectively-remov-v2.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 59d7df554aa120588bca4f89869c6cbcf42cb4f5 Mon Sep 17 00:00:00 2001
=46rom: Gert Doering <gert@...1296...>
Date: Sat, 26 Dec 2015 23:08:14 +0100
Subject: [PATCH v2] Implement push-remove option to selectively remove push=
ed
 options.

With this option, the server can remove individual options from the
set pushed to a client (call from --client-config-dir file, or from
--client-connect script or plugin).  Options are removed at parse
time, so it is possible to do stuff like:

  push-remove route-ipv6
  push "route-ipv6 fd00::/8"

to first remove all IPv6 route options set so far, then add something
specific (what "push-reset" does to all the options).

Arguments to push-remove are strncmp()'ed to option string, so partial
matches like

  push-remove route-ipv6 2001:

are possible ("remove all IPv6 routes starting with 2001:").

Implementation of remove_iroutes_from_push_route_list() had to be changed
slightly to stop it from re-enabling all disabled options again.

v2: documentation (Changes.rst, doc/openvpn.8)
    remove surplus gc_arena
    implement filtering of "ifconfig-ipv6"

Trac #29, #614

Signed-off-by: Gert Doering <gert@...1296...>
---
 Changes.rst           |  4 ++++
 doc/openvpn.8         | 35 ++++++++++++++++++++++++++++++++++-
 src/openvpn/options.c | 10 ++++++++++
 src/openvpn/options.h |  1 +
 src/openvpn/push.c    | 47 ++++++++++++++++++++++++++++++++++++++++-------
 src/openvpn/push.h    |  1 +
 6 files changed, 90 insertions(+), 8 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index c2142fa..b3acf71 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -5,6 +5,10 @@ Version 2.4.0
 New features
 ------------
=20
+push-remove
+    new option to remove options on a per-client basis from the "push" list
+    (more fine-grained than "push-reset")
+
 keying-material-exporter
     Keying Material Exporter [RFC-5705] allow additional keying material t=
o be
     derived from existing TLS channel.
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 368bd4c..ed0a1a4 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -2964,6 +2964,39 @@ as with a
 configuration file.  This option will ignore
 .B \-\-push
 options at the global config file level.
+.\"*********************************************************
+.TP
+.B \-\-push\-remove opt
+selectively remove all
+.B \-\-push
+options matching "opt" from the option list for a client.  "opt" is matched
+as a substring against the whole option string to-be-pushed to the client,=
 so
+.B \-\-push\-remove route
+would remove all
+.B \-\-push route ...
+and
+.B \-\-push route-ipv6 ...
+statements, while
+.B \-\-push\-remove 'route-ipv6 2001:'
+would only remove IPv6 routes for 2001:... networks.
+
+.B \-\-push\-remove
+can only be used in a client-specific context, like in a
+.B \-\-client\-config\-dir
+file, or
+.B \-\-client\-connect
+script or plugin -- similar to
+.B \-\-push\-reset,
+just more selective.
+
+NOTE: to
+.I change
+an option,
+.B \-\-push\-remove
+can be used to first remove the old value, and then add a new
+.B \-\-push
+option with the new value.
+.\"*********************************************************
 .TP
 .B \-\-push\-peer\-info
 Push additional information about the client to server.  The additional in=
formation
@@ -3288,7 +3321,7 @@ without needing to restart the server.
=20
 The following
 options are legal in a client-specific context:
-.B \-\-push, \-\-push\-reset, \-\-iroute, \-\-ifconfig\-push,
+.B \-\-push, \-\-push\-reset, \-\-push\-remove, \-\-iroute, \-\-ifconfig\-=
push,
 and
 .B \-\-config.
 .\"*********************************************************
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 46aa824..bf1d2d7 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5578,6 +5578,15 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_INSTANCE);
       push_reset (options);
     }
+  else if (streq (p[0], "push-remove"))
+    {
+      int j;
+      VERIFY_PERMISSION (OPT_P_INSTANCE);
+      for (j =3D 1; j < MAX_PARMS && p[j]; ++j)
+        {
+	  push_remove_option (options,p[j]);
+	}
+    }
   else if (streq (p[0], "ifconfig-pool") && p[1] && p[2] && !p[4])
     {
       const int lev =3D M_WARN;
@@ -5926,6 +5935,7 @@ add_option (struct options *options,
       options->push_ifconfig_ipv6_local =3D local;
       options->push_ifconfig_ipv6_netbits =3D netbits;
       options->push_ifconfig_ipv6_remote =3D remote;
+      options->push_ifconfig_ipv6_blocked =3D false;
     }
   else if (streq (p[0], "disable") && !p[1])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 2f6c8b4..7551f79 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -432,6 +432,7 @@ struct options
   struct in6_addr push_ifconfig_ipv6_local;		/* IPv6 */
   int 		  push_ifconfig_ipv6_netbits;		/* IPv6 */
   struct in6_addr push_ifconfig_ipv6_remote;		/* IPv6 */
+  bool            push_ifconfig_ipv6_blocked;		/* IPv6 */
   bool enable_c2c;
   bool duplicate_cn;
   int cf_max;
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index d4f3cb6..c985163 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -255,7 +255,8 @@ send_push_reply (struct context *c)
=20
   buf_printf (&buf, "%s", cmd);
=20
-  if ( c->c2.push_ifconfig_ipv6_defined )
+  if ( c->c2.push_ifconfig_ipv6_defined &&
+          !c->options.push_ifconfig_ipv6_blocked )
     {
       /* IPv6 is put into buffer first, could be lengthy */
       buf_printf( &buf, ",ifconfig-ipv6 %s/%d %s",
@@ -414,6 +415,37 @@ push_reset (struct options *o)
 {
   CLEAR (o->push_list);
 }
+
+void
+push_remove_option (struct options *o, const char *p)
+{
+  msg( D_PUSH, "PUSH_REMOVE '%s'", p );
+
+  /* ifconfig-ipv6 is special, as not part of the push list */
+  if ( streq( p, "ifconfig-ipv6" ))
+    {
+      o->push_ifconfig_ipv6_blocked =3D true;
+      return;
+    }
+
+  if (o && o->push_list.head )
+    {
+      struct push_entry *e =3D o->push_list.head;
+
+      /* cycle through the push list */
+      while (e)
+	{
+	  if ( e->enable &&
+               strncmp( e->option, p, strlen(p) ) =3D=3D 0 )
+	    {
+	      msg (D_PUSH, "PUSH_REMOVE removing: '%s'", e->option);
+	      e->enable =3D false;
+	    }
+
+	  e =3D e->next;
+	}
+    }
+}
 #endif
=20
 #if P2MP_SERVER
@@ -543,7 +575,8 @@ remove_iroutes_from_push_route_list (struct options *o)
=20
 	  /* parse the push item */
 	  CLEAR (p);
-	  if (parse_line (e->option, p, SIZE (p), "[PUSH_ROUTE_REMOVE]", 1, D_ROU=
TE_DEBUG, &gc))
+	  if ( e->enable &&
+               parse_line (e->option, p, SIZE (p), "[PUSH_ROUTE_REMOVE]", =
1, D_ROUTE_DEBUG, &gc))
 	    {
 	      /* is the push item a route directive? */
 	      if (p[0] && !strcmp (p[0], "route") && !p[3])
@@ -569,12 +602,12 @@ remove_iroutes_from_push_route_list (struct options *=
o)
 			}
 		    }
 		}
-	    }
=20
-	  /* should we copy the push item? */
-	  e->enable =3D enable;
-	  if (!enable)
-	    msg (D_PUSH, "REMOVE PUSH ROUTE: '%s'", e->option);
+	      /* should we copy the push item? */
+	      e->enable =3D enable;
+	      if (!enable)
+		msg (D_PUSH, "REMOVE PUSH ROUTE: '%s'", e->option);
+	    }
=20
 	  e =3D e->next;
 	}
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index fa06e08..e756582 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -61,6 +61,7 @@ void push_option (struct options *o, const char *opt, int=
 msglevel);
 void push_options (struct options *o, char **p, int msglevel, struct gc_ar=
ena *gc);
=20
 void push_reset (struct options *o);
+void push_remove_option (struct options *o, const char *p);
=20
 bool send_push_reply (struct context *c);
=20
--=20
2.4.10


--hGKBrX8jzeaj5K+o--

--mw++YNDjOnI+tSxv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVoBQ2qkuBuNlUUl1AQI7cAP/fF0cH64GErL0FYkKv5iCMfHB/ytCPJvK
r4pbqoh0BGaEJbi3GR9J7ThwWMllrjR2b74nTyRGfwub9WgruA5ZE6ypbqP3uysA
5Dt1myLX4qk8s/wuYwk4hMlw1m/ziZhMVL/QeJAjUCfdHpxI0oTpcFX+RSt30u1f
RSe6+Htafjo=
=N0Is
-----END PGP SIGNATURE-----

--mw++YNDjOnI+tSxv--

