Date: Fri, 30 Dec 2011 21:21:20 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20111230202120.GH5060@...1296...>
References: <4ECC6EE6.5050709@...1388...>
	<20111230191255.GF5060@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gMqNd2jlyJQcupG/"
Content-Disposition: inline
In-Reply-To: <20111230191255.GF5060@...1296...>
Subject: Re: [Openvpn-devel] Problems with add_route_ipv6()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Michal Ludvig <mludvig@...1388...>
Cc: openvpn-devel@lists.sourceforge.net

--gMqNd2jlyJQcupG/
Content-Type: multipart/mixed; boundary="i/CQJCAqWP/GQJtX"
Content-Disposition: inline

--i/CQJCAqWP/GQJtX
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Dec 30, 2011 at 08:12:56PM +0100, Gert Doering wrote:
> On Wed, Nov 23, 2011 at 04:56:22PM +1300, Michal Ludvig wrote:
> > I'm using the latest openvpn from GIT on OpenSUSE 11.4 and am=20
> > experiencing a problem with IPv6 payload setup. It works but openvpn=20
> > seems to be somewhat confused when setting up the v6 route.
[..]
> Bug.  For workarounds, see above :-) and a patch will follow as soon as
> I have cornered the bug (or have understood why this is not happening for
> IPv4).

"lazy coder error".  OpenVPN in p2mp client mode saves certain(!) options=20
before pulling options from the server (pre_pull_save() etc. in options.c)
and this only happened for IPv4 - because, when adding IPv6 support, I
just overlooked this code path.

So on reconnection, the IPv4 "route_option_list" was reset, and the
corresponding IPv6 "route_ipv6_option_list" wasn't - and thus, all the
IPv6 routes were added to whatever was pushed by the server previously,
leading to duplicate routes.

A patch is attached.  I have tested this here for various cases, and
with the patch, the problem is gone (as expected) and I haven't seen
any adverse cases.

Michal, if you could test that this fixes the problem for you, it would
be great.

David, this patch is pretty much straightforward duplication of the
corresponding IPv4 code path.  It needs helpers in route.c, thus the
patch is somewhat bigger than expected...  but it should be "fairly
easy" to review.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--i/CQJCAqWP/GQJtX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Fix-build-up-of-duplicate-IPv6-routes-on-reconnect.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 1a8e83b89a828cfc80a229309e30d8b3b6c59928 Mon Sep 17 00:00:00 2001
From: Gert Doering <gert@...1536...>
Date: Fri, 30 Dec 2011 21:08:49 +0100
Subject: [PATCH] Fix build-up of duplicate IPv6 routes on reconnect.

options.c: extend pre_pull_save() and pre_pull_restore() to
	   save/restore options->routes_ipv6 as well
options.h: add routes_ipv6 to "struct options_pre_pull"
route.h, route.c: add clone_route_ipv6_option_list() and
	   copy_route_ipv6_option_list() helper functions

Signed-off-by: Gert Doering <gert@...1296...>
---
 options.c |   13 +++++++++++++
 options.h |    3 +++
 route.c   |   19 +++++++++++++++++++
 route.h   |    3 +++
 4 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/options.c b/options.c
index 736495e..a186276 100644
--- a/options.c
+++ b/options.c
@@ -2778,6 +2778,11 @@ pre_pull_save (struct options *o)
 	  o->pre_pull->routes =3D clone_route_option_list(o->routes, &o->gc);
 	  o->pre_pull->routes_defined =3D true;
 	}
