Date: Wed, 23 Oct 2013 18:26:18 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20131023162618.GP161@...1296...>
References: <CAN_jwOsXhs-qTqOmrqhNk+Jf6-pRSBVVTovShLGgQAKKTZkE4g@...278...>
	<554440252.59882.1380270883311.JavaMail.zimbra@...1795...>
	<CAN_jwOvixY5Jz7Rheq-=o40saprsoQmxRB9yn3-jdCmFa9VM0A@...278...>
	<52456F61.3000104@...1114...>
	<CAN_jwOt4kiM09YjZi5=jh6qFgQTpLFgPOSO1opFOF72EY8fyCw@...278...>
	<CAN_jwOuJcwF-Co0r=pukUHO2z0a0ff5xtERp7_mc2PYot9yv-Q@...278...>
	<CAN_jwOuQR6rxUTA5Nho9tBkvSBMU75Yzfv=PFpFUHa2Kq8=E2A@...278...>
	<20131023141829.GA13900@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MrYn40gufhvT+RW4"
Content-Disposition: inline
In-Reply-To: <20131023141829.GA13900@...1296...>
Subject: Re: [Openvpn-devel] Does openvpn 2.3.2 has memory leak?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Brad Zhang <hebei5000@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--MrYn40gufhvT+RW4
Content-Type: multipart/mixed; boundary="cW27jhpBl+zg4ncD"
Content-Disposition: inline

--cW27jhpBl+zg4ncD
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Oct 23, 2013 at 04:18:29PM +0200, Gert Doering wrote:
>  - each further renegotiation leaks "a few kbyte" of memory per client,
>    which should also be fully returned when the client disconnects - this
>    is the issue I discovered earlier, with the GC handling of the per-cli=
ent
>    environment set, and I'll send a patch for that "soon" (as soon as I
>    have fully understood the code involved).

Yeah...  Fosdem 2012 rearing it's ugly head.

Please try the following patch to git master, it should bring back=20
2.1-behaviour here.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--cW27jhpBl+zg4ncD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Fix-slow-memory-drain-on-each-client-renegotiation.patch"
Content-Transfer-Encoding: quoted-printable

=46rom b56e50638f436ca7e4bcffbb0025ee9efa4244d6 Mon Sep 17 00:00:00 2001
From: Gert Doering <gert@...1296...>
Date: Wed, 23 Oct 2013 17:54:05 +0200
Subject: [PATCH] Fix slow memory drain on each client renegotiation.

This reverts commit bee92b479414d12035b0422f81ac5fcfe14fa645 and parts
of commit dc7be6d078ba106f9b0de12f3e879c3561c3c537, as these introduced a
subtle memory drain on client renegotiations (es->gc got initialized,
which led to "unused" gc_entry records accumulating while a client is
connected).

Setting es->gc=3DNULL causes env_set_add_nolock() / remove_env_item() to
free() allocated and no longer used strings in the es, while an active
gc would leave them for cleanup with gc_free() at client disconnect time.

Signed-off-by: Gert Doering <gert@...1296...>

Conflicts:
	src/openvpn/buffer.c
---
 src/openvpn/buffer.c  | 29 +++++++++++++++++++----------
 src/openvpn/init.c    |  2 +-
 src/openvpn/openvpn.c |  2 +-
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 56d14b1..fb3b52d 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -327,19 +327,28 @@ gc_malloc (size_t size, bool clear, struct gc_arena *=
a)
 #endif
 {
   void *ret;
-  struct gc_entry *e;
-  ASSERT (NULL !=3D a);
-
+  if (a)
+    {
+      struct gc_entry *e;
 #ifdef DMALLOC
-  e =3D (struct gc_entry *) openvpn_dmalloc (file, line, size + sizeof (st=
ruct gc_entry));
+      e =3D (struct gc_entry *) openvpn_dmalloc (file, line, size + sizeof=
 (struct gc_entry));
 #else
-  e =3D (struct gc_entry *) malloc (size + sizeof (struct gc_entry));
+      e =3D (struct gc_entry *) malloc (size + sizeof (struct gc_entry));
 #endif
-  check_malloc_return (e);
-  ret =3D (char *) e + sizeof (struct gc_entry);
-  e->next =3D a->list;
-  a->list =3D e;
-
+      check_malloc_return (e);
+      ret =3D (char *) e + sizeof (struct gc_entry);
+      e->next =3D a->list;
+      a->list =3D e;
+    }
+  else
+    {
+#ifdef DMALLOC
+      ret =3D openvpn_dmalloc (file, line, size);
+#else
+      ret =3D malloc (size);
+#endif
+      check_malloc_return (ret);
+    }
 #ifndef ZERO_BUFFER_ON_ALLOC
   if (clear)
 #endif
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 031fb20..ba15fe3 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3030,7 +3030,7 @@ do_close_ifconfig_pool_persist (struct context *c)
 static void
 do_inherit_env (struct context *c, const struct env_set *src)
 {
-  c->c2.es =3D env_set_create (&c->c2.gc);
+  c->c2.es =3D env_set_create (NULL);
   c->c2.es_owned =3D true;
   env_set_inherit (c->c2.es, src);
 }
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index 104c9e9..5125eae 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -171,7 +171,7 @@ openvpn_main (int argc, char *argv[])
 	  gc_init (&c.gc);
=20
 	  /* initialize environmental variable store */
-	  c.es =3D env_set_create (&c.gc);
+	  c.es =3D env_set_create (NULL);
 #ifdef WIN32
 	  set_win_sys_path_via_env (c.es);
 #endif
--=20
1.8.1.5


--cW27jhpBl+zg4ncD--

--MrYn40gufhvT+RW4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUmf4qqkuBuNlUUl1AQIxnwQAo2YOGFRO2jjSlfpdlEO07QSz01L8Ip9B
2cwORiHzNJCrBosR+OzwH+eIQRGZ7FXkyJaR0kw9Hsy8coDJXZTQkX3hGMJWq8mw
SFGoOn5+Goa5T9B/zNo3s6SahV3GR/f9+ng9MWGhL360TWDYqy2bdx6m1n/5p5SB
Z3CvMQ1zuUo=
=GqoE
-----END PGP SIGNATURE-----

--MrYn40gufhvT+RW4--

