Date: Sat, 26 Dec 2015 23:19:06 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151226221906.GY24952@...1296...>
References: <1445277979-21591-1-git-send-email-gert@...1296...>
	<5625FF23.70203@...1400...>
	<20151020212827.GN22054@...1296...>
	<5626C540.2080907@...1114...> <56274788.6060801@...1227...>
	<5629EBF4.2060405@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/+iafdNWqqIUsmMR"
Content-Disposition: inline
In-Reply-To: <5629EBF4.2060405@...2080...>
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
To: openvpn-devel@lists.sourceforge.net

--/+iafdNWqqIUsmMR
Content-Type: multipart/mixed; boundary="D9XCUYN30ineI4V8"
Content-Disposition: inline

--D9XCUYN30ineI4V8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Oct 23, 2015 at 10:12:36AM +0200, David Sommerseth wrote:
> > Am 21.10.15 um 00:50 schrieb David Sommerseth:
> >>> >  --push-filter ifconfig-ipv6 tun-ipv6 route-ipv6
> >>> >=20
> >>> > which would do exactly what the current patch did, but is much more=
 flexible
> >>> > depending on what exactly needs to be worked around with *this* cli=
ent...
[..]
> That's better.  Another suggestion could be --push-remove.  But I have
> no strong opinion either way.

So, you asked for it, you or Arne get to review this :-) - it's currently
missing a man page entry, but the commit message explains how it works -
just put

  push-remove tun-ipv6
  push-remove route-ipv6

into your ccd/ file, and all options strings starting with one of these
strings are removed.  Caveat: "push-remove route" will remove IPv4 and
IPv6 routes, so to remove only IPv4 routes, use

  push-remove 'route '

(our config parser is just magic :) )

Missing in this patch is "openvpn.8" and you can't remove "ifconfig-ipv6"
(or "ifconfig", for that matter) from the push list as these are not normal
options but special cased - but that is actually not very hard to add if
you agree with the general direction.

gert

PS: merry christmas everyone :-)

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--D9XCUYN30ineI4V8
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Implement-push-remove-option-to-selectively-remove-p.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 06a634bb966c6adbc8f5bd66a0cf796e25727c6d Mon Sep 17 00:00:00 2001
=46rom: Gert Doering <gert@...1296...>
Date: Sat, 26 Dec 2015 23:08:14 +0100
Subject: [PATCH] Implement push-remove option to selectively remove pushed
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

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/options.c |  9 +++++++++
 src/openvpn/push.c    | 38 ++++++++++++++++++++++++++++++++------
 src/openvpn/push.h    |  1 +
 3 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 46aa824..952e171 100644
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
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index d4f3cb6..59fb4cf 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -414,6 +414,31 @@ push_reset (struct options *o)
 {
   CLEAR (o->push_list);
 }
+
+void
+push_remove_option (struct options *o, const char *p)
+{
+  msg( D_PUSH, "PUSH_REMOVE '%s'", p );
+
+  if (o && o->push_list.head )
+    {
+      struct gc_arena gc =3D gc_new ();
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
@@ -543,7 +568,8 @@ remove_iroutes_from_push_route_list (struct options *o)
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
@@ -569,12 +595,12 @@ remove_iroutes_from_push_route_list (struct options *=
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


--D9XCUYN30ineI4V8--

--/+iafdNWqqIUsmMR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVn8SWakuBuNlUUl1AQI1WwQAsGy4fi9+hN3mS67rJe42oKD/m+Z5ORwx
aUBSu807SZFYPr5DTlCm5GroErCAjMpz4EfndyR5UBLnET6aCs3Ydg0U8KJ+c+jW
MmGklR70WDZYFWfGp05k49giJZfgnlgn9NTsGvjD8zqIaKCyADByXIddh+iuFUD/
uJK2mZEWycw=
=HswJ
-----END PGP SIGNATURE-----

--/+iafdNWqqIUsmMR--