+      if (o->routes_ipv6)
+	{
+	  o->pre_pull->routes_ipv6 =3D clone_route_ipv6_option_list(o->routes_ipv=
6, &o->gc);
+	  o->pre_pull->routes_ipv6_defined =3D true;
+	}
 #ifdef ENABLE_CLIENT_NAT
       if (o->client_nat)
 	{
@@ -2806,6 +2811,14 @@ pre_pull_restore (struct options *o)
       else
 	o->routes =3D NULL;
=20
+      if (pp->routes_ipv6_defined)
+	{
+	  rol6_check_alloc (o);
+	  copy_route_ipv6_option_list (o->routes_ipv6, pp->routes_ipv6);
+	}
+      else
+	o->routes_ipv6 =3D NULL;
+
 #ifdef ENABLE_CLIENT_NAT
       if (pp->client_nat_defined)
 	{
diff --git a/options.h b/options.h
index 06c4dcb..03fd197 100644
--- a/options.h
+++ b/options.h
@@ -68,6 +68,9 @@ struct options_pre_pull
   bool routes_defined;
   struct route_option_list *routes;
=20
+  bool routes_ipv6_defined;
+  struct route_ipv6_option_list *routes_ipv6;
+
 #ifdef ENABLE_CLIENT_NAT
   bool client_nat_defined;
   struct client_nat_option_list *client_nat;
diff --git a/route.c b/route.c
index be23a89..e95292c 100644
--- a/route.c
+++ b/route.c
@@ -108,6 +108,15 @@ clone_route_option_list (const struct route_option_lis=
t *src, struct gc_arena *a
   return ret;
 }
=20
+struct route_ipv6_option_list *
+clone_route_ipv6_option_list (const struct route_ipv6_option_list *src, st=
ruct gc_arena *a)
+{
+  const size_t rl_size =3D array_mult_safe (sizeof(struct route_ipv6_optio=
n), src->capacity, sizeof(struct route_ipv6_option_list));
+  struct route_ipv6_option_list *ret =3D gc_malloc (rl_size, false, a);
+  memcpy (ret, src, rl_size);
+  return ret;
+}
+
 void
 copy_route_option_list (struct route_option_list *dest, const struct route=
_option_list *src)
 {
@@ -117,6 +126,16 @@ copy_route_option_list (struct route_option_list *dest=
, const struct route_optio
   memcpy (dest, src, src_size);
 }
=20
+void
+copy_route_ipv6_option_list (struct route_ipv6_option_list *dest,=20
+			     const struct route_ipv6_option_list *src)
+{
+  const size_t src_size =3D array_mult_safe (sizeof(struct route_ipv6_opti=
on), src->capacity, sizeof(struct route_ipv6_option_list));
+  if (src->n > dest->capacity)
+    msg (M_FATAL, PACKAGE_NAME " ROUTE: (copy) number of route options in =
src (%d) is greater than route list capacity in dest (%d)", src->n, dest->c=
apacity);
+  memcpy (dest, src, src_size);
+}
+
 struct route_list *
 new_route_list (const int max_routes, struct gc_arena *a)
 {
diff --git a/route.h b/route.h
index 9953478..3e1e84e 100644
--- a/route.h
+++ b/route.h
@@ -211,7 +211,10 @@ struct route_option_list *new_route_option_list (const=
 int max_routes, struct gc
 struct route_ipv6_option_list *new_route_ipv6_option_list (const int max_r=
outes, struct gc_arena *a);
=20
 struct route_option_list *clone_route_option_list (const struct route_opti=
on_list *src, struct gc_arena *a);
+struct route_ipv6_option_list *clone_route_ipv6_option_list (const struct =
route_ipv6_option_list *src, struct gc_arena *a);
 void copy_route_option_list (struct route_option_list *dest, const struct =
route_option_list *src);
+void copy_route_ipv6_option_list (struct route_ipv6_option_list *dest,=20
+				  const struct route_ipv6_option_list *src);
=20
 struct route_list *new_route_list (const int max_routes, struct gc_arena *=
a);
 struct route_ipv6_list *new_route_ipv6_list (const int max_routes, struct =
gc_arena *a);
--=20
1.7.3.4


--i/CQJCAqWP/GQJtX--

--gMqNd2jlyJQcupG/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTv4dP6kuBuNlUUl1AQJmXQQAg0pqGUrga1Whqe5YqLifMAumIpinoLRN
FJu0Hlc5OFd49XO3sk3I/MAR4x8ab3gA520H4X09Ny/ltPFR0l/jJDHEVz+sh5QS
qVuy8uFkKJqzQERmmaYNI1HWEw9RT+3Eoffeo5fYNp5VWyFFC/APFE1L4SjbuYNj
vd/n3NnMvJE=
=3Ila
-----END PGP SIGNATURE-----

--gMqNd2jlyJQcupG/--

